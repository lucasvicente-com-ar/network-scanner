# Network Scanner

Escaner de red local para Windows. Detecta todos los dispositivos activos, identifica fabricantes, sistemas operativos, puertos abiertos y titulos HTTP.

## Caracteristicas

- **SSDP/UPnP** — identifica dispositivos por nombre y fabricante exacto
- **Ping paralelo** — escanea 254 IPs en ~5 segundos (50 hilos)
- **Port scan** — detecta puertos abiertos (80, 443, 22, 554, 3389, etc.)
- **DNS reverso** — resuelve nombres de host en paralelo
- **HTTP title** — obtiene el titulo de la pagina web de cada dispositivo
- **OUI MAC lookup** — identifica fabricante por MAC address (~300 vendors)
- **TTL OS detection** — estima el sistema operativo por TTL
- **Colores** — tabla con colores segun tipo de dispositivo
- **Exporta CSV** — guarda resultado con fecha/hora en el escritorio
- **Multi-red** — si hay varias interfaces de red, pregunta cual escanear

## Uso

Doble clic en `escaner-red.exe`

No requiere instalacion ni dependencias.

## Columnas

| Columna | Descripcion |
|---------|-------------|
| IP | Direccion IP del dispositivo |
| MAC | Direccion MAC |
| Ping | Latencia en ms |
| OS | Sistema operativo estimado (Windows / Linux-Android / Router-IoT) |
| Nombre | Nombre del dispositivo (UPnP, HTTP title o DNS) |
| Fabricante | Marca del dispositivo |
| Puertos | Puertos TCP abiertos |

## Colores

- `Cyan` — Este PC
- `Verde` — Gateway / Router
- `Amarillo` — Dispositivo con puerto inseguro (Telnet/FTP)
- `Gris` — Sin identificar

## Desarrollado por

**Lucas M. Vicente** + **Claude (Anthropic)**

## Requisitos

- Windows 10 / 11

> PowerShell 5.1 y curl.exe vienen incluidos en Windows 10/11, no se necesita instalar nada adicional.
