# Network Scanner

Escaner de red local para Windows. Detecta dispositivos activos, los clasifica por tipo, identifica repetidores/puntos de acceso y genera un reporte HTML.

Version actual: **v6.0**

## Caracteristicas

- **Deteccion de repetidores por WiFi (BSSID)**: lista todos los radios de tu red por `netsh` (mismo SSID, distinto BSSID), detectando repetidores/APs aunque esten en modo bridge y no tengan IP. Requiere Servicios de ubicacion activados en Windows 11.
- **Clasificacion de dispositivos**: asigna un tipo a cada equipo (Router, Repetidor/AP, Camara, Movil, PC, Impresora, TV/Media, IoT, Consola, etc.).
- **Deteccion de repetidores/AP por IP**: por nombre (RE, EX, Deco, Mesh, Orbi...), por compartir fabricante con el router, o por panel de admin web. Resumen aparte y resaltado en magenta.
- **mDNS/Bonjour**: nombres reales de moviles, TVs, Chromecast e impresoras (UDP 5353).
- **NetBIOS**: nombres de PCs y NAS Windows (NBSTAT, UDP 137).
- **SNMP**: modelo y firmware exactos de routers, APs e impresoras (sysDescr/sysName, community public).
- **Banners de servicio**: identifica software por el banner de SSH/FTP/Telnet y el header HTTP `Server`.
- **OUI IEEE completo**: catalogo oficial de ~40.000 fabricantes (descarga y cache local), con fallback a tabla interna.
- **SSDP/UPnP**: identifica dispositivos por nombre y fabricante exacto.
- **Ping + Port scan paralelos**: 254 IPs con runspaces; puertos 21, 22, 23, 53, 80, 139, 443, 445, 554, 1883, 3389, 5000, 7547, 8080, 8443, 9100.
- **DNS reverso** y **TTL OS detection**.
- **Reporte HTML**: dashboard visual (tema oscuro) con tarjetas resumen, seccion de radios WiFi y tabla ordenable; se abre en el navegador.
- **Historial con alias**: recuerda dispositivos por MAC, permite ponerles alias y marca los **dispositivos nuevos** desde el ultimo escaneo.
- **Exporta CSV** con fecha y hora, incluyendo Tipo e Info tecnica.
- **Multi-red**: permite elegir interfaz si hay varias redes disponibles.

## Actualizaciones v6.0

- **Deteccion de repetidores/APs por radio WiFi** (`netsh wlan ... mode=bssid`): encuentra los puntos de acceso de tu malla aunque no tengan IP.
- **Descubrimiento de nombres** por mDNS, NetBIOS y SNMP, ademas de UPnP/DNS/HTTP.
- **SNMP** para modelo y firmware exactos de equipo de red e impresoras.
- **Banner grabbing** (SSH/FTP/Telnet + header HTTP Server).
- **Catalogo OUI IEEE** de ~40.000 fabricantes con cache local.
- **Reporte HTML** que se abre automaticamente al terminar.
- **Historial con alias** por MAC y deteccion de **dispositivos nuevos**.
- Tabla **agrupada por tipo** y barra de progreso.
- Codificacion UTF-8 (BOM) para acentos correctos en consola y reporte.

## Actualizaciones v5.3

- Nueva columna **Tipo** con clasificacion automatica del dispositivo.
- Deteccion heuristica de repetidores y puntos de acceso, resaltados en **magenta** y listados en un resumen al final del escaneo.
- Puerto **9100** anadido al scan para detectar impresoras de red.
- La columna Tipo se incluye tambien en el CSV exportado.

## Actualizaciones v5.2

- Optimizacion de recursos en ping, escaneo de puertos y runspaces.
- Cierre explicito de objetos de red para evitar residuos durante escaneos repetidos.
- Menos trabajo repetido al detectar interfaces de red.
- Deduplicacion de IPs antes de ordenar resultados.
- Validacion mas segura de MACs cortas o invalidas.
- Creditos actualizados.

## Uso

Doble clic en `escaner-red.exe`.

No requiere instalacion ni dependencias externas. Al terminar cada escaneo:

- Muestra la tabla en consola, agrupada por tipo.
- Lista los radios WiFi de tu red y los repetidores/APs detectados.
- Guarda un CSV y un reporte HTML en el escritorio y abre el HTML en el navegador.
- Ofrece poner un **alias** a una IP (`a`), volver a escanear (`s`) o salir (`n`).

Para ver los repetidores por radio WiFi en Windows 11, activa **Configuracion > Privacidad y seguridad > Ubicacion**.

## Columnas

| Columna | Descripcion |
|---------|-------------|
| IP | Direccion IP del dispositivo |
| MAC | Direccion MAC |
| Ping | Latencia en ms |
| Tipo | Categoria del dispositivo (Router, Repetidor/AP, Camara, Movil, PC...) |
| Nombre | Alias, o nombre por SNMP / UPnP / mDNS / NetBIOS / HTTP / DNS |
| Fabricante | Marca del dispositivo (OUI IEEE) |
| Puertos | Puertos TCP abiertos |
| Info | sysDescr SNMP o banner de servicio (CSV y HTML) |

## Colores

- `Cyan`: este PC.
- `Verde`: gateway o router.
- `Magenta`: repetidor o punto de acceso detectado.
- `Rojo`: dispositivo nuevo desde el ultimo escaneo (marcado con `*`).
- `Amarillo`: dispositivo con puerto inseguro, como Telnet o FTP.
- `Gris`: sin identificar.

## Datos persistentes

En `%LOCALAPPDATA%\net-scanner\`:

- `oui-cache.txt`: catalogo OUI IEEE cacheado (se refresca cada ~45 dias).
- `known-devices.json`: historial de dispositivos y alias por MAC.

## Requisitos

- Windows 10 / 11
- PowerShell 5.1
- `curl.exe`

PowerShell 5.1 y `curl.exe` vienen incluidos en Windows 10/11. El catalogo OUI completo requiere conexion a internet la primera vez (si no, usa la tabla interna).

## Desarrollado por

**Lucas M. Vicente** + **Claude (Anthropic)** + **OpenAI Codex**
