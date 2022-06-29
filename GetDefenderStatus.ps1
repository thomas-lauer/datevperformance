#
# Thomas Lauer (c) 2021
#

$defenderOptions = Get-MpComputerStatus
$defenderPreference = Get-MpPreference

if([string]::IsNullOrEmpty($defenderOptions)) 
{ 
  # No Defender Installed
  Write-host "Windows Defender was not found running on the Server:" $env:computername -foregroundcolor "red"
}
else
{

    Write-host "Windows Defender was found on the Server:" $env:computername -foregroundcolor "green" 
    Write-host "> Windows Defender Enabled="$defenderOptions.AntivirusEnabled 
    Write-host "> Windows Defender Service Enabled="$defenderOptions.AMServiceEnabled 
    Write-host "> Windows Defender Antispyware Enabled="$defenderOptions.AntispywareEnabled 
    Write-host "> Windows Defender OnAccessProtection Enabled="$defenderOptions.OnAccessProtectionEnabled 
    Write-host "> Windows Defender RealTimeProtection Enabled="$defenderOptions.RealTimeProtectionEnabled
    Write-host "> Windows Defender ExclusionExtension "$defenderPreference.ExclusionExtension
    Write-host "> Windows Defender ExclusionIpAddress "$defenderPreference.ExclusionIpAddress
    Write-host "> Windows Defender ExclusionPath "$defenderPreference.ExclusionPath
    Write-host "> Windows Defender ExclusionProcess "$defenderPreference.ExclusionProcess

    
    # Check all Service true
    if($defenderOptions.AntivirusEnabled -and 
       $defenderOptions.AMServiceEnabled -and
       $defenderOptions.AntispywareEnabled -and
       $defenderOptions.OnAccessProtectionEnabled -and
       $defenderOptions.RealTimeProtectionEnabled)
    {
        $enable = $true
        write-host "Enable:"+ $enable
    }
    else
    {
        $enable = $false
        write-host "Enable:"+ $enable
    }

    
    # Update older than 24h
    $lastUpdate = $defenderOptions.AntivirusSignatureLastUpdated
    $StartDate=(GET-DATE)
    $EndDate=$lastUpdate
    $tsinh = [math]::Round((NEW-TIMESPAN –Start $StartDate –End $EndDate).TotalHours * -1)
        
    if($tsinh -gt 24.0)
    {
        write-host "OUTDATED, "+ $tsinh
        $upToDate = $false
    }
    else
    {
        write-host "OK, " $tsinh
        $upToDate = $true
    }


 }
