Hyper-V bietet mit dem Resource Metering grundsätzlich eine interessante Option, um den Verbrauch von Hardware-Ressourcen über einen längeren Zeitraum zu beobachten. Diese Messung muss man mit *Enable-VMResourceMetering* aktivieren und kann dann über *Measure-VM* die akkumulierten Daten abrufen.

**Nur Daten zu maximal zugewiesenem Speicher**

Sie liefern vor allem Informationen zum Datendurchsatz, aber darüber hinaus noch einen Wert für den maximalen Speicherplatz während des gesamten Zeitraums. Das folgende Beispiel zeigt die entsprechende Abfrage nach dem Aktivieren des VM Resource Meterings:

```Powershell
Enable-VMResourceMetering -VMName dc-2
Measure-VM dc-2 | select VMName,
@{n="Max. zugewiesener Speicherplatz (MB)";e={$_.TotalDiskAllocation}},
@{n="Dauer";e={$_.MeteringDuration}}
```

Das Ergebnis ist bei VMs mit mehreren Laufwerken hilfreich, weil man damit die Summe des zugeteilten Speichers erhält. Insgesamt ist der Wert aber nicht sonderlich aussagekräftig, vor allem wenn man die VHDs während der Messdauer weder vergrößert noch verkleinert.

**Zugewiesener versus verbrauchter Speicherplatz**

Für die Bereitstellung von Storage ist es nicht nur wichtig zu wissen, wie viel Kapazität den VMs aktuell zugewiesen ist, sondern auch den kommenden Bedarf zu erkennen. Wenn die virtuellen Laufwerke von mehreren VMs bereits kurz davor sind vollzulaufen, dann ist absehbar, dass man mehr Speicherplatz braucht.

Eine Übersicht über die Auslastung der Disks erhält man mit dem folgenden simplen Script. Es iteriert über die VHDs aller VMs und ermittelt dabei deren maximale Kapazität sowie den aktuellen Verbrauch und errechnet, wie viel Prozent der Disk belegt sind.

```Powershell
Get-VM | foreach{
 $vmname = $_.VMName
 $_ | Get-VMHardDiskDrive | Get-VHD |
 select @{n="VMName"; e={"$vmname"}},
 @{n="VHD";e={$_.Path | Split-Path -Leaf}},
 @{n="Max. Größe";e={$_.Size / 1GB}},
 @{n="Aktuelle Größe";e={[math]::Round($_.filesize / 1GB, 2)}},
 @{n="Prozent verbraucht"; e={[math]::Round($_.filesize / $_.Size * 100, 2)}}
 } | sort -Descending "Prozent verbraucht" | Format-Table
```

Umgekehrt zeigt diese Auswertung aber auch, ob bestimmte VHDs für die betreffenden VMs zu groß dimensioniert wurden. Für dynamische Laufwerke ist das weniger ein Problem, aber bei fixen Disks kann dadurch einiges an Storage verloren gehen. Um die Abfrage auf diesen Typus einzuschränken, müsste man die dritte Zeile des obigen Scripts so ändern:

```Powershell
$_ | Get-VMHardDiskDrive | Get-VHD | Where-Object VhdType -eq "fixed"
```

**Snapshots analysieren**

Snapshots, von Microsoft seit einiger Zeit auch Checkpoint genannt, bieten die Möglichkeit, die VM auf einen früheren Zustand zurückzusetzen. Dies ist praktisch, um Änderungen nach Wartungsarbeiten oder Updates rückgängig zu machen. Sie sind aber nicht für einen langfristigen Einsatz vorgesehen, das gilt auch für die neueren Production Checkpoints.

Wenn man allerdings vergisst, die Snapshots beizeiten mit der Disk zusammenzuführen, dann wachsen die differenziellen VHDs auf ein großes Volumen an. Das folgende Script ermittelt alle VMs, die Snapshots aufweisen, und zeigt, wann diese erstellt wurden.

```Powershell
Get-VM | foreach{

if(Get-VMSnapshot -VM $_){

"=== VM: " + $_.vmname + " ==="

$_ | Get-VMSnapshot -OutVariable CP| select -ExpandProperty HardDrives |

foreach{ Get-ChildItem $_.Path |
 select @{n="Disk-Name";e={$_.Name}},
 @{n="Größe (GB)";e={[math]::Round($_.length /1GB,2)}},
 @{n="Erstellt am";e={$CP.CreationTime}}
 }

$_ | Get-VMHardDiskDrive |

foreach{ Get-ChildItem $_.Path |
 select @{n="Disk-Name";e={$_.Name}},
 @{n="Größe (GB)";e={[math]::Round($_.length /1GB,2)}}}
 }}
```

**Verwaiste VHDs finden**

Unnötiger Platzverbrauch entsteht auch durch virtuelle Laufwerke, die keiner VM zugeordnet sind. Der Hyper-V Manager macht es Admins leicht, solche aufgelassenen VHDs zu produzieren. Wenn man dort eine VM löscht, dann eliminiert er ohne Rückfrage die Konfigurationsdatei, das virtuelle Laufwerk bleibt aber bestehen.

```Powershell
$VMVHDs = Get-VM | Get-VMHardDiskDrive | Select path | %{$_.path}
# Snapshot-Dateien erfassen
$VMVHDs += Get-VM | Get-VMSnapshot | Select -ExpandProperty HardDrives | %{$_.path}
#Virtuelle Festplatten auf D:\ finden
$VHDs = Get-ChildItem -Path "D:\" -Filter *.*vhd? -Recurse | %{$_.fullname}
"`r`n"
"VHDs, die keiner VM zugeordnet sind:`r`n"
$VHDs | Where-Object { $_ -notin $VMVHDs }
```
