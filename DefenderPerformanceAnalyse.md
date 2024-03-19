### Analysieren des Microsoft Protection-Protokolls
   
Die Microsoft-Schutzprotokolldatei finden Sie unter *C:\ProgramData\Microsoft\Windows Defender\Support*  
In *MPLog-xxxxxxxx-xxxxxx.log* finden Sie die geschätzten Informationen zur Leistungsbeeinträchtigung der ausgeführten Software als EstimatedImpact:  
   
Per-process counts:ProcessImageName: smsswd.exe, TotalTime: 6597, Count: 1406, MaxTime: 609, MaxTime   
File: \Device\HarddiskVolume3\_SMSTaskSequence\Packages\WQ1008E9\Files\FramePkg.exe, EstimatedImpact: 65%

|Feldname	        | Beschreibung                                                                                                                                                                          |
|:------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|ProcessImageName   |	Prozessimagename                                                                                                                                                                    |
|TotalTime	        | Die kumulierte Dauer in Millisekunden, die für die Überprüfung von Dateien aufgewendet wird, auf die durch diesen Prozess zugegriffen wird                                            |
|Anzahl	           | Die Anzahl der gescannten Dateien, auf die von diesem Prozess zugegriffen wird                                                                                                        |
|MaxTime	           | Die Dauer in Millisekunden bei der längsten einzelnen Überprüfung einer Datei, auf die von diesem Prozess zugegriffen wird                                                            |
|MaxTimeFile	     | Der Pfad der Datei, auf die von diesem Prozess zugegriffen wird, für die die längste Überprüfung der MaxTime Dauer aufgezeichnet wurde.                                               |
|EstimatedImpact	  | Der Prozentsatz der Zeit, die für die Überprüfung von Dateien aufgewendet wurde, auf die von diesem Prozess zugegriffen wird, außerhalb des Zeitraums, in dem bei diesem Prozess eine Überprüfungsaktivität aufgetreten ist |
  
Wenn die Leistungsbeeinträchtigung hoch ist, versuchen Sie, den Prozess den Pfad-/Prozessausschlüssen hinzuzufügen.  
  
