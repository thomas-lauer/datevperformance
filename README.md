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


##### Local Storage SSD Raid5 / VM, OS 2019
Total IO
thread |       bytes     |     I/Os     |    MiB/s   |  I/O per s |  AvgLat  | IopsStdDev | LatStdDev |  file
------------------------------------------------------------------------------------------------------------------
     0 |    175508717568 |   10.712.202 |    1859.76 |  119024.53 |    0.025 |    1155.77 |     0.016 | c:\admglsh\test.dat (50MiB)


Read IO
thread |       bytes     |     I/Os     |    MiB/s   |  I/O per s |  AvgLat  | IopsStdDev | LatStdDev |  file
------------------------------------------------------------------------------------------------------------------
     0 |     66705752064 |    40.71.396 |     706.84 |   45237.76 |    0.025 |     484.72 |     0.017 | c:\admglsh\test.dat (50MiB)


Write IO
thread |       bytes     |     I/Os     |    MiB/s   |  I/O per s |  AvgLat  | IopsStdDev | LatStdDev |  file
------------------------------------------------------------------------------------------------------------------
     0 |    108802965504 |    66.40.806 |    1152.92 |   73786.78 |    0.025 |     711.20 |     0.016 | c:\admglsh\test.dat (50MiB)



