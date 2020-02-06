#RequireAdmin
Opt('MustDeclareVars',1)
Global $obj_SR, $obj_WMI
Global $SystemDrive = EnvGet('SystemDrive')

Func _SR_CreateRestorePoint($strDescription	)
	Local Const $MAX_DESC = 64
	Local Const $MAX_DESC_W = 256
	Local Const $BEGIN_SYSTEM_CHANGE = 100
	Local Const $MODIFY_SETTINGS = 12
	Local $_RESTOREPTINFO = DllStructCreate('DWORD dwEventType;DWORD dwRestorePtType;INT64 llSequenceNumber;WCHAR szDescription['&$MAX_DESC&']')
	DllStructSetData($_RESTOREPTINFO,'dwEventType',$BEGIN_SYSTEM_CHANGE)
	DllStructSetData($_RESTOREPTINFO,'dwRestorePtType',$MODIFY_SETTINGS)
	DllStructSetData($_RESTOREPTINFO,'llSequenceNumber',0)
	DllStructSetData($_RESTOREPTINFO,'szDescription',$strDescription)
	Local $pRestorePtSpec = DllStructGetPtr($_RESTOREPTINFO)

	Local $_SMGRSTATUS = DllStructCreate('UINT  nStatus;INT64 llSequenceNumber')
	Local $pSMgrStatus = DllStructGetPtr($_SMGRSTATUS)

	Local $aRet = DllCall('SrClient.dll','BOOL','SRSetRestorePointW','ptr',$pRestorePtSpec,'ptr',$pSMgrStatus)
	If @error Then Return 0
	Return $aRet[0]
EndFunc

Func _SR_EnumRestorePoints()
	Local $aRet[1][3], $i = 0
	$aRet[0][0] = 0
	If Not IsObj($obj_WMI) Then $obj_WMI = ObjGet("winmgmts:root/default")
	If Not IsObj($obj_WMI) Then Return $aRet
	Local $RPSet = $obj_WMI.InstancesOf("SystemRestore")
	If Not IsObj($RPSet) Then Return $aRet
	For $RP In $RPSet
		$i += 1
		ReDim $aRet[$i+1][3]
		$aRet[$i][0] = $RP.SequenceNumber
		$aRet[$i][1] = $RP.Description
		$aRet[$i][2] = WMIDateStringToDate($RP.CreationTime)
	Next
	$aRet[0][0] = $i
	Return $aRet
EndFunc

Func WMIDateStringToDate($dtmDate)
	Return (StringMid($dtmDate, 5, 2) & "/" & _
	StringMid($dtmDate, 7, 2) & "/" & StringLeft($dtmDate, 4) _
	& " " & StringMid($dtmDate, 9, 2) & ":" & StringMid($dtmDate, 11, 2) & ":" & StringMid($dtmDate,13, 2))
EndFunc

Func _SR_RemoveRestorePoint($rpSeqNumber)
	Local $aRet = DllCall('SrClient.dll','DWORD','SRRemoveRestorePoint','DWORD',$rpSeqNumber)
	If @error Then
		Return SetError(1,0,0)
	ElseIf $aRet[0] = 0 Then
		Return 1
	Else
		Return SetError(1,0,0)
	EndIf
EndFunc

Func _SR_RemoveAllRestorePoints()
	Local $aRP = _SR_EnumRestorePoints(), $ret = 1
	For $i = 1 To $aRP[0][0]
		$ret *= _SR_RemoveRestorePoint($aRP[$i][0])
	Next
	Return $ret
EndFunc

Func SR_Enable($DriveL = $SystemDrive)
	If Not IsObj($obj_SR) Then $obj_SR = ObjGet("winmgmts:{impersonationLevel=impersonate}!root/default:SystemRestore")
	If Not IsObj($obj_SR) Then Return 0
	If $obj_SR.Enable($DriveL) = 0 Then Return 1
	Return 0
EndFunc

Func SR_Disable($DriveL = $SystemDrive)
	If Not IsObj($obj_SR) Then $obj_SR = ObjGet("winmgmts:{impersonationLevel=impersonate}!root/default:SystemRestore")
	If Not IsObj($obj_SR) Then Return 0
	If $obj_SR.Disable($DriveL) = 0 Then Return 1
	Return 0
EndFunc

Func _SR_Restore($rpSeqNumber)
	If Not IsObj($obj_SR) Then $obj_SR = ObjGet("winmgmts:{impersonationLevel=impersonate}!root/default:SystemRestore")
	If Not IsObj($obj_SR) Then Return 0
	If $obj_SR.Restore($rpSeqNumber) = 0 Then Return 1
	Return 0
EndFunc

