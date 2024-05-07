## FSLogix-Antivirus-Ausschlüsse
Stellen Sie sicher, dass Sie die folgenden Antiviren-Ausschlüsse für die virtuellen Festplatten von FSLogix-Profilecontainern konfigurieren. Stellen Sie sicher, dass Sie die folgenden Informationen mit Ihrem Sicherheitsteam überprüfen.  

Dateien ausschließen:  
%Programfiles%\FSLogix\Apps\frxdrv.sys  
%Programfiles%\FSLogix\Apps\frxdrvvt.sys  
%Programfiles%\FSLogix\Apps\frxccd.sys   
%TEMP%*.VHD  
%TEMP%*.VHDX  
%Windir%\TEMP*.VHD  
%Windir%\TEMP*.VHDX  
\\storageaccount.file.core.windows.net\share**.VHD  
\\storageaccount.file.core.windows.net\share**.VHDX  
  
Prozesse ausschließen:  
%Programfiles%\FSLogix\Apps\frxccd.exe  
%Programfiles%\FSLogix\Apps\frxccds.exe  
%Programfiles%\FSLogix\Apps\frxsvc.exe  
