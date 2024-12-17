# datevperformance

## Disk Performance

#### CMD

```Batch
diskspd.exe -L -D -r -d90 -w62 -b16k -o4 -F1 -c50m -a3 c:\admglsh\test.dat
```
in der VM ausführen  

[:floppy_disk: diskspd](https://github.com/microsoft/diskspd)

#### Werte 
##### IOPS

| Wert     | Bewertung |
|----------|-----------|
|> 70.000  |:+1: good  |
|< 66.000  |:-1: bad   |

Total IO und sehen hier drei wichtige Kenndaten: 
Einen Durchsatz von 1859.76 MB/s, 
119024.53 IOPS und eine 
Latenz von 0.025 ms. 
Je mehr IOPS und je geringer die Latenz, umso besser.

#### Baselines
| System                                                                          | Durchsatz MiB/s |    IOPS    |  Latenz/ms  |
|:--------------------------------------------------------------------------------|----------------:|-----------:|------------:|
|HYPERV2019 VM2019 auf HP DL380 Lokal Storage SSD RAID5                           |   1.859,76      | 119.024,53 |       0,025 |
|Surface Pro 7, W10, SSD 1TB                                                      |        1.449,32 |  92.756,25 |       0,032 |
|HYPERV VM2019 auf HP DL380 Datev Shared Storage SSD                              |    1.786,78     | 114.353,75 |    0,035    |
|HYPERV VM2012R2 auf DP ML380 Datev Shared Storage SSD                            |    1.818,89     | 116.409,19 |    0,025    |
|ESX VM2016 auf DELL Shared Storage SATA - von 2015                               |    986,88       |  63.160,09 |    0,062    |
|ESX VM2012R2 auf DELL Shared Storage SATA - von 2015                             |    1.081,80     |  69.235,33 |    0,042    |
|ESXi6.5, HPE DL380 Gen9, DATEV FS VM2016 Pday 2020/12                            | 1.143,58        | 73.189,25  | 0,054       |
|ESXi 6.5, HPE DL380 G9,TS VM2016, Purestorage, Pday 2020/12                      | 978,14          | 62.600,72  | 0,064       |
|HyperV2019 Pday 2020/12, DL380 G10, Purestorage, DATEV FS VM2016 Pday 2020/12    | 1.685,96        | 107.901,75 | 0,037       |
|HyperV2019 Pday 2020/12, HPE DL380 G10, Purestorage, TS VM2016 Pday 2020/12      | 1.318,44        | 84.379,89  | 0,047       |
|HyperV2016 Pday 2020/12, HPE DL380 G10, Purestorage, DATEV FS VM2016 Pday 2020/12| 1.608,73        | 102.958,51 | 0,039       |
|HyperV2016 Pday 2020/12, HPE DL380 G10, TS VM2016 Pday 2020/12                   | 1.426,54        | 91.298,25  | 0,044       |
|HyperV2016 Pday 2020/12, Wortmann TERRA SERVER 7220 G2, VDI VM W10 Pday 2021/01  | 1.134,72        | 72.622,06  | 0,055       |
|ESXi6.5, HPE DL380 G9, DATEV FS VM2016 Pday 2020/12                              | 1.315,93        | 84.219,38  | 0,047       |
|HPE Synergy / Pure Storage / Comput Module 480 Gen10 Hyper-V-2019 / VM 2019      |  2.136,80       | 139.260,66 | 0,026       |
|Azure D4v3 VM2019 P30 Storage                                                    |1.806,71         |115.629,00  | 0,026       |
|HyperV2019 VM2016 auf DELL R630 auf IBM AllFlash Shared Storage Raid5            | 1.030,99        | 65.983,21  | 0,060       |
|DATEV Partnerasp HCI Cluster mit SSD                                             | 1.355,98        | 86.782,81  | 0,046       |
|DATEV Partnerasp HCI Cluster mit NVME                                            | 1.586,40        | 101.529,30 | 0,039       |





Beispiel Batch
```Batch
@SET uWorkDir=%~dp0
"%uWorkDir%diskspd.exe"  -L -D -r -d90 -w62 -b16k -o4 -F1 -c50m -a3 "%uWorkDir%test.dat" > "%uWorkDir%result.txt"
type "%uWorkDir%result.txt"
```
#### Die wichtigen Zahlen findet man hier

![Ausgabe Diskspd](https://github.com/glshnu/datevperformance/blob/main/diskspd_result.png)


## Prozessor Messen
[Prozessor Geschwindigkeit messen](https://github.com/glshnu/datevperformance/blob/main/prozessor_messen.ps1)

| Wert     | Bewertung |
|----------|-----------|
|> 25.000  |:+1: good  |
|< 16.000  |:-1: bad   |

### Beim Einsatz von Microsoft Defender for Endpoints werden die Ergebnisse des Powershell Scripts verfälscht
Unter dieser Umgebung kann die CPUperf.exe verwendet werden

| Wert        | Bewertung |
|-------------|-----------|
|> 5.500.000  |:+1: good  |
|< 4.100.000  |:-1: bad   |

| Beschreibung                                                                                          | Wert       |
|:------------------------------------------------------------------------------------------------------|-----------:|
|VM2019 / HyperV2019 - HP DL380 XEON Gold 6254 3.10GHz - 1,5 Fach überbucht                             | 28.040     |
|TSVM2016 32GB vRAM / 7 User DATEV / HyperV2019 - HP DL380 XEON Gold 6254 3.10GHz - 1,5 Fach überbucht  | 18.317     |

## Referenzsystem 
Wird von den Anwendern als gut bezeichnet. 

### iPerf 
Download https://github.com/ar51an/iperf3-win-builds   
zwischen zwei VMs (TS und DC). Beide auf gleichem Host.

| Beschreibung                                                                                          | Wert               |
|:------------------------------------------------------------------------------------------------------|-------------------:|
|VM2022/HyperV2022 - HP DL380 XEON Gold 6342 2.8GHz, 10GBit/s Netzadapter                               | 6.64 Gbits/sec     |
|VM2022/HyperV2022 - HP DL380 XEON Gold 6342 2.8GHz, 10GBit/s Netzadapter (10 Clients parallel) "-P 10" | 19 Gbits/sec       |

### Diskspd auf DATEV Laufwerk

| System                                                                               | Durchsatz MiB/s |    IOPS    |  Latenz/ms  |
|:-------------------------------------------------------------------------------------|----------------:|-----------:|------------:|
|VM2022/HYPERV2022, DATEV Shared Storage, MSDFE mDA [^1] - Local LWC in VM             |   1.131,98      | 72.446,55  |       0,055 |
|VM2022/HYPERV2022, DATEV Shared Storage, MSDFE mDA [^1] - DATEV Netzlaufwerk in VM    |        1.303,08 |  83.397,32 |       0,048 |
[^1]: MSDFE mDA = Microsoft Defender for Endpoints P1/P2 mit DATEV Ausschlüssen

### DATEV Leistung Index auf TS ohne Benutzer
   
[StartScore] 3,205 Sekunden   
[DataAccessScore] 0,943 Sekunden   
[ProcessorScore] 0,683 Sekunden   
[HardDiskScore] 0,889 Sekunden   
[ServiceScore] 0,531 Sekunden   
[GuiScore] 3,054 Sekunden  
[OverallScore] 9,306 Sekunden  
   
[ProcessorInfo]   
Processor=Intel(R) Xeon(R) Gold 6342 CPU @ 2.80GHz   
Description=Intel64 Family 6 Model 106 Stepping 6   
MaxClockSpeed=2793   
NumberOfCores=3   
NumberOfLogicalProcessors=6   
   
[ComputerInfo]   
Model=Virtual Machine   
TotalPhysicalMemory=32.766 MB   
   
[OperatingSystemInfo]   
Caption=Microsoft Windows Server 2022 Standard   
   
   

## CPU Performance prüfen
[Prozessor messen](https://github.com/glshnu/datevperformance/blob/main/prozessor_messen.ps1)

## Überbuchung prüfen
[Check vCPU Ratios](https://github.com/glshnu/datevperformance/blob/main/checkvCPURatios.ps1)

## NUMA-Affinität prüfen
[Check NUMA spanning](https://github.com/glshnu/datevperformance/blob/main/CheckNumaSpanning.ps1)

## Virenscanner ausschlüsse  
[Microsoft Defender](https://github.com/glshnu/datevperformance/blob/main/msdefenderexclusions.ps1)  
[Microsoft Empfehlungen für HYPERV Rolle](https://learn.microsoft.com/de-de/troubleshoot/windows-server/virtualization/antivirus-exclusions-for-hyper-v-hosts)

## Datev Leitungsindex silent ausführen
https://github.com/glshnu/datevperformance/blob/main/leistungsindexsilent.ps1

## HYPERV Performance Counter  
https://github.com/glshnu/datevperformance/blob/main/getcounters.ps1  
weitere Infos unter  
http://wiki.webperfect.ch/index.php?title=Hyper-V:_Performance_(Counters)

## Datev Performance Checkliste
https://github.com/glshnu/datevperformance/blob/main/checkliste.md  

## RAM Bedarf von VMs ermitteln
Abfrahe unter HYPER-V
´´´ Powershell
Get-VM | select Name, `
@{n="Angeforderter Speicher (GB)";e={$_.MemoryDemand/1GB}}, `
@{n="Zugewiesener Speicher (GB)";e={$_.MemoryAssigned/1GB}}
´´´

## Links
https://www.altaro.com/hyper-v/storage-performance-baseline-diskspd/  
https://www.windowspro.de/marcel-kueppers/storage-performance-iops-unter-hyper-v-messen-diskspd
https://docs.pexip.com/server_design/hyperv_numa_affinity.htm  
https://apps.datev.de/help-center/documents/1080028

