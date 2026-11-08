# 📋 Registro de Cambios (Changelog) - CS 1.6 Config & Mod Suite

Todas las actualizaciones y mejoras del paquete de configuración, armaduras y modernización técnica para Counter-Strike 1.6 están documentadas en este archivo.

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
