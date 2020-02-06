FileChangeDir("D:\XPtsp\Packages\Green")
$search = FileFindFirstFile("*.res")
If $search = -1 Then
    MsgBox(0, "Error", "No files/directories matched the search pattern")
    Exit
EndIf
While 1
    $file = FileFindNextFile($search)
    If @error Then ExitLoop
	RunWait("D:\XPtsp\Programs\Reshacker -extract """ & @WorkingDir & "\" & $file & """, ""D:\XPtsp\Temp\_.rc""
WEnd
FileClose($search)
