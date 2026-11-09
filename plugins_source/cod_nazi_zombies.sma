/* =================================================================================
 *  CALL OF DUTY: NAZI ZOMBIES CLASSIC - CS 1.6 MOD SUITE
 *  Inspirado en Call of Duty: World at War (2008) - Nacht der Untoten
 *  Desarrollado para AMX Mod X 1.8.2 / GoldSrc
 * ================================================================================= */

#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <fun>
#include <hamsandwich>
#include <fakemeta>
#include <engine>

#define PLUGIN_NAME    "CoD Nazi Zombies Classic"
#define PLUGIN_VERSION "1.0.0"
#define PLUGIN_AUTHOR  "Tormenta Cosmica Azul"

// Configuración de Oleadas CoD
new g_current_round = 1
new g_zombies_total_wave = 6
new g_zombies_spawned = 0
new g_zombies_alive = 0
new bool:g_intermission = false
new bool:g_game_started = false

// Power-ups
new bool:g_insta_kill = false
new bool:g_double_points = false
new g_powerup_timer_insta = 0
new g_powerup_timer_double = 0

// Perks por jugador (Index 1..32)
new bool:g_has_juggernog[33]
new bool:g_has_speedcola[33]
new bool:g_has_doubletap[33]
new bool:g_has_quickrevive[33]
new g_barricade_points[33]

// Sonidos clásicos GoldSrc garantizados
new const SOUND_ROUND_START[]   = "ambience/port_siren.wav"
new const SOUND_ROUND_END[]     = "events/task_complete.wav"
new const SOUND_HITMARKER[]     = "buttons/bell1.wav"
new const SOUND_POWERUP[]       = "buttons/latchunlocked1.wav"
new const SOUND_NUKE[]          = "weapons/c4_explode1.wav"
new const SOUND_BOX_SPIN[]      = "buttons/lever1.wav"
new const SOUND_TEDDY[]         = "misc/ooorgle.wav"
new const SOUND_ZOMBIE_GROWL[]  = "misc/brawwrr.wav"
new const SOUND_ZOMBIE_ATTACK[] = "weapons/knife_hit1.wav"
new const SOUND_REPAIR[]        = "buttons/button9.wav"

// Mensajes de pantalla
new g_msg_screenfade

public plugin_init()
{
	register_plugin(PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_AUTHOR)

	// Hooks de eventos de jugador
	RegisterHam(Ham_Spawn, "player", "OnPlayerSpawn_Post", 1)
	RegisterHam(Ham_Killed, "player", "OnPlayerKilled_Post", 1)
	RegisterHam(Ham_TakeDamage, "player", "OnTakeDamage")

	// Comandos de chat y consola para jugadores
	register_clcmd("say /perks", "ShowPerksMenu")
	register_clcmd("say /perk", "ShowPerksMenu")
	register_clcmd("say /ventajas", "ShowPerksMenu")
	register_clcmd("say /box", "CmdMysteryBox")
	register_clcmd("say /caja", "CmdMysteryBox")
	register_clcmd("cod_perks", "ShowPerksMenu")
	register_clcmd("cod_box", "CmdMysteryBox")
	register_clcmd("cod_nextround", "AdminNextRound")
	register_clcmd("cod_restart", "RestartZombieGame")

	// Tecla E (+use) para reparar
	register_forward(FM_CmdStart, "OnCmdStart")

	// Evento de reinicio de ronda de CS
	register_event("HLTV", "OnNewRound", "a", "1=0", "2=0")
	register_event("TextMsg", "OnRoundRestartEvent", "a", "2&#Game_C", "2&#Game_w")

	g_msg_screenfade = get_user_msgid("ScreenFade")

	// Tareas continuas de HUD y timers
	set_task(1.0, "Task_HudDisplay", 1001, _, _, "b")
	set_task(1.0, "Task_SecondLoop", 1002, _, _, "b")

	server_cmd("mp_autoteambalance 0")
	server_cmd("mp_limitteams 0")
	server_cmd("bot_knives_only 1")
	server_cmd("bot_join_team T")
}

