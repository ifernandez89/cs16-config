# 📋 Registro de Cambios (Changelog) - CS 1.6 Config & Mod Suite

Todas las actualizaciones y mejoras del paquete de configuración, armaduras y modernización técnica para Counter-Strike 1.6 están documentadas en este archivo.

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

