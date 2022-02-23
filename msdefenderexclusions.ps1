# DATEV Empfohleme Ausschlüsse für Virenscanner
# für Microsoft Defender
# https://apps.datev.de/help-center/documents/1080028
# erweitert um .VHDX
# Thomas Lauer - 23.02.2022
#

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
Add-MpPreference -ExclusionExtension "KOSTST.MDB"
Add-MpPreference -ExclusionExtension ".BTV"
Add-MpPreference -ExclusionExtension ".DB"
Add-MpPreference -ExclusionExtension ".DBX"
Add-MpPreference -ExclusionExtension ".EDB"
Add-MpPreference -ExclusionExtension ".IDX"
Add-MpPreference -ExclusionExtension ".INI"
Add-MpPreference -ExclusionExtension ".LDF"
