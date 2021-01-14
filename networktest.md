# datevperformance

## Netzwerk Performance

### CMD

```Batch
NTttcp.exe -r -m 2,0,172.26.240.1 -a 16
```
[:floppy_disk: NTttcp](https://docs.microsoft.com/de-de/azure/virtual-network/virtual-network-bandwidth-testing)

#### Werte 
....



Beispiel Batch
```Batch
@SET uWorkDir=%~dp0
netsh advfirewall firewall add rule program=%uWorkDir%ntttcp.exe name="ntttcp" protocol=any dir=in action=allow enable=yes profile=ANY
"%uWorkDir%NTttcp.exe"  -r -m 2,0,172.26.240.1 -a 16 > "%uWorkDir%result.txt"
type "%uWorkDir%result.txt"
netsh advfirewall firewall delete rule program=%uWorkDir%ntttcp.exe
```
