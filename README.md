# datevperformance

## Disk Performance

### CMD

```Shell
diskspd.exe -L -D -r -d90 -w62 -b16k -o4 -F1 -c50m -a3 c:\admglsh\test.dat
```
[:floppy_disk: diskspd](https://github.com/microsoft/diskspd)

#### Werte 
##### TotalIOPS

| Wert     | Bewertung |
|----------|-----------|
|> 118.000 |:+1: good  |
|< 66.000  |:-1: bad   |

Total IO und sehen hier drei wichtige Kenndaten: 
Einen Durchsatz von 1859.76 MB/s, 
119024.53 IOPS und eine 
Latenz von 0.025 ms. 
Je mehr IOPS und je geringer die Latenz, umso besser.


##### :+1: Local Storage 10x SSD Raid5 / VM, OS 2019

|    MiB/s   |  I/O per s |  AvgLat  | IopsStdDev | LatStdDev |
|-----------:|-----------:|---------:|-----------:|----------:|
|  *1859.76* |*119024.53* |  *0.025* |    1155.77 |     0.016 |


##### :+1: Local Storage 18x SATA Raid5 / VM, OS 2019
|       |       bytes     |   I/Os     |    MiB/s   |  I/O per s |  AvgLat  | IopsStdDev | LatStdDev |
|-------|----------------:|-----------:|-----------:|-----------:|---------:|-----------:|----------:|
|TotalIO|    178965594112 |   10923193 |    1896.39 |  121368.85 |    0.025 |    8934.49 |     0.040 |
|Read IO|     68016422912 |    4151393 |     720.73 |   46126.61 |    0.024 |    3394.23 |     0.038 |
|WriteIO|    110949171200 |    6771800 |    1175.66 |   75242.25 |    0.025 |    5545.92 |     0.041 |

