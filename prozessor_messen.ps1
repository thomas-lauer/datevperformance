$_cores = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName .).NumberOfLogicalProcessors
$_tLoops = 10
$_pmax = 10000
$_fibmax = 1000000000000
$_piMax = 1000000
$_unencstr = "1234567890$abcdefghijklmnopqrstuvwxyz�ABCDEFGHIJKLMNOPQRSTUVWXYZ"

$_qos = Get-WmiObject -Class Win32_OperatingSystem -ComputerName . 
$_os = $_qos.Caption + $_qos.CSDVersion + " " + $_qos._osArchitecture
$_qep = powercfg /getactivescheme 
$_qep = $_qep.SubString($_qep.IndexOf("(")+1,$_qep.Length-$_qep.IndexOf("(")-2)


#https://gallery.technet.microsoft.com/scriptcenter/Set-processor-affinity-895062bb
Function Set-PSAffinity
{
    <#
    .SYNOPSIS
    Set the processor affinity of the current Powershell session
    .PARAMETER core
    The core thread that is allowed to run this process. Separate each cor
    e with a comma. e.g. 1,3
    .PARAMETER all
    if specified, all _cores are allowed.
    .EXAMPLE
    Set-PSAffinity -core 2
    .EXAMPLE
    Set-PSAffinity -core 1,3,5
    .EXAMPLE
    Set-PSAffinity -all
    #>
    param (
        $core,
        [switch]$all
    )
    [int]$NumberOfLogicalProcessors = 0
    Get-WmiObject -class win32_processor | ForEach-Object {$NumberOfLogicalProcessors = ($NumberOfLogicalProcessors + $_.NumberOfLogicalProcessors)}
    $maxaffinity = ([math]::pow(2,$NumberOfLogicalProcessors) - 1)
    if ($core) { $core | Select-Object -unique | ForEach-Object {$affinity = 0} {$affinity += [math]::pow(2,$_-1) } }
    if ($all) { $affinity = $maxaffinity }
    if (($affinity -gt $maxaffinity) -or ($affinity -lt 1)) {$affinity = $maxaffinity}
    (Get-Process -id $pid).processoraffinity = [int]$affinity
}

#https://books.google.de/books?id=UZ7jla5G7gwC&pg=PT101&lpg=PT101&dq=filter+prim+powershell&source=bl&ots=JDpseqG90V&sig=o0_6jBu5KmIaQHHE2q-oV6eMZ3o&hl=de&sa=X&ved=0ahUKEwiTx5O1tf7UAhVIUhQKHV94BfkQ6AEIIjAA#v=onepage&q=filter%20prim%20powershell&f=false
filter Get-Prim {
    $limit = ($_/2 +1);
    for ($i =2; $i -lt $limit;$i++) {
    if (($_ % $i) -eq 0) {return}
}}

#http://get-powershell.com/post/2008/01/24/Fibonacci-Series-in-Powershell.aspx
Function Get-Fib ($n) {
    $current = $previous = 1;
    while ($current -lt $n) {
    #$current;
    $current,$previous = ($current + $previous),$current}
}

#http://www.mathematik-wissen.de/kreisberechnung.htm
Function Get-Pi ($n) {
    $flaeche = 0
    $r = 1
    foreach ($counter In 1..$n) {
        $flaeche = $flaeche + 4*$r/$n*[system.math]::sqrt(($r*$r)-(($counter/$n)*($counter/$n)))
}}

#https://gist.github.com/ctigeek/2a56648b923d198a6e60
Function caesmgmObject($key, $IV) {
    $aesmgm = New-Object "System.Security.Cryptography.AesManaged"
    $aesmgm.Mode = [System.Security.Cryptography.CipherMode]::CBC
    $aesmgm.Padding = [System.Security.Cryptography.PaddingMode]::Zeros
    $aesmgm.BlockSize = 128
    $aesmgm.KeySize = 256
    if ($IV) {
    if ($IV.getType().Name -eq "String") {
        $aesmgm.IV = [System.Convert]::FromBase64String($IV)
    }
    else {
        $aesmgm.IV = $IV
    }
    }
    if ($key) {
        if ($key.getType().Name -eq "String") {
        $aesmgm.Key = [System.Convert]::FromBase64String($key)
    }
    else {
        $aesmgm.Key = $key
    }
    }
    $aesmgm
}

