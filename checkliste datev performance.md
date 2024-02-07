## Die Performance eines DATEV Systems ist von vielen Komponenten abhängig.

 - CPU
 - RAM
 - DISK
 - NETWORK

Auf diese 4 Bereiche müssen im Zusammenspiel der Applicationen betrachtet werden.

## Beispiel
Wenn ein DATEV Arbeitsplatz eines Clients auf den DATEV SQL Server zugreift. Spielt die Leistung des Clients, die Leitung des SQL Servers und der Netzwerkdurchsatz eine Entscheidende Rolle.

Client -> CPU, RAM, DISK, NETWORK -> SQL Server -> CPU, RAM, DISK, NETWORK
Es kann auch Seiten Effekte geben, wenn z.B. ein Virenscanner ständig die MDF oder 
LDF Files des SQL Servers überprüft.

## Datev stellt mehrere Tool zur Performance Messung bereit

 - Dokument SQL Analyse
 - SQM Tools
 - Servicetool
 - Leistungsindex (nicht immer aussagekräftig)

Desweitern gibt es unter https://github.com/glshnu/datevperformance verschiedene 
Tools und Erfahrungswerte für den Test.

**Weitere Tools zur Performance Überwachung**
https://www.dnsstuff.com/de/vm-leistungsuberwachungstool

## Checkliste
  
 - [ ] Service Tool - Laufzeitfaktoren (Hier prüft das DATEV Service Tool die Umgebung)
   
 - [ ] SQLAnalyse - (Der DATEV SQL Server zeichnet SQL Performance Werte auf. Diese können Exportiert werden und  mit dem Dokument SQLAnalyse überprüft bzw. angepasst werden.
   
 - [ ] Überbuchung von CPUs in virtuellen Umgebungen siehe https://github.com/glshnu/datevperformance
   
 - [ ] DISK bzw. Storage - Prüfen ob Cache eingeschaltet 
vergleiche DSKSPD https://github.com/glshnu/datevperformance
  
 - [ ] EDGE bzw. Chrome konfigurieren, dass inaktive Tabs schlafen gehen
   
 - [ ] Virenscanner und EDR Systeme - Ausschlüsse nach DATEV vorgaben konfigurieren
https://apps.datev.de/help-center/documents/1080028
  
 - [ ] DATEV ist eine Single Thread Applikation je mehr desto besser - hier kann der Single Thread Wert eine CPU ermittelt werden, https://www.cpubenchmark.net/singleThread.html
  
 - [ ] In virtuellen Umgebungen ist ist es besser alle VMs so nah wie möglich zu halten
 Azure nennt das Proximity placement groups
 https://learn.microsoft.com/en-us/azure/virtual-machines/co-location
   
  - [ ] DATEV SQL Tools - Hier werden Werte generiert, dies verglichen werden müssen.



> Written by Thomas Lauer
