# Counters für HyperV

$counterlist = @("\Prozessor(_Total)\Prozessorzeit (%)",
                 "\Arbeitsspeicher\Verfügbare MB",
                 "\Netzwerkadapter(*)\Gesamtanzahl Bytes/s",
                 "\Hyper-V-Ausgleichsmodul für dynamischen Arbeitsspeicher(*)\Verfügbarer Arbeitsspeicher",
                 "\Prozessor(_Total)\% C2-Zeit",
                 "\Logischer Datenträger(*)\Mittlere Sek./Lesevorgänge",
                 "\Logischer Datenträger(*)\Mittlere Sek./Schreibvorgänge",
                 "\Hyper-V-Hypervisor – logischer Prozessor(_Total)\% Gesamtausführungszeit",
                 "\Hyper-V-Hypervisor – Stamm des virtuellen Prozessors(_Total)\% Gesamtausführungszeit",
                 "\Hyper-V-Hypervisor – virtueller Prozessor(*)\% Gesamtausführungszeit"
                 )

#"\Logischer Datenträger(*)\Mittlere Sek./Lesevorgänge"
#"\Logischer Datenträger(*)\Mittlere Sek./Schreibvorgänge"
# Wenn genug IOPS vorhanden das bewegen sich diese Werte zwischen 1ms und 15ms 
# ständig bis 25ms ungünstiger EInfluss auf Applicationen.
# > 26ms problematisch

# Wenn der \Hyper-V-Hypervisor – logischer Prozessor(_Total)\% Gesamtausführungszeit > 90% ist der Host überlastet

# Wenn der "\Hyper-V-Hypervisor – virtueller Prozessor(_Total)\% Gesamtausführungszeit" > 90% dann folgendes prüfen
# Prüfen, ob der Host überlastet ist
# Finden Sie heraus, ob die Arbeitslast mehr virtuelle Prozessoren nutzen kann
# Weisen Sie der virtuellen Maschine mehr virtuelle Prozessoren zu
   
# Wenn \Hyper-V-Ausgleichsmodul für dynamischen Arbeitsspeicher(*)\Verfügbarer Arbeitsspeicher
# und \Arbeitsspeicher\Verfügbare MB der VM mehr speicher geben

# $counterlist | Get-Counter -MaxSamples 600 | Export-Counter -Path .\counter.csv -FileFormat csv
# Gibt man den Parameter FileFormat nicht an, dann verwendet Export-Counter standardmäßig ein binäres Format.

# -MaxSamples 300 = 5min, 3600 = 1 Stunde
Get-Counter -Counter $counterlist -MaxSamples 300 | Export-Counter -Path .\counter.blg

.\counter.blg