Function cAesKey() {
    $aesmgm = caesmgmObject
    $aesmgm.GenerateKey()
    [System.Convert]::ToBase64String($aesmgm.Key)
}

Function encstr($key, $_unencstr) {
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($_unencstr)
    $aesmgm = caesmgmObject $key
    $encryptor = $aesmgm.CreateEncryptor()
    $encryptedData = $encryptor.TransformFinalBlock($bytes, 0, $bytes.Length);
    [byte[]] $fullData = $aesmgm.IV + $encryptedData
    $aesmgm.Dispose()
    [System.Convert]::ToBase64String($fullData)
}

Function decstr($key, $encryptedStringWithIV) {
    $bytes = [System.Convert]::FromBase64String($encryptedStringWithIV)
    $IV = $bytes[0..15]
    $aesmgm = caesmgmObject $key $IV
    $decryptor = $aesmgm.CreateDecryptor();
    $unencryptedData = $decryptor.TransformFinalBlock($bytes, 16, $bytes.Length - 16);
    $aesmgm.Dispose()
    [System.Text.Encoding]::UTF8.GetString($unencryptedData).Trim([char]0)
}


Clear-Host
Write-Host "Computername:      " $env:COMPUTERNAME
Write-Host "Benutzer:          " $env:USERNAME
Write-Host "Beriebsystem:      " $_os
Write-Host "Energie Spar Modus:" $_qep

# cpu-affinitaet
Write-Host "Anzahl Core:       " $_cores
Set-PSAffinity -core $_cores


# Primzahl
Write-Host " "
Write-Host "Bitte warten ." -NoNewline
$_elp = [System.Diagnostics.Stopwatch]::StartNew()
ForEach ($i In 1..$_tLoops) {
    @(1..($_pmax)) | Get-Prim
}
$_elpPrim = $_elp.Elapsed.TotalSeconds
$itsPrim = $_tLoops / $_elpPrim

# Fib
Write-Host "." -NoNewline
$_elp = [System.Diagnostics.Stopwatch]::StartNew()
ForEach ($i In 1..$_tLoops*10000) {
    Get-Fib $_fibmax
}
$_elpFib = $_elp.Elapsed.TotalSeconds
$itsFib = ($_tLoops*10000) / $_elpFib

# PI
Write-Host "." -NoNewline
$_elp = [System.Diagnostics.Stopwatch]::StartNew()
ForEach ($i In 1..$_tLoops) {
    Get-Pi $_piMax
}
$_elpPi = $_elp.Elapsed.TotalSeconds
$itsPi = $_tLoops / $_elpPi

# Sinus
Write-Host "." -NoNewline
$_elp = [System.Diagnostics.Stopwatch]::StartNew()
ForEach ($a In 1..$_tLoops*100) {
    ForEach ($b In 1..$_tLoops*100) {
        $c = [math]::Sqrt(($a*$a)+($b*$b))
        $sinus = $a / $c 
        $cosinus = $b / $c 
        $tangens = $a / $b 
    }
}
$_elpTrig = $_elp.Elapsed.TotalSeconds
$itsTrig = ($_tLoops*100) / $_elpTrig

# Verschuesseln / Endschluesseln
Write-Host "." -NoNewline
$_elp = [System.Diagnostics.Stopwatch]::StartNew()
ForEach ($i In 1..$_tLoops*1000) {
    $key = cAesKey
    $encryptedString = encstr $key $_unencstr
    $backToPlainText = decstr $key $encryptedString
}
$_elpCrpyt = $_elp.Elapsed.TotalSeconds
$itsCrypt = ($_tLoops*1000) / $_elpCrpyt
Write-Host "."

# Ergebniss
$_elpTotal = $_elpPrim + $_elpFib + $_elpPi + $_elpTrig + $_elpCrpyt
$Points = [math]::Floor($itsPrim + $itsFib + $itsPi + $itsTrig + $itsCrypt)

$pointcolor = "Yellow"
if($Points -gt 25000)
{
    $pointcolor = "Green"
}
if($Points -ilt 16000)
{
    $pointcolor = "Red"
}
Write-Host " "
Write-Host "Benchmark Punkte:  " $Points -ForegroundColor $pointcolor
Write-Host "> 25000 = good"
Write-Host "< 16000 = bad"

