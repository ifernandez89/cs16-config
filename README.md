# 🎯 Counter-Strike 1.6 - Professional Config & Autoexec

[![CS 1.6 Config](https://img.shields.io/badge/Counter--Strike-1.6-orange.svg)](https://store.steampowered.com/app/10/CounterStrike/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Configuracion optimizada para **Counter-Strike 1.6**. Incluye mira de alto contraste sin transparencia, solucion de mano derecha, cambio rapido de armas, netcode optimizado para 100 FPS, binds de compra rapida y un menu de comandos (**Tecla H**) totalmente personalizado en espanol.

---

## 🚀 Características Principales

- **🎯 Mira Optimizada:** Color verde fluorescente (`0 255 0`), tamano mediano, 100% solida (sin transparencia) y fija (no se expande al correr).
- **🔫 Mano Derecha Forzada:** Solucion definitiva al bug de la mano izquierda (`cl_righthand 1`).
- **⚡ FastSwitch Activo (`hud_fastswitch 1`):** Cambia de arma al instante con los numeros o rueda del raton sin hacer clic.
- **🛡️ Anti-AutoSwitch (`_cl_autowepswitch 0`):** Evita equipar automaticamente armas recogidas del suelo durante un tiroteo.
- **📡 Netcode Competitivo & 100 FPS:** `fps_max 101.0`, `rate 25000`, `cl_cmdrate 101`, `cl_updaterate 101`, `ex_interp 0.01`.
- **⌨️ Binds de Compra Rapida:** Compras instantaneas usando teclas **F1-F4** y el **Teclado Numerico (Numpad)**.
- **📜 Menu 'H' Personalizado (`commandmenu.txt`):** Ajusta la mira, cambia la mano de arma, controla Bots y maneja servidores locales desde un menu intuitivo dentro del juego.

---

## ⌨️ Asignaciones de Teclas (Quick-Buy Binds)

### Teclas de Funcion (F1 - F4)
| Tecla | Equipamiento Comprado |
| :---: | :--- |
| **F1** | AK-47 / M4A1 + Chaleco + Casco + HE + 2 Flash + Defusador |
| **F2** | AWP + Deagle + Chaleco + Casco + HE + 2 Flash + Defusador |
| **F3** | Deagle + Chaleco + Casco + HE + 2 Flash + Defusador |
| **F4** | Kit de Granadas (HE, 2 Flash, Smoke) + Defusador |

### Teclado Numerico (Numpad)
| Tecla Numpad | Equipamiento Comprado |
| :---: | :--- |
| **7 (Home)** | AK-47 / M4A1 + Chaleco + Casco + Granadas |
| **8 (Up Arrow)** | AWP + Deagle + Chaleco + Casco + Granadas |
| **9 (PgUp)** | Deagle + Chaleco + Casco + Granadas |
| **4 (Left Arrow)** | Kit completo de Granadas |
| **5 (Clear)** | Chaleco + Casco |
| **6 (Right Arrow)** | Kit de Desactivacion (Defuser) |
| **1 (End)** | FAMAS / Galil + Chaleco + Casco + Granadas |
| **2 (Down Arrow)** | MP5 + Chaleco + Casco + Granadas |

---

## 📜 Funciones del Menú 'H' (CommandMenu)

Presiona la tecla **H** dentro de una partida para acceder a:
1. **Mano del Arma:** Cambiar entre mano derecha e izquierda.
2. **Ajustes de Mira:** Cambiar tamano (Pequeno, Mediano, Grande, Auto), color (Verde, Rojo, Amarillo, Azul, Blanco), dinamismo y transparencia con 1 clic.
3. **Control de Bots:** Agregar Terroristas/CTs, eliminar bots, cambiar dificultad y restringir armas.
4. **Servidor Local / Practica:** Reiniciar ronda, otorgar $16.000, cambiar tiempo de ronda a 5 min, ajustar gravedad.

---

## 📥 Instalación

### Método Automático (Recomendado - 1 Clic)
1. Descarga o clona este repositorio.
2. Haz clic derecho sobre `install.ps1` y selecciona **Ejecutar con PowerShell**.
3. El script detectara automaticamente la carpeta de tu Counter-Strike 1.6 o la carpeta VirtualStore de Windows y copiara los archivos.

### Método Manual
Copia el contenido de la carpeta `cstrike` de este repositorio dentro de la carpeta de tu juego:
`C:\Program Files (x86)\Counter-Strike 1.6\cstrike\` (o en `C:\Users\<TuUsuario>\AppData\Local\VirtualStore\Program Files (x86)\Counter-Strike 1.6\cstrike\`).

---

## 📜 Licencia

Este proyecto esta bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para mas detalles.
