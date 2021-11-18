
#THE HOLY NGIS VM-WS2019 NETWORK BACK OPTIMIZATION SCRIPT V1.0


#  für folgenden Umgebungen NATIVE2019, HV2019, VM2019
#Get-NetTCPSetting | ft -AutoSize
Set-NetTCPSetting -SettingName "InternetCustom" -CongestionProvider CTCP
Set-NetTCPSetting -SettingName "InternetCustom" -DelayedAckTimeoutMs 50
Set-NetTCPSetting -SettingName "InternetCustom" -ForceWS DisabledSet-NetTCPSetting -SettingName "DatacenterCustom" -CongestionProvider DCTCP
Set-NetTCPSetting -SettingName "DatacenterCustom" -CwndRestart True
Set-NetTCPSetting -SettingName "DatacenterCustom" -ForceWS DisabledSet-NetTCPSetting -SettingName "Compat" -ForceWS DisabledSet-NetTCPSetting -SettingName "Datacenter" -CongestionProvider DCTCP
Set-NetTCPSetting -SettingName "Datacenter" -CwndRestart True
Set-NetTCPSetting -SettingName "Datacenter" -ForceWS DisabledSet-NetTCPSetting -SettingName "Internet" -CongestionProvider CTCP
Set-NetTCPSetting -SettingName "Internet" -DelayedAckTimeoutMs 50
Set-NetTCPSetting -SettingName "Internet" -ForceWS Disabled

#für folgenden Umgebungen NATIVE2019, HV2019, VM2019
#netsh int tcp show global
netsh int tcp set global RSS=Disabled
netsh int tcp set global RSC=Disabled

#für folgenden Umgebungen NATIVE2019, HV2019, VM2019
#Get-Net6to4Configuration | ft -AutoSize
Set-Net6to4Configuration -State Disabled

#für folgenden Umgebungen NATIVE2019, HV2019, VM2019
#Get-NetIsatapConfiguration | ft -AutoSize
Set-NetIsatapConfiguration -State Disabled

#für folgenden Umgebungen VM2019
#Get-NetAdapterAdvancedProperty | ft -AutoSize
Get-NetAdapter | Set-NetAdapterAdvancedProperty -DisplayName "Large Send Offload Version 2 (IPv4)" -DisplayValue "Disabled" -NoRestart
Get-NetAdapter | Set-NetAdapterAdvancedProperty -DisplayName "Large Send Offload Version 2 (IPv6)" -DisplayValue "Disabled" -NoRestart
Get-NetAdapter | Set-NetAdapterAdvancedProperty -DisplayName "Recv Segment Coalescing (IPv4)" -DisplayValue "Disabled" -NoRestart
Get-NetAdapter | Set-NetAdapterAdvancedProperty -DisplayName "Recv Segment Coalescing (IPv6)" -DisplayValue "Disabled" -NoRestart
Get-NetAdapter | Set-NetAdapterAdvancedProperty -DisplayName "Receive Side Scaling" -DisplayValue "Disabled" -NoRestart
Get-NetAdapter | Restart-NetAdapter

