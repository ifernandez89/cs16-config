# 📋 Registro de Cambios (Changelog) - CS 1.6 Config & Mod Suite

Todas las actualizaciones y mejoras del paquete de configuración, armaduras y modernización técnica para Counter-Strike 1.6 están documentadas en este archivo.

---

## [2.6.0] - 2026-11-09

### 🧟 Modo Call of Duty: World at War — Nazi Zombies Classic
- **🌊 Sistema de Oleadas Progresivas (Wave Survival):**
  - Progresión infinita de rondas inspirada en *Nacht der Untoten*: inicio de ronda con sirena atmosférica, HUD con contador de zombis restantes en tiempo real y 7 segundos de intermisión musical al superar cada oleada.
  - Escalado dinámico de la horda: los zombis incrementan su salud ($80 + \text{Ronda} \times 35$ HP) y su velocidad de desplazamiento ($240 + \text{Ronda} \times 7$ u/s) conforme avanzan las rondas.
  - Resurgimiento continuo de bots en combate (respawn en 2s) para mantener la presión de la horda hasta agotar la reserva de la ronda.
- **💰 Economía de Puntos CoD:**
  - Recompensa instantánea en efectivo: $+10$ créditos por bala impactada ($+20$ con Puntos Dobles), $+50$ por baja estándar, $+100$ por disparo a la cabeza (Headshot) y $+130$ por baja con arma blanca / cuchillo.
  - Sonido discreto de confirmación de impacto (*hitmarker*).
- **🥤 Máquina de Ventajas Perk-a-Cola (`/perks` o Tecla P):**
  - **Juggernog ($2.500):** Aumenta la salud máxima a 250 HP y absorbe un 30% del daño recibido.
  - **Speed Cola ($3.000):** Incrementa la velocidad de movimiento a 320 u/s y acelera la movilidad táctica.
  - **Double Tap Root Beer ($2.000):** Multiplica por $1.5\times$ (+50%) el daño de todas las balas disparadas.
  - **Quick Revive ($1.500):** Sistema de segunda oportunidad con reanimación automática y escudo verde si la salud cae a niveles críticos.
- **📦 Caja Misteriosa ($950) (`/box` o Tecla B):**
  - Ruleta aleatoria de armas de alto calibre: AK-47, M4A1, ametralladora pesada M249 Para, francotirador AWP, escopeta automática XM1014, Desert Eagle, Berettas Duales y subfusil P90.
  - Posibilidad de aparición del "Osito de Samantha" con risa siniestra y reseteo de tirada.
- **✨ Potenciadores Aleatorios en el Campo (Power-Ups):**
  - Probabilidad de 8% en cada baja de zombi de activar bonificaciones globales:
    - **Munición Máxima (Max Ammo):** Recarga total de cartuchos y reservas para todos los supervivientes.
    - **Baja Instantánea (Insta-Kill):** Eliminación de zombis de un solo disparo durante 25 segundos.
    - **Bomba Nuclear (Nuke):** Pulso blanco cegador que aniquila a todos los zombis presentes en el mapa y otorga $+400$ créditos a cada jugador.
    - **Puntos Dobles (Double Points):** Multiplicador $2\times$ de puntos y créditos durante 30 segundos.
- **🔨 Reparación de Barricadas (Tecla E / `+use`):**
  - Fortificación de defensas y accesos manteniendo pulsada la tecla de acción, otorgando $+10$ créditos hasta un máximo de 50 por ronda.
- **🕹️ Lanzador y Configuración Dedicada:**
  - `INICIAR_COD_ZOMBIES.bat`: Lanzador directo con 1 clic listo para ejecutar el modo en mapas de supervivencia.
  - `cstrike/cod_zombies.cfg`: Configuración equilibrada para bots, tiempos, dinero inicial ($500) y binds automáticos.
  - Integración en Menú 'H' (`commandmenu.txt`): Nueva sección con accesos rápidos a ventajas, caja misteriosa y control de oleadas.
- **🛡️ Blindaje de Repositorio Git:**
  - Actualización exhaustiva de `.gitignore`: exclusión de volcados de memoria (`*.mdmp`), archivos de caché GoldSrc (`*.ztmp`), demos (`*.dem`), archivos comprimidos (`*.zip`, `*.rar`, `*.7z`) y registros de servidor (`cstrike/logs/`).

---

## [2.5.0] - 2026-11-08

### 🛸 Protocolo Dead Space (Cámara OTS & Mira Láser 3D Volumétrica)
- **📐 Cámara Cinematográfica sobre el Hombro (Over-The-Shoulder - OTS):**
  - Calibración a 48 unidades de distancia de la espalda y 16 grados de desplazamiento angular hacia el hombro derecho (`cam_idealdist 48`, `cam_idealyaw 16`), idéntico al encuadre de Isaac Clarke en *Dead Space*.
  - Sistema de contención y anticolisión perimetral (`cam_contain 1`) para evitar clipping al pasar por esquinas o muros.