public plugin_precache()
{
	precache_sound(SOUND_ROUND_START)
	precache_sound(SOUND_ROUND_END)
	precache_sound(SOUND_HITMARKER)
	precache_sound(SOUND_POWERUP)
	precache_sound(SOUND_NUKE)
	precache_sound(SOUND_BOX_SPIN)
	precache_sound(SOUND_TEDDY)
	precache_sound(SOUND_ZOMBIE_GROWL)
	precache_sound(SOUND_ZOMBIE_ATTACK)
	precache_sound(SOUND_REPAIR)
}

public client_putinserver(id)
{
	ResetPlayerPerks(id)
}

public client_disconnect(id)
{
	ResetPlayerPerks(id)
}

public ResetPlayerPerks(id)
{
	g_has_juggernog[id] = false
	g_has_speedcola[id] = false
	g_has_doubletap[id] = false
	g_has_quickrevive[id] = false
	g_barricade_points[id] = 0
}

public OnNewRound()
{
	// Si es la primera ronda o reinicio general
	if (!g_game_started)
	{
		g_game_started = true
		StartRound(1)
	}
}

public OnRoundRestartEvent()
{
	RestartZombieGame(0)
}

public RestartZombieGame(id)
{
	g_current_round = 1
	g_game_started = true
	g_insta_kill = false
	g_double_points = false
	StartRound(1)
	return PLUGIN_HANDLED
}

public StartRound(round_num)
{
	g_current_round = round_num
	g_intermission = false

	// Fórmula progresiva CoD WaW: 4 zombis iniciales + 2 por ronda
	g_zombies_total_wave = 4 + (g_current_round * 2)
	g_zombies_spawned = 0
	g_zombies_alive = 0

	// Reset de barricadas por ronda
	for (new i = 1; i <= 32; i++)
		g_barricade_points[i] = 0

	client_cmd(0, "spk %s", SOUND_ROUND_START)

	set_hudmessage(255, 30, 30, -1.0, 0.25, 1, 6.0, 5.0, 0.1, 0.2, -1)
	show_hudmessage(0, "=== [ RONDA %d ] ===^n¡LA HORDA DE ZOMBIS SE APROXIMA!", g_current_round)

	// Respawnear bots existentes en equipo T
	set_task(1.5, "Task_SpawnZombies")
}

public Task_SpawnZombies()
{
	new players[32], pnum
	get_players(players, pnum, "e", "TERRORIST")

	for (new i = 0; i < pnum; i++)
	{
		new bot = players[i]
		if (g_zombies_spawned < g_zombies_total_wave)
		{
			if (!is_user_alive(bot))
			{
				ExecuteHamB(Ham_CS_RoundRespawn, bot)
			}
			else
			{
				SetupZombie(bot)
			}
			g_zombies_spawned++
			g_zombies_alive++
		}
	}
}

public OnPlayerSpawn_Post(id)
{
	if (!is_user_alive(id))
		return

	if (cs_get_user_team(id) == CS_TEAM_T)
	{
		SetupZombie(id)
	}
	else if (cs_get_user_team(id) == CS_TEAM_CT)
	{
		SetupHuman(id)
	}
}

public SetupZombie(id)
{
	// Desarmar completamente al zombi y forzar cuchillo
	strip_user_weapons(id)
	give_item(id, "weapon_knife")

	// Escala de Vida CoD WaW: 80 HP base + 35 HP por ronda
	new hp = 80 + (g_current_round * 35)
	if (hp > 3000) hp = 3000
	set_user_health(id, hp)

	// Velocidad progresiva: zombis rápidos en rondas avanzadas
	new Float:speed = 240.0 + float(g_current_round * 7)
	if (speed > 330.0) speed = 330.0
	set_user_maxspeed(id, speed)

	// Aura de Zombi (Resplandor carmesí siniestro)
	set_user_rendering(id, kRenderFxGlowShell, 220, 20, 20, kRenderNormal, 16)
}

public SetupHuman(id)
{
	// Aplicar Perks activos si el jugador ya los compró
	if (g_has_juggernog[id])
	{
		set_user_health(id, 250)
		set_user_rendering(id, kRenderFxGlowShell, 200, 30, 30, kRenderNormal, 10)
	}
	else
	{
		set_user_health(id, 100)
		set_user_rendering(id, kRenderFxNone, 0, 0, 0, kRenderNormal, 0)
	}

	if (g_has_speedcola[id])
	{
		set_user_maxspeed(id, 320.0)
	}

	cs_set_user_armor(id, 100, CS_ARMOR_VESTHELM)
}

