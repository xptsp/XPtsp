KRNL("C:\NTLDR")

Func KRNL($S)
	Local $Handle = FileOpen($S, 16)
	Local $VAR = FileRead($Handle)
	FileClose($Handle)
	MsgBox(0, "KRNL", StringINStr($VAR, "NTOSKRNL", 0))
EndFunc