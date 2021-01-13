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


| System                                        | Durchsatz MiB/s |    IOPS    |  Latenz/ms  |
|-----------------------------------------------|----------------:|-----------:|------------:|
|HYPERV VM auf HP ML380 Lokal STorage SSD RAID5 |   1.859,76      | 119.024,53 |       0,025 |
|Surface Pro 7, W10, SSD 1TB                    |        1.449,32 |  92.756,25 |       0,032 |