public OnTakeDamage(victim, inflictor, attacker, Float:damage, damage_type)
{
	if (!is_user_connected(attacker) || !is_user_connected(victim))
		return HAM_IGNORED

	new CsTeams:att_team = cs_get_user_team(attacker)
	new CsTeams:vic_team = cs_get_user_team(victim)

	// Fuego Humano contra Zombi
	if (att_team == CS_TEAM_CT && vic_team == CS_TEAM_T)
	{
		// Power-up Insta-Kill: 1 disparo = Muerte
		if (g_insta_kill)
		{
			SetHamParamFloat(4, 99999.0)
			return HAM_HANDLED
		}

		// Perk Double Tap: +50% de daño balístico
		if (g_has_doubletap[attacker])
		{
			damage *= 1.5
			SetHamParamFloat(4, damage)
		}

		// Sistema de Puntos por impacto CoD: +10 pts por bala acertada
		new pts = g_double_points ? 20 : 10
		new cur_money = cs_get_user_money(attacker)
		cs_set_user_money(attacker, cur_money + pts, 1)

		// Sonido discreto de hitmarker
		client_cmd(attacker, "spk %s", SOUND_HITMARKER)

		return HAM_HANDLED
	}

	// Ataque Zombi contra Humano
	if (att_team == CS_TEAM_T && vic_team == CS_TEAM_CT)
	{
		// Juggernog absorbe un 30% del daño recibido
		if (g_has_juggernog[victim])
		{
			damage *= 0.7
			SetHamParamFloat(4, damage)
		}

		// Quick Revive: Auto-reanimación de emergencia si la salud baja de 25
		new hp = get_user_health(victim)
		if (g_has_quickrevive[victim] && (float(hp) - damage <= 10.0))
		{
			g_has_quickrevive[victim] = false
			set_user_health(victim, 120)
			client_cmd(victim, "spk %s", SOUND_POWERUP)

			// Destello verde de reanimación
			message_begin(MSG_ONE_UNRELIABLE, g_msg_screenfade, _, victim)
			write_short(1<<12)
			write_short(1<<12)
			write_short(0x0000)
			write_byte(0)
			write_byte(255)
			write_byte(100)
			write_byte(180)
			message_end()

			client_print(victim, print_center, "¡QUICK REVIVE ACTIVADO! (Segunda Oportunidad)")
			SetHamParamFloat(4, 0.0)
			return HAM_HANDLED
		}
	}

	return HAM_IGNORED
}

public OnPlayerKilled_Post(victim, attacker, shouldgib)
{
	if (!is_user_connected(victim))
		return

	if (cs_get_user_team(victim) == CS_TEAM_T)
	{
		// Zombi eliminado
		if (is_user_connected(attacker) && cs_get_user_team(attacker) == CS_TEAM_CT)
		{
			new headshot = (get_pdata_int(victim, 75) == 1) // HITGROUP_HEAD
			new weapon = get_user_weapon(attacker)

			new kill_pts = 50
			if (weapon == CSW_KNIFE) kill_pts = 130
			else if (headshot) kill_pts = 100

			if (g_double_points) kill_pts *= 2

			new cur_money = cs_get_user_money(attacker)
			cs_set_user_money(attacker, cur_money + kill_pts, 1)

			// Sonido de gruñido zombi al caer
			emit_sound(victim, CHAN_VOICE, SOUND_ZOMBIE_GROWL, VOL_NORM, ATTN_NORM, 0, PITCH_NORM)

			// Probabilidad de soltar Power-Up (8%)
			if (random_num(1, 100) <= 8)
			{
				DropRandomPowerUp(victim, attacker)
			}
		}

		g_zombies_alive--

		// Si todavía quedan zombis por generar en la reserva de la oleada actual
		if (g_zombies_spawned < g_zombies_total_wave)
		{
			// Respawnear al bot en 2 segundos para mantener la presión de la horda
			set_task(2.0, "Task_RespawnZombie", victim)
			g_zombies_spawned++
			g_zombies_alive++
		}
		else if (g_zombies_alive <= 0 && !g_intermission)
		{
			// ¡Oleada Completada!
			RoundCleared()
		}
	}
	else if (cs_get_user_team(victim) == CS_TEAM_CT)
	{
		ResetPlayerPerks(victim)
	}
}

