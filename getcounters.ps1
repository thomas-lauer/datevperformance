

$c | Get-Counter -MaxSamples 120 | Export-Counter -Path .\counter.csv -FileFormat csv

# Gibt man den Parameter FileFormat nicht an, dann verwendet Export-Counter standardmäßig ein binäres Format.
