#include <misc.au3>

; Declare an array with the names of the months in it:
Dim $MON[12] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
Dim $DEBUG = 0, $EXCLUDE = ""

; Build the 7Zip SFX for distribution:
$ver = FileGetVersion("XPtsp.exe")
$File = "XPtsp_v" & $ver
FileDelete("Programs\Reshacker.log")
FileDelete("Programs\Reshacker.ini")
if $DEBUG then $EXCLUDE = "-x!Programs\Reshacker.* -x!programs\Dialogs.*"
RunWait("C:\Program Files\7-zip\7zG.exe a -r -mx9 -mmt " & $EXCLUDE & " """ & @ScriptDir & "\XPtsp.7z"" Boot\* Languages\*.ini Pics\* Programs\* XPtsp.exe XPtsp.ini", @ScriptDir)
If FileExists("XPtsp.7z") = 0 Then exit MsgBox(0, "", "Error compressing stuff!")
$OUTPUT = $File & "_GUI.exe"
RunWait(@ComSpec & " /c copy /b Source\Misc\7ZSD_All.sfx+Source\Misc\config.txt+XPtsp.7z " & $OUTPUT, @ScriptDir, @SW_HIDE)
FileDelete("XPtsp.7z")
Version_Info($OUTPUT)

; Modify the SFX to put the correct version info in it:
Func Version_Info($FName)
	Dim $ini = "101 ICON ""XPtsp.ico""" & @CRLF & @CRLF & _
			"1 VERSIONINFO" & @CRLF & _
			"FILEVERSION " & StringReplace($ver, ".", ",") & @CRLF & _
			"PRODUCTVERSION 3,3,6,0" & @CRLF & _
			"FILEOS 0x4" & @CRLF & _
			"FILETYPE 0x0" & @CRLF & @CRLF & _
			"{" & @CRLF & _
			"BLOCK ""StringFileInfo""" & @CRLF & _
			"{" & @CRLF & _
			"BLOCK ""040904b0""" & @CRLF & _
			"{" & @CRLF & _
			"VALUE ""FileVersion"", """ & $Ver & """" & @CRLF & _
			"VALUE ""Comments"", ""Patches/Overwrites default Windows XP resources""" & @CRLF & _
			"VALUE ""FileDescription"", ""XP Theme Source Patcher""" & @CRLF & _
			"VALUE ""LegalCopyright"", ""XPtsp Development Team""" & @CRLF & _
			"}" & @CRLF & _
			"}" & @CRLF & @CRLF & _
			"BLOCK ""VarFileInfo""" & @CRLF & _
			"{" & @CRLF & _
			"VALUE ""Translation"", 0x0409 0x04B0" & @CRLF & _
			"}" & @CRLF & _
			"}" & @CRLF
	FileCopy("Source\XPtsp.ico", ".\", 1)
	FileDelete("Version.rc")
	FileWriteLine("Version.rc", $ini)
	RunWait(@ScriptDir & "\Programs\Rc.exe ""Version.rc""", @ScriptDir, @SW_HIDE)
	RunWait(@ScriptDir & "\Programs\ResHacker  -addoverwrite """ & $FName & """, """ & $FName & """, """ & @ScriptDir & "\Version.res"",,,", @WorkingDir, @SW_HIDE)
	FileDelete("Version.rc")
	FileDelete("Version.res")
	FileDelete("XPtsp.ico")
EndFunc