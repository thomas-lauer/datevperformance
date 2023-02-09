<#
.SYNOPSIS
Set Storage Quality of Service for all Virtual Machines.

.DESCRIPTION
Set Minimum and Maximum Storage Quality of Service for all Virtual Machines.
.NOTES
File Name : Set-VMStorageIO.ps1
Author    : Charbel Nemnom
Version   : 1.1
Requires  : PowerShell Version 4.0 or above
OS        : Windows Server 2012 R2 Hyper-V or Free Hyper-V Server 2012 R2

.LINK
To provide feedback or for further assistance please visit: https://charbelnemnom.com

.PARAMETER HVServerName
The name of a single Hyper-V Server
.PARAMETER Disable
Switch to disable Storage QoS
.PARAMETER MinMax
The storage QoS to be set - Maximum, Minimum or Both
.PARAMETER StorageMinIO
The Storage minimum limit IO number to be set
.PARAMETER StorageMaxIO
The Storage maximum limit IO number to be set

.EXAMPLE
.\Set-VMStorageIO -HVServerName <HyperVServerName> -MinMax <Maximum> -StorageMaxIO <500>
This example will set the maximum Storage QoS for all virtual machines to 500.
.EXAMPLE
.\Set-VMStorageIO -HVServerName <HyperVServerName> -MinMax <Minimum> -StorageMinIO <250>
This example will set the minimum Storage QoS for all virtual machines to 250.
.EXAMPLE
.\Set-VMStorageIO -HVServerName <HyperVServerName> -MinMax <Both> -StorageMinIO <250> -StorageMaxIO <1000>
This example will set the Storage QoS for minimum 250 IOPS and maximum 1000 IOPS for all virtual machines.
.EXAMPLE
.\Set-VMStorageIO -HVServerName <HyperVServerName> -Disable
This example will disable the Storage QoS for all virtual machines.
#>

[CmdletBinding()]
param (
[Parameter(Mandatory = $true, Position = 0, HelpMessage = 'Hyper-V Server Name')]
[Alias('Hyper-V Server')]
[String]$HVServerName,

[Parameter(HelpMessage = 'Disable Storage QoS', ParameterSetName = "Disable")]
[Switch]$Disable,

[Parameter(Mandatory = $true, HelpMessage = 'Maximun, Minimum or Both', ParameterSetName = "Enable")]
[ValidateSet("Maximum", "Minimum", "Both")]
[String]$MinMax = "Maximum",

[Parameter(HelpMessage = 'Storage Minimum IO', ParameterSetName = "Enable")]
[Int]$StorageMinIO,

[Parameter(HelpMessage = 'Storage Maximum IO', ParameterSetName = "Enable")]
[Int]$StorageMaxIO
)


# If Disable switch equal to true, disable Storage QoS on all VMs
If ($Disable) {
    $VMIOPs = Get-VM -ComputerName $HVServerName | Get-VMHardDiskDrive
    foreach ($VM in $VMIOPs) {
        Set-VMHardDiskDrive -ComputerName $HVServerName -VMName $VM.VMName -ControllerType $VM.ControllerType -ControllerNumber $VM.ControllerNumber -ControllerLocation $VM.ControllerLocation -MinimumIOPS $false -MaximumIOPS $false
}
} else {

If ($StorageMinIO -eq '0' -and $StorageMaxIO -eq '0') {
    Write-Error "Minimum and Maximum IOPs cannot both be set to Zero!"
    Break
}

If ($StorageMinIO -gt $StorageMaxIO) {
    Write-Error "The maximum IOPS must be equal to or greater than the minimum IOPS or set to zero to accept the system default value!"
    break
}


$VMIOPs = Get-VM -ComputerName $HVServerName | Get-VMHardDiskDrive

If ($MinMax -eq "Maximum") {
foreach ($VM in $VMIOPs) {
    Set-VMHardDiskDrive -ComputerName $HVServerName -VMName $VM.VMName -ControllerType $VM.ControllerType -ControllerNumber $VM.ControllerNumber -ControllerLocation $VM.ControllerLocation -MaximumIOPS $StorageMaxIO
}
} elseif ($MinMax -eq "Minimum") {
    foreach ($VM in $VMIOPs) {
    Set-VMHardDiskDrive -ComputerName $HVServerName -VMName $VM.VMName -ControllerType $VM.ControllerType -ControllerNumber $VM.ControllerNumber -ControllerLocation $VM.ControllerLocation -MinimumIOPS $StorageMinIO
}
} else {
foreach ($VM in $VMIOPs) {
    Set-VMHardDiskDrive -ComputerName $HVServerName -VMName $VM.VMName -ControllerType $VM.ControllerType -ControllerNumber $VM.ControllerNumber -ControllerLocation $VM.ControllerLocation -MinimumIOPS $StorageMinIO -MaximumIOPS $StorageMaxIO
}
}
}
# End