public Task_RespawnZombie(id)
{
	if (is_user_connected(id) && cs_get_user_team(id) == CS_TEAM_T && !is_user_alive(id))
	{
		ExecuteHamB(Ham_CS_RoundRespawn, id)
	}
}

public DropRandomPowerUp(victim, killer)
{
	new type = random_num(1, 4)
	switch (type)
	{
		case 1: // Max Ammo
		{
			client_cmd(0, "spk %s", SOUND_POWERUP)
			RefillAllAmmo()
			set_hudmessage(0, 255, 255, -1.0, 0.40, 0, 4.0, 4.0, 0.1, 0.2, -1)
			show_hudmessage(0, "★ ¡MUNICION MAXIMA! ★^n(Todas las armas recargadas)")
		}
		case 2: // Insta-Kill
		{
			client_cmd(0, "spk %s", SOUND_POWERUP)
			g_insta_kill = true
			g_powerup_timer_insta = 25
			set_hudmessage(255, 50, 50, -1.0, 0.40, 0, 4.0, 4.0, 0.1, 0.2, -1)
			show_hudmessage(0, "☠ ¡BAJA INSTANTANEA (25s)! ☠^n(Zombis caen de 1 disparo)")
		}
		case 3: // Nuke (Bomba Nuclear)
		{
			client_cmd(0, "spk %s", SOUND_NUKE)
			// Destello blanco cegador para todos
			message_begin(MSG_BROADCAST, g_msg_screenfade)
			write_short(1<<13)
			write_short(1<<13)
			write_short(0x0000)
			write_byte(255)
			write_byte(255)
			write_byte(255)
			write_byte(220)
			message_end()

			// Eliminar todos los zombis en el mapa y otorgar bono
			new players[32], pnum
			get_players(players, pnum, "ae", "TERRORIST")
			for (new i = 0; i < pnum; i++)
			{
				user_silentkill(players[i])
			}

			// Bono de $400 a todos los supervivientes
			get_players(players, pnum, "ae", "CT")
			for (new i = 0; i < pnum; i++)
			{
				new money = cs_get_user_money(players[i])
				cs_set_user_money(players[i], money + 400, 1)
			}

			set_hudmessage(255, 255, 0, -1.0, 0.40, 0, 4.0, 4.0, 0.1, 0.2, -1)
			show_hudmessage(0, "☢ ¡BOMBA NUCLEAR DETONADA! ☢^n(+$400 Créditos para todos)")

			if (g_zombies_spawned >= g_zombies_total_wave && g_zombies_alive <= 0 && !g_intermission)
			{
				RoundCleared()
			}
		}
		case 4: // Double Points
		{
			client_cmd(0, "spk %s", SOUND_POWERUP)
			g_double_points = true
			g_powerup_timer_double = 30
			set_hudmessage(255, 215, 0, -1.0, 0.40, 0, 4.0, 4.0, 0.1, 0.2, -1)
			show_hudmessage(0, "$$ ¡PUNTOS DOBLES (30s)! $$^n(2x Puntos en disparos y bajas)")
		}
	}
}

public RefillAllAmmo()
{
	new players[32], pnum
	get_players(players, pnum, "ae", "CT")

	for (new i = 0; i < pnum; i++)
	{
		new id = players[i]
		cs_set_user_bpammo(id, CSW_AK47, 90)
		cs_set_user_bpammo(id, CSW_M4A1, 90)
		cs_set_user_bpammo(id, CSW_AWP, 30)
		cs_set_user_bpammo(id, CSW_DEAGLE, 35)
		cs_set_user_bpammo(id, CSW_MP5NAVY, 120)
		cs_set_user_bpammo(id, CSW_M249, 200)
		cs_set_user_bpammo(id, CSW_XM1014, 32)
		cs_set_user_bpammo(id, CSW_M3, 32)
		cs_set_user_bpammo(id, CSW_GALIL, 90)
		cs_set_user_bpammo(id, CSW_FAMAS, 90)
		cs_set_user_bpammo(id, CSW_P90, 100)
		cs_set_user_bpammo(id, CSW_SCOUT, 90)
		cs_set_user_bpammo(id, CSW_USP, 100)
		cs_set_user_bpammo(id, CSW_GLOCK18, 120)
		cs_set_user_bpammo(id, CSW_ELITE, 120)
	}
}

