# PowerShell script to query some hardware infos from Hyper-V hosts (physical cores, logical cores, used virtual cores, mem overall, mem free, ...)
# Written by Haiko Hertes | www.hertes.net

# Change this according to your needs
$AllHyperVHosts = "SRV042HV"

function Get-HyperVHostInfo([string]$HyperVHost)
{

    $vCores = ((Get-VM -ComputerName $HyperVHost).ProcessorCount | Measure-Object -Sum).Sum

    $Property = "numberOfCores", "NumberOfLogicalProcessors"
    $CPUs = Get-Ciminstance -class Win32_Processor -Property  $Property -ComputerName $HyperVHost| Select-Object -Property $Property 
    $Cores = ($CPUs.numberOfCores | Measure-Object -Sum).Sum
    $logCores = ($CPUs.NumberOfLogicalProcessors | Measure-Object -Sum).Sum

    $os = Get-Ciminstance Win32_OperatingSystem -ComputerName $HyperVHost
    $MemFreePct = [math]::Round(($os.FreePhysicalMemory/$os.TotalVisibleMemorySize)*100,2)

    $object = New-Object -TypeName PSObject
    $object | Add-Member –MemberType NoteProperty –Name PhysicalCores –Value $Cores
    $object | Add-Member –MemberType NoteProperty –Name LogicalCores –Value $logCores
    $object | Add-Member –MemberType NoteProperty –Name VirtualCores –Value $vCores
    $object | Add-Member –MemberType NoteProperty –Name MemTotalGB -Value ([int]($os.TotalVisibleMemorySize/1mb))
    $object | Add-Member –MemberType NoteProperty –Name MemFreeGB -Value ([math]::Round($os.FreePhysicalMemory/1mb,2))
    $object | Add-Member –MemberType NoteProperty –Name MemFreePct -Value $MemFreePct

    Return $object
}

ForEach($OneHost in $AllHyperVHosts)
{
    $HostData = Get-HyperVHostInfo -HyperVHost $OneHost

    Write-Host "$OneHost has $($Hostdata.PhysicalCores) physical cores, $($Hostdata.LogicalCores) logical cores and $($Hostdata.VirtualCores) virtual cores are used in all VMs overall." -ForegroundColor Yellow
    Write-Host "The Core:vCore ratio is `t`t1:$([math]::Round(($Hostdata.VirtualCores) /  ($Hostdata.PhysicalCores),2))"
    Write-Host "The Log.Core:vCore ratio is `t1:$([math]::Round(($Hostdata.VirtualCores) /  ($Hostdata.LogicalCores),2))"
    Write-Host "The system has $($Hostdata.MemFreeGB)GB of free memory and $($Hostdata.MemTotalGB)GB memory at all, which is $($Hostdata.MemFreePct)% free"
    Write-Host ""

}
Write-Host "The conservative approach for logical cores is `t1:8 "
