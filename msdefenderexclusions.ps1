# DATEV Empfohleme Ausschlüsse für Virenscanner
# für Microsoft Defender
# https://apps.datev.de/help-center/documents/1080028
# 
# Thomas Lauer - 18.01.2023
#
# Ausschlüsse testen mit
# Invoke-WebRequest "http://www.eicar.org/download/eicar.com.txt" -OutFile "C:\test\kostdb.mdb"

Add-MpPreference -ExclusionExtension ".LOG"
Add-MpPreference -ExclusionExtension ".MDF"
Add-MpPreference -ExclusionExtension ".MEM"
Add-MpPreference -ExclusionExtension ".NDF"
Add-MpPreference -ExclusionExtension ".NVR"
Add-MpPreference -ExclusionExtension ".SQU"
Add-MpPreference -ExclusionExtension ".STM"
Add-MpPreference -ExclusionExtension ".VHD"
Add-MpPreference -ExclusionExtension ".VHDX"
Add-MpPreference -ExclusionExtension ".VMC"
Add-MpPreference -ExclusionExtension ".VMD"
Add-MpPreference -ExclusionExtension ".VMS"
Add-MpPreference -ExclusionExtension ".VMX"

# !!!WICHTIG!!! Laufwerk anpassen
$kdbs = Get-ChildItem -Path c:\ -Recurse -Filter 'kostdb.mdb' -ErrorAction SilentlyContinue | Select-Object FullName
foreach($kdb in $kdbs)
{
    write-host $kdb.FullName
    Add-MpPreference -ExclusionPath $kdb.FullName
}


Add-MpPreference -ExclusionExtension ".BTV"
Add-MpPreference -ExclusionExtension ".DB"
Add-MpPreference -ExclusionExtension ".DBX"
Add-MpPreference -ExclusionExtension ".EDB"
Add-MpPreference -ExclusionExtension ".IDX"
Add-MpPreference -ExclusionExtension ".INI"
Add-MpPreference -ExclusionExtension ".LDF"

# mit Vorsicht zu geniesen

# !!!WICHTIG!!! Laufwerk anpassen
$aexes = Get-ChildItem -Path c:\ -Recurse -Filter 'Arbeitsplatz.exe' -ErrorAction SilentlyContinue | Select-Object FullName
foreach($aexe in $aexes)
{
    write-host $aexe.FullName
    Add-MpPreference -ExclusionPath $aexe.FullName
}

# !!!WICHTIG!!! Laufwerk anpassen
$iexes = Get-ChildItem -Path c:\ -Recurse -Filter 'irw.exe' -ErrorAction SilentlyContinue | Select-Object FullName
foreach($iexe in $iexes)
{
    write-host $iexe.FullName
    Add-MpPreference -ExclusionPath $iexe.FullName
}

# !!!WICHTIG!!! Laufwerk anpassen
$dexes = Get-ChildItem -Path c:\ -Recurse -Filter 'dts.exe' -ErrorAction SilentlyContinue | Select-Object FullName
foreach($dexe in $dexes)
{
    write-host $dexe.FullName
    Add-MpPreference -ExclusionPath $dexe.FullName
}

# !!!WICHTIG!!! Laufwerk anpassen
$sexes = Get-ChildItem -Path c:\ -Recurse -Filter 'starface.exe' -ErrorAction SilentlyContinue | Select-Object FullName
foreach($sexe in $sexes)
{
    write-host $sexe.FullName
    Add-MpPreference -ExclusionPath $sexe.FullName
}

# !!!WICHTIG!!! Laufwerk anpassen
$lexes = Get-ChildItem -Path c:\ -Recurse -Filter 'LogFilter.exe' -ErrorAction SilentlyContinue | Select-Object FullName
foreach($lexe in $lexes)
{
    write-host $lexe.FullName
    Add-MpPreference -ExclusionPath $lexe.FullName
}

# !!!WICHTIG!!! Laufwerk anpassen
$wexes = Get-ChildItem -Path c:\ -Recurse -Filter 'wpwin.exe' -ErrorAction SilentlyContinue | Select-Object FullName
foreach($wexe in $wexes)
{
    write-host $wexe.FullName
    Add-MpPreference -ExclusionPath $wexe.FullName
}