- **🔴 Apuntado Láser 3D Volumétrico (Solución Definitiva al Paralaje):**
  - Proyección de haz láser continuo en Cian Neón (`sprites/laserbeam.spr`) desde la boca del arma hasta el punto exacto de impacto en el mapa.
  - Sprite reactivo de impacto (`sprites/laserdot.spr`) en el mundo tridimensional: el jugador apunta guiándose por el punto físico donde impactarán las balas.
- **🧬 Indicador Biométrico RIG en la Columna Vertebral:**
  - Modulación dinámica del aura de la armadura según los puntos de vida en tiempo real: Cian Eléctrico ($\ge 70$ HP), Ámbar/Amarillo Alerta ($30-69$ HP) y Rojo Crítico ($< 30$ HP).
- **🕹️ Alternancia Rápida (Teclas V y F5):**
  - Transición instantánea entre la perspectiva Dead Space OTS y la vista clásica en 1ra persona con confirmación sónica y mensaje en pantalla.

---

## [2.4.0] - 2026-11-08

### ⚡ Motor Metamod + AMX Mod X & Armamento Sci-Fi (CSO / CSNZ Suite)
- **🦿 Tercera Persona Real (`CAMERA_3RDPERSON`):** Integración nativa del hook de motor GoldSrc para vista externa libre mientras juegas con bots y multijugador, superando la limitación del ejecutable original de CS 1.6. Alternable en tiempo real con `V` o `F5`.
- **💥 Cañón Gauss / Railgun (Francotiradores AWP & Scout):** Disparo de rayo láser continuo en Cian Neón (`TE_BEAMPOINTS`), destello de iluminación dinámica en recámara e impacto (`TE_DLIGHT`), chispas eléctricas de alto voltaje (`TE_SPARKS`) y anillo expansivo de choque (`TE_BEAMCYLINDER`) con sonido de descarga de Gauss de Half-Life.
- **🔮 Lanza-Granadas de Plasma (HE Grenade):** Proyectil de energía con estela luminosa de plasma Cian (`TE_BEAMFOLLOW`), aura de blindaje brillante y detonación en pulso electromagnético expansivo con anillo de onda de choque y descarga sónica de plasma.
- **🛡️ Escudo Táctico Holográfico:** Aura de fuerza traslúcida y deflexión balística con chispas de plasma al recibir impactos de bala.

---

## [2.3.0] - 2026-11-08

### 🦿 Modo Tercera Persona Cyberpunk (TPS Over-The-Shoulder)
- **Cámara Externa Calibrada:** Ajuste automático a 90 unidades de distancia y elevación angular de 10° (`cam_idealpitch 10`, `cam_idealdist 90`) con detección y contención de colisiones con muros (`cam_contain 1`), dejando la retícula de disparo 100% visible sin que el casco tape la mira.
- **Alternancia Rápida de Perspectiva (1 ms):** Teclas directas **`V`** y **`F5`** configuradas con alias en memoria para alternar instantáneamente entre vista en 3ra persona y vista clásica en 1ra persona.
- **Selector de Perspectiva en Menú H (`commandmenu.txt`):** Nuevo menú `[CÁMARA] Perspectiva & Vista` con opciones directas de 3ra persona TPS y 1ra persona FPS.
- **Lanzador Rápido:** Creación de `INICIAR_CS16_CYBERPUNK.bat` en la raíz del proyecto y acceso directo en el Escritorio.

---

## [2.2.0] - 2026-11-08

### ⚡ Cyberpunk Overhaul (Fase 1: Despliegue Rápido)
- **👁️ Retícula Holográfica Cyberpunk para Francotiradores (`scope_arc*.tga`):**
  - Sustitución de los bordes opacos del visor telescópico por una interfaz HUD de implante ocular Kiroshi con anillo de telemetría Cian Neón (`#00f0ff`) y marcas angulares cada 15° y 5° en Amarillo Eléctrico (`#fee801`).
  - Diagnósticos de puntería en tiempo real en las cuatro esquinas: cálculo de viento, estado de batería, enlace HUD y compensador balístico.
- **💥 Diseño Sonoro FX de Granadas y Explosivos Cyberpunk:**
  - `flashbang`: Sobrecarga sensorial neuronal / glitch auditivo cibernético con modulación de frecuencia e implosión sub-grave.
  - `hegrenade` & `explode3..5`: Detonación de pulso electromagnético (EMP) con golpe sónico en 50 Hz y descarga de plasma.
  - `sg_explode`: Descompresión criogénica de nanopartículas con siseo presurizado y chasquido de apertura mecánica.
  - `c4_explode1`: Explosión apocalíptica de ciber-núcleo con retumbe sísmico en 38 Hz y cola reverberante.
- **🖥️ Esquema de Color Terminal Cyberpunk / Arasaka (`ClientScheme.res`):**
  - Fondo en negro carbón profundo (`10 12 18`) con textos y bordes en Cian Eléctrico y Amarillo Neón.
  - Equipos coloreados con iluminación fluorescente: Fuerzas Antiterroristas en Azul Cian Neón (`0 220 255`) y Fuerzas Terroristas en Carmesí Neón (`255 50 70`).
