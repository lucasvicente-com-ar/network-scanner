#Requires -Version 5.1
$ErrorActionPreference = "SilentlyContinue"

# ── OUI: MAC → Fabricante ─────────────────────────────────────────────────────
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

# ── Funciones helper ──────────────────────────────────────────────────────────
function Get-Vendor($mac) {
    if (-not $mac -or $mac -eq "-") { return "-" }
    $clean = ($mac -replace "[-:]","").ToUpper()
    if ($clean.Length -lt 6) { return "-" }
    $key = $clean.Substring(0,6)
    if ($OUI[$key]) { return $OUI[$key] }
    return "-"
}

function Get-OSFromTTL($ttl) {
    if (-not $ttl)    { return "-" }
    if ($ttl -le 64)  { return "Linux/Android" }
    if ($ttl -le 128) { return "Windows" }
    return "Router/IoT"
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

# ── Port scan paralelo ────────────────────────────────────────────────────────
function Invoke-PortScan([string[]]$IPs, [int]$Threads=150, [int]$Ms=350) {
    if (-not $IPs) { return @{} }
    $ports = @(21,22,23,80,443,554,3389,8080,8443)
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

# ── Tabla con colores ─────────────────────────────────────────────────────────
function Show-Table($rows, $gateway, $miIP) {
    $w = @{IP=16;MAC=20;Ms=7;OS=14;Nombre=22;Fab=16;Ports=20}
    $hdr = "  {0,-$($w.IP)} {1,-$($w.MAC)} {2,-$($w.Ms)} {3,-$($w.OS)} {4,-$($w.Nombre)} {5,-$($w.Fab)} {6}" -f "IP","MAC","Ping","OS","Nombre","Fabricante","Puertos"
    Write-Host $hdr -ForegroundColor White
    Write-Host ("  " + "-" * ($hdr.Length - 2)) -ForegroundColor DarkGray
    foreach ($r in $rows) {
        $col = if ($r.IP -eq $miIP)                                              { "Cyan" }
               elseif ($r.IP -eq $gateway)                                       { "Green" }
               elseif ($r.Raw -and ($r.Raw | Where-Object {$_ -in 21,23}))       { "Yellow" }
               elseif ($r.Fab -eq "-" -and $r.Nombre -eq "-")                   { "DarkGray" }
               else                                                               { "Gray" }
        $line = "  {0,-$($w.IP)} {1,-$($w.MAC)} {2,-$($w.Ms)} {3,-$($w.OS)} {4,-$($w.Nombre)} {5,-$($w.Fab)} {6}" -f `
            $r.IP, $r.MAC, $r.Ping, $r.OS,
            ($r.Nombre.Substring(0,[Math]::Min($r.Nombre.Length,$w.Nombre-1))),
            ($r.Fab.Substring(0,[Math]::Min($r.Fab.Length,$w.Fab-1))),
            $r.Ports
        Write-Host $line -ForegroundColor $col
    }
    Write-Host ""
    Write-Host "  " -NoNewline
    Write-Host "Cyan" -ForegroundColor Cyan -NoNewline; Write-Host "=Este PC  " -NoNewline
    Write-Host "Verde" -ForegroundColor Green -NoNewline; Write-Host "=Gateway  " -NoNewline
    Write-Host "Amarillo" -ForegroundColor Yellow -NoNewline; Write-Host "=Puerto inseguro  " -NoNewline
    Write-Host "Gris" -ForegroundColor DarkGray -NoNewline; Write-Host "=Sin identificar"
}

# ── Créditos ──────────────────────────────────────────────────────────────────
function Show-Credits {
    Clear-Host
    Write-Host ""
    Write-Host "  +---------------------------------------------------------+" -ForegroundColor Cyan
    Write-Host "  |                                                         |" -ForegroundColor Cyan
    Write-Host "  |          N E T W O R K   S C A N N E R                 |" -ForegroundColor Cyan
    Write-Host "  |                      v5.1  -  2026                     |" -ForegroundColor Cyan
    Write-Host "  |                                                         |" -ForegroundColor Cyan
    Write-Host "  +---------------------------------------------------------+" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Desarrollado por:" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "    Lucas M. Vicente" -ForegroundColor White
    Write-Host "    Claude  (Anthropic)" -ForegroundColor Magenta
    Write-Host "    OpenAI Codex  (optimizacion y mantenimiento)" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  SSDP/UPnP - Ping paralelo - Port scan - DNS reverso" -ForegroundColor DarkGray
    Write-Host "  HTTP title - OUI MAC lookup - TTL OS detection" -ForegroundColor DarkGray
    Write-Host ""
    Start-Sleep -Seconds 2
}

# ═══════════════════════════════════════════════════════════════════════════════
Show-Credits

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

    # SSDP en background mientras corre el ping
    $ssdpJob = Start-Job -ScriptBlock {
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
                $out[$ip] = [PSCustomObject]@{ FriendlyName=$null; Manufacturer=$null; LocationURL=$loc }
            } catch { break }
        }
        $udp.Close()
        foreach ($ip in @($out.Keys)) {
            if (-not $out[$ip].LocationURL) { continue }
            try {
                $xml = [xml](curl.exe -sk -L --max-time 2 $out[$ip].LocationURL 2>$null)
                $out[$ip].FriendlyName = $xml.root.device.friendlyName
                $out[$ip].Manufacturer = $xml.root.device.manufacturer
            } catch {}
        }
        return $out
    }

    Write-Host "  [1/4] Ping + SSDP..." -NoNewline
    $pingData    = Invoke-PingSweep $subred
    $upnp        = Receive-Job $ssdpJob -Wait -AutoRemoveJob
    if (-not $upnp) { $upnp = @{} }
    Write-Host " $($pingData.Count) activos, $($upnp.Count) UPnP" -ForegroundColor Green

    $macTable = @{}
    Get-NetNeighbor -AddressFamily IPv4 -ErrorAction SilentlyContinue |
        Where-Object { $_.LinkLayerAddress -notmatch "FF-FF|00-00-00-00-00-00" } |
        ForEach-Object { $macTable[$_.IPAddress] = $_.LinkLayerAddress }

    $ipSet = @{}
    @($pingData.Keys) + $miIP + $gateway | ForEach-Object {
        if ($_ -match "^\d+\.\d+\.\d+\.\d+$") { $ipSet[$_] = $true }
    }
    $allIPs = $ipSet.Keys | Sort-Object { [version]$_ }

    Write-Host "  [2/4] DNS reverso..." -NoNewline
    $dns = Invoke-DnsReverse $allIPs
    Write-Host " listo." -ForegroundColor Green

    Write-Host "  [3/4] Puertos..." -NoNewline
    $ports = Invoke-PortScan $allIPs
    Write-Host " listo." -ForegroundColor Green

    Write-Host "  [4/4] Titulos HTTP..." -NoNewline
    $titles = Invoke-HttpTitles $allIPs $ports
    Write-Host " listo." -ForegroundColor Green

    # Construir filas
    $rows = $allIPs | ForEach-Object {
        $ip  = $_
        $mac = if ($macTable[$ip]) { $macTable[$ip] } else { "-" }
        $u   = $upnp[$ip]
        $raw = if ($ports[$ip]) { $ports[$ip] | Sort-Object } else { @() }
        [PSCustomObject]@{
            IP     = $ip
            MAC    = $mac
            Ping   = if ($pingData[$ip]) { "$($pingData[$ip].Ms)ms" } else { "-" }
            OS     = Get-OSFromTTL ($pingData[$ip].TTL)
            Nombre = if ($u.FriendlyName) { $u.FriendlyName } elseif ($titles[$ip]) { $titles[$ip] } elseif ($dns[$ip]) { $dns[$ip] } else { "-" }
            Fab    = if ($u.Manufacturer) { $u.Manufacturer } else { Get-Vendor $mac }
            Ports  = if ($raw) { $raw -join "," } else { "-" }
            Raw    = $raw
        }
    }

    Write-Host "`n  Dispositivos activos ($($allIPs.Count))" -ForegroundColor Cyan
    Write-Host ("  " + "-" * 100) -ForegroundColor DarkGray
    Show-Table $rows $gateway $miIP

    $fecha = Get-Date -Format "yyyyMMdd-HHmm"
    $csv = "$env:USERPROFILE\Desktop\escaner-$fecha.csv"
    $rows | Select-Object IP,MAC,Ping,OS,Nombre,Fab,Ports | Export-Csv $csv -NoTypeInformation -Encoding UTF8
    Write-Host "`n  Guardado: $csv" -ForegroundColor DarkGray
    Write-Host ""

} while ((Read-Host "  Escanear de nuevo? (s/n)") -eq "s")
