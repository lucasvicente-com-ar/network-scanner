# Network Scanner

Escaner de red local para Windows. Detecta dispositivos activos, los clasifica por tipo, identifica repetidores/puntos de acceso y genera un reporte HTML.

Version actual: **v6.1**

## Modos de escaneo

Al arrancar puedes elegir el modo (o pasar `-Lite` / `-Power` como parametro):

- **Lite**: lo mas rapido posible. Ping + MAC/fabricante + WiFi BSSID + mini escaneo de puertos + clasificacion. Sin descubrimiento pasivo ni descarga del catalogo OUI. Ideal para un inventario rapido (~2x mas rapido que Power).
- **Power**: descubrimiento completo. Anade port scan completo, SNMP, mDNS, NetBIOS, banners, titulos HTTP, SSDP/UPnP y catalogo OUI IEEE. Ideal para identificar equipos con el maximo detalle.

Puedes cambiar de modo entre escaneos con la opcion `[m]` del menu.

| Tecnica | Lite | Power |
|---------|:----:|:-----:|
| Ping sweep (254 IPs) | ✅ | ✅ |
| ARP -> MAC / fabricante | ✅ | ✅ |
| WiFi BSSID (repetidores por radio) | ✅ | ✅ |
| Clasificacion por tipo | ✅ | ✅ |
| Escaneo de puertos | mini (4) | completo (16) |
| Catalogo OUI IEEE (~40k) | solo cache | descarga |
| DNS reverso | — | ✅ |
| NetBIOS (nombres de PC) | — | ✅ |
| SNMP (modelo/firmware) | — | ✅ |
| Banners SSH/FTP + HTTP Server | — | ✅ |
| Titulos HTTP | — | ✅ |
| SSDP/UPnP + mDNS/Bonjour | — | ✅ |
| Reporte HTML + CSV + historial | ✅ | ✅ |

Tiempo tipico en una red domestica: **Lite ~7 s**, **Power ~14 s** (depende del numero de equipos activos).

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

## Como detecta los repetidores / puntos de acceso

El scanner combina cuatro senales, de la mas fiable a la mas heuristica:

1. **Radio WiFi (BSSID)** — la mas directa. Los repetidores y APs de tu malla
   emiten el **mismo SSID** que el router pero con un **BSSID distinto** (la MAC
   de cada radio). El scanner los lista con `netsh wlan show networks mode=bssid`
   y marca como repetidor todos los BSSID de tu SSID que no sean el que te da
   señal. Funciona **aunque el repetidor este en modo bridge y no tenga IP**.
   Requiere Servicios de ubicacion activados (Windows 11).
2. **Nombre** — si el nombre (por UPnP, HTTP, mDNS, SNMP o DNS) contiene patrones
   tipo `RE`, `EX`, `Deco`, `Mesh`, `Orbi`, `Velop`, `eero`, `Extender`,
   `Repeater` o `Access Point`, se clasifica como `Repetidor/AP` (confirmado).
3. **Mismo fabricante que el router** — un dispositivo con el mismo OUI que tu
   gateway, que no es el gateway, es casi siempre un repetidor/AP de la misma
   marca. Se marca como `Repetidor/AP?` (por confirmar).
4. **Fabricante de red + panel web** — un equipo de una marca de networking
   (TP-Link, Asus, Netgear, D-Link, Linksys, Tenda, Mercusys, Eero, Ubiquiti...)
   con puerto 80/443 abierto se marca como `Repetidor/AP?`.

Los confirmados y los "por confirmar" se distinguen en la salida, se resaltan en
**magenta** y se listan en un resumen aparte al final del escaneo.

## Actualizaciones v6.1

- **Modos Lite y Power**: elige entre inventario rapido o descubrimiento completo, con menu al inicio, parametros `-Lite`/`-Power` y cambio de modo en caliente (`[m]`).
- En modo Lite el catalogo OUI no se descarga (usa cache o tabla interna) y el escaneo de puertos es minimo, para maxima velocidad.
- Barra de progreso adaptada al numero de fases de cada modo.

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

Doble clic en `escaner-red.exe` y elige el modo (Lite o Power). Tambien puedes ejecutarlo con un modo fijo:

```
escaner-red.exe -Lite
escaner-red.exe -Power
```

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

## Solucion de problemas

- **No aparecen los repetidores por WiFi / "Servicios de ubicacion"**: Windows 11
  exige ubicacion activada para exponer los BSSID. Actívala en *Configuracion >
  Privacidad y seguridad > Ubicacion*. Sin esto, los repetidores igual se detectan
  por IP (mismo fabricante que el router), pero no por radio.
- **SmartScreen bloquea el .exe**: al no estar firmado, Windows puede avisar. Elige
  *Mas informacion > Ejecutar de todas formas*, o ejecuta el `.ps1` directamente.
- **SNMP / mDNS / NetBIOS no devuelven nada**: son best-effort. SNMP solo responde
  si el equipo tiene agente con community `public`; NetBIOS si tiene NetBIOS over
  TCP/IP activado; mDNS si hay dispositivos que lo anuncian. Su ausencia no afecta
  al resto del escaneo.
- **El escaneo va lento**: usa el modo **Lite**, o ejecuta `escaner-red.exe -Lite`.
- **Acentos mal en consola**: el `.ps1` debe guardarse como **UTF-8 con BOM**
  (PowerShell 5.1 lo requiere). Si editas el script, conserva el BOM.

## Compilar desde el codigo

El ejecutable se genera desde `escaner-red.ps1` con [ps2exe](https://github.com/MScholtes/PS2EXE):

```powershell
Install-Module ps2exe -Scope CurrentUser
Invoke-ps2exe -inputFile escaner-red.ps1 -outputFile escaner-red.exe `
    -title "Network Scanner" -version "6.1.0.0" -product "Network Scanner" -company "Lucas M. Vicente"
```

## Desarrollado por

**Lucas M. Vicente** + **Claude (Anthropic)** + **OpenAI Codex**
