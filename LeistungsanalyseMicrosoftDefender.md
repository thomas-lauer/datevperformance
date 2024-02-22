### Leistungsanalyse für Microsoft Defender

### Gilt für
Microsoft Defender für Endpunkt Plan 1   
Microsoft Defender für Endpunkt Plan 2   
Microsoft Defender Antivirus   


### Microsoft Defender Antivirus-Leistungsanalyse erfüllt die folgenden Voraussetzungen:
- Unterstützte Windows-Versionen: Windows 10, Windows 11, Windows 2012 R2 mit der modernen einheitlichen Lösung und Windows Server 2016 und höher
- Plattformversion: 4.18.2108.7 oder höher
- PowerShell-Version: PowerShell Version 5.1, PowerShell ISE, Remote-PowerShell (4.18.2201.10 und höher), PowerShell 7.x (4.18.2201.10 und höher)

### Was ist Microsoft Defender Antivirus-Leistungsanalyse?
Wenn auf Computern, auf denen Microsoft Defender Antivirus ausgeführt wird, Leistungsprobleme auftreten, können Sie die Leistungsanalyse verwenden, um die Leistung von Microsoft Defender Antivirus zu verbessern. Die Leistungsanalyse für Microsoft Defender Antivirus in Windows 10, Windows 11 und Windows Server ist ein PowerShell-Befehlszeilentool, mit dem Sie Dateien, Dateierweiterungen und Prozesse ermitteln können, die bei Antivirenscans zu Leistungsproblemen auf einzelnen Endpunkten führen können. Sie können die von der Leistungsanalyse gesammelten Informationen verwenden, um Leistungsprobleme zu bewerten und Abhilfemaßnahmen anzuwenden.

### Folgende Optionen können analysiert werden:
- Die wichtigsten Pfade, die sich auf die Überprüfungszeit auswirken
- Die wichtigsten Dateien, die sich auf die Überprüfungszeit auswirken
- Wichtigste Prozesse, die sich auf die Überprüfungszeit auswirken
- Die wichtigsten Dateierweiterungen, die sich auf die Überprüfungszeit auswirken
- Kombinationen – z. B.:
  - Top-Dateien pro Erweiterung
  - Top-Pfade pro Erweiterung
  - Top-Prozesse pro Pfad
  - Top-Scans pro Datei
  - Top-Scans pro Datei und Prozess


### Leistungsanalyse im Eisatz

Führen Sie den folgenden Befehl aus, um die Aufzeichnung zu starten:

```PowerShell
New-MpPerformanceRecording -RecordTo recording.etl
```
- Dabei -RecordTo gibt der Parameter den vollständigen Pfad an, an dem die Ablaufverfolgungsdatei gespeichert wird. Weitere Cmdlet-Informationen finden Sie unter Microsoft Defender Antivirus-Cmdlets.   
- Wenn es Prozesse oder Dienste gibt, die die Leistung beeinträchtigen, reproduzieren Sie die Situation, indem Sie die entsprechenden Aufgaben ausführen.   
- Drücken Sie die EINGABETASTE , um die Aufzeichnung zu beenden und zu speichern, oder STRG+C , um die Aufzeichnung abzubrechen.   
- Analysieren Sie die Ergebnisse mit dem Parameter des Get-MpPerformanceReport Leistungsanalysetools. Beispielsweise erhält der Benutzer beim Ausführen des Befehls Get-MpPerformanceReport -Path <recording.etl> -TopFiles 3 -TopScansPerFile 10eine Liste der zehn wichtigsten Scans für die drei wichtigsten Dateien, die sich auf die Leistung auswirken.

### Auswerten der Aufzeichnung
```PowerShell
Get-MpPerformanceReport -Path .\recording.etl -Topscans 1000
```
### Exportieren in CSV
```PowerShell
(Get-MpPerformanceReport -Path .\recording.etl -Topscans 1000).TopScans | Export-CSV -Path .\recording.csv -Encoding UTF8 -NoTypeInformation
```
### Erfassen einer Leistungsaufzeichnung für eine PowerShell-Remotesitzung
```PowerShell
$s = New-PSSession -ComputerName Server02 -Credential Domain01\User01
New-MpPerformanceRecording -RecordTo C:\LocalPathOnServer02\trace.etl -Session $s
```
Der obige Befehl erfasst eine Leistungsaufzeichnung auf Server02 (wie durch argument $s des Parameters Session angegeben) und speichert sie im angegebenen Pfad: C:\LocalPathOnServer02\trace.etl auf Server02.  

### Muster Script
```Powershell
New-MpPerformanceRecording -RecordTo $env:TEMP\MpPerformanceRecord.etl -Seconds 1800
Get-MpPerformanceReport -Path $env:TEMP\MpPerformanceRecord.etl -TopFiles:10 -TopExtensions:10 -TopProcesses:10 -TopScans:10
```
Dieses Script läuft 30min und zweigt danach die TopFiles,Ext,Prozesse und Scans an.