public RoundCleared()
{
	g_intermission = true
	client_cmd(0, "spk %s", SOUND_ROUND_END)

	set_hudmessage(0, 255, 100, -1.0, 0.35, 1, 6.0, 5.0, 0.1, 0.2, -1)
	show_hudmessage(0, "✔ ¡RONDA %d SUPERADA! ✔^nPreparate para la Ronda %d en 7 segundos...", g_current_round, g_current_round + 1)

	set_task(7.0, "Task_NextRound")
}

public Task_NextRound()
{
	StartRound(g_current_round + 1)
}

public Task_SecondLoop()
{
	// Reducir temporizadores de power-ups
	if (g_insta_kill)
	{
		g_powerup_timer_insta--
		if (g_powerup_timer_insta <= 0)
		{
			g_insta_kill = false
			client_print(0, print_center, "Baja Instantánea ha expirado.")
		}
	}

	if (g_double_points)
	{
		g_powerup_timer_double--
		if (g_powerup_timer_double <= 0)
		{
			g_double_points = false
			client_print(0, print_center, "Puntos Dobles han expirado.")
		}
	}
}

public Task_HudDisplay()
{
	new players[32], pnum
	get_players(players, pnum, "ae", "CT")

	for (new i = 0; i < pnum; i++)
	{
		new id = players[i]
		new perks_str[64] = ""
		if (g_has_juggernog[id])   add(perks_str, charsmax(perks_str), "[Juggernog] ")
		if (g_has_speedcola[id])    add(perks_str, charsmax(perks_str), "[SpeedCola] ")
		if (g_has_doubletap[id])    add(perks_str, charsmax(perks_str), "[DoubleTap] ")
		if (g_has_quickrevive[id])  add(perks_str, charsmax(perks_str), "[QuickRevive] ")
		if (strlen(perks_str) == 0) copy(perks_str, charsmax(perks_str), "Ninguna (Visita /perks)")

		new power_str[64] = ""
		if (g_insta_kill)           formatex(power_str, charsmax(power_str), "| ¡INSTA-KILL (%ds)! ", g_powerup_timer_insta)
		if (g_double_points)        formatex(power_str, charsmax(power_str), "%s| ¡2X PUNTOS (%ds)! ", power_str, g_powerup_timer_double)

		set_hudmessage(255, 40, 40, 0.02, 0.20, 0, 1.1, 1.0, 0.05, 0.05, 2)
		show_hudmessage(id, "[ NAZI ZOMBIES ]^nRONDA: %d^nZombis Restantes: %d / %d %s^nVentajas: %s^nCaja Misteriosa ($950): Escribe /box",
			g_current_round,
			(g_zombies_total_wave - g_zombies_spawned) + g_zombies_alive,
			g_zombies_total_wave,
			power_str,
			perks_str)
	}
}

// =================================================================================
// MENÚ DE PERKS (VENTAJAS PERK-A-COLA)
// =================================================================================

public ShowPerksMenu(id)
{
	if (!is_user_alive(id) || cs_get_user_team(id) != CS_TEAM_CT)
	{
		client_print(id, print_chat, "[ZOMBIES] Solo los supervivientes pueden acceder a las ventajas.")
		return PLUGIN_HANDLED
	}

	new menu = menu_create("\y[CoD Zombies] Maquina Perk-a-Cola:", "MenuHandler_Perks")

	new jugg_str[64], speed_str[64], tap_str[64], revive_str[64]
	formatex(jugg_str, charsmax(jugg_str), "Juggernog (+150 HP Max) \r[$2500]%s", g_has_juggernog[id] ? " \y[Activo]" : "")
	formatex(speed_str, charsmax(speed_str), "Speed Cola (Velocidad & Recarga) \r[$3000]%s", g_has_speedcola[id] ? " \y[Activo]" : "")
	formatex(tap_str, charsmax(tap_str), "Double Tap Root Beer (+50%% Daño) \r[$2000]%s", g_has_doubletap[id] ? " \y[Activo]" : "")
	formatex(revive_str, charsmax(revive_str), "Quick Revive (Segunda Vida) \r[$1500]%s", g_has_quickrevive[id] ? " \y[Activo]" : "")

	menu_additem(menu, jugg_str, "1")
	menu_additem(menu, speed_str, "2")
	menu_additem(menu, tap_str, "3")
	menu_additem(menu, revive_str, "4")

	menu_setprop(menu, MPROP_EXITNAME, "Cerrar")
	menu_display(id, menu, 0)
	return PLUGIN_HANDLED
}

