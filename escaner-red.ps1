#Requires -Version 5.1
$ErrorActionPreference = "SilentlyContinue"
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}

# ── OUI: MAC → Fabricante (tabla base, nombres normalizados) ───────────────────
$OUI = @{
    "0027E3"="TP-Link";"1C3BD3"="TP-Link";"50BD5F"="TP-Link";"6C5AB0"="TP-Link";"8C25BA"="TP-Link"
    "A0F3C1"="TP-Link";"B095B9"="TP-Link";"C04A00"="TP-Link";"D80DC7"="TP-Link";"E492FB"="TP-Link"
    "F4F26D"="TP-Link";"FCD733"="TP-Link";"AC1526"="TP-Link";"5054FF"="TP-Link";"B0487A"="TP-Link"
    "1CC626"="TP-Link";"742044"="TP-Link";"80EA96"="TP-Link";"841324"="TP-Link";"886AC4"="TP-Link"
    "98DBC4"="TP-Link";"A84E3F"="TP-Link";"7C8BCA"="TP-Link";"5C899A"="TP-Link"
    "001422"="ASUS";"00265A"="ASUS";"08606E"="ASUS";"10FEED"="ASUS";"1C872C"="ASUS"
    "2C56DC"="ASUS";"305A3A"="ASUS";"3C970E"="ASUS";"40167E"="ASUS";"485BAE"="ASUS"
    "5404A6"="ASUS";"60A44C"="ASUS";"6045CB"="ASUS";"704D7B"="ASUS";"74D02B"="ASUS"
    "788A20"="ASUS";"804B7A"="ASUS";"90E6BA"="ASUS";"AC220B"="ASUS";"BC9746"="ASUS"
    "F07260"="ASUS";"F83286"="ASUS";"94DEED"="ASUS"
    "00095B"="Netgear";"001E2A"="Netgear";"002275"="Netgear";"009096"="Netgear";"20E52A"="Netgear"
    "2CB05D"="Netgear";"44944A"="Netgear";"4C60DE"="Netgear";"6CB0CE"="Netgear";"9C3DCF"="Netgear"
    "A040A0"="Netgear";"C03F0E"="Netgear";"E0469A"="Netgear"
    "001195"="D-Link";"0015E9"="D-Link";"001CF0"="D-Link";"1C7EE5"="D-Link"
    "340804"="D-Link";"5CD998"="D-Link";"78542E"="D-Link";"B8A386"="D-Link";"C8BE19"="D-Link"
    "000C41"="Linksys";"000E08"="Linksys";"001217"="Linksys";"00184D"="Linksys";"00906D"="Linksys"
    "C8D719"="Linksys";"EC1A59"="Linksys";"48F8B3"="Linksys"
    "000A27"="Apple";"000D93"="Apple";"001124"="Apple";"001451"="Apple";"0016CB"="Apple"
    "001EC2"="Apple";"001F5B"="Apple";"00215C"="Apple";"002241"="Apple";"002312"="Apple"
    "0025BC"="Apple";"0026B0"="Apple";"0026BB"="Apple";"3C0754"="Apple";"3CD0F8"="Apple"
    "404D7F"="Apple";"48437C"="Apple";"5C8D4E"="Apple";"5CF938"="Apple";"600308"="Apple"
    "64200C"="Apple";"6C4008"="Apple";"701124"="Apple";"705681"="Apple";"78A3E4"="Apple"
    "8C2DAA"="Apple";"984B4A"="Apple";"A45EE0"="Apple";"A8202F"="Apple";"B065BD"="Apple"
    "B09FBA"="Apple";"B418D1"="Apple";"C82A14"="Apple";"D4619D"="Apple";"DC2B2A"="Apple"
    "E099D0"="Apple";"E0ACCA"="Apple";"F0189B"="Apple";"F4F951"="Apple";"F81206"="Apple"
    "001247"="Samsung";"0015B9"="Samsung";"001632"="Samsung";"001C43"="Samsung";"001DF6"="Samsung"
    "002119"="Samsung";"002339"="Samsung";"0025A0"="Samsung";"002566"="Samsung";"0026E2"="Samsung"
    "2C0E3D"="Samsung";"347085"="Samsung";"380116"="Samsung";"3CB87A"="Samsung";"403101"="Samsung"
    "44F459"="Samsung";"488060"="Samsung";"4C3C16"="Samsung";"504E36"="Samsung";"5490E8"="Samsung"
    "5C2E59"="Samsung";"64B310"="Samsung";"68EBAE"="Samsung";"6C8336"="Samsung";"706F81"="Samsung"
    "74458A"="Samsung";"7825AD"="Samsung";"7CC3A1"="Samsung";"84256B"="Samsung";"8825B3"="Samsung"
    "8CABF1"="Samsung";"9449EB"="Samsung";"A8F274"="Samsung";"B047BF"="Samsung";"B4EF13"="Samsung"
    "BC20A4"="Samsung";"BC8CCD"="Samsung";"CC07AB"="Samsung";"D0176A"="Samsung";"E4324C"="Samsung"
    "E47475"="Samsung";"EC9BF3"="Samsung";"F05A09"="Samsung";"F49F54"="Samsung";"F8042E"="Samsung"
    "001882"="Xiaomi";"0C1DAF"="Xiaomi";"14F65A"="Xiaomi";"185936"="Xiaomi";"28E31F"="Xiaomi"
    "3480B3"="Xiaomi";"3CE33C"="Xiaomi";"406789"="Xiaomi";"4C4977"="Xiaomi";"5866BA"="Xiaomi"
    "642737"="Xiaomi";"688388"="Xiaomi";"7451BA"="Xiaomi";"7C1DD9"="Xiaomi";"8CBEBE"="Xiaomi"
    "9871E5"="Xiaomi";"A4C361"="Xiaomi";"C07C6F"="Xiaomi";"D4970B"="Xiaomi";"F48B32"="Xiaomi"
    "0C47C9"="Amazon";"34D270"="Amazon";"4488AC"="Amazon";"680371"="Amazon";"7001B5"="Amazon"
    "74C246"="Amazon";"78E103"="Amazon";"84D6D0"="Amazon";"A002DC"="Amazon";"A4085A"="Amazon"
    "AC63BE"="Amazon";"B47C9C"="Amazon";"F0D2F1"="Amazon";"FC65DE"="Amazon"
    "00FA7B"="Google";"08D400"="Google";"1C1ADF"="Google";"20DF3B"="Google";"3498B5"="Google"
    "38CAD3"="Google";"48B02D"="Google";"54600A"="Google";"5880E8"="Google"
    "A47732"="Google";"C898AB"="Google";"D8453D"="Google";"F88FCA"="Google";"FC6571"="Google"
    "0013A9"="Sony";"001A80"="Sony";"0024BE"="Sony";"30B5C2"="Sony"
    "4C00B8"="Sony";"5C514F"="Sony";"7054D2"="Sony";"7CF9B2"="Sony";"84C7E9"="Sony"
    "AC9B0A"="Sony";"FC0FE6"="Sony";"84CBFE"="Sony"
    "001C62"="LG";"001E75"="LG";"002483"="LG";"0025E5"="LG";"002637"="LG";"005A13"="LG"
    "18895B"="LG";"1C407D"="LG";"34A7BA"="LG";"3CA374"="LG";"40B837"="LG";"60A10A"="LG"
    "64899A"="LG";"6C9685"="LG";"88CA48"="LG";"A00BBA"="LG";"B42BB2"="LG";"CC2D8C"="LG"
    "001E10"="Huawei";"0022A1"="Huawei";"002568"="Huawei";"00259E"="Huawei";"0026E9"="Huawei"
    "009EC8"="Huawei";"047902"="Huawei";"0C37DC"="Huawei";"10C61F"="Huawei";"1C1D67"="Huawei"
    "283CE4"="Huawei";"2C9EFC"="Huawei";"30D17E"="Huawei";"344B50"="Huawei";"380102"="Huawei"
    "3CB798"="Huawei";"40CBA8"="Huawei";"48AD08"="Huawei";"4CAC0A"="Huawei";"54514C"="Huawei"
    "6865CB"="Huawei";"6C8DC1"="Huawei";"70849F"="Huawei";"74A78E"="Huawei";"784C35"="Huawei"
    "7C604F"="Huawei";"80717A"="Huawei";"883FD3"="Huawei";"8C34FD"="Huawei";"9001B4"="Huawei"
    "949226"="Huawei";"9C37F4"="Huawei";"A43177"="Huawei";"A49947"="Huawei";"A89FEC"="Huawei"
    "AC853D"="Huawei";"B0E5ED"="Huawei";"BC7670"="Huawei";"C4073C"="Huawei";"C4A81D"="Huawei"
    "C8514B"="Huawei";"CC533B"="Huawei";"D02786"="Huawei";"D46AA8"="Huawei";"D4F9A1"="Huawei"
    "D8490B"="Huawei";"DC727C"="Huawei";"E0247F"="Huawei";"E45090"="Huawei";"E8B4C8"="Huawei"
    "B4755E"="Eero";"F8EFBD"="Eero"
    "0418D6"="Ubiquiti";"002722"="Ubiquiti";"24A43C"="Ubiquiti";"44D9E7"="Ubiquiti";"687259"="Ubiquiti"
    "80213A"="Ubiquiti";"DC9FDB"="Ubiquiti";"F09FC2"="Ubiquiti";"F4E2C6"="Ubiquiti"
    "AC1C26"="Hikvision/Ezviz";"A41BAA"="Hikvision";"BC5676"="Hikvision";"282C02"="Hikvision"
    "304BDB"="Ezviz";"F4E374"="Ezviz";"D4AEB9"="Ezviz"
    "C41AC4"="Mercusys"
    "001B21"="Intel";"001D92"="Intel";"0021C5"="Intel";"002567"="Intel";"0026C7"="Intel"
    "001C25"="Intel";"001EEC"="Intel";"002313"="Intel";"047D7B"="Intel";"10026B"="Intel"
    "1866DA"="Intel";"244BFE"="Intel";"34023B"="Intel";"40A36B"="Intel"
    "5CF9DD"="Intel";"6C2934"="Intel";"784B87"="Intel";"808DA8"="Intel";"8C8D28"="Intel"
    "98E743"="Intel";"9C4E36"="Intel";"B0A428"="Intel";"B4B686"="Intel";"D85D4C"="Intel"
    "001FC7"="Realtek";"00E04C"="Realtek";"5254FF"="Realtek"
    "B827EB"="Raspberry Pi";"DCA632"="Raspberry Pi";"E45F01"="Raspberry Pi"
    "0009BF"="Nintendo";"002709"="Nintendo";"002666"="Nintendo";"00224C"="Nintendo";"001FC5"="Nintendo"
    "0019FB"="Nintendo";"4C5007"="Nintendo";"6C4148"="Nintendo";"7866A4"="Nintendo";"B898B3"="Nintendo"
    "E84ECE"="Nintendo"
    "001DD8"="Microsoft";"003017"="Microsoft";"0050F2"="Microsoft";"0017FA"="Microsoft"
    "28186B"="Microsoft";"485073"="Microsoft";"7045C4"="Microsoft";"94B86D"="Microsoft"
    "001372"="Dell";"001A4B"="Dell";"001E4F"="Dell";"00219B"="Dell";"002564"="Dell"
    "14B31F"="Dell";"18037F"="Dell";"182032"="Dell";"1C40AF"="Dell";"248551"="Dell"
    "2CD05A"="Dell";"6CC217"="Dell";"78BC1A"="Dell";"84BFBD"="Dell"
    "001083"="HP";"001560"="HP";"0017A4"="HP";"001CB1"="HP";"001E0B"="HP";"002169"="HP"
    "0021B7"="HP";"002268"="HP";"00237D"="HP";"0024E8"="HP";"002599"="HP";"0026B9"="HP"
    "1C946E"="HP";"3C4A92"="HP";"3CEA4F"="HP";"40B034"="HP";"58202F"="HP";"5C8A38"="HP"
    "708BCD"="HP";"78ACC0"="HP";"9C8E99"="HP";"A45D36"="HP";"B4B52F"="HP";"C4346B"="HP"
    "000D3A"="Lenovo";"001F16"="Lenovo";"002264"="Lenovo";"0023AE"="Lenovo";"002454"="Lenovo"
    "485BA6"="Lenovo";"60672D"="Lenovo";"742EA7"="Lenovo";"98FA9B"="Lenovo"
    "D4AE52"="Lenovo";"E8396D"="Lenovo"
    "4CEE0D"="Tenda";"788102"="Tenda";"84D9C8"="Tenda";"C83A35"="Tenda";"CC7EE5"="Tenda"
    "001788"="Philips";"0017C4"="Philips"
    "000E58"="Sonos";"5CAAD4"="Sonos";"78282E"="Sonos";"B8E937"="Sonos"
    "08052D"="Roku";"B0A737"="Roku";"CC6EAF"="Roku";"D4E29B"="Roku";"DC3A5E"="Roku"
    "F4F5E8"="Chromecast"
}