- **🎵 Banda Sonora Darksynth del Menú Principal (`media/gamestartup.mp3`):**
  - Pista original de música electrónica cyberpunk a 124 BPM generada por síntesis analógica, arpegios en Re menor y línea de bajo rodante que suena al iniciar el juego.

---

## [2.1.0] - 2026-11-08

### 🛡️ Protección de Propiedad Intelectual & Repositorio Limpio
- **Blindaje Git Local (`assume-unchanged`):** Los modelos 3D y assets binarios sensibles se mantienen desacoplados del rastreo remoto para garantizar un repositorio 100% libre de riesgos de DMCA y derechos de autor.
- **Actualización de `.gitignore`:** Exclusión de carpetas de herramientas (`tools/`), scripts de build/compilación, temporales de síntesis y backups de audio.

### 🔊 Remasterización Sonora (44.1 / 22 kHz PCM)
- **Suite de Radio Táctica con Asistente de IA (Protocolo NEXO):**
  - Reemplazo completo de los 46 comandos clásicos de radio por una voz de IA táctica sintetizada mediante red neuronal (`es-ES-ElviraNeural`).
  - Procesamiento DSP avanzado con filtro pasabanda militar (220 Hz – 5.200 Hz), realce de presencia en 2.4 kHz y compresión de intercomunicador táctico.
- **Efectos de Sonido para Guanteletes Repulsores (`knife_*.wav`):**
  - Despliegue con sonido de carga de energía e ignición magnética (*whiiir-CHING*).
  - Trazado de corte con ráfaga sónica y desplazamiento de aire.
  - Impactos cinéticos con descarga de arco eléctrico y pegada de subgraves.
  - Choques de aleación de titanio contra hormigón y superficies duras.
  - Ataque pesado secundario con detonación sónica de sobrecarga en 55 Hz.
- **Disparos y Mecánicas de Recarga:**
  - Realce de graves profundos en 68 Hz, pegada en transitorios y cola de reverberación acústica espacial en armamento principal (AK-47, M4A1, AWP, Deagle, MP5, etc.).
  - Sonidos de inserción de cargador y cerrojo limpios y de alta fidelidad.

### 🔫 Modernización de Armamento en Primera Persona (`v_*.mdl`)
- **Guantes Tácticos de Fibra de Carbono & Exoesqueleto:**
  - Inyección de texturas de fibra de carbono tejida, refuerzos mecánicos en nudillos y mangas balísticas oscuras en los 11 modelos principales de armas (`v_ak47`, `v_m4a1`, `v_awp`, `v_deagle`, `v_mp5`, `v_usp`, `v_glock18`, `v_galil`, `v_famas`, `v_scout`, `v_p90`).
  - Sustitución del modelo de manos poligonales clásicas de 1999 por estética coordinada con el traje blindado.
- **Guanteletes Repulsores (`v_knife.mdl`):**
  - Manos mecatrónicas en primera persona equipadas con reactores de palma para el combate cuerpo a cuerpo (Slot 3).

### 🤖 Roster de Armaduras (Hall of Heroes / Tech Crew)
- **Fuerzas Antiterroristas (CT):**
  - Seal Team 6 (`urban`): Mark XLII (Autonomous Propulsion).
  - GIGN (`gign`): Silver Centurion Mark XXXIII (Cryo Polar).
  - GSG-9 (`gsg9`): Heartbreaker Mark XVII (Heavy Artillery).
  - SAS (`sas`): Cobalt Protocol (Stealth Recon).
- **Fuerzas Terroristas (T):**
  - Arctic (`arctic`): Polar Frost Centurion.
  - Guerilla (`guerilla`): War Machine Mk II (Tactical Military).
  - L337 Krew (`leet`): Mark VII (Combat Heavy).
  - Phoenix (`terror`): Auren NEXO-01 (JarBees Master Armor).
- **VIP / Honor Guard (`vip`):** Spartan MJOLNIR Mark VI.
- **Tarjetas VGUI TGA:** Menús de selección de personajes en alta resolución con HUD sci-fi, telemetría Mach y núcleo de energía.

### ⚙️ Automatización e Instalación
- **Instalador Multi-Destino (`install.ps1`):** Soporte automático y simultáneo para carpetas `cstrike` y `cstrike_spanish` en VirtualStore y Program Files.
- **Ajustes Competitivos (`userconfig.cfg`):** Netcode afinado a 100 FPS (`rate 25000`, `cl_cmdrate 101`, `cl_updaterate 101`, `ex_interp 0.01`), binds rápidos y mira fija verde fluorescente.

---

## [2.0.0] - 2026-10-29
- Incorporación de menú de fondo retocado por IA en alta definición.
- Configuración visual optimizada para tarjetas gráficas modernas y monitores de alta tasa de refresco.
- Menú interactivo CommandMenu en español accesible con la tecla **H**.

---

## [1.0.0] - 2026-10-15
- Lanzamiento inicial del repositorio con binds competitivos, más de 540 mapas personalizados y script de instalación base.

