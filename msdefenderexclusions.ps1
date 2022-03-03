# DATEV Empfohleme Ausschlüsse für Virenscanner
# für Microsoft Defender
# https://apps.datev.de/help-center/documents/1080028
# erweitert um .VHDX
# Thomas Lauer - 23.02.2022
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
