# DATEV Leitungsindex Silent ausführen

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

Start-Process -FilePath "$env:datevpp\PROGRAMM\RWApplic\irw.exe" -ArgumentList "-ap:PerfIndex -d:IRW20011 -c" -Wait
Start-Process -FilePath "$env:datevpp\PROGRAMM\RWApplic\irw.exe" -ArgumentList "-ap:PerfIndex -d:IRW20011 -c" -Wait

$dir = "$env:temp\IrwPerformanceIndex*.txt"
$latest = Get-ChildItem -Path $dir | Sort-Object LastAccessTime -Descending | Select-Object -First 1
$latest.name

$iniFile = Get-IniFile $latest.FullName

$StartScore = $iniFile.StartScore.Duration.replace(' Sekunden','')
$StartScore

$DataAccessScore = $iniFile.DataAccessScore.Duration.replace(' Sekunden','')
$DataAccessScore

$ProcessorScore = $iniFile.ProcessorScore.Duration.replace(' Sekunden','')
$ProcessorScore

$HardDiskScore = $iniFile.HardDiskScore.Duration.replace(' Sekunden','')
$HardDiskScore

$ServiceScore = $iniFile.ServiceScore.Duration.replace(' Sekunden','')
$ServiceScore

$GuiScore = $iniFile.GuiScore.Duration.replace(' Sekunden','')
$GuiScore

$OverallScore = $iniFile.OverallScore.Duration.replace(' Sekunden','')
$OverallScore
