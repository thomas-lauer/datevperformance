$counterlist = @("\Prozessor(_Total)\Prozessorzeit (%)", "\Hyper-V Hypervisor: virtueller Prozessor(_Total)\% Gesamtlaufzeit")

# $counterlist | Get-Counter -MaxSamples 120 | Export-Counter -Path .\counter.csv -FileFormat csv
# Gibt man den Parameter FileFormat nicht an, dann verwendet Export-Counter standardmäßig ein binäres Format.

$counterlist | Get-Counter -MaxSamples 120 | Export-Counter -Path .\counter.blg
$counterlist = @("\Prozessor(_Total)\Prozessorzeit (%)", "\Hyper-V Hypervisor: virtueller Prozessor(_Total)\% Gesamtlaufzeit")

# $counterlist | Get-Counter -MaxSamples 120 | Export-Counter -Path .\counter.csv -FileFormat csv
# Gibt man den Parameter FileFormat nicht an, dann verwendet Export-Counter standardmäßig ein binäres Format.

$counterlist | Get-Counter -MaxSamples 120 | Export-Counter -Path .\counter.blg