public MenuHandler_Perks(id, menu, item)
{
	if (item == MENU_EXIT || !is_user_alive(id))
	{
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}

	new money = cs_get_user_money(id)

	switch (item)
	{
		case 0: // Juggernog
		{
			if (g_has_juggernog[id]) { client_print(id, print_chat, "[ZOMBIES] Ya posees Juggernog."); }
			else if (money < 2500) { client_print(id, print_chat, "[ZOMBIES] Necesitas $2500 para Juggernog."); }
			else
			{
				cs_set_user_money(id, money - 2500, 1)
				g_has_juggernog[id] = true
				set_user_health(id, 250)
				client_cmd(id, "spk %s", SOUND_POWERUP)
				client_print(id, print_chat, "[ZOMBIES] ¡Has adquirido Juggernog! (Vida aumentada a 250 HP)")
			}
		}
		case 1: // Speed Cola
		{
			if (g_has_speedcola[id]) { client_print(id, print_chat, "[ZOMBIES] Ya posees Speed Cola."); }
			else if (money < 3000) { client_print(id, print_chat, "[ZOMBIES] Necesitas $3000 para Speed Cola."); }
			else
			{
				cs_set_user_money(id, money - 3000, 1)
				g_has_speedcola[id] = true
				set_user_maxspeed(id, 320.0)
				client_cmd(id, "spk %s", SOUND_POWERUP)
				client_print(id, print_chat, "[ZOMBIES] ¡Has adquirido Speed Cola! (+Velocidad y agilidad)")
			}
		}
		case 2: // Double Tap
		{
			if (g_has_doubletap[id]) { client_print(id, print_chat, "[ZOMBIES] Ya posees Double Tap."); }
			else if (money < 2000) { client_print(id, print_chat, "[ZOMBIES] Necesitas $2000 para Double Tap."); }
			else
			{
				cs_set_user_money(id, money - 2000, 1)
				g_has_doubletap[id] = true
				client_cmd(id, "spk %s", SOUND_POWERUP)
				client_print(id, print_chat, "[ZOMBIES] ¡Has adquirido Double Tap Root Beer! (+50%% Daño balístico)")
			}
		}
		case 3: // Quick Revive
		{
			if (g_has_quickrevive[id]) { client_print(id, print_chat, "[ZOMBIES] Ya posees Quick Revive."); }
			else if (money < 1500) { client_print(id, print_chat, "[ZOMBIES] Necesitas $1500 para Quick Revive."); }
			else
			{
				cs_set_user_money(id, money - 1500, 1)
				g_has_quickrevive[id] = true
				client_cmd(id, "spk %s", SOUND_POWERUP)
				client_print(id, print_chat, "[ZOMBIES] ¡Has adquirido Quick Revive! (Seguro contra muerte)")
			}
		}
	}

	menu_destroy(menu)
	return PLUGIN_HANDLED
}

// =================================================================================
// CAJA MISTERIOSA (MYSTERY BOX)
// =================================================================================

