Die Performance eines DATEV Systems ist von vielen Komponenten abhängig.

 - CPU
 - RAM
 - DISK
 - NETWORK

Auf diese 4 Bereiche müssen im Zusammenspiel der Applicationen betrachtet werden.

z.B.
Wenn ein DATEV Arbeitsplatz eines Clients auf den DATEV SQL Server zugreift. Spielt die Leistung des Clients, die Leitung des SQL Servers und der Netzwerkdurchsatz eine Entscheidende Rolle.

Client -> CPU, RAM, DISK, NETWORK -> SQL Server -> CPU, RAM, DISK, NETWORK
Es kann auch Seiten Effekte geben, wenn z.B. ein Virenscanner ständig die MDF oder 
LDF Files des SQL Servers überprüft.

Datev stellt mehrere Tool zur Performance Messung bereit

 - Dokument SQL Analyse
 - SQM Tools
 - Servicetool
 - Leistungsindex (nicht immer aussagekräftig)

Desweitern gibt es unter https://github.com/glshnu/datevperformance verschiedene 
Tools und Erfahrungswerte für den Test.

Folgende Checkliste soll helfen den Performance Engpass zu finden

 - [ ] Service Tool - Laufzeitfaktoren (Hier prüft das DATEV Service Tool die Umgebung)
 - [ ] SQLAnalyse - (Der DATEV SQL Server zeichnet SQL Performance Werte auf. Diese können Exportiert werden und  mit dem Dokument SQLAnalyse überprüft bzw. angepasst werden.
 - [ ] Überbuchung von CPUs in virtuellen Umgebungen siehe https://github.com/glshnu/datevperformance
 - [ ] DISK bzw. Storage - Prüfen ob Cache eingeschaltet 
vergleiche DSKSPD https://github.com/glshnu/datevperformance
 - [ ] EDGE bzw. Chrome konfigurieren, dass inaktive Tabs schlafen gehen
 - [ ] Virenscanner und EDR Systeme - Ausschlüsse nach DATEV vorgaben konfigurieren
https://apps.datev.de/help-center/documents/1080028

> Written with [StackEdit](https://stackedit.io/).
