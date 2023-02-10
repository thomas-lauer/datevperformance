# RSC- Receive Segment Coalescing

### View the current settings
Get-VMSwitch -Name vSwitchName | Select-Object *RSC*  

### Enable or Disable RSC in the vSwitch 
Important: RSC in the vSwitch can be enabled and disabled on the fly without impact to existing connections. 

#### Disable RSC in the vSwitch 
Set-VMSwitch -Name vSwitchName -EnableSoftwareRsc $false 

#### Re-enable RSC in the vSwitch 
Set-VMSwitch -Name vSwitchName -EnableSoftwareRsc $True 

### Links
https://support.citrix.com/article/CTX351231/citrix-cloud-users-sessions-are-freezing-with-2019-cloud-connector-with-receive-side-coalescing-feature-in-vswitch  
https://learn.microsoft.com/en-us/windows-server/networking/technologies/hpn/rsc-in-the-vswitch  
