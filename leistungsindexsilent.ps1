function Get-IniFile 
{  
    param(  
        [parameter(Mandatory = $true)] [string] $filePath  
    )  
    
    $anonymous = "NoSection"
  
    $ini = @{}  
    switch -regex -file $filePath  
    {  
        "^\[(.+)\]$" # Section  
        {  
            $section = $matches[1]  
            $ini[$section] = @{}  
            $CommentCount = 0  
        }  

        "^(;.*)$" # Comment  
        {  
            if (!($section))  
            {  
                $section = $anonymous  
                $ini[$section] = @{}  
            }  
            $value = $matches[1]  
            $CommentCount = $CommentCount + 1  
            $name = "Comment" + $CommentCount  
            $ini[$section][$name] = $value  
        }   

        "(.+?)\s*=\s*(.*)" # Key  
        {  
            if (!($section))  
            {  
                $section = $anonymous  
                $ini[$section] = @{}  
            }  
            $name,$value = $matches[1..2]  
            $ini[$section][$name] = $value  
        }  
    }  

    return $ini  
}

Start-Process -FilePath "$($env:datevpp)\PROGRAMM\RWApplic\irw.exe" -ArgumentList "-ap:PerfIndex -d:IRW20011 -c" -Wait
Start-Process -FilePath "$($env:datevpp)\PROGRAMM\RWApplic\irw.exe" -ArgumentList "-ap:PerfIndex -d:IRW20011 -c" -Wait

$dir = "$($env:temp)\IrwPerformanceIndex*.txt"
$latest = Get-ChildItem -Path $dir | Sort-Object LastAccessTime -Descending | Select-Object -First 1
$latest.name

$iniFile = Get-IniFile $latest.FullName

$StartScore = $iniFile.StartScore.Duration.replace(' Sekunden','')
write-host "StartScore" $StartScore

$DataAccessScore = $iniFile.DataAccessScore.Duration.replace(' Sekunden','')
write-host "DataAccessScore" $DataAccessScore

$ProcessorScore = $iniFile.ProcessorScore.Duration.replace(' Sekunden','')
write-host "ProcessorScore" $ProcessorScore

$HardDiskScore = $iniFile.HardDiskScore.Duration.replace(' Sekunden','')
write-host "HardDiskScore" $HardDiskScore

$ServiceScore = $iniFile.ServiceScore.Duration.replace(' Sekunden','')
write-host "ServiceScore" $ServiceScore

$GuiScore = $iniFile.GuiScore.Duration.replace(' Sekunden','')
write-host "GuiScore" $GuiScore

$OverallScore = $iniFile.OverallScore.Duration.replace(' Sekunden','')
write-host "OverallScore" $OverallScore

# UDF Feld für Datto RMM schreiben
New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage -Name Custom16 -Value $OverallScore -Force