# Base OUI ampliada (IEEE), se puebla en runtime desde cache/descarga
$OUIFull = @{}

# Fabricantes de equipamiento de red (routers, repetidores, APs, mesh)
$NetVendors = @("TP-Link","ASUS","Netgear","D-Link","Linksys","Tenda","Mercusys","Eero","Ubiquiti",
                "Sagemcom","Technicolor","Arris","ZTE","Cisco","Zyxel","AVM","Cambium","Aruba","MikroTik")

# Rutas de datos persistentes
$DataDir     = Join-Path $env:LOCALAPPDATA "net-scanner"
$OuiCache    = Join-Path $DataDir "oui-cache.txt"
$KnownFile   = Join-Path $DataDir "known-devices.json"

# ── Normalizacion de nombre de fabricante ─────────────────────────────────────
function Convert-VendorName($name) {
    if (-not $name) { return "-" }
    $n = $name.Trim()
    $map = @(
        @('tp.?link','TP-Link'), @('\basus','ASUS'), @('netgear','Netgear'), @('d.?link','D-Link'),
        @('linksys','Linksys'), @('tenda','Tenda'), @('mercusys','Mercusys'), @('\beero','Eero'),
        @('ubiquiti','Ubiquiti'), @('sagemcom','Sagemcom'), @('technicolor','Technicolor'),
        @('arris','Arris'), @('\bzte\b','ZTE'), @('cisco','Cisco'), @('zyxel','Zyxel'),
        @('avm ','AVM'), @('mikrotik|routerboard','MikroTik'), @('aruba','Aruba'),
        @('apple','Apple'), @('samsung','Samsung'), @('xiaomi','Xiaomi'), @('huawei','Huawei'),
        @('amazon','Amazon'), @('google','Google'), @('\bsony','Sony'),
        @('lg electronics|lg innotek','LG'), @('hikvision','Hikvision'), @('ezviz','Ezviz'),
        @('intel','Intel'), @('realtek','Realtek'), @('raspberry','Raspberry Pi'),
        @('nintendo','Nintendo'), @('microsoft','Microsoft'), @('dell','Dell'),
        @('hewlett|hp inc','HP'), @('lenovo','Lenovo'), @('philips','Philips'),
        @('sonos','Sonos'), @('roku','Roku'), @('espressif','Espressif'),
        @('tuya','Tuya'), @('shenzhen','Shenzhen'), @('azurewave','AzureWave')
    )
    foreach ($m in $map) { if ($n -imatch $m[0]) { return $m[1] } }
    # Nombre largo del IEEE: recortar a algo legible
    $n = $n -replace '(?i)\b(technologies?|technology|co\.?|ltd\.?|inc\.?|corp\.?|corporation|gmbh|limited|company|electronics?)\b',''
    $n = ($n -replace '[",]',' ' -replace '\s+',' ').Trim()
    if ($n.Length -gt 18) { $n = $n.Substring(0,18) }
    if (-not $n) { return "-" }
    return $n
}

# ── Funciones helper ──────────────────────────────────────────────────────────
function Get-VendorKey($mac) {
    if (-not $mac -or $mac -eq "-") { return $null }
    $clean = ($mac -replace "[-:]","").ToUpper()
    if ($clean.Length -lt 6) { return $null }
    return $clean.Substring(0,6)
}

function Get-Vendor($mac) {
    $key = Get-VendorKey $mac
    if (-not $key) { return "-" }
    if ($OUI[$key])     { return $OUI[$key] }
    if ($OUIFull[$key]) { return (Convert-VendorName $OUIFull[$key]) }
    return "-"
}

function Get-OSFromTTL($ttl) {
    if (-not $ttl)    { return "-" }
    if ($ttl -le 64)  { return "Linux/Android" }
    if ($ttl -le 128) { return "Windows" }
    return "Router/IoT"
}

# ── Clasificacion de tipo de dispositivo ──────────────────────────────────────
function Get-DeviceType($vendor, $name, $ports, $isGateway, $isSelf, $gatewayVendor, $info) {
    if ($isSelf)    { return "Este PC" }
    if ($isGateway) { return "Router" }
    $n = if ($name -and $name -ne "-") { $name } else { "" }
    $i = if ($info -and $info -ne "-") { $info } else { "" }
    $hasWebAdmin = @($ports | Where-Object { $_ -in 80,443,8080,8443 }).Count -gt 0

    # Nombre / banner / SNMP con indicios de repetidor o mesh
    if (($n + " " + $i) -match "(?i)repeat|extend|range.?ext|\bRE\d|\bEX\d|mesh|deco|velop|orbi|\beero\b|access.?point|\bAP[- ]?\d") {
        return "Repetidor/AP"
    }
    # Banner / SNMP con indicios de router
    if ($i -match "(?i)router|gateway|openwrt|dd-wrt|rt-ac|rt-ax|archer") { return "Router sec." }
    # Camara IP
    if ($vendor -match "Hikvision|Ezviz" -or ($ports -contains 554) -or $i -match "(?i)camera|ipcam|dvr|nvr") { return "Camara" }
    # Streaming / media
    if ($vendor -match "Roku|Chromecast|Sonos" -or $i -match "(?i)chromecast|roku|smart.?tv|bravia|webos") { return "TV/Media" }
    # Consola
    if ($vendor -eq "Nintendo") { return "Consola" }
    # Impresora
    if ($ports -contains 9100 -or $i -match "(?i)printer|jetdirect|laserjet|officejet") { return "Impresora" }
    # Mismo fabricante que el router + no es el gateway  => casi seguro repetidor/AP de la malla
    if ($vendor -ne "-" -and $vendor -eq $gatewayVendor) { return "Repetidor/AP?" }
    # Fabricante de red con panel de admin web => probable repetidor/AP
    if (($NetVendors -contains $vendor) -and $hasWebAdmin)  { return "Repetidor/AP?" }
    # Movil / tablet (fabricante de moviles y sin panel web)
    if ($vendor -match "Apple|Samsung|Xiaomi|Huawei|LG|Sony" -and -not $hasWebAdmin) { return "Movil/Tablet" }
    # Asistentes / altavoces
    if ($vendor -match "Amazon|Google") { return "IoT/Asistente" }
    # PC
    if ($ports -contains 3389 -or $ports -contains 22) { return "PC" }
    if ($vendor -match "Intel|Dell|^HP$|Lenovo|Microsoft|Realtek") { return "PC" }
    if ($vendor -eq "Raspberry Pi") { return "Raspberry Pi" }
    if ($vendor -match "Espressif|Tuya") { return "IoT" }
    return "-"
}

