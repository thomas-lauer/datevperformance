# Check NUMA spanning
# Mehr Infos unter 
# https://docs.pexip.com/server_design/hyperv_numa_affinity.htm

$VMs = Get-VM
$vCPUOutput = ""
foreach ($VM in $VMs)
{
  $GetvCPUCount = Get-VM -Name $VM.Name | select Name,NumaAligned,ProcessorCount,NumaNodesCount,NumaSocketCount
  $CPU = Get-WmiObject Win32_Processor
  $totalCPU = $CPU.numberoflogicalprocessors[0]*$CPU.count
  if ($GetvCPUCount.NumaAligned -eq $False)
  {
    $vCPUoutput += "NUMA nicht optimiert für; $($VM.Name). vCPU zugewiesen: $($GetvCPUCount.ProcessorCount) von $totalCPU verfügbar`n"
  }
}
if(!$vCPUOutput)
{ 
  $vCPUOutput = "NUMA OK" 
}
Write-Host $vCPUoutput
