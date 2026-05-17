# Network Scanner

Escaner de red local para Windows. Detecta dispositivos activos, fabricantes, sistemas operativos estimados, puertos abiertos y titulos HTTP.

Version actual: **v5.2**

## Caracteristicas

- **SSDP/UPnP**: identifica dispositivos por nombre y fabricante exacto.
- **Ping paralelo**: escanea 254 IPs con runspaces.
- **Port scan**: detecta puertos abiertos como 21, 22, 23, 80, 443, 554, 3389, 8080 y 8443.
- **DNS reverso**: resuelve nombres de host en paralelo.
- **HTTP title**: obtiene el titulo web de dispositivos con puertos HTTP/HTTPS abiertos.
- **OUI MAC lookup**: identifica fabricante por direccion MAC.
- **TTL OS detection**: estima el sistema operativo por TTL.
- **Colores**: tabla visual segun tipo de dispositivo.
- **Exporta CSV**: guarda el resultado con fecha y hora en el escritorio.
- **Multi-red**: permite elegir interfaz si hay varias redes disponibles.

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
| Nombre | Nombre del dispositivo por UPnP, HTTP title o DNS |
| Fabricante | Marca del dispositivo |
| Puertos | Puertos TCP abiertos |

## Colores

- `Cyan`: este PC.
- `Verde`: gateway o router.
- `Amarillo`: dispositivo con puerto inseguro, como Telnet o FTP.
- `Gris`: sin identificar.

## Requisitos

- Windows 10 / 11
- PowerShell 5.1
- `curl.exe`

PowerShell 5.1 y `curl.exe` vienen incluidos en Windows 10/11.

## Desarrollado por

**Lucas M. Vicente** + **Claude (Anthropic)** + **OpenAI Codex**