# ── Base OUI IEEE: carga desde cache o descarga (fallback silencioso) ──────────
function Get-OuiDatabase {
    $db = @{}
    try {
        if (Test-Path $OuiCache) {
            foreach ($ln in [System.IO.File]::ReadLines($OuiCache)) {
                $i = $ln.IndexOf('='); if ($i -eq 6) { $db[$ln.Substring(0,6)] = $ln.Substring(7) }
            }
            $age = ((Get-Date) - (Get-Item $OuiCache).LastWriteTime).TotalDays
            if ($db.Count -gt 1000 -and $age -lt 45) { return $db }
        }
    } catch {}
    # Descargar catalogo IEEE
    try {
        if (-not (Test-Path $DataDir)) { New-Item -ItemType Directory -Path $DataDir -Force | Out-Null }
        $csv = curl.exe -sk --max-time 25 "https://standards-oui.ieee.org/oui/oui.csv" 2>$null
        if ($csv -and $csv.Count -gt 1000) {
            $new = @{}
            foreach ($line in $csv) {
                if ($line -match '^MA-L,([0-9A-Fa-f]{6}),"?([^",]+)') {
                    $new[$matches[1].ToUpper()] = $matches[2].Trim()
                }
            }
            if ($new.Count -gt 1000) {
                $sb = New-Object System.Text.StringBuilder
                foreach ($k in $new.Keys) { [void]$sb.AppendLine("$k=$($new[$k])") }
                [System.IO.File]::WriteAllText($OuiCache, $sb.ToString())
                return $new
            }
        }
    } catch {}
    return $db
}

# ── Ping sweep paralelo ───────────────────────────────────────────────────────
function Invoke-PingSweep([string]$Subred, [int]$Threads=50, [int]$Ms=600) {
    $pool = [RunspaceFactory]::CreateRunspacePool(1, $Threads); $pool.Open()
    try {
        $jobs = 1..254 | ForEach-Object {
            $ip = "$Subred.$_"
            $ps = [PowerShell]::Create().AddScript({
                param($ip,$ms)
                $p = New-Object System.Net.NetworkInformation.Ping
                try {
                    $r = $p.Send($ip,$ms)
                    if ($r.Status -eq "Success") { @{IP=$ip;Ms=$r.RoundtripTime;TTL=$r.Options.Ttl} }
                } finally {
                    $p.Dispose()
                }
            }).AddArgument($ip).AddArgument($Ms)
            $ps.RunspacePool = $pool
            @{PS=$ps; H=$ps.BeginInvoke()}
        }
        $out = @{}
        $jobs | ForEach-Object { $r=$_.PS.EndInvoke($_.H); if($r){$out[$r.IP]=$r}; $_.PS.Dispose() }
        return $out
    } finally {
        $pool.Close()
        $pool.Dispose()
    }
}

# ── DNS reverso paralelo ──────────────────────────────────────────────────────
function Invoke-DnsReverse([string[]]$IPs, [int]$Threads=50) {
    if (-not $IPs) { return @{} }
    $pool = [RunspaceFactory]::CreateRunspacePool(1, $Threads); $pool.Open()
    try {
        $jobs = $IPs | ForEach-Object {
            $ps = [PowerShell]::Create().AddScript({
                param($ip)
                try { $h=[System.Net.Dns]::GetHostEntry($ip).HostName; if($h-ne$ip){@{IP=$ip;Name=($h-split"\.")[0]}} } catch {}
            }).AddArgument($_)
            $ps.RunspacePool = $pool
            @{PS=$ps; H=$ps.BeginInvoke()}
        }
        $out = @{}
        $jobs | ForEach-Object { $r=$_.PS.EndInvoke($_.H); if($r){$out[$r.IP]=$r.Name}; $_.PS.Dispose() }
        return $out
    } finally {
        $pool.Close()
        $pool.Dispose()
    }
}

# ── NetBIOS (NBSTAT, UDP 137) paralelo ────────────────────────────────────────
function Invoke-Netbios([string[]]$IPs, [int]$Threads=60, [int]$Ms=700) {
    if (-not $IPs) { return @{} }
    $pool = [RunspaceFactory]::CreateRunspacePool(1, $Threads); $pool.Open()
    try {
        $jobs = $IPs | ForEach-Object {
            $ps = [PowerShell]::Create().AddScript({
                param($ip,$ms)
                try {
                    # NBSTAT node status request para el nombre comodin "*"
                    $req = New-Object byte[] 50
                    $req[0]=0x00; $req[1]=0x00      # transaction id
                    $req[2]=0x00; $req[3]=0x00      # flags
                    $req[4]=0x00; $req[5]=0x01      # QDCOUNT=1
                    # nombre codificado: 0x20 + "CKAAAA...AA" (32) + 0x00
                    $req[6]=0x20
                    $enc="CK"+("AA"*15)
                    for($i=0;$i-lt32;$i++){ $req[7+$i]=[byte][char]$enc[$i] }
                    $req[39]=0x00                    # fin del nombre
                    $req[40]=0x00; $req[41]=0x21      # QTYPE=NBSTAT(0x21)
                    $req[42]=0x00; $req[43]=0x01      # QCLASS=IN
                    $udp=New-Object System.Net.Sockets.UdpClient
                    $udp.Client.ReceiveTimeout=$ms
                    [void]$udp.Send($req,44,$ip,137)
                    $ep=New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Any,0)
                    $resp=$udp.Receive([ref]$ep); $udp.Close()
                    if($resp.Length -lt 57){ return }
                    $num=$resp[56]; $pos=57; $best=$null
                    for($k=0;$k -lt $num -and ($pos+17) -lt $resp.Length;$k++){
                        $nm=[System.Text.Encoding]::ASCII.GetString($resp,$pos,15).Trim()
                        $suffix=$resp[$pos+15]; $flags=$resp[$pos+16]
                        $isGroup=($flags -band 0x80) -ne 0
                        if(-not $isGroup -and $suffix -eq 0x00 -and $nm -and $nm -notmatch '^\x01\x02'){ $best=$nm; break }
                        $pos+=18
                    }
                    if($best){ @{IP=$ip;Name=$best} }
                } catch {}
            }).AddArgument($_).AddArgument($Ms)
            $ps.RunspacePool = $pool
            @{PS=$ps; H=$ps.BeginInvoke()}
        }
        $out = @{}
        $jobs | ForEach-Object { $r=$_.PS.EndInvoke($_.H); if($r){$out[$r.IP]=$r.Name}; $_.PS.Dispose() }
        return $out
    } finally {
        $pool.Close(); $pool.Dispose()
    }
}

