# 🎯 Counter-Strike 1.6 - Professional Config, Custom Skins & Map Pack

[![CS 1.6 Config](https://img.shields.io/badge/Counter--Strike-1.6-orange.svg)](https://store.steampowered.com/app/10/CounterStrike/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Configuración completa y optimizada para **Counter-Strike 1.6**. Este paquete incluye la configuración competitiva, solución al bug de mano derecha, mira fija sin transparencia, mas de 500 mapas personalizados, skins de personajes (Iron Man, Kurt Cobain, etc.), modelos de armas, paquetes de sonidos y un menú interactivo en español (**Tecla H**).

---

## 📦 Contenido Incluido en el Repositorio

- **🧟 Modo CoD: Nazi Zombies Classic:** Oleadas progresivas inspiradas en *Call of Duty: World at War*, sistema de puntos por impacto y bajas, máquina Perk-a-Cola (`/perks`), Caja Misteriosa ($950) (`/box`), Power-ups aleatorios (Max Ammo, Insta-Kill, Nuke, Double Points) y reparación de barricadas con tecla **E**.
- **🗺️ Mapas Personalizados (+540 mapas):** Colección de mapas clásicos y personalizados (`de_dust2`, `cs_deagle5`, `fy_pool_day`, `zm_`, `gungame_`, `awp_`, etc.).
- **🎭 Skins & Modelos de Personajes:** Packs de personajes como *Iron Man CT/T*, *Kurt Cobain*, modelos *skelet*, y variantes personalizadas de Terroristas y Anti-Terroristas.
- **🔊 Pack de Sonidos:** Efectos de sonido ambient, *GunGame*, *Ultimate Sounds*, radio femenina y sonidos de armas mejorados.
- **🎨 Sprites & GFX:** Sprites de armas, miras personalizadas, efectos y *HD Skyboxes*.
- **🎯 Mira Optimizada:** Color verde fluorescente (`0 255 0`), tamaño mediano, 100% sólida (sin transparencia) y fija (`cl_dynamiccrosshair 0`).
- **🔫 Mano Derecha Forzada:** Solución permanente al bug de la mano izquierda (`cl_righthand 1`).
- **⚡ FastSwitch Activo (`hud_fastswitch 1`):** Equipado instantáneo de armas con números/rueda del ratón.
- **🛡️ Anti-AutoSwitch (`_cl_autowepswitch 0`):** Evita cambiar automáticamente al arma recogida del suelo en combate.
- **📡 Netcode Competitivo & 100 FPS:** `fps_max 101.0`, `rate 25000`, `cl_cmdrate 101`, `cl_updaterate 101`, `ex_interp 0.01`.
- **⌨️ Binds de Compra Rápida:** Compras instantáneas usando teclas **F1-F4** y el **Teclado Numérico (Numpad)**.
- **📜 Menú 'H' Personalizado (`commandmenu.txt`):** Menú en español para ajustar mira, mano de arma, bots y servidor local.

---

## ⌨️ Asignaciones de Teclas (Quick-Buy Binds)

### Teclas de Función (F1 - F4)
| Tecla | Equipamiento Comprado |
| :---: | :--- |
| **F1** | AK-47 / M4A1 + Chaleco + Casco + HE + 2 Flash + Defusador |
| **F2** | AWP + Deagle + Chaleco + Casco + HE + 2 Flash + Defusador |
| **F3** | Deagle + Chaleco + Casco + HE + 2 Flash + Defusador |
| **F4** | Kit de Granadas (HE, 2 Flash, Smoke) + Defusador |

### Teclado Numérico (Numpad)
| Tecla Numpad | Equipamiento Comprado |
| :---: | :--- |
| **7 (Home)** | AK-47 / M4A1 + Chaleco + Casco + Granadas |
| **8 (Up Arrow)** | AWP + Deagle + Chaleco + Casco + Granadas |
| **9 (PgUp)** | Deagle + Chaleco + Casco + Granadas |
| **4 (Left Arrow)** | Kit completo de Granadas |
| **5 (Clear)** | Chaleco + Casco |
| **6 (Right Arrow)** | Kit de Desactivación (Defuser) |
| **1 (End)** | FAMAS / Galil + Chaleco + Casco + Granadas |
| **2 (Down Arrow)** | MP5 + Chaleco + Casco + Granadas |

---

## 📜 Funciones del Menú 'H' (CommandMenu)

Presiona la tecla **H** dentro de una partida para acceder a:
1. **Mano del Arma:** Cambiar entre mano derecha e izquierda.
2. **Ajustes de Mira:** Cambiar tamaño (Pequeño, Mediano, Grande, Auto), color (Verde, Rojo, Amarillo, Azul, Blanco), dinamismo y transparencia con 1 clic.
3. **Control de Bots:** Agregar Terroristas/CTs, eliminar bots, cambiar dificultad y restringir armas.
4. **Servidor Local / Práctica:** Reiniciar ronda, otorgar $16.000, cambiar tiempo de ronda a 5 min, ajustar gravedad.

---

## 🧟 Modo Call of Duty: Nazi Zombies Classic

Recreación integral de la experiencia clásica de supervivencia por oleadas inspirada en *Nacht der Untoten*:
- **Lanzamiento rápido:** Haz doble clic sobre [`INICIAR_COD_ZOMBIES.bat`](file:///d:/Projects/cs16-config-repo/INICIAR_COD_ZOMBIES.bat) para entrar directamente al mapa de supervivencia con bots zombis configurados.
- **Teclas y Binds de Supervivencia:**
  - **Tecla `P`** o escribe `/perks` en el chat: Abre la máquina de ventajas Perk-a-Cola (*Juggernog*, *Speed Cola*, *Double Tap*, *Quick Revive*).
  - **Tecla `B`** o escribe `/box` en el chat: Tira de la Caja Misteriosa ($950) para obtener armamento de alto calibre (o toparte con el Osito de Samantha).
  - **Tecla `E`** (`+use`): Fortifica defensas y repara barricadas ganando $+10$ créditos (hasta 50 por ronda).
  - **Tecla `H`**: Despliega el menú interactivo con la sección `[COD ZOMBIES]` para agregar más zombis, reiniciar la horda o forzar la siguiente ronda.

---

## 📥 Instalación

### Método Automático (Recomendado - 1 Clic)
1. Descarga o clona este repositorio.
2. Haz clic derecho sobre `install.ps1` y selecciona **Ejecutar con PowerShell**.
3. El script detectará automáticamente la carpeta de tu Counter-Strike 1.6 y copiará la configuración, mapas, skins y sonidos.

### Método Manual
Copia el contenido de la carpeta `cstrike` de este repositorio dentro de la carpeta de tu juego:
`C:\Program Files (x86)\Counter-Strike 1.6\cstrike\` (o en `C:\Users\<TuUsuario>\AppData\Local\VirtualStore\Program Files (x86)\Counter-Strike 1.6\cstrike\`).

---

## 📜 Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.
