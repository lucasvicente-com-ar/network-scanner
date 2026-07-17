# Network Scanner

Escaner de red local para Windows. Detecta dispositivos activos, fabricantes, sistemas operativos estimados, puertos abiertos y titulos HTTP.

Version actual: **v5.3**

## Caracteristicas

- **SSDP/UPnP**: identifica dispositivos por nombre y fabricante exacto.
- **Ping paralelo**: escanea 254 IPs con runspaces.
- **Port scan**: detecta puertos abiertos como 21, 22, 23, 80, 443, 554, 3389, 8080, 8443 y 9100.
- **DNS reverso**: resuelve nombres de host en paralelo.
- **HTTP title**: obtiene el titulo web de dispositivos con puertos HTTP/HTTPS abiertos.
- **OUI MAC lookup**: identifica fabricante por direccion MAC.
- **TTL OS detection**: estima el sistema operativo por TTL.
- **Clasificacion de dispositivos**: asigna un tipo a cada equipo (Router, Repetidor/AP, Camara, Movil, PC, Impresora, TV/Media, IoT, etc.).
- **Deteccion de repetidores/AP**: identifica extensores y puntos de acceso por nombre (RE, EX, Deco, Mesh, Orbi...), por panel de admin web o por compartir fabricante con el router, y muestra un resumen aparte.
- **Colores**: tabla visual segun tipo de dispositivo.
- **Exporta CSV**: guarda el resultado con fecha y hora en el escritorio (incluye la columna Tipo).
- **Multi-red**: permite elegir interfaz si hay varias redes disponibles.

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

No requiere instalacion ni dependencias externas.

## Columnas

| Columna | Descripcion |
|---------|-------------|
| IP | Direccion IP del dispositivo |
| MAC | Direccion MAC |
| Ping | Latencia en ms |
| OS | Sistema operativo estimado |
| Tipo | Categoria del dispositivo (Router, Repetidor/AP, Camara, Movil, PC...) |
| Nombre | Nombre del dispositivo por UPnP, HTTP title o DNS |
| Fabricante | Marca del dispositivo |
| Puertos | Puertos TCP abiertos |

## Colores

- `Cyan`: este PC.
- `Verde`: gateway o router.
- `Magenta`: repetidor o punto de acceso detectado.
- `Amarillo`: dispositivo con puerto inseguro, como Telnet o FTP.
- `Gris`: sin identificar.

## Requisitos

- Windows 10 / 11
- PowerShell 5.1
- `curl.exe`

PowerShell 5.1 y `curl.exe` vienen incluidos en Windows 10/11.

## Desarrollado por

**Lucas M. Vicente** + **Claude (Anthropic)** + **OpenAI Codex**