public CmdMysteryBox(id)
{
	if (!is_user_alive(id) || cs_get_user_team(id) != CS_TEAM_CT)
	{
		client_print(id, print_chat, "[ZOMBIES] Solo los supervivientes pueden abrir la Caja Misteriosa.")
		return PLUGIN_HANDLED
	}

	new money = cs_get_user_money(id)
	if (money < 950)
	{
		client_print(id, print_chat, "[ZOMBIES] Necesitas $950 para tirar de la Caja Misteriosa.")
		return PLUGIN_HANDLED
	}

	cs_set_user_money(id, money - 950, 1)
	client_cmd(id, "spk %s", SOUND_BOX_SPIN)

	// Ruleta aleatoria de armas
	new roll = random_num(1, 10)
	switch (roll)
	{
		case 1:
		{
			give_item(id, "weapon_ak47")
			cs_set_user_bpammo(id, CSW_AK47, 90)
			client_print(id, print_center, "★ CAJA MISTERIOSA: ¡AK-47 Kalashnikov! ★")
		}
		case 2:
		{
			give_item(id, "weapon_m4a1")
			cs_set_user_bpammo(id, CSW_M4A1, 90)
			client_print(id, print_center, "★ CAJA MISTERIOSA: ¡Carabina M4A1! ★")
		}
		case 3:
		{
			give_item(id, "weapon_m249")
			cs_set_user_bpammo(id, CSW_M249, 200)
			client_print(id, print_center, "★ CAJA MISTERIOSA: ¡Ametralladora Pesada M249! ★")
		}
		case 4:
		{
			give_item(id, "weapon_awp")
			cs_set_user_bpammo(id, CSW_AWP, 30)
			client_print(id, print_center, "★ CAJA MISTERIOSA: ¡Francotirador Magnum AWP! ★")
		}
		case 5:
		{
			give_item(id, "weapon_xm1014")
			cs_set_user_bpammo(id, CSW_XM1014, 32)
			client_print(id, print_center, "★ CAJA MISTERIOSA: ¡Escopeta Automática XM1014! ★")
		}
		case 6:
		{
			give_item(id, "weapon_deagle")
			cs_set_user_bpammo(id, CSW_DEAGLE, 35)
			client_print(id, print_center, "★ CAJA MISTERIOSA: ¡Pistola Pesada Desert Eagle! ★")
		}
		case 7:
		{
			give_item(id, "weapon_elite")
			cs_set_user_bpammo(id, CSW_ELITE, 120)
			client_print(id, print_center, "★ CAJA MISTERIOSA: ¡Pistolas Duales Beretta! ★")
		}
		case 8:
		{
			give_item(id, "weapon_p90")
			cs_set_user_bpammo(id, CSW_P90, 100)
			client_print(id, print_center, "★ CAJA MISTERIOSA: ¡Subfusil FN P90 (50 Balas)! ★")
		}
		case 9:
		{
			give_item(id, "weapon_galil")
			cs_set_user_bpammo(id, CSW_GALIL, 90)
			client_print(id, print_center, "★ CAJA MISTERIOSA: ¡Fusil de Asalto Galil! ★")
		}
		case 10: // El Osito / Teddy Bear
		{
			client_cmd(id, "spk %s", SOUND_TEDDY)
			client_print(id, print_center, "☠ ¡EL OSITO DE SAMANTHA! ☠^n(La caja se ha reído de ti... Sin arma)")
		}
	}

	return PLUGIN_HANDLED
}

// =================================================================================
// REPARACIÓN DE BARRICADAS (+USE / TECLA E)
// =================================================================================

public OnCmdStart(id, uc_handle, random_seed)
{
	if (!is_user_alive(id) || cs_get_user_team(id) != CS_TEAM_CT)
		return FMRES_IGNORED

	new button = get_uc(uc_handle, UC_Buttons)
	new oldbutton = pev(id, pev_oldbuttons)

	// Al pulsar tecla +use
	if ((button & IN_USE) && !(oldbutton & IN_USE))
	{
		if (g_barricade_points[id] < 50)
		{
			g_barricade_points[id] += 10
			new money = cs_get_user_money(id)
			cs_set_user_money(id, money + 10, 1)

			client_cmd(id, "spk %s", SOUND_REPAIR)
			client_print(id, print_center, "+10 PTS (Fortificando Barricada [%d/50])", g_barricade_points[id])
		}
	}

	return FMRES_IGNORED
}

public AdminNextRound(id)
{
	if (!is_user_admin(id) && id != 0)
	{
		client_print(id, print_chat, "[ZOMBIES] Solo el administrador puede forzar la siguiente ronda.")
		return PLUGIN_HANDLED
	}

	RoundCleared()
	return PLUGIN_HANDLED
}
