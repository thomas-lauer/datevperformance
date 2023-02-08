# Counters für HyperV

$counterlist = @("\Prozessor(_Total)\Prozessorzeit (%)",
                 "\Arbeitsspeicher\Verfügbare MB",
                 "\Netzwerkadapter(*)\Gesamtanzahl Bytes/s",
                 "\Hyper-V-Ausgleichsmodul für dynamischen Arbeitsspeicher(*)\Verfügbarer Arbeitsspeicher",
                 "\Prozessor(_Total)\% C2-Zeit",
                 "\Logischer Datenträger(*)\Mittlere Sek./Lesevorgänge",
                 "\Logischer Datenträger(*)\Mittlere Sek./Schreibvorgänge"
                 )

#"\Logischer Datenträger(*)\Mittlere Sek./Lesevorgänge"
#"\Logischer Datenträger(*)\Mittlere Sek./Schreibvorgänge"
# Wenn genug IOPS vorhanden das bewegen sich diese Werte zwischen 1ms und 15ms 
# ständig bis 25ms ungünstiger EInfluss auf Applicationen.
# > 26ms problematisch


                 

# $counterlist | Get-Counter -MaxSamples 120 | Export-Counter -Path .\counter.csv -FileFormat csv
# Gibt man den Parameter FileFormat nicht an, dann verwendet Export-Counter standardmäßig ein binäres Format.

Get-Counter -Counter $counterlist -MaxSamples 120 | Export-Counter -Path .\counter.blg
