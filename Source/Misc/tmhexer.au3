FileCopy(@WindowsDir & "\System32\Taskmgr.exe", @DesktopDir & "\TASKMGR.EXE", 1)
$TASKMGR = "00B2EE|00B2EE|0000EE"
_Hex_TASKMGR_EXE(@DesktopDir & "\TASKMGR.EXE")

Func _Hex_TASKMGR_EXE($S = "", $RFILE = "")
	Local $Handle = FileOpen($S, 16)
	Local $VAR = FileRead($Handle), $OLD
	FileClose($Handle)
	Local $MOD = $TASKMGR
	If $MOD = "" Then Return MsgBox(0, "", "ERROR")
	$MOD = StringSplit($MOD, "|")
	if $MOD[0] <> 3 then Return
	$MOD[1] = StringLeft($MOD[1] & "000000", 6)
	$MOD[2] = StringLeft($MOD[2] & "000000", 6)
	$MOD[3] = StringLeft($MOD[3] & "000000", 6)
	$VAR = StringReplace($VAR, "FFFF0000FFB5", $MOD[2] & "00FFB5")	; cpu digits
	$VAR = StringReplace($VAR, "00FF0000FF73", $MOD[1] & "00FF73")	; memory digits
	$VAR = StringReplace($VAR, "0E04000000FF0000FF00", "0E040000" & $MOD[1] & "00FF00")	; cpu line
	$VAR = StringReplace($VAR, "FFFF000000FF000000000000", $MOD[2] & "00" & $MOD[1] & "0000000000")	; lan line
	$VAR = StringReplace($VAR, "FFFF68008040006A", "FFFF68" & $MOD[3] & "006A") ;cpu grid
	$VAR = StringReplace($VAR, "FFFF00002500", $MOD[2] & "002500") ;memory line
	$VAR = StringReplace($VAR, "2B7D1068008040006A01", "2B7D1068" & $MOD[3] & "006A01") ;lan grid
	$VAR = StringReplace($VAR, "FFFF000000FF00", "2B7D1068" & $MOD[3] & "006A01") ;lan digits   
	FileDelete($S)
	$Handle = FileOpen($S, 16 + 2)
	FileWrite($Handle, $VAR)
	FileClose($Handle)
EndFunc   ;==>_Hex_TASKMGR_EXE