# ── mDNS (Bonjour, UDP 5353) en un job de escucha ─────────────────────────────
function Start-MdnsJob {
    Start-Job -ScriptBlock {
        # Parser DNS minimo con soporte de compresion de nombres
        function Read-Name($b,[int]$p){
            $labels=@(); $jumped=$false; $safety=0
            while($safety -lt 128){
                $safety++
                if($p -ge $b.Length){ break }
                $len=$b[$p]
                if($len -eq 0){ if(-not $jumped){$p++}; break }
                if(($len -band 0xC0) -eq 0xC0){
                    $ptr=(($len -band 0x3F) -shl 8) -bor $b[$p+1]
                    if(-not $jumped){ $p+=2 }
                    $p=$ptr; $jumped=$true; continue
                }
                $p++
                if($p+$len -gt $b.Length){ break }
                $labels+=[System.Text.Encoding]::UTF8.GetString($b,$p,$len)
                $p+=$len
            }
            return ($labels -join ".")
        }
        $out=@{}
        try{
            $udp=New-Object System.Net.Sockets.UdpClient
            $udp.Client.SetSocketOption([System.Net.Sockets.SocketOptionLevel]::Socket,[System.Net.Sockets.SocketOptionName]::ReuseAddress,$true)
            # Bind a 5353 + unirse al grupo multicast para recibir las respuestas
            # (mDNS responde por multicast, no al puerto efimero). Fallback silencioso.
            try {
                $udp.Client.Bind((New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Any,5353)))
                $udp.JoinMulticastGroup([System.Net.IPAddress]::Parse("224.0.0.251"))
            } catch {}
            $udp.Client.ReceiveTimeout=4500
            $ep=New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Parse("224.0.0.251"),5353)
            # Consultar servicios comunes: sus respuestas incluyen el A record (hostname.local -> IP)
            $svcs=@("_services._dns-sd._udp.local","_http._tcp.local","_workstation._tcp.local",
                    "_googlecast._tcp.local","_airplay._tcp.local","_raop._tcp.local",
                    "_ipp._tcp.local","_printer._tcp.local","_companion-link._tcp.local",
                    "_spotify-connect._tcp.local","_amzn-wplay._tcp.local","_homekit._tcp.local",
                    "_device-info._tcp.local","_smb._tcp.local")
            foreach($svc in $svcs){
                $q=New-Object System.Collections.Generic.List[byte]
                0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x00 | ForEach-Object { $q.Add([byte]$_) }
                foreach($lbl in ($svc -split "\.")){
                    $q.Add([byte]$lbl.Length); [System.Text.Encoding]::ASCII.GetBytes($lbl) | ForEach-Object { $q.Add($_) }
                }
                $q.Add(0x00); $q.Add(0x00); $q.Add(0x0C); $q.Add(0x80); $q.Add(0x01)
                try { [void]$udp.Send($q.ToArray(),$q.Count,$ep) } catch {}
            }
            $deadline=(Get-Date).AddSeconds(4.5)
            while((Get-Date) -lt $deadline){
                try{
                    $rep=New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Any,0)
                    $data=$udp.Receive([ref]$rep)
                    $src=$rep.Address.ToString()
                    if($data.Length -lt 12){ continue }
                    $qd=($data[4] -shl 8) -bor $data[5]
                    $an=($data[6] -shl 8) -bor $data[7]
                    $ns=($data[8] -shl 8) -bor $data[9]
                    $ar=($data[10] -shl 8) -bor $data[11]
                    $pos=12
                    # saltar preguntas
                    for($i=0;$i -lt $qd;$i++){
                        while($pos -lt $data.Length -and $data[$pos] -ne 0){
                            if(($data[$pos] -band 0xC0) -eq 0xC0){ $pos++; break }
                            $pos+=$data[$pos]+1
                        }
                        $pos+=1; $pos+=4
                    }
                    $total=$an+$ns+$ar
                    for($i=0;$i -lt $total -and $pos -lt $data.Length;$i++){
                        $name=Read-Name $data $pos
                        # avanzar el NAME
                        while($pos -lt $data.Length){
                            $l=$data[$pos]
                            if($l -eq 0){ $pos++; break }
                            if(($l -band 0xC0) -eq 0xC0){ $pos+=2; break }
                            $pos+=$l+1
                        }
                        if($pos+10 -gt $data.Length){ break }
                        $type=($data[$pos] -shl 8) -bor $data[$pos+1]
                        $rdlen=($data[$pos+8] -shl 8) -bor $data[$pos+9]
                        $rdpos=$pos+10
                        if($type -eq 1 -and $rdlen -eq 4){
                            $aip="$($data[$rdpos]).$($data[$rdpos+1]).$($data[$rdpos+2]).$($data[$rdpos+3])"
                            $hn=($name -replace '\.local$','')
                            if($hn -and -not $out.ContainsKey($aip)){ $out[$aip]=$hn }
                        }
                        $pos=$rdpos+$rdlen
                    }
                } catch { break }
            }
            $udp.Close()
        } catch {}
        return $out
    }
}

