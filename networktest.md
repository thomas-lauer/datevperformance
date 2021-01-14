# datevperformance

## Netzwerk Performance

### CMD

```Batch
diskspd.exe -L -D -r -d90 -w62 -b16k -o4 -F1 -c50m -a3 c:\admglsh\test.dat
```
[:floppy_disk: NTttcp](https://docs.microsoft.com/de-de/azure/virtual-network/virtual-network-bandwidth-testing)

#### Werte 

NTttcp.exe -r -m 2,0,172.26.240.1 -a 16 -xml 'C:\admglsh\SQM Performance Test\Results\DESKTOP-AMUM2VA_ntttcp_receiver_details_20210114_135318.xml'


netsh advfirewall firewall add rule program=<PATH>\ntttcp.exe name="ntttcp" protocol=any dir=in action=allow enable=yes profile=ANY
