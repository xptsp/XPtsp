FileChangeDir("D:\XPtsp\Packages\Green")
$search = FileFindFirstFile("*.res")
$count = 0
$Max = 0
If $search = -1 Then
	MsgBox(0, "Error", "No files/directories matched the search pattern")
	Exit
EndIf
While 1
	$file = FileFindNextFile($search)
	If @error Then ExitLoop
	$max += 1
wend

$search = FileFindFirstFile("*.res")
If $search = -1 Then
	MsgBox(0, "Error", "No files/directories matched the search pattern")
	Exit
EndIf
While 1
	$file = FileFindNextFile($search)
	If @error Then ExitLoop
	RunWait("D:\XPtsp\Programs\Reshacker -extract """ & @WorkingDir & "\" & $file & """, ""D:\XPtsp\Temp\_.rc"", DIALOG,,")
	RunWait("D:\XPtsp\Programs\Rh2Rc ""_.rc"" ""_2.rc""", "D:\XPtsp\Temp", @SW_HIDE)
	RunWait("D:\XPtsp\Programs\rc /r ""_2.rc""", "D:\XPtsp\Temp", @SW_HIDE)
	MsgBox(0, "", "!")
WEnd
FileClose($search)