# ── SSDP/UPnP en un job de escucha ────────────────────────────────────────────
function Start-SsdpJob {
    Start-Job -ScriptBlock {
        $msg   = "M-SEARCH * HTTP/1.1`r`nHOST: 239.255.255.250:1900`r`nMAN: `"ssdp:discover`"`r`nMX: 2`r`nST: ssdp:all`r`n`r`n"
        $bytes = [System.Text.Encoding]::ASCII.GetBytes($msg)
        $udp   = New-Object System.Net.Sockets.UdpClient
        $udp.Client.ReceiveTimeout = 2500
        $ep    = New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Parse("239.255.255.250"), 1900)
        [void]$udp.Send($bytes, $bytes.Length, $ep)
        $seen = @{}; $out = @{}
        while ($true) {
            try {
                $data = $udp.Receive([ref]$ep); $ip = $ep.Address.ToString()
                if ($seen[$ip]) { continue }; $seen[$ip] = $true
                $txt = [System.Text.Encoding]::ASCII.GetString($data)
                $loc = if ($txt -match "(?i)LOCATION:\s*(\S+)") { $matches[1] } else { $null }
                $out[$ip] = [PSCustomObject]@{ FriendlyName=$null; Manufacturer=$null; Model=$null; LocationURL=$loc }
            } catch { break }
        }
        $udp.Close()
        foreach ($ip in @($out.Keys)) {
            if (-not $out[$ip].LocationURL) { continue }
            try {
                $xml = [xml](curl.exe -sk -L --max-time 2 $out[$ip].LocationURL 2>$null)
                $out[$ip].FriendlyName = $xml.root.device.friendlyName
                $out[$ip].Manufacturer = $xml.root.device.manufacturer
                $out[$ip].Model        = $xml.root.device.modelName
            } catch {}
        }
        return $out
    }
}

# ── WiFi: APs de mi red por radio (netsh BSSID) ───────────────────────────────
function Get-WifiAPs {
    $result = [PSCustomObject]@{ SSID=$null; MyBssid=$null; APs=@(); Error=$null }
    $iface = netsh wlan show interfaces 2>&1
    $ifaceTxt = ($iface | Out-String)
    if ($ifaceTxt -match "(?i)location|ubicaci") {
        $result.Error = "location"; return $result
    }
    if ($ifaceTxt -match "(?i)no hay|is no wireless|not running|no está en") {
        $result.Error = "nowifi"; return $result
    }
    # SSID actual (evitando BSSID). Toma el valor tras 'SSID :'
    foreach ($ln in $iface) {
        if ($ln -match '^\s*SSID\s*:\s*(.+?)\s*$')  { $result.SSID    = $matches[1].Trim() }
        if ($ln -match '^\s*BSSID\s*:\s*([0-9A-Fa-f:]{17})') { $result.MyBssid = $matches[1].ToUpper() }
    }
    if (-not $result.SSID) { $result.Error = "nowifi"; return $result }

    $net = netsh wlan show networks mode=bssid 2>&1
    $curSsid=$null; $aps=@(); $cur=$null
    foreach ($ln in $net) {
        if ($ln -match '^\s*SSID\s+\d+\s*:\s*(.*)$') { $curSsid = $matches[1].Trim(); continue }
        if ($ln -match '^\s*BSSID\s+\d+\s*:\s*([0-9A-Fa-f:]{17})') {
            if ($cur) { $aps += $cur }
            $cur = [PSCustomObject]@{ SSID=$curSsid; BSSID=$matches[1].ToUpper(); Signal=$null; Channel=$null; Radio=$null }
            continue
        }
        if ($cur) {
            if ($ln -match '(\d{1,3})\s*%')                          { $cur.Signal  = [int]$matches[1] }
            if ($ln -match '(?i)(?:channel|canal)\s*:\s*(\d+)')      { $cur.Channel = $matches[1] }
            if ($ln -match '(?i)(?:radio type|tipo de radio)\s*:\s*(.+?)\s*$') { $cur.Radio = $matches[1].Trim() }
        }
    }
    if ($cur) { $aps += $cur }
    # Solo los BSSID de MI red (mismo SSID)
    $result.APs = @($aps | Where-Object { $_.SSID -eq $result.SSID })
    return $result
}

# ── Port scan paralelo ────────────────────────────────────────────────────────
function Invoke-PortScan([string[]]$IPs, [int]$Threads=150, [int]$Ms=350) {
    if (-not $IPs) { return @{} }
    $ports = @(21,22,23,53,80,139,443,445,554,1883,3389,5000,7547,8080,8443,9100)
    $pool = [RunspaceFactory]::CreateRunspacePool(1, $Threads); $pool.Open()
    try {
        $jobs = foreach ($ip in $IPs) { foreach ($p in $ports) {
            $ps = [PowerShell]::Create().AddScript({
                param($ip,$p,$ms)
                $t=New-Object System.Net.Sockets.TcpClient
                $c=$null
                try {
                    $c=$t.BeginConnect($ip,$p,$null,$null)
                    if($c.AsyncWaitHandle.WaitOne($ms)-and$t.Connected){
                        $t.EndConnect($c)
                        @{IP=$ip;P=$p}
                    }
                } catch {} finally {
                    if($c){$c.AsyncWaitHandle.Close()}
                    $t.Close()
                }
            }).AddArgument($ip).AddArgument($p).AddArgument($Ms)
            $ps.RunspacePool = $pool
            @{PS=$ps; H=$ps.BeginInvoke()}
        }}
        $out = @{}
        $jobs | ForEach-Object {
            $r=$_.PS.EndInvoke($_.H)
            if($r){
                if(-not$out.ContainsKey($r.IP)){$out[$r.IP]=New-Object System.Collections.ArrayList}
                [void]$out[$r.IP].Add($r.P)
            }
            $_.PS.Dispose()
        }
        return $out
    } finally {
        $pool.Close()
        $pool.Dispose()
    }
}

# ── Banners de servicio (SSH/FTP/Telnet) + header HTTP Server ──────────────────
function Invoke-Banners([string[]]$IPs, [hashtable]$PortTable, [int]$Threads=40) {
    if (-not $IPs) { return @{} }
    $pool = [RunspaceFactory]::CreateRunspacePool(1, $Threads); $pool.Open()
    try {
        $jobs = foreach ($ip in $IPs) {
            $pp = $PortTable[$ip]
            if (-not $pp) { continue }
            $ps = [PowerShell]::Create().AddScript({
                param($ip,$pp)
                $found=$null
                # Banners que el servidor envia al conectar (SSH 22, FTP 21, Telnet 23)
                foreach($bp in @(22,21,23)){
                    if($pp -notcontains $bp){ continue }
                    try{
                        $t=New-Object System.Net.Sockets.TcpClient
                        $c=$t.BeginConnect($ip,$bp,$null,$null)
                        if($c.AsyncWaitHandle.WaitOne(700) -and $t.Connected){
                            $t.EndConnect($c); $t.ReceiveTimeout=700
                            $s=$t.GetStream(); Start-Sleep -Milliseconds 150
                            $buf=New-Object byte[] 160
                            if($s.DataAvailable){ $n=$s.Read($buf,0,160) } else { $n=0 }
                            if($n -gt 0){
                                $b=([System.Text.Encoding]::ASCII.GetString($buf,0,$n) -replace '[\r\n\x00-\x1F]',' ').Trim()
                                if($b){ $found=($b -replace '\s+',' '); }
                            }
                            $t.Close()
                        } else { $t.Close() }
                    } catch {}
                    if($found){ break }
                }
                # Header HTTP Server
                if(-not $found -and ($pp -contains 80 -or $pp -contains 8080 -or $pp -contains 443 -or $pp -contains 8443)){
                    $u = if($pp -contains 80){"http://$ip"} elseif($pp -contains 8080){"http://${ip}:8080"} elseif($pp -contains 443){"https://$ip"} else {"https://${ip}:8443"}
                    try{
                        $hd=curl.exe -skI -L --max-time 3 $u 2>$null
                        $sv=($hd | Where-Object { $_ -match '(?i)^Server:\s*(.+)$' } | Select-Object -First 1)
                        if($sv -match '(?i)^Server:\s*(.+)$'){ $found="Server: "+($matches[1].Trim()) }
                    } catch {}
                }
                if($found){ @{IP=$ip;B=$found.Substring(0,[Math]::Min($found.Length,120))} }
            }).AddArgument($ip).AddArgument($pp)
            $ps.RunspacePool = $pool
            @{PS=$ps; H=$ps.BeginInvoke()}
        }
        $out=@{}
        $jobs | ForEach-Object { $r=$_.PS.EndInvoke($_.H); if($r){$out[$r.IP]=$r.B}; $_.PS.Dispose() }
        return $out
    } finally {
        $pool.Close(); $pool.Dispose()
    }
}

# ── SNMP v1 GET (sysDescr + sysName), community public ─────────────────────────
function New-SnmpRequest {
    function EncLen($n){ if($n -lt 128){ return ,([byte]$n) }; $b=@(); while($n -gt 0){ $b=@([byte]($n -band 0xFF))+$b; $n=$n -shr 8 }; return @([byte](0x80 -bor $b.Count))+$b }
    function EncTLV($tag,$val){ $v=@($val); return @([byte]$tag)+(EncLen $v.Count)+$v }
    $oidDescr = @(0x2B,0x06,0x01,0x02,0x01,0x01,0x01,0x00)  # 1.3.6.1.2.1.1.1.0
    $oidName  = @(0x2B,0x06,0x01,0x02,0x01,0x01,0x05,0x00)  # 1.3.6.1.2.1.1.5.0
    $vb1 = EncTLV 0x30 ((EncTLV 0x06 $oidDescr)+(EncTLV 0x05 @()))
    $vb2 = EncTLV 0x30 ((EncTLV 0x06 $oidName )+(EncTLV 0x05 @()))
    $vbl = EncTLV 0x30 ($vb1+$vb2)
    $pduBody = (EncTLV 0x02 @(0x27,0x0F))+(EncTLV 0x02 @(0x00))+(EncTLV 0x02 @(0x00))+$vbl
    $pdu = EncTLV 0xA0 $pduBody
    $body = (EncTLV 0x02 @(0x00))+(EncTLV 0x04 ([System.Text.Encoding]::ASCII.GetBytes("public")))+$pdu
    return ,([byte[]](EncTLV 0x30 $body))
}

function Invoke-Snmp([string[]]$IPs, [byte[]]$Request, [int]$Threads=60, [int]$Ms=600) {
    if (-not $IPs) { return @{} }
    $pool = [RunspaceFactory]::CreateRunspacePool(1, $Threads); $pool.Open()
    try {
        $jobs = $IPs | ForEach-Object {
            $ps = [PowerShell]::Create().AddScript({
                param($ip,$req,$ms)
                try {
                    $udp=New-Object System.Net.Sockets.UdpClient
                    $udp.Client.ReceiveTimeout=$ms
                    [void]$udp.Send($req,$req.Length,$ip,161)
                    $ep=New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Any,0)
                    $r=$udp.Receive([ref]$ep); $udp.Close()
                    if(-not $r -or $r.Length -lt 2 -or $r[0] -ne 0x30){ return }
                    # lector de longitud BER
                    $script:pos=0
                    function RL($b){ $l=$b[$script:pos]; $script:pos++; if($l -band 0x80){ $n=$l -band 0x7F; $l=0; for($j=0;$j -lt $n;$j++){ $l=($l -shl 8) -bor $b[$script:pos]; $script:pos++ } }; return $l }
                    $script:pos=1; [void](RL $r)          # SEQ
                    $script:pos++; $vl=RL $r; $script:pos+=$vl   # version
                    $script:pos++; $cl=RL $r; $script:pos+=$cl   # community
                    $script:pos++; [void](RL $r)          # PDU (0xA2)
                    $script:pos++; $il=RL $r; $script:pos+=$il   # request-id
                    $script:pos++; $il=RL $r; $script:pos+=$il   # error-status
                    $script:pos++; $il=RL $r; $script:pos+=$il   # error-index
                    $script:pos++; [void](RL $r)          # varbind list SEQ
                    $vals=@()
                    while($script:pos -lt $r.Length){
                        if($r[$script:pos] -ne 0x30){ break }
                        $script:pos++; $vbl=RL $r; $vbEnd=$script:pos+$vbl
                        if($r[$script:pos] -ne 0x06){ break }
                        $script:pos++; $ol=RL $r; $script:pos+=$ol   # OID
                        $vtag=$r[$script:pos]; $script:pos++; $vlen=RL $r
                        if($vtag -eq 0x04 -and $vlen -gt 0){
                            $vals += ([System.Text.Encoding]::UTF8.GetString($r,$script:pos,$vlen) -replace '[\r\n]',' ').Trim()
                        } else { $vals += "" }
                        $script:pos=$vbEnd
                    }
                    $descr = if($vals.Count -ge 1){ $vals[0] } else { "" }
                    $name  = if($vals.Count -ge 2){ $vals[1] } else { "" }
                    if($descr -or $name){ @{IP=$ip;Descr=$descr;Name=$name} }
                } catch {}
            }).AddArgument($_).AddArgument($Request).AddArgument($Ms)
            $ps.RunspacePool = $pool
            @{PS=$ps; H=$ps.BeginInvoke()}
        }
        $out=@{}
        $jobs | ForEach-Object { $r=$_.PS.EndInvoke($_.H); if($r){$out[$r.IP]=$r}; $_.PS.Dispose() }
        return $out
    } finally {
        $pool.Close(); $pool.Dispose()
    }
}

# ── HTTP title paralelo ───────────────────────────────────────────────────────
function Invoke-HttpTitles([string[]]$IPs, [hashtable]$PortTable, [int]$Threads=30) {
    if (-not $IPs) { return @{} }
    $pool = [RunspaceFactory]::CreateRunspacePool(1, $Threads); $pool.Open()
    try {
        $jobs = foreach ($ip in $IPs) {
            $pp=$PortTable[$ip]
            if (-not $pp -or -not ($pp -contains 80 -or $pp -contains 443 -or $pp -contains 8080 -or $pp -contains 8443)) { continue }
            $ps = [PowerShell]::Create().AddScript({
                param($ip,$pp)
                $urls=@(); if($pp-contains 80){$urls+="http://$ip"}; if($pp-contains 8080){$urls+="http://${ip}:8080"}
                if($pp-contains 443){$urls+="https://$ip"}; if($pp-contains 8443){$urls+="https://${ip}:8443"}
                foreach($u in $urls){
                    try{
                        $h=curl.exe -sk -L --max-time 3 $u 2>$null
                        if($h-match"<title[^>]*>([^<]{2,60})</title>"){
                            $t=$matches[1].Trim()-replace"\s+"," "
                            if($t-and$t-notmatch"404|Not Found|Error"){return @{IP=$ip;T=$t}}
                        }
                    }catch{}
                }
            }).AddArgument($ip).AddArgument($pp)
            $ps.RunspacePool = $pool
            @{PS=$ps; H=$ps.BeginInvoke()}
        }
        $out = @{}
        $jobs | ForEach-Object { $r=$_.PS.EndInvoke($_.H); if($r){$out[$r.IP]=$r.T}; $_.PS.Dispose() }
        return $out
    } finally {
        $pool.Close()
        $pool.Dispose()
    }
}

# ── Historial de dispositivos conocidos (alias + primera/ultima vez) ───────────
function Get-KnownDevices {
    if (Test-Path $KnownFile) {
        try {
            $h=@{}
            (Get-Content $KnownFile -Raw | ConvertFrom-Json).PSObject.Properties | ForEach-Object { $h[$_.Name]=$_.Value }
            return $h
        } catch { return @{} }
    }
    return @{}
}

function Save-KnownDevices($known) {
    try {
        if (-not (Test-Path $DataDir)) { New-Item -ItemType Directory -Path $DataDir -Force | Out-Null }
        $known | ConvertTo-Json -Depth 4 | Set-Content $KnownFile -Encoding UTF8
    } catch {}
}

# ── Prioridad de tipo para ordenar/agrupar ────────────────────────────────────
function Get-TypeRank($tipo) {
    switch -Regex ($tipo) {
        "Este PC"        { return 0 }
        "^Router$"       { return 1 }
        "Router sec"     { return 2 }
        "Repetidor"      { return 3 }
        "Camara"         { return 4 }
        "Impresora"      { return 5 }
        "TV/Media"       { return 6 }
        "IoT|Asistente"  { return 7 }
        "Consola"        { return 8 }
        "Movil"          { return 9 }
        "PC|Raspberry"   { return 10 }
        default          { return 11 }
    }
}

# ── Tabla con colores (agrupada por tipo) ─────────────────────────────────────
function Show-Table($rows, $gateway, $miIP) {
    $w = @{IP=16;MAC=19;Ms=7;Tipo=14;Nombre=22;Fab=14;Ports=16}
    $fmt = "  {0,-$($w.IP)} {1,-$($w.MAC)} {2,-$($w.Ms)} {3,-$($w.Tipo)} {4,-$($w.Nombre)} {5,-$($w.Fab)} {6}"
    $hdr = $fmt -f "IP","MAC","Ping","Tipo","Nombre","Fabricante","Puertos"
    Write-Host $hdr -ForegroundColor White
    Write-Host ("  " + "-" * ($hdr.Length - 2)) -ForegroundColor DarkGray
    foreach ($r in $rows) {
        $col = if ($r.IP -eq $miIP)                                        { "Cyan" }
               elseif ($r.IP -eq $gateway)                                 { "Green" }
               elseif ($r.Tipo -match "Repetidor|Router sec")             { "Magenta" }
               elseif ($r.Nuevo)                                           { "Red" }
               elseif ($r.Raw -and ($r.Raw | Where-Object {$_ -in 21,23})) { "Yellow" }
               elseif ($r.Fab -eq "-" -and $r.Nombre -eq "-")             { "DarkGray" }
               else                                                         { "Gray" }
        $nm = if ($r.Nuevo) { "* " + $r.Nombre } else { $r.Nombre }
        $line = $fmt -f `
            $r.IP, $r.MAC, $r.Ping,
            ($r.Tipo.Substring(0,[Math]::Min($r.Tipo.Length,$w.Tipo-1))),
            ($nm.Substring(0,[Math]::Min($nm.Length,$w.Nombre-1))),
            ($r.Fab.Substring(0,[Math]::Min($r.Fab.Length,$w.Fab-1))),
            $r.Ports
        Write-Host $line -ForegroundColor $col
    }
    Write-Host ""
    Write-Host "  " -NoNewline
    Write-Host "Cyan" -ForegroundColor Cyan -NoNewline;    Write-Host "=Este PC  " -NoNewline
    Write-Host "Verde" -ForegroundColor Green -NoNewline;  Write-Host "=Gateway  " -NoNewline
    Write-Host "Magenta" -ForegroundColor Magenta -NoNewline; Write-Host "=Repetidor/AP  " -NoNewline
    Write-Host "Rojo" -ForegroundColor Red -NoNewline;     Write-Host "=Nuevo (*)  " -NoNewline
    Write-Host "Amarillo" -ForegroundColor Yellow -NoNewline; Write-Host "=Puerto inseguro  " -NoNewline
    Write-Host "Gris" -ForegroundColor DarkGray -NoNewline; Write-Host "=Sin identificar"
}

# ── Reporte HTML ──────────────────────────────────────────────────────────────
function Export-HtmlReport($rows, $wifi, $gateway, $miIP, $ssid, $path) {
    function HtmlEsc($s){ if($null -eq $s){return ""}; return [System.Net.WebUtility]::HtmlEncode([string]$s) }
    $total   = $rows.Count
    $nRepes  = @($rows | Where-Object { $_.Tipo -match "Repetidor|Router sec" }).Count
    $nNuevos = @($rows | Where-Object { $_.Nuevo }).Count
    $nCam    = @($rows | Where-Object { $_.Tipo -eq "Camara" }).Count
    $fecha   = Get-Date -Format "yyyy-MM-dd HH:mm"

    $sb = New-Object System.Text.StringBuilder
    [void]$sb.Append(@"
<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Escaner de Red - $fecha</title>
<style>
:root{--bg:#0f1420;--card:#1a2232;--edge:#2a3550;--tx:#e6ecf5;--mut:#8a97b0;--acc:#4da3ff;--mag:#e061e0;--red:#ff6b6b;--grn:#4bd18a;--yel:#ffd166}
*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--tx);font:14px/1.5 'Segoe UI',system-ui,sans-serif;padding:24px}
h1{font-size:22px;margin:0 0 2px}.sub{color:var(--mut);margin-bottom:20px;font-size:13px}
.cards{display:flex;flex-wrap:wrap;gap:12px;margin-bottom:24px}
.card{background:var(--card);border:1px solid var(--edge);border-radius:12px;padding:14px 18px;min-width:120px}
.card .n{font-size:26px;font-weight:700}.card .l{color:var(--mut);font-size:12px;text-transform:uppercase;letter-spacing:.5px}
.card.mag .n{color:var(--mag)}.card.red .n{color:var(--red)}.card.acc .n{color:var(--acc)}
h2{font-size:15px;margin:22px 0 10px;color:var(--mut);text-transform:uppercase;letter-spacing:.5px}
table{width:100%;border-collapse:collapse;background:var(--card);border-radius:12px;overflow:hidden}
th,td{padding:9px 12px;text-align:left;border-bottom:1px solid var(--edge);font-size:13px}
th{background:#141b28;color:var(--mut);cursor:pointer;user-select:none;position:sticky;top:0}
tr:hover td{background:#212b3f}
.badge{display:inline-block;padding:2px 8px;border-radius:20px;font-size:11px;font-weight:600}
.b-rep{background:rgba(224,97,224,.18);color:var(--mag)}.b-rt{background:rgba(75,209,138,.18);color:var(--grn)}
.b-cam{background:rgba(255,209,102,.18);color:var(--yel)}.b-new{background:rgba(255,107,107,.18);color:var(--red)}
.b-def{background:rgba(138,151,176,.15);color:var(--mut)}
.mono{font-family:Consolas,monospace}.mut{color:var(--mut)}.star{color:var(--red);font-weight:700}
.wifi{display:flex;flex-wrap:wrap;gap:12px}.ap{background:var(--card);border:1px solid var(--edge);border-radius:10px;padding:12px 16px;min-width:200px}
.ap .bs{font-family:Consolas,monospace;font-size:13px}.ap.me{border-color:var(--acc)}.bar{height:6px;background:#141b28;border-radius:4px;margin-top:6px;overflow:hidden}.bar>i{display:block;height:100%;background:var(--acc)}
footer{color:var(--mut);font-size:12px;margin-top:28px}
</style></head><body>
<h1>Escaner de Red</h1><div class="sub">$fecha &nbsp;&middot;&nbsp; red $(HtmlEsc $miIP) &nbsp;&middot;&nbsp; gateway $(HtmlEsc $gateway)$(if($ssid){" &middot; SSID "+(H $ssid)})</div>
<div class="cards">
<div class="card acc"><div class="n">$total</div><div class="l">Dispositivos</div></div>
<div class="card mag"><div class="n">$nRepes</div><div class="l">Repetidores/AP</div></div>
<div class="card red"><div class="n">$nNuevos</div><div class="l">Nuevos</div></div>
<div class="card"><div class="n">$nCam</div><div class="l">Camaras</div></div>
</div>
"@)
    # Seccion WiFi
    if ($wifi -and $wifi.APs -and $wifi.APs.Count) {
        [void]$sb.Append("<h2>Puntos de acceso WiFi &mdash; SSID $(HtmlEsc $wifi.SSID) ($($wifi.APs.Count) radios)</h2><div class='wifi'>")
        foreach ($ap in ($wifi.APs | Sort-Object { -1 * [int]$_.Signal })) {
            $me = if ($ap.BSSID -eq $wifi.MyBssid) { " me" } else { "" }
            $tag = if ($ap.BSSID -eq $wifi.MyBssid) { " <span class='badge b-rt'>conectado</span>" } else { " <span class='badge b-rep'>repetidor/AP</span>" }
            $vend = Get-Vendor $ap.BSSID
            $sig = [int]$ap.Signal
            [void]$sb.Append("<div class='ap$me'><div class='bs'>$(HtmlEsc $ap.BSSID)$tag</div><div class='mut'>$(HtmlEsc $vend) &middot; canal $(HtmlEsc $ap.Channel) &middot; $(HtmlEsc $ap.Radio)</div><div class='mut'>señal $sig%</div><div class='bar'><i style='width:$sig%'></i></div></div>")
        }
        [void]$sb.Append("</div>")
    } elseif ($wifi -and $wifi.Error -eq "location") {
        [void]$sb.Append("<h2>Puntos de acceso WiFi</h2><div class='ap'>Windows requiere <b>Servicios de ubicacion</b> activados para listar los BSSID. Actívalos en Configuracion &gt; Privacidad &gt; Ubicacion.</div>")
    }
    # Tabla principal
    [void]$sb.Append("<h2>Dispositivos</h2><table id='t'><thead><tr><th>IP</th><th>MAC</th><th>Ping</th><th>Tipo</th><th>Nombre</th><th>Fabricante</th><th>Puertos</th><th>Info (SNMP / banner)</th></tr></thead><tbody>")
    foreach ($r in $rows) {
        $cls = switch -Regex ($r.Tipo) { "Repetidor" {"b-rep"} "Router sec" {"b-rt"} "^Router$" {"b-rt"} "Camara" {"b-cam"} default {"b-def"} }
        $star = if ($r.Nuevo) { "<span class='star'>&#9733; </span>" } else { "" }
        $newb = if ($r.Nuevo) { " <span class='badge b-new'>nuevo</span>" } else { "" }
        [void]$sb.Append("<tr><td class='mono'>$(HtmlEsc $r.IP)</td><td class='mono mut'>$(HtmlEsc $r.MAC)</td><td>$(HtmlEsc $r.Ping)</td><td><span class='badge $cls'>$(HtmlEsc $r.Tipo)</span></td><td>$star$(HtmlEsc $r.Nombre)$newb</td><td>$(HtmlEsc $r.Fab)</td><td class='mono mut'>$(HtmlEsc $r.Ports)</td><td class='mut'>$(HtmlEsc $r.Info)</td></tr>")
    }
    [void]$sb.Append(@"
</tbody></table>
<footer>Generado por Network Scanner v6.0 &middot; Lucas M. Vicente</footer>
<script>
document.querySelectorAll('#t th').forEach((th,i)=>th.addEventListener('click',()=>{
 const tb=th.closest('table').querySelector('tbody');
 const rows=[...tb.rows];const asc=th._a=!th._a;
 rows.sort((a,b)=>{const x=a.cells[i].innerText,y=b.cells[i].innerText;
  const nx=parseFloat(x),ny=parseFloat(y);
  if(!isNaN(nx)&&!isNaN(ny))return asc?nx-ny:ny-nx;
  return asc?x.localeCompare(y):y.localeCompare(x);});
 rows.forEach(r=>tb.appendChild(r));}));
</script></body></html>
"@)
    [System.IO.File]::WriteAllText($path, $sb.ToString(), [System.Text.Encoding]::UTF8)
}

# ── Créditos ──────────────────────────────────────────────────────────────────
function Show-Credits {
    Clear-Host
    Write-Host ""
    Write-Host "  +---------------------------------------------------------+" -ForegroundColor Cyan
    Write-Host "  |                                                         |" -ForegroundColor Cyan
    Write-Host "  |          N E T W O R K   S C A N N E R                  |" -ForegroundColor Cyan
    Write-Host "  |                      v6.0  -  2026                      |" -ForegroundColor Cyan
    Write-Host "  |                                                         |" -ForegroundColor Cyan
    Write-Host "  +---------------------------------------------------------+" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Desarrollado por:" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "    Lucas M. Vicente" -ForegroundColor White
    Write-Host "    Claude  (Anthropic)" -ForegroundColor Magenta
    Write-Host "    OpenAI Codex  (optimizacion y mantenimiento)" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  WiFi BSSID - mDNS - NetBIOS - SNMP - Banners - OUI IEEE" -ForegroundColor DarkGray
    Write-Host "  SSDP/UPnP - Ping/Port scan - Clasificacion - Reporte HTML" -ForegroundColor DarkGray
    Write-Host ""
    Start-Sleep -Seconds 2
}

# ═══════════════════════════════════════════════════════════════════════════════
Add-Type -AssemblyName System.Web -ErrorAction SilentlyContinue
Show-Credits

# Cargar base OUI IEEE (cache/descarga) una vez por ejecucion
Write-Host "  Cargando base de fabricantes OUI..." -NoNewline -ForegroundColor DarkGray
$OUIFull = Get-OuiDatabase
if ($OUIFull.Count -gt 1000) { Write-Host " $($OUIFull.Count) fabricantes." -ForegroundColor Green }
else { Write-Host " tabla base (sin catalogo IEEE)." -ForegroundColor DarkGray }

do {
    Clear-Host
    Write-Host "  Escaner de Red  -  Lucas M. Vicente + Claude (Anthropic) + OpenAI Codex" -ForegroundColor DarkGray
    Write-Host ""

    # Detectar interfaces
    $interfaces = @()
    $adapterNames = @{}
    Get-NetAdapter -ErrorAction SilentlyContinue | ForEach-Object { $adapterNames[$_.InterfaceIndex] = $_.Name }
    $seenInterfaces = @{}
    Get-NetRoute -DestinationPrefix "0.0.0.0/0" | Sort-Object RouteMetric | ForEach-Object {
        if (-not $seenInterfaces[$_.InterfaceIndex]) {
            $seenInterfaces[$_.InterfaceIndex] = $true
            $addr = Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex $_.InterfaceIndex -ErrorAction SilentlyContinue |
                    Where-Object { $_.IPAddress -notmatch "^127\.|^169\.254" } | Select-Object -First 1
            if ($addr) {
                $interfaces += [PSCustomObject]@{
                    Num     = $interfaces.Count + 1
                    Nombre  = $adapterNames[$_.InterfaceIndex]
                    IP      = $addr.IPAddress
                    Gateway = $_.NextHop
                }
            }
        }
    }

    if (-not $interfaces) { Write-Host "Sin conexion de red." -ForegroundColor Red; Read-Host; exit }

    $sel = if ($interfaces.Count -eq 1) { $interfaces[0] } else {
        $interfaces | ForEach-Object { Write-Host "  [$($_.Num)] $($_.Nombre.PadRight(25)) $($_.IP.PadRight(16)) gw: $($_.Gateway)" }
        $n = $null
        do { $n = Read-Host "`n  Elegir red" } while (-not ($sel = $interfaces | Where-Object { $_.Num -eq [int]$n }))
        $sel
    }

    $miIP    = $sel.IP
    $gateway = $sel.Gateway
    $subred  = ($miIP -split "\." | Select-Object -First 3) -join "."
    Write-Host "  $($sel.Nombre)  |  $miIP  |  gw $gateway`n" -ForegroundColor DarkGray

    # Jobs de escucha (corren mientras hacemos ping/puertos)
    $ssdpJob  = Start-SsdpJob
    $mdnsJob  = Start-MdnsJob

    $step = 0; $steps = 8
    function Progreso($msg){ $script:step++; Write-Progress -Activity "Escaneando $subred.0/24" -Status "$msg" -PercentComplete ([int](($script:step/$steps)*100)) }

    Progreso "Ping sweep + descubrimiento SSDP/mDNS"
    $pingData = Invoke-PingSweep $subred

    Progreso "Leyendo tabla ARP"
    $macTable = @{}
    Get-NetNeighbor -AddressFamily IPv4 -ErrorAction SilentlyContinue |
        Where-Object { $_.LinkLayerAddress -notmatch "FF-FF|00-00-00-00-00-00" } |
        ForEach-Object { $macTable[$_.IPAddress] = $_.LinkLayerAddress }

    $ipSet = @{}
    @($pingData.Keys) + $miIP + $gateway | ForEach-Object {
        if ($_ -match "^\d+\.\d+\.\d+\.\d+$") { $ipSet[$_] = $true }
    }
    $allIPs = $ipSet.Keys | Sort-Object { [version]$_ }

    Progreso "Escaneo de puertos"
    $ports = Invoke-PortScan $allIPs

    Progreso "DNS reverso + NetBIOS"
    $dns      = Invoke-DnsReverse $allIPs
    $netbios  = Invoke-Netbios $allIPs

    Progreso "SNMP (modelos de equipo)"
    $snmp = Invoke-Snmp $allIPs (New-SnmpRequest)

    Progreso "Banners de servicio + titulos HTTP"
    $banners = Invoke-Banners $allIPs $ports
    $titles  = Invoke-HttpTitles $allIPs $ports

    Progreso "Radios WiFi (BSSID)"
    $wifi = Get-WifiAPs

    Progreso "Recolectando descubrimiento pasivo"
    $upnp = Receive-Job $ssdpJob -Wait -AutoRemoveJob; if (-not $upnp) { $upnp = @{} }
    $mdns = Receive-Job $mdnsJob -Wait -AutoRemoveJob; if (-not $mdns) { $mdns = @{} }
    Write-Progress -Activity "Escaneando" -Completed

    # Fabricante del gateway (por OUI) para detectar repetidores de la misma malla
    $gatewayVendor = Get-Vendor $macTable[$gateway]

    # Historial de dispositivos conocidos
    $known = Get-KnownDevices
    $ahora = (Get-Date).ToString("yyyy-MM-dd HH:mm")

    # Construir filas
    $rows = $allIPs | ForEach-Object {
        $ip  = $_
        $mac = if ($macTable[$ip]) { $macTable[$ip] } else { "-" }
        $macKey = ($mac -replace "[-:]","").ToUpper()
        $u   = $upnp[$ip]
        $sn  = $snmp[$ip]
        $raw = if ($ports[$ip]) { $ports[$ip] | Sort-Object } else { @() }

        # Info tecnica (SNMP sysDescr preferente, si no banner)
        $info = if ($sn -and $sn.Descr) { $sn.Descr } elseif ($banners[$ip]) { $banners[$ip] } else { "-" }

        # Alias del historial (por MAC)
        $alias = $null
        if ($macKey -and $known[$macKey] -and $known[$macKey].alias) { $alias = $known[$macKey].alias }

        # Nombre: alias > SNMP sysName > UPnP > mDNS > NetBIOS > HTTP title > DNS
        $nombre = if ($alias) { $alias }
                  elseif ($sn -and $sn.Name)   { $sn.Name }
                  elseif ($u.FriendlyName)      { $u.FriendlyName }
                  elseif ($mdns[$ip])           { $mdns[$ip] }
                  elseif ($netbios[$ip])        { $netbios[$ip] }
                  elseif ($titles[$ip])         { $titles[$ip] }
                  elseif ($dns[$ip])            { $dns[$ip] }
                  else { "-" }

        # Fabricante: UPnP > modelo UPnP > OUI
        $fab = if ($u.Manufacturer) { $u.Manufacturer } else { Get-Vendor $mac }
        $vkey = Get-Vendor $mac

        # Nuevo si su MAC no estaba en el historial
        $esNuevo = $false
        if ($macKey -and $macKey -ne "-" -and -not $known[$macKey]) { $esNuevo = $true }

        [PSCustomObject]@{
            IP     = $ip
            MAC    = $mac
            Ping   = if ($pingData[$ip]) { "$($pingData[$ip].Ms)ms" } else { "-" }
            OS     = Get-OSFromTTL ($pingData[$ip].TTL)
            Tipo   = Get-DeviceType $vkey $nombre $raw ($ip -eq $gateway) ($ip -eq $miIP) $gatewayVendor $info
            Nombre = $nombre
            Fab    = $fab
            Ports  = if ($raw) { $raw -join "," } else { "-" }
            Info   = $info
            Raw    = $raw
            Nuevo  = $esNuevo
        }
    }

    # Ordenar por tipo (repetidores arriba) y luego IP
    $rows = $rows | Sort-Object @{E={Get-TypeRank $_.Tipo}}, @{E={[version]$_.IP}}

    # Actualizar historial
    foreach ($r in $rows) {
        $k = ($r.MAC -replace "[-:]","").ToUpper()
        if (-not $k -or $k -eq "-") { continue }
        if ($known[$k]) {
            $known[$k].lastSeen = $ahora
            if (-not $known[$k].alias) { $known[$k] | Add-Member -NotePropertyName alias -NotePropertyValue "" -Force }
        } else {
            $known[$k] = [PSCustomObject]@{ alias=""; ip=$r.IP; vendor=$r.Fab; firstSeen=$ahora; lastSeen=$ahora }
        }
    }
    Save-KnownDevices $known

    Write-Host "`n  Dispositivos activos ($($allIPs.Count))" -ForegroundColor Cyan
    Write-Host ("  " + "-" * 100) -ForegroundColor DarkGray
    Show-Table $rows $gateway $miIP

    # Seccion WiFi (repetidores por radio)
    if ($wifi.APs -and $wifi.APs.Count) {
        Write-Host ""
        Write-Host "  Radios WiFi de tu red '$($wifi.SSID)': $($wifi.APs.Count)" -ForegroundColor Magenta
        foreach ($ap in ($wifi.APs | Sort-Object { -1 * [int]$_.Signal })) {
            $tag = if ($ap.BSSID -eq $wifi.MyBssid) { "[conectado]" } else { "[repetidor/AP]" }
            $vend = Get-Vendor $ap.BSSID
            $col  = if ($ap.BSSID -eq $wifi.MyBssid) { "Green" } else { "Magenta" }
            Write-Host ("    {0}  {1,-16} señal {2,3}%  canal {3,-4} {4}" -f $ap.BSSID, $vend, [int]$ap.Signal, $ap.Channel, $tag) -ForegroundColor $col
        }
        if ($wifi.APs.Count -gt 1) {
            Write-Host "    -> $($wifi.APs.Count - 1) AP(s) ademas del que te da señal = repetidores/puntos de acceso de tu malla." -ForegroundColor DarkGray
        }
    } elseif ($wifi.Error -eq "location") {
        Write-Host "`n  [WiFi] Windows pide 'Servicios de ubicacion' activados para ver los BSSID." -ForegroundColor Yellow
        Write-Host "         Actívalos en: Configuracion > Privacidad y seguridad > Ubicacion." -ForegroundColor DarkGray
    }

    # Resumen de repetidores / puntos de acceso por IP
    $repes = @($rows | Where-Object { $_.Tipo -match "Repetidor|Router sec" -and $_.IP -ne $gateway })
    if ($repes.Count) {
        Write-Host ""
        Write-Host "  Posibles repetidores / APs por IP: $($repes.Count)" -ForegroundColor Magenta
        foreach ($r in $repes) {
            $marca = if ($r.Fab -ne "-") { $r.Fab } else { "?" }
            $nom   = if ($r.Nombre -ne "-") { "  ($($r.Nombre))" } else { "" }
            $seg   = if ($r.Tipo -match "\?") { "  [por confirmar]" } else { "" }
            Write-Host "    - $($r.IP.PadRight(15)) $marca$nom$seg" -ForegroundColor Magenta
        }
    }

    # Dispositivos nuevos
    $nuevos = @($rows | Where-Object { $_.Nuevo })
    if ($nuevos.Count) {
        Write-Host ""
        Write-Host "  Dispositivos nuevos desde el ultimo escaneo: $($nuevos.Count)" -ForegroundColor Red
        foreach ($r in $nuevos) { Write-Host "    * $($r.IP.PadRight(15)) $($r.MAC)  $($r.Fab)" -ForegroundColor Red }
    }

    # Exportar CSV + HTML
    $fecha = Get-Date -Format "yyyyMMdd-HHmm"
    $csv   = "$env:USERPROFILE\Desktop\escaner-$fecha.csv"
    $html  = "$env:USERPROFILE\Desktop\escaner-$fecha.html"
    $rows | Select-Object IP,MAC,Ping,OS,Tipo,Nombre,Fab,Ports,Info,Nuevo | Export-Csv $csv -NoTypeInformation -Encoding UTF8
    Export-HtmlReport $rows $wifi $gateway $miIP $wifi.SSID $html
    Write-Host "`n  Guardado CSV : $csv" -ForegroundColor DarkGray
    Write-Host "  Guardado HTML: $html" -ForegroundColor DarkGray
    try { Start-Process $html } catch {}
    Write-Host ""

    # Menu: reescanear / alias / salir
    $op = Read-Host "  [s] escanear de nuevo   [a] poner alias a una IP   [n] salir"
    if ($op -eq "a") {
        $aip = Read-Host "    IP a etiquetar"
        $row = $rows | Where-Object { $_.IP -eq $aip } | Select-Object -First 1
        if ($row -and $row.MAC -ne "-") {
            $al = Read-Host "    Alias para $aip ($($row.MAC))"
            $k  = ($row.MAC -replace "[-:]","").ToUpper()
            if (-not $known[$k]) { $known[$k] = [PSCustomObject]@{ alias=""; ip=$aip; vendor=$row.Fab; firstSeen=$ahora; lastSeen=$ahora } }
            $known[$k].alias = $al
            Save-KnownDevices $known
            Write-Host "    Alias guardado. Se mostrara en los proximos escaneos." -ForegroundColor Green
            Start-Sleep -Seconds 1
        } else {
            Write-Host "    IP no encontrada o sin MAC." -ForegroundColor Yellow; Start-Sleep -Seconds 1
        }
        $op = "s"
    }

} while ($op -eq "s")
