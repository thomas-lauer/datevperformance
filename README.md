# datevperformance

## Disk Performance

### CMD

```Shell
diskspd.exe -L -D -r -d90 -w62 -b16k -o4 -F1 -c50m -a3 c:\admglsh\test.dat
```
[:floppy_disk: diskspd](https://github.com/microsoft/diskspd)

#### Werte 
##### IOPS

| Wert     | Bewertung |
|----------|-----------|
|> 118.000 |:+1: good  |
|< 66.000  |:-1: bad   |

Total IO und sehen hier drei wichtige Kenndaten: 
Einen Durchsatz von 1859.76 MB/s, 
119024.53 IOPS und eine 
Latenz von 0.025 ms. 
Je mehr IOPS und je geringer die Latenz, umso besser.


| System                                              | Durchsatz MiB/s |    IOPS    |  Latenz/ms  |
|:----------------------------------------------------|----------------:|-----------:|------------:|
|HYPERV VM2019 auf HP ML380 Lokal Storage SSD RAID5   |   1.859,76      | 119.024,53 |       0,025 |
|Surface Pro 7, W10, SSD 1TB                          |        1.449,32 |  92.756,25 |       0,032 |
|HYPERV VM2019 auf HP ML380 Datev Shared Storage SSD  |    1.786,78     | 114.353,75 |    0,035    |
|HYPERV VM2012R2 auf HP ML380 Datev Shared Storage SSD|    1.818,89     | 116.409,19 |    0,025    |
|ESX VM2016 auf DELL Shared Storage SATA - von 2015   |    986,88       |  63.160,09 |    0,062    |
|ESX VM2012R2 auf DELL Shared Storage SATA - von 2015 |    1.081,80     |  69.235,33 |    0,042    |



Beispiel Batch
```Batch
@SET uWorkDir=%~dp0
"%uWorkDir%diskspd.exe"  -L -D -r -d90 -w62 -b16k -o4 -F1 -c50m -a3 "%uWorkDir%test.dat" > "%uWorkDir%result.txt"
type "%uWorkDir%result.txt"
```
### Die wichtigen Zahlen findet man hier

![Ausgabe Diskspd](https://github.com/glshnu/datevperformance/blob/main/diskspd_result.png)



## Links
[https://www.altaro.com/hyper-v/storage-performance-baseline-diskspd/](https://www.altaro.com/hyper-v/storage-performance-baseline-diskspd/)
