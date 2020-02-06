#NoTrayIcon
Global Const $STDOUT_CHILD = 2
Global Const $STDERR_CHILD = 4
Global Const $BS_ICON = 0x0040
Global Const $CBS_AUTOHSCROLL = 0x40
Global Const $CBS_DROPDOWN = 0x2
Global Const $CBS_DROPDOWNLIST = 0x3
Global Const $__COMBOBOXCONSTANT_WS_VSCROLL = 0x00200000
Global Const $GUI_SS_DEFAULT_COMBO = BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $__COMBOBOXCONSTANT_WS_VSCROLL)
Global Const $ES_MULTILINE = 4
Global Const $ES_AUTOVSCROLL = 64
Global Const $ES_AUTOHSCROLL = 128
Global Const $ES_READONLY = 2048
Global Const $ES_WANTRETURN = 4096
Global Const $ES_NUMBER = 8192
Global Const $__EDITCONSTANT_WS_VSCROLL = 0x00200000
Global Const $__EDITCONSTANT_WS_HSCROLL = 0x00100000
Global Const $GUI_SS_DEFAULT_EDIT = BitOR($ES_WANTRETURN, $__EDITCONSTANT_WS_VSCROLL, $__EDITCONSTANT_WS_HSCROLL, $ES_AUTOVSCROLL, $ES_AUTOHSCROLL)
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_CHECKED = 1
Global Const $GUI_UNCHECKED = 4
Global Const $GUI_SHOW = 16
Global Const $GUI_HIDE = 32
Global Const $GUI_ENABLE = 64
Global Const $GUI_DISABLE = 128
Global Const $GUI_FOCUS = 256
Global Const $GUI_DEFBUTTON = 512
Global Const $PBS_SMOOTH = 1
Global Const $SS_CENTER = 0x1
Global Const $SS_RIGHT = 0x2
Global Const $SS_LEFTNOWORDWRAP = 0xC
Global Const $SS_CENTERIMAGE = 0x0200
Global Const $TCS_SINGLELINE = 0x00000000
Global Const $TVS_HASBUTTONS = 0x00000001
Global Const $TVS_HASLINES = 0x00000002
Global Const $TVS_LINESATROOT = 0x00000004
Global Const $TVS_DISABLEDRAGDROP = 0x00000010
Global Const $TVS_SHOWSELALWAYS = 0x00000020
Global Const $TVS_CHECKBOXES = 0x00000100
Global Const $TVS_FULLROWSELECT = 0x00001000
Global Const $GUI_SS_DEFAULT_TREEVIEW = BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS)
Global Const $WS_MINIMIZEBOX = 0x00020000
Global Const $WS_SYSMENU = 0x00080000
Global Const $WS_VSCROLL = 0x00200000
Global Const $WS_BORDER = 0x00800000
Global Const $WS_CAPTION = 0x00C00000
Global Const $WS_POPUP = 0x80000000
Global Const $WS_POPUPWINDOW = 0x80880000
Global Const $WS_EX_CLIENTEDGE = 0x00000200
Global Const $WS_EX_STATICEDGE = 0x00020000
Global Const $WS_EX_TOPMOST = 0x00000008
Global Const $GUI_SS_DEFAULT_GUI = BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU)
Global Const $tagGDIPSTARTUPINPUT = "uint Version;ptr Callback;bool NoThread;bool NoCodecs"
Global Const $tagGDIPIMAGECODECINFO = "byte CLSID[16];byte FormatID[16];ptr CodecName;ptr DllName;ptr FormatDesc;ptr FileExt;" & "ptr MimeType;dword Flags;dword Version;dword SigCount;dword SigSize;ptr SigPattern;ptr SigMask"
Global Const $tagGUID = "ulong Data1;ushort Data2;ushort Data3;byte Data4[8]"
Global Const $tagSECURITY_ATTRIBUTES = "dword Length;ptr Descriptor;bool InheritHandle"
Func _Iif($fTest, $vTrueVal, $vFalseVal)
If $fTest Then
Return $vTrueVal
Else
Return $vFalseVal
EndIf
EndFunc
Func _Singleton($sOccurenceName, $iFlag = 0)
Local Const $ERROR_ALREADY_EXISTS = 183
Local Const $SECURITY_DESCRIPTOR_REVISION = 1
Local $tSecurityAttributes = 0
If BitAND($iFlag, 2) Then
Local $tSecurityDescriptor = DllStructCreate("byte;byte;word;ptr[4]")
Local $aRet = DllCall("advapi32.dll", "bool", "InitializeSecurityDescriptor", _
"struct*", $tSecurityDescriptor, "dword", $SECURITY_DESCRIPTOR_REVISION)
If @error Then Return SetError(@error, @extended, 0)
If $aRet[0] Then
$aRet = DllCall("advapi32.dll", "bool", "SetSecurityDescriptorDacl", _
"struct*", $tSecurityDescriptor, "bool", 1, "ptr", 0, "bool", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aRet[0] Then
$tSecurityAttributes = DllStructCreate($tagSECURITY_ATTRIBUTES)
DllStructSetData($tSecurityAttributes, 1, DllStructGetSize($tSecurityAttributes))
DllStructSetData($tSecurityAttributes, 2, DllStructGetPtr($tSecurityDescriptor))
DllStructSetData($tSecurityAttributes, 3, 0)
EndIf
EndIf
EndIf
Local $handle = DllCall("kernel32.dll", "handle", "CreateMutexW", "struct*", $tSecurityAttributes, "bool", 1, "wstr", $sOccurenceName)
If @error Then Return SetError(@error, @extended, 0)
Local $lastError = DllCall("kernel32.dll", "dword", "GetLastError")
If @error Then Return SetError(@error, @extended, 0)
If $lastError[0] = $ERROR_ALREADY_EXISTS Then
If BitAND($iFlag, 1) Then
Return SetError($lastError[0], $lastError[0], 0)
Else
Exit -1
EndIf
EndIf
Return $handle[0]
EndFunc
Func _SendMessage($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lresult")
Local $aResult = DllCall("user32.dll", $sReturnType, "SendMessageW", "hwnd", $hWnd, "uint", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
If @error Then Return SetError(@error, @extended, "")
If $iReturn >= 0 And $iReturn <= 4 Then Return $aResult[$iReturn]
Return $aResult
EndFunc
Global Const $HGDI_ERROR = Ptr(-1)
Global Const $INVALID_HANDLE_VALUE = Ptr(-1)
Global Const $KF_EXTENDED = 0x0100
Global Const $KF_ALTDOWN = 0x2000
Global Const $KF_UP = 0x8000
Global Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 8)
Global Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 8)
Global Const $LLKHF_UP = BitShift($KF_UP, 8)
Func _WinAPI_GetClassName($hWnd)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Local $aResult = DllCall("user32.dll", "int", "GetClassNameW", "hwnd", $hWnd, "wstr", "", "int", 4096)
If @error Then Return SetError(@error, @extended, False)
Return SetExtended($aResult[0], $aResult[2])
EndFunc
Func _WinAPI_GUIDFromString($sGUID)
Local $tGUID = DllStructCreate($tagGUID)
_WinAPI_GUIDFromStringEx($sGUID, $tGUID)
If @error Then Return SetError(@error, @extended, 0)
Return $tGUID
EndFunc
Func _WinAPI_GUIDFromStringEx($sGUID, $pGUID)
Local $aResult = DllCall("ole32.dll", "long", "CLSIDFromString", "wstr", $sGUID, "struct*", $pGUID)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_IsClassName($hWnd, $sClassName)
Local $sSeparator = Opt("GUIDataSeparatorChar")
Local $aClassName = StringSplit($sClassName, $sSeparator)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Local $sClassCheck = _WinAPI_GetClassName($hWnd)
For $x = 1 To UBound($aClassName) - 1
If StringUpper(StringMid($sClassCheck, 1, StringLen($aClassName[$x]))) = StringUpper($aClassName[$x]) Then Return True
Next
Return False
EndFunc
Func _WinAPI_StringFromGUID($pGUID)
Local $aResult = DllCall("ole32.dll", "int", "StringFromGUID2", "struct*", $pGUID, "wstr", "", "int", 40)
If @error Then Return SetError(@error, @extended, "")
Return SetExtended($aResult[0], $aResult[2])
EndFunc
Func _WinAPI_WideCharToMultiByte($pUnicode, $iCodePage = 0, $bRetString = True)
Local $sUnicodeType = "wstr"
If Not IsString($pUnicode) Then $sUnicodeType = "struct*"
Local $aResult = DllCall("kernel32.dll", "int", "WideCharToMultiByte", "uint", $iCodePage, "dword", 0, $sUnicodeType, $pUnicode, "int", -1, _
"ptr", 0, "int", 0, "ptr", 0, "ptr", 0)
If @error Then Return SetError(@error, @extended, "")
Local $tMultiByte = DllStructCreate("char[" & $aResult[0] & "]")
$aResult = DllCall("kernel32.dll", "int", "WideCharToMultiByte", "uint", $iCodePage, "dword", 0, $sUnicodeType, $pUnicode, "int", -1, _
"struct*", $tMultiByte, "int", $aResult[0], "ptr", 0, "ptr", 0)
If @error Then Return SetError(@error, @extended, "")
If $bRetString Then Return DllStructGetData($tMultiByte, 1)
Return $tMultiByte
EndFunc
Global $ghGDIPDll = 0
Global $giGDIPRef = 0
Global $giGDIPToken = 0
Func _GDIPlus_Encoders()
Local $iCount = _GDIPlus_EncodersGetCount()
Local $iSize = _GDIPlus_EncodersGetSize()
Local $tBuffer = DllStructCreate("byte[" & $iSize & "]")
Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageEncoders", "uint", $iCount, "uint", $iSize, "struct*", $tBuffer)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] <> 0 Then Return SetError($aResult[0], 0, 0)
Local $pBuffer = DllStructGetPtr($tBuffer)
Local $tCodec, $aInfo[$iCount + 1][14]
$aInfo[0][0] = $iCount
For $iI = 1 To $iCount
$tCodec = DllStructCreate($tagGDIPIMAGECODECINFO, $pBuffer)
$aInfo[$iI][1] = _WinAPI_StringFromGUID(DllStructGetPtr($tCodec, "CLSID"))
$aInfo[$iI][2] = _WinAPI_StringFromGUID(DllStructGetPtr($tCodec, "FormatID"))
$aInfo[$iI][3] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "CodecName"))
$aInfo[$iI][4] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "DllName"))
$aInfo[$iI][5] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "FormatDesc"))
$aInfo[$iI][6] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "FileExt"))
$aInfo[$iI][7] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "MimeType"))
$aInfo[$iI][8] = DllStructGetData($tCodec, "Flags")
$aInfo[$iI][9] = DllStructGetData($tCodec, "Version")
$aInfo[$iI][10] = DllStructGetData($tCodec, "SigCount")
$aInfo[$iI][11] = DllStructGetData($tCodec, "SigSize")
$aInfo[$iI][12] = DllStructGetData($tCodec, "SigPattern")
$aInfo[$iI][13] = DllStructGetData($tCodec, "SigMask")
$pBuffer += DllStructGetSize($tCodec)
Next
Return $aInfo
EndFunc
Func _GDIPlus_EncodersGetCLSID($sFileExt)
Local $aEncoders = _GDIPlus_Encoders()
For $iI = 1 To $aEncoders[0][0]
If StringInStr($aEncoders[$iI][6], "*." & $sFileExt) > 0 Then Return $aEncoders[$iI][1]
Next
Return SetError(-1, -1, "")
EndFunc
Func _GDIPlus_EncodersGetCount()
Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageEncodersSize", "uint*", 0, "uint*", 0)
If @error Then Return SetError(@error, @extended, -1)
Return SetExtended($aResult[0], $aResult[1])
EndFunc
Func _GDIPlus_EncodersGetSize()
Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageEncodersSize", "uint*", 0, "uint*", 0)
If @error Then Return SetError(@error, @extended, -1)
Return SetExtended($aResult[0], $aResult[2])
EndFunc
Func _GDIPlus_ImageDispose($hImage)
Local $aResult = DllCall($ghGDIPDll, "int", "GdipDisposeImage", "handle", $hImage)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0] = 0
EndFunc
Func _GDIPlus_ImageGetHeight($hImage)
Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageHeight", "handle", $hImage, "uint*", 0)
If @error Then Return SetError(@error, @extended, -1)
Return SetExtended($aResult[0], $aResult[2])
EndFunc
Func _GDIPlus_ImageGetWidth($hImage)
Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageWidth", "handle", $hImage, "uint*", -1)
If @error Then Return SetError(@error, @extended, -1)
Return SetExtended($aResult[0], $aResult[2])
EndFunc
Func _GDIPlus_ImageLoadFromFile($sFileName)
Local $aResult = DllCall($ghGDIPDll, "int", "GdipLoadImageFromFile", "wstr", $sFileName, "ptr*", 0)
If @error Then Return SetError(@error, @extended, -1)
Return SetExtended($aResult[0], $aResult[2])
EndFunc
Func _GDIPlus_ImageSaveToFileEx($hImage, $sFileName, $sEncoder, $pParams = 0)
Local $tGUID = _WinAPI_GUIDFromString($sEncoder)
Local $aResult = DllCall($ghGDIPDll, "int", "GdipSaveImageToFile", "handle", $hImage, "wstr", $sFileName, "struct*", $tGUID, "struct*", $pParams)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0] = 0
EndFunc
Func _GDIPlus_Shutdown()
If $ghGDIPDll = 0 Then Return SetError(-1, -1, False)
$giGDIPRef -= 1
If $giGDIPRef = 0 Then
DllCall($ghGDIPDll, "none", "GdiplusShutdown", "ptr", $giGDIPToken)
DllClose($ghGDIPDll)
$ghGDIPDll = 0
EndIf
Return True
EndFunc
Func _GDIPlus_Startup()
$giGDIPRef += 1
If $giGDIPRef > 1 Then Return True
$ghGDIPDll = DllOpen("GDIPlus.dll")
If $ghGDIPDll = -1 Then
$giGDIPRef = 0
Return SetError(1, 2, False)
EndIf
Local $tInput = DllStructCreate($tagGDIPSTARTUPINPUT)
Local $tToken = DllStructCreate("ulong_ptr Data")
DllStructSetData($tInput, "Version", 1)
Local $aResult = DllCall($ghGDIPDll, "int", "GdiplusStartup", "struct*", $tToken, "struct*", $tInput, "ptr", 0)
If @error Then Return SetError(@error, @extended, False)
$giGDIPToken = DllStructGetData($tToken, "Data")
Return $aResult[0] = 0
EndFunc
Func _DateDayOfWeek($iDayNum, $iShort = 0)
Local Const $aDayOfWeek[8] = ["", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
Select
Case Not StringIsInt($iDayNum) Or Not StringIsInt($iShort)
Return SetError(1, 0, "")
Case $iDayNum < 1 Or $iDayNum > 7
Return SetError(1, 0, "")
Case Else
Select
Case $iShort = 0
Return $aDayOfWeek[$iDayNum]
Case $iShort = 1
Return StringLeft($aDayOfWeek[$iDayNum], 3)
Case Else
Return SetError(1, 0, "")
EndSelect
EndSelect
EndFunc
Func _DateIsLeapYear($iYear)
If StringIsInt($iYear) Then
Select
Case Mod($iYear, 4) = 0 And Mod($iYear, 100) <> 0
Return 1
Case Mod($iYear, 400) = 0
Return 1
Case Else
Return 0
EndSelect
EndIf
Return SetError(1, 0, 0)
EndFunc
Func _DateIsValid($sDate)
Local $asDatePart[4], $asTimePart[4]
Local $sDateTime = StringSplit($sDate, " T")
If $sDateTime[0] > 0 Then $asDatePart = StringSplit($sDateTime[1], "/-.")
If UBound($asDatePart) <> 4 Then Return(0)
If $asDatePart[0] <> 3 Then Return(0)
If Not StringIsInt($asDatePart[1]) Then Return(0)
If Not StringIsInt($asDatePart[2]) Then Return(0)
If Not StringIsInt($asDatePart[3]) Then Return(0)
$asDatePart[1] = Number($asDatePart[1])
$asDatePart[2] = Number($asDatePart[2])
$asDatePart[3] = Number($asDatePart[3])
Local $iNumDays = _DaysInMonth($asDatePart[1])
If $asDatePart[1] < 1000 Or $asDatePart[1] > 2999 Then Return(0)
If $asDatePart[2] < 1 Or $asDatePart[2] > 12 Then Return(0)
If $asDatePart[3] < 1 Or $asDatePart[3] > $iNumDays[$asDatePart[2]] Then Return(0)
If $sDateTime[0] > 1 Then
$asTimePart = StringSplit($sDateTime[2], ":")
If UBound($asTimePart) < 4 Then ReDim $asTimePart[4]
Else
Dim $asTimePart[4]
EndIf
If $asTimePart[0] < 1 Then Return(1)
If $asTimePart[0] < 2 Then Return(0)
If $asTimePart[0] = 2 Then $asTimePart[3] = "00"
If Not StringIsInt($asTimePart[1]) Then Return(0)
If Not StringIsInt($asTimePart[2]) Then Return(0)
If Not StringIsInt($asTimePart[3]) Then Return(0)
$asTimePart[1] = Number($asTimePart[1])
$asTimePart[2] = Number($asTimePart[2])
$asTimePart[3] = Number($asTimePart[3])
If $asTimePart[1] < 0 Or $asTimePart[1] > 23 Then Return(0)
If $asTimePart[2] < 0 Or $asTimePart[2] > 59 Then Return(0)
If $asTimePart[3] < 0 Or $asTimePart[3] > 59 Then Return(0)
Return 1
EndFunc
Func _DateTimeFormat($sDate, $sType)
Local $asDatePart[4], $asTimePart[4]
Local $sTempDate = "", $sTempTime = ""
Local $sAM, $sPM, $lngX
If Not _DateIsValid($sDate) Then
Return SetError(1, 0, "")
EndIf
If $sType < 0 Or $sType > 5 Or Not IsInt($sType) Then
Return SetError(2, 0, "")
EndIf
_DateTimeSplit($sDate, $asDatePart, $asTimePart)
Switch $sType
Case 0
$lngX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 0x400, "dword", 0x1F, "wstr", "", "int", 255)
If Not @error And $lngX[0] <> 0 Then
$sTempDate = $lngX[3]
Else
$sTempDate = "M/d/yyyy"
EndIf
If $asTimePart[0] > 1 Then
$lngX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 0x400, "dword", 0x1003, "wstr", "", "int", 255)
If Not @error And $lngX[0] <> 0 Then
$sTempTime = $lngX[3]
Else
$sTempTime = "h:mm:ss tt"
EndIf
EndIf
Case 1
$lngX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 0x400, "dword", 0x20, "wstr", "", "int", 255)
If Not @error And $lngX[0] <> 0 Then
$sTempDate = $lngX[3]
Else
$sTempDate = "dddd, MMMM dd, yyyy"
EndIf
Case 2
$lngX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 0x400, "dword", 0x1F, "wstr", "", "int", 255)
If Not @error And $lngX[0] <> 0 Then
$sTempDate = $lngX[3]
Else
$sTempDate = "M/d/yyyy"
EndIf
Case 3
If $asTimePart[0] > 1 Then
$lngX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 0x400, "dword", 0x1003, "wstr", "", "int", 255)
If Not @error And $lngX[0] <> 0 Then
$sTempTime = $lngX[3]
Else
$sTempTime = "h:mm:ss tt"
EndIf
EndIf
Case 4
If $asTimePart[0] > 1 Then
$sTempTime = "hh:mm"
EndIf
Case 5
If $asTimePart[0] > 1 Then
$sTempTime = "hh:mm:ss"
EndIf
EndSwitch
If $sTempDate <> "" Then
$lngX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 0x400, "dword", 0x1D, "wstr", "", "int", 255)
If Not @error And $lngX[0] <> 0 Then
$sTempDate = StringReplace($sTempDate, "/", $lngX[3])
EndIf
Local $iWday = _DateToDayOfWeek($asDatePart[1], $asDatePart[2], $asDatePart[3])
$asDatePart[3] = StringRight("0" & $asDatePart[3], 2)
$asDatePart[2] = StringRight("0" & $asDatePart[2], 2)
$sTempDate = StringReplace($sTempDate, "d", "@")
$sTempDate = StringReplace($sTempDate, "m", "#")
$sTempDate = StringReplace($sTempDate, "y", "&")
$sTempDate = StringReplace($sTempDate, "@@@@", _DateDayOfWeek($iWday, 0))
$sTempDate = StringReplace($sTempDate, "@@@", _DateDayOfWeek($iWday, 1))
$sTempDate = StringReplace($sTempDate, "@@", $asDatePart[3])
$sTempDate = StringReplace($sTempDate, "@", StringReplace(StringLeft($asDatePart[3], 1), "0", "") & StringRight($asDatePart[3], 1))
$sTempDate = StringReplace($sTempDate, "####", _DateToMonth($asDatePart[2], 0))
$sTempDate = StringReplace($sTempDate, "###", _DateToMonth($asDatePart[2], 1))
$sTempDate = StringReplace($sTempDate, "##", $asDatePart[2])
$sTempDate = StringReplace($sTempDate, "#", StringReplace(StringLeft($asDatePart[2], 1), "0", "") & StringRight($asDatePart[2], 1))
$sTempDate = StringReplace($sTempDate, "&&&&", $asDatePart[1])
$sTempDate = StringReplace($sTempDate, "&&", StringRight($asDatePart[1], 2))
EndIf
If $sTempTime <> "" Then
$lngX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 0x400, "dword", 0x28, "wstr", "", "int", 255)
If Not @error And $lngX[0] <> 0 Then
$sAM = $lngX[3]
Else
$sAM = "AM"
EndIf
$lngX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 0x400, "dword", 0x29, "wstr", "", "int", 255)
If Not @error And $lngX[0] <> 0 Then
$sPM = $lngX[3]
Else
$sPM = "PM"
EndIf
$lngX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 0x400, "dword", 0x1E, "wstr", "", "int", 255)
If Not @error And $lngX[0] <> 0 Then
$sTempTime = StringReplace($sTempTime, ":", $lngX[3])
EndIf
If StringInStr($sTempTime, "tt") Then
If $asTimePart[1] < 12 Then
$sTempTime = StringReplace($sTempTime, "tt", $sAM)
If $asTimePart[1] = 0 Then $asTimePart[1] = 12
Else
$sTempTime = StringReplace($sTempTime, "tt", $sPM)
If $asTimePart[1] > 12 Then $asTimePart[1] = $asTimePart[1] - 12
EndIf
EndIf
$asTimePart[1] = StringRight("0" & $asTimePart[1], 2)
$asTimePart[2] = StringRight("0" & $asTimePart[2], 2)
$asTimePart[3] = StringRight("0" & $asTimePart[3], 2)
$sTempTime = StringReplace($sTempTime, "hh", StringFormat("%02d", $asTimePart[1]))
$sTempTime = StringReplace($sTempTime, "h", StringReplace(StringLeft($asTimePart[1], 1), "0", "") & StringRight($asTimePart[1], 1))
$sTempTime = StringReplace($sTempTime, "mm", StringFormat("%02d", $asTimePart[2]))
$sTempTime = StringReplace($sTempTime, "ss", StringFormat("%02d", $asTimePart[3]))
$sTempDate = StringStripWS($sTempDate & " " & $sTempTime, 3)
EndIf
Return $sTempDate
EndFunc
Func _DateTimeSplit($sDate, ByRef $asDatePart, ByRef $iTimePart)
Local $sDateTime = StringSplit($sDate, " T")
If $sDateTime[0] > 0 Then $asDatePart = StringSplit($sDateTime[1], "/-.")
If $sDateTime[0] > 1 Then
$iTimePart = StringSplit($sDateTime[2], ":")
If UBound($iTimePart) < 4 Then ReDim $iTimePart[4]
Else
Dim $iTimePart[4]
EndIf
If UBound($asDatePart) < 4 Then ReDim $asDatePart[4]
For $x = 1 To 3
If StringIsInt($asDatePart[$x]) Then
$asDatePart[$x] = Number($asDatePart[$x])
Else
$asDatePart[$x] = -1
EndIf
If StringIsInt($iTimePart[$x]) Then
$iTimePart[$x] = Number($iTimePart[$x])
Else
$iTimePart[$x] = 0
EndIf
Next
Return 1
EndFunc
Func _DateToDayOfWeek($iYear, $iMonth, $iDay)
If Not _DateIsValid($iYear & "/" & $iMonth & "/" & $iDay) Then
Return SetError(1, 0, "")
EndIf
Local $i_aFactor = Int((14 - $iMonth) / 12)
Local $i_yFactor = $iYear - $i_aFactor
Local $i_mFactor = $iMonth +(12 * $i_aFactor) - 2
Local $i_dFactor = Mod($iDay + $i_yFactor + Int($i_yFactor / 4) - Int($i_yFactor / 100) + Int($i_yFactor / 400) + Int((31 * $i_mFactor) / 12), 7)
Return($i_dFactor + 1)
EndFunc
Func _DateToMonth($iMonth, $iShort = 0)
Local $aMonthNumber[13] = ["", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
Local $aMonthNumberAbbrev[13] = ["", "Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
Select
Case Not StringIsInt($iMonth)
Return SetError(1, 0, "")
Case $iMonth < 1 Or $iMonth > 12
Return SetError(1, 0, "")
Case Else
Select
Case $iShort = 0
Return $aMonthNumber[$iMonth]
Case $iShort = 1
Return $aMonthNumberAbbrev[$iMonth]
Case Else
Return SetError(1, 0, "")
EndSelect
EndSelect
EndFunc
Func _Now()
Return(_DateTimeFormat(@YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC, 0))
EndFunc
Func _DaysInMonth($iYear)
Local $aiDays[13] = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
If _DateIsLeapYear($iYear) Then $aiDays[2] = 29
Return $aiDays
EndFunc
Func _Max($nNum1, $nNum2)
If Not IsNumber($nNum1) Then Return SetError(1, 0, 0)
If Not IsNumber($nNum2) Then Return SetError(2, 0, 0)
If $nNum1 > $nNum2 Then
Return $nNum1
Else
Return $nNum2
EndIf
EndFunc
Func _Min($nNum1, $nNum2)
If(Not IsNumber($nNum1)) Then Return SetError(1, 0, 0)
If(Not IsNumber($nNum2)) Then Return SetError(2, 0, 0)
If $nNum1 > $nNum2 Then
Return $nNum2
Else
Return $nNum1
EndIf
EndFunc
Func __UDF_DebugPrint($sText, $iLine = @ScriptLineNumber, $err = @error, $ext = @extended)
ConsoleWrite( _
"!===========================================================" & @CRLF & _
"+======================================================" & @CRLF & _
"-->Line(" & StringFormat("%04d", $iLine) & "):" & @TAB & $sText & @CRLF & _
"+======================================================" & @CRLF)
Return SetError($err, $ext, 1)
EndFunc
Func __UDF_ValidateClassName($hWnd, $sClassNames)
__UDF_DebugPrint("This is for debugging only, set the debug variable to false before submitting")
If _WinAPI_IsClassName($hWnd, $sClassNames) Then Return True
Local $sSeparator = Opt("GUIDataSeparatorChar")
$sClassNames = StringReplace($sClassNames, $sSeparator, ",")
__UDF_DebugPrint("Invalid Class Type(s):" & @LF & @TAB & "Expecting Type(s): " & $sClassNames & @LF & @TAB & "Received Type : " & _WinAPI_GetClassName($hWnd))
Exit
EndFunc
Global Const $LV_VIEW_DETAILS = 0x0001
Global Const $LV_VIEW_ICON = 0x0000
Global Const $LV_VIEW_LIST = 0x0003
Global Const $LV_VIEW_SMALLICON = 0x0002
Global Const $LV_VIEW_TILE = 0x0004
Global Const $LVHT_ONITEMICON = 0x00000002
Global Const $LVHT_ONITEMLABEL = 0x00000004
Global Const $LVHT_ONITEMSTATEICON = 0x00000008
Global Const $LVHT_ONITEM = BitOR($LVHT_ONITEMICON, $LVHT_ONITEMLABEL, $LVHT_ONITEMSTATEICON)
Global Const $LVHT_EX_GROUP_HEADER = 0x10000000
Global Const $LVHT_EX_GROUP_FOOTER = 0x20000000
Global Const $LVHT_EX_GROUP_COLLAPSE = 0x40000000
Global Const $LVHT_EX_GROUP_BACKGROUND = 0x80000000
Global Const $LVHT_EX_GROUP_STATEICON = 0x01000000
Global Const $LVHT_EX_GROUP_SUBSETLINK = 0x02000000
Global Const $LVHT_EX_GROUP = BitOR($LVHT_EX_GROUP_BACKGROUND, $LVHT_EX_GROUP_COLLAPSE, $LVHT_EX_GROUP_FOOTER, $LVHT_EX_GROUP_HEADER, $LVHT_EX_GROUP_STATEICON, $LVHT_EX_GROUP_SUBSETLINK)
Global Const $LVM_FIRST = 0x1000
Global Const $LVM_GETVIEW =($LVM_FIRST + 143)
Global Const $LVM_SETVIEW =($LVM_FIRST + 142)
Func _ArrayDisplay(Const ByRef $avArray, $sTitle = "Array: ListView Display", $iItemLimit = -1, $iTranspose = 0, $sSeparator = "", $sReplace = "|", $sHeader = "")
If Not IsArray($avArray) Then Return SetError(1, 0, 0)
Local $iDimension = UBound($avArray, 0), $iUBound = UBound($avArray, 1) - 1, $iSubMax = UBound($avArray, 2) - 1
If $iDimension > 2 Then Return SetError(2, 0, 0)
If $sSeparator = "" Then $sSeparator = Chr(124)
If _ArraySearch($avArray, $sSeparator, 0, 0, 0, 1) <> -1 Then
For $x = 1 To 255
If $x >= 32 And $x <= 127 Then ContinueLoop
Local $sFind = _ArraySearch($avArray, Chr($x), 0, 0, 0, 1)
If $sFind = -1 Then
$sSeparator = Chr($x)
ExitLoop
EndIf
Next
EndIf
Local $vTmp, $iBuffer = 4094
Local $iColLimit = 250
Local $iOnEventMode = Opt("GUIOnEventMode", 0), $sDataSeparatorChar = Opt("GUIDataSeparatorChar", $sSeparator)
If $iSubMax < 0 Then $iSubMax = 0
If $iTranspose Then
$vTmp = $iUBound
$iUBound = $iSubMax
$iSubMax = $vTmp
EndIf
If $iSubMax > $iColLimit Then $iSubMax = $iColLimit
If $iItemLimit < 1 Then $iItemLimit = $iUBound
If $iUBound > $iItemLimit Then $iUBound = $iItemLimit
If $sHeader = "" Then
$sHeader = "Row  "
For $i = 0 To $iSubMax
$sHeader &= $sSeparator & "Col " & $i
Next
EndIf
Local $avArrayText[$iUBound + 1]
For $i = 0 To $iUBound
$avArrayText[$i] = "[" & $i & "]"
For $j = 0 To $iSubMax
If $iDimension = 1 Then
If $iTranspose Then
$vTmp = $avArray[$j]
Else
$vTmp = $avArray[$i]
EndIf
Else
If $iTranspose Then
$vTmp = $avArray[$j][$i]
Else
$vTmp = $avArray[$i][$j]
EndIf
EndIf
$vTmp = StringReplace($vTmp, $sSeparator, $sReplace, 0, 1)
If StringLen($vTmp) > $iBuffer Then $vTmp = StringLeft($vTmp, $iBuffer)
$avArrayText[$i] &= $sSeparator & $vTmp
Next
Next
Local Const $_ARRAYCONSTANT_GUI_DOCKBORDERS = 0x66
Local Const $_ARRAYCONSTANT_GUI_DOCKBOTTOM = 0x40
Local Const $_ARRAYCONSTANT_GUI_DOCKHEIGHT = 0x0200
Local Const $_ARRAYCONSTANT_GUI_DOCKLEFT = 0x2
Local Const $_ARRAYCONSTANT_GUI_DOCKRIGHT = 0x4
Local Const $_ARRAYCONSTANT_GUI_EVENT_CLOSE = -3
Local Const $_ARRAYCONSTANT_LVM_GETCOLUMNWIDTH =(0x1000 + 29)
Local Const $_ARRAYCONSTANT_LVM_GETITEMCOUNT =(0x1000 + 4)
Local Const $_ARRAYCONSTANT_LVM_GETITEMSTATE =(0x1000 + 44)
Local Const $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE =(0x1000 + 54)
Local Const $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT = 0x20
Local Const $_ARRAYCONSTANT_LVS_EX_GRIDLINES = 0x1
Local Const $_ARRAYCONSTANT_LVS_SHOWSELALWAYS = 0x8
Local Const $_ARRAYCONSTANT_WS_EX_CLIENTEDGE = 0x0200
Local Const $_ARRAYCONSTANT_WS_MAXIMIZEBOX = 0x00010000
Local Const $_ARRAYCONSTANT_WS_MINIMIZEBOX = 0x00020000
Local Const $_ARRAYCONSTANT_WS_SIZEBOX = 0x00040000
Local $iWidth = 640, $iHeight = 480
Local $hGUI = GUICreate($sTitle, $iWidth, $iHeight, Default, Default, BitOR($_ARRAYCONSTANT_WS_SIZEBOX, $_ARRAYCONSTANT_WS_MINIMIZEBOX, $_ARRAYCONSTANT_WS_MAXIMIZEBOX))
Local $aiGUISize = WinGetClientSize($hGUI)
Local $hListView = GUICtrlCreateListView($sHeader, 0, 0, $aiGUISize[0], $aiGUISize[1] - 26, $_ARRAYCONSTANT_LVS_SHOWSELALWAYS)
Local $hCopy = GUICtrlCreateButton("Copy Selected", 3, $aiGUISize[1] - 23, $aiGUISize[0] - 6, 20)
GUICtrlSetResizing($hListView, $_ARRAYCONSTANT_GUI_DOCKBORDERS)
GUICtrlSetResizing($hCopy, $_ARRAYCONSTANT_GUI_DOCKLEFT + $_ARRAYCONSTANT_GUI_DOCKRIGHT + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_LVS_EX_GRIDLINES, $_ARRAYCONSTANT_LVS_EX_GRIDLINES)
GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT, $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT)
GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_WS_EX_CLIENTEDGE, $_ARRAYCONSTANT_WS_EX_CLIENTEDGE)
For $i = 0 To $iUBound
GUICtrlCreateListViewItem($avArrayText[$i], $hListView)
Next
$iWidth = 0
For $i = 0 To $iSubMax + 1
$iWidth += GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_GETCOLUMNWIDTH, $i, 0)
Next
If $iWidth < 250 Then $iWidth = 230
$iWidth += 20
If $iWidth > @DesktopWidth Then $iWidth = @DesktopWidth - 100
WinMove($hGUI, "",(@DesktopWidth - $iWidth) / 2, Default, $iWidth)
GUISetState(@SW_SHOW, $hGUI)
While 1
Switch GUIGetMsg()
Case $_ARRAYCONSTANT_GUI_EVENT_CLOSE
ExitLoop
Case $hCopy
Local $sClip = ""
Local $aiCurItems[1] = [0]
For $i = 0 To GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_GETITEMCOUNT, 0, 0)
If GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_GETITEMSTATE, $i, 0x2) Then
$aiCurItems[0] += 1
ReDim $aiCurItems[$aiCurItems[0] + 1]
$aiCurItems[$aiCurItems[0]] = $i
EndIf
Next
If Not $aiCurItems[0] Then
For $sItem In $avArrayText
$sClip &= $sItem & @CRLF
Next
Else
For $i = 1 To UBound($aiCurItems) - 1
$sClip &= $avArrayText[$aiCurItems[$i]] & @CRLF
Next
EndIf
ClipPut($sClip)
EndSwitch
WEnd
GUIDelete($hGUI)
Opt("GUIOnEventMode", $iOnEventMode)
Opt("GUIDataSeparatorChar", $sDataSeparatorChar)
Return 1
EndFunc
Func _ArrayReverse(ByRef $avArray, $iStart = 0, $iEnd = 0)
If Not IsArray($avArray) Then Return SetError(1, 0, 0)
If UBound($avArray, 0) <> 1 Then Return SetError(3, 0, 0)
Local $vTmp, $iUBound = UBound($avArray) - 1
If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(2, 0, 0)
For $i = $iStart To Int(($iStart + $iEnd - 1) / 2)
$vTmp = $avArray[$i]
$avArray[$i] = $avArray[$iEnd]
$avArray[$iEnd] = $vTmp
$iEnd -= 1
Next
Return 1
EndFunc
Func _ArraySearch(Const ByRef $avArray, $vValue, $iStart = 0, $iEnd = 0, $iCase = 0, $iCompare = 0, $iForward = 1, $iSubItem = -1)
If Not IsArray($avArray) Then Return SetError(1, 0, -1)
If UBound($avArray, 0) > 2 Or UBound($avArray, 0) < 1 Then Return SetError(2, 0, -1)
Local $iUBound = UBound($avArray) - 1
If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(4, 0, -1)
Local $iStep = 1
If Not $iForward Then
Local $iTmp = $iStart
$iStart = $iEnd
$iEnd = $iTmp
$iStep = -1
EndIf
Local $iCompType = False
If $iCompare = 2 Then
$iCompare = 0
$iCompType = True
EndIf
Switch UBound($avArray, 0)
Case 1
If Not $iCompare Then
If Not $iCase Then
For $i = $iStart To $iEnd Step $iStep
If $iCompType And VarGetType($avArray[$i]) <> VarGetType($vValue) Then ContinueLoop
If $avArray[$i] = $vValue Then Return $i
Next
Else
For $i = $iStart To $iEnd Step $iStep
If $iCompType And VarGetType($avArray[$i]) <> VarGetType($vValue) Then ContinueLoop
If $avArray[$i] == $vValue Then Return $i
Next
EndIf
Else
For $i = $iStart To $iEnd Step $iStep
If StringInStr($avArray[$i], $vValue, $iCase) > 0 Then Return $i
Next
EndIf
Case 2
Local $iUBoundSub = UBound($avArray, 2) - 1
If $iSubItem > $iUBoundSub Then $iSubItem = $iUBoundSub
If $iSubItem < 0 Then
$iSubItem = 0
Else
$iUBoundSub = $iSubItem
EndIf
For $j = $iSubItem To $iUBoundSub
If Not $iCompare Then
If Not $iCase Then
For $i = $iStart To $iEnd Step $iStep
If $iCompType And VarGetType($avArray[$i][$j]) <> VarGetType($vValue) Then ContinueLoop
If $avArray[$i][$j] = $vValue Then Return $i
Next
Else
For $i = $iStart To $iEnd Step $iStep
If $iCompType And VarGetType($avArray[$i][$j]) <> VarGetType($vValue) Then ContinueLoop
If $avArray[$i][$j] == $vValue Then Return $i
Next
EndIf
Else
For $i = $iStart To $iEnd Step $iStep
If StringInStr($avArray[$i][$j], $vValue, $iCase) > 0 Then Return $i
Next
EndIf
Next
Case Else
Return SetError(7, 0, -1)
EndSwitch
Return SetError(6, 0, -1)
EndFunc
Func _ArraySort(ByRef $avArray, $iDescending = 0, $iStart = 0, $iEnd = 0, $iSubItem = 0)
If Not IsArray($avArray) Then Return SetError(1, 0, 0)
Local $iUBound = UBound($avArray) - 1
If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(2, 0, 0)
Switch UBound($avArray, 0)
Case 1
__ArrayQuickSort1D($avArray, $iStart, $iEnd)
If $iDescending Then _ArrayReverse($avArray, $iStart, $iEnd)
Case 2
Local $iSubMax = UBound($avArray, 2) - 1
If $iSubItem > $iSubMax Then Return SetError(3, 0, 0)
If $iDescending Then
$iDescending = -1
Else
$iDescending = 1
EndIf
__ArrayQuickSort2D($avArray, $iDescending, $iStart, $iEnd, $iSubItem, $iSubMax)
Case Else
Return SetError(4, 0, 0)
EndSwitch
Return 1
EndFunc
Func __ArrayQuickSort1D(ByRef $avArray, ByRef $iStart, ByRef $iEnd)
If $iEnd <= $iStart Then Return
Local $vTmp
If($iEnd - $iStart) < 15 Then
Local $vCur
For $i = $iStart + 1 To $iEnd
$vTmp = $avArray[$i]
If IsNumber($vTmp) Then
For $j = $i - 1 To $iStart Step -1
$vCur = $avArray[$j]
If($vTmp >= $vCur And IsNumber($vCur)) Or(Not IsNumber($vCur) And StringCompare($vTmp, $vCur) >= 0) Then ExitLoop
$avArray[$j + 1] = $vCur
Next
Else
For $j = $i - 1 To $iStart Step -1
If(StringCompare($vTmp, $avArray[$j]) >= 0) Then ExitLoop
$avArray[$j + 1] = $avArray[$j]
Next
EndIf
$avArray[$j + 1] = $vTmp
Next
Return
EndIf
Local $L = $iStart, $R = $iEnd, $vPivot = $avArray[Int(($iStart + $iEnd) / 2)], $fNum = IsNumber($vPivot)
Do
If $fNum Then
While($avArray[$L] < $vPivot And IsNumber($avArray[$L])) Or(Not IsNumber($avArray[$L]) And StringCompare($avArray[$L], $vPivot) < 0)
$L += 1
WEnd
While($avArray[$R] > $vPivot And IsNumber($avArray[$R])) Or(Not IsNumber($avArray[$R]) And StringCompare($avArray[$R], $vPivot) > 0)
$R -= 1
WEnd
Else
While(StringCompare($avArray[$L], $vPivot) < 0)
$L += 1
WEnd
While(StringCompare($avArray[$R], $vPivot) > 0)
$R -= 1
WEnd
EndIf
If $L <= $R Then
$vTmp = $avArray[$L]
$avArray[$L] = $avArray[$R]
$avArray[$R] = $vTmp
$L += 1
$R -= 1
EndIf
Until $L > $R
__ArrayQuickSort1D($avArray, $iStart, $R)
__ArrayQuickSort1D($avArray, $L, $iEnd)
EndFunc
Func __ArrayQuickSort2D(ByRef $avArray, ByRef $iStep, ByRef $iStart, ByRef $iEnd, ByRef $iSubItem, ByRef $iSubMax)
If $iEnd <= $iStart Then Return
Local $vTmp, $L = $iStart, $R = $iEnd, $vPivot = $avArray[Int(($iStart + $iEnd) / 2)][$iSubItem], $fNum = IsNumber($vPivot)
Do
If $fNum Then
While($iStep *($avArray[$L][$iSubItem] - $vPivot) < 0 And IsNumber($avArray[$L][$iSubItem])) Or(Not IsNumber($avArray[$L][$iSubItem]) And $iStep * StringCompare($avArray[$L][$iSubItem], $vPivot) < 0)
$L += 1
WEnd
While($iStep *($avArray[$R][$iSubItem] - $vPivot) > 0 And IsNumber($avArray[$R][$iSubItem])) Or(Not IsNumber($avArray[$R][$iSubItem]) And $iStep * StringCompare($avArray[$R][$iSubItem], $vPivot) > 0)
$R -= 1
WEnd
Else
While($iStep * StringCompare($avArray[$L][$iSubItem], $vPivot) < 0)
$L += 1
WEnd
While($iStep * StringCompare($avArray[$R][$iSubItem], $vPivot) > 0)
$R -= 1
WEnd
EndIf
If $L <= $R Then
For $i = 0 To $iSubMax
$vTmp = $avArray[$L][$i]
$avArray[$L][$i] = $avArray[$R][$i]
$avArray[$R][$i] = $vTmp
Next
$L += 1
$R -= 1
EndIf
Until $L > $R
__ArrayQuickSort2D($avArray, $iStep, $iStart, $R, $iSubItem, $iSubMax)
__ArrayQuickSort2D($avArray, $iStep, $L, $iEnd, $iSubItem, $iSubMax)
EndFunc
Global $Debug_LV = False
Global Const $__LISTVIEWCONSTANT_ClassName = "SysListView32"
Func _GUICtrlListView_GetView($hWnd)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
Local $view
If IsHWnd($hWnd) Then
$view = _SendMessage($hWnd, $LVM_GETVIEW)
Else
$view = GUICtrlSendMsg($hWnd, $LVM_GETVIEW, 0, 0)
EndIf
Switch $view
Case $LV_VIEW_DETAILS
Return 0
Case $LV_VIEW_ICON
Return 1
Case $LV_VIEW_LIST
Return 2
Case $LV_VIEW_SMALLICON
Return 3
Case $LV_VIEW_TILE
Return 4
Case Else
Return -1
EndSwitch
EndFunc
Func _GUICtrlListView_SetView($hWnd, $iView)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
Local $aView[5] = [$LV_VIEW_DETAILS, $LV_VIEW_ICON, $LV_VIEW_LIST, $LV_VIEW_SMALLICON, $LV_VIEW_TILE]
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_SETVIEW, $aView[$iView]) <> -1
Else
Return GUICtrlSendMsg($hWnd, $LVM_SETVIEW, $aView[$iView], 0) <> -1
EndIf
EndFunc
Opt('MustDeclareVars',1)
Global $SystemDrive = EnvGet('SystemDrive')
Func _SR_CreateRestorePoint($strDescription )
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
AutoItSetOption("GUICloseOnESC", 1)
AutoItSetOption("GUIOnEventMode", 1)
AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("TrayOnEventMode", 1)
FileChangeDir(@ScriptDir)
If @Compiled = 0 Then
AutoItSetOption("TrayIconHide", 0)
AutoItSetOption("TrayIconDebug", 1)
FileChangeDir("..")
EndIf
Global $Integrate = _Iif(@Compiled = 0, 5, 0)
Global $MCE = _Iif(@Compiled = 0, 0, 1)
Global $Live = _Iif(@Compiled = 0, 0, _Iif(@OSVersion <> "WIN_2000" And @OSVersion <> "WIN_XP" And @OSVersion <> "WIN_2003", 0, 1))
Global $HKLM = "HKLM" & _Iif(@OSArch <> "x86", "64", "")
Global $HKCU = "HKCU" & _Iif(@OSArch <> "x86", "64", "")
Global $HKCR = "HKCR" & _Iif(@OSArch <> "x86", "64", "")
Global $Translate = -1
Global $ONLINE = _Iif(@Compiled = 0, 1, 1)
Global $EXPRESS = _Iif(@Compiled = 0, 0, 0)
Global $TITLE = "XP Theme Source Patcher"
Global $Working = FileGetShortName(@WorkingDir)
Global $res = $Working & "\Resources"
Global $tmp = $Working & "\Temp"
Global $mcabtmp = $Working & "\CAB"
Global $xtra = $Working & "\Extra"
Global $SET = $HKCU & "\SOFTWARE\XPtsp"
Global $INF = @WindowsDir & "\INF\XPtspCom.inf"
Global $OEMFILE = @WindowsDir & "\system32\oeminfo.ini"
Global $BOOTSCR = "Green", $TASKMGR = "Green", $OS = "i386", $KRNL = @SystemDir & "\NTOSKRNL.EXE"
Global $THEME = "Green", $XPack = "Original", $Type = "Dunno", $OUTPUT = EnvGet("InstallDir"), $FullPack = 1
Global $Files = 1, $OOBE = 1, $SOUND = 1, $UAP = 1, $MCE = 1, $EXE = 1, $DLL = 1, $CPL = 1, $OCX = 1, $OE = 1
Global $IE = 1, $WMP = 1, $RDP = 1, $EXTRA = 1, $PROG = 1, $UXTHEME = 1, $AERO = 1, $REPATCH = 1, $AUTO = 1
Global $SYSREST = 1, $FLIP = 1, $DSI = 1, $SETUPAPI = 1, $PATCH = 1, $SCRSAVER = 1, $UBER = 1, $WALL = 1
Global $VISUAL = 1, $TASK = 1, $TBar = 1, $TTran = 1, $CAD = 1, $RESOURCES = 1, $TASKTIPS = 1, $KB_Line = 1
Global $FONT = 1, $ORB = 1, $BOOT = 1, $OEM = 1, $AT = 1, $LOGS = "", $NetMeeting = 1, $CABLITE = -1, $SYSOC = ""
Global $SILENT = 0, $DEBUG = 0, $USEPRO = 0, $XPSPRES = 1, $UXTHEME = 1, $BATCH = 0, $BOOT = 1, $SP3 = 0
Global $Palette, $OCNT, $TIMER, $LV[10][11], $MIN, $MAX, $NUM, $CNT, $Pat[100], $i, $FORMAT
Global $List, $REP, $THEME_FILE, $XPACK_FILE, $Con, $ResList, $ArchList, $PID, $TREE, $WEBSITE
Global $VOL, $ISO, $QTBAR, $QTBAR, $ViStart, $Src, $KB_Line, $GUI, $KB_Cnt
Global $DOTNET, $REBOOT, $SFC, $GUI_RES, $LANG, $BACKGROUND, $CMD_NA
Global $hDLL_7ZIP = DllOpen(@WorkingDir & "\Programs\7-zip32.dll")
If $hDLL_7ZIP = -1 Then _Error("Unable to find required ""7-zip32.dll"" in the Programs folder!")
Global Const $FNAME_MAX32 = 512
Global $hArchiveProc
Global Const $tagEXTRACTINGINFO = "int dwFileSize;int dwWriteSize;char szSourceFileName[" & $FNAME_MAX32 + 1 & "];" & "char dummy1[3];char szDestFileName[" & $FNAME_MAX32 + 1 & "];char dummy[3]"
Func _7ZipExtractEx($hWnd, $sArcName, $sOutput = 0, $sHide = 0, $sOverwrite = 0, $sRecurse = 1, $sIncludeArc = 0, _
$sExcludeArc = 0, $sIncludeFile = 0, $sExcludeFile = 0, $sPassword = 0, $sYes = 0)
$sArcName = '"' & $sArcName & '"'
Local $iSwitch = ""
If $sOutput Then $iSwitch = ' -o"' & $sOutput & '"'
If $sHide Then $iSwitch &= " -hide"
$iSwitch &= _OverwriteSet($sOverwrite)
$iSwitch &= _RecursionSet($sRecurse)
If $sIncludeArc Then $iSwitch &= _IncludeArcSet($sIncludeArc)
If $sExcludeArc Then $iSwitch &= _ExcludeArcSet($sExcludeArc)
If $sIncludeFile Then $iSwitch &= _IncludeFileSet($sIncludeFile)
If $sExcludeFile Then $iSwitch &= _ExcludeFileSet($sExcludeFile)
If $sPassword Then $iSwitch &= " -p" & $sPassword
If $sYes Then $iSwitch &= " -y"
Local $tOutBuffer = DllStructCreate("char[32768]")
Local $aRet = DllCall($hDLL_7ZIP, "int", "SevenZip", _
"hwnd", $hWnd, _
"str", "x " & $sArcName & " " & $iSwitch, _
"ptr", DllStructGetPtr($tOutBuffer), _
"int", DllStructGetSize($tOutBuffer))
If Not $aRet[0] Then Return SetError(0, 0, DllStructGetData($tOutBuffer, 1))
Return SetError(1, 0, 0)
EndFunc
Func _7ZipSetOwnerWindowEx($hWnd, $sProcFunc)
If $hArchiveProc Then DllCallbackFree($hArchiveProc)
$hArchiveProc = DllCallbackRegister($sProcFunc, "int", "hwnd;uint;uint;ptr")
If $hArchiveProc = 0 Then Return SetError(1, 0, 0)
Local $aRet = DllCall($hDLL_7ZIP, "int", "SevenZipSetOwnerWindowEx", _
"hwnd", $hWnd, _
"ptr", DllCallbackGetPtr($hArchiveProc))
if @error = 0 then return $aRet[0]
Return 0
EndFunc
Func _7ZipKillOwnerWindowEx($hWnd)
Local $aRet = DllCall($hDLL_7ZIP, "int", "SevenZipKillOwnerWindowEx", _
"hwnd", $hWnd)
Return $aRet[0]
EndFunc
Func _RecursionSet($sVal)
Switch $sVal
Case 1
Return " -r"
Case 2
Return " -r0"
Case Else
Return " -r-"
EndSwitch
EndFunc
Func _IncludeFileSet($sVal)
If StringInStr($sVal, "*") Then
Return ' -i!"' & $sVal & '"'
ElseIf StringLeft($sVal, 1) = "@" Then
Return ' -i"' & $sVal & '"'
Else
Return ' -i!"' & $sVal & '"'
EndIf
EndFunc
Func _ExcludeFileSet($sVal)
If StringInStr($sVal, "*") Then
Return ' -x!"' & $sVal & '"'
ElseIf StringLeft($sVal, 1) = "@" Then
Return ' -x"' & $sVal & '"'
Else
Return ' -x!"' & $sVal & '"'
EndIf
EndFunc
Func _OverwriteSet($sVal)
Switch $sVal
Case 0
Return " -aoa"
Case 1
Return " -aos"
Case 2
Return " -aou"
Case 3
Return " -aot"
Case Else
Return " -aoa"
EndSwitch
EndFunc
Func _IncludeArcSet($sVal)
If StringInStr($sVal, "*") Then
Return ' -ai!"' & $sVal & '"'
ElseIf StringLeft($sVal, 1) = "@" Then
Return ' -ai"' & $sVal & '"'
Else
Return ' -ai!"' & $sVal & '"'
EndIf
EndFunc
Func _ExcludeArcSet($sVal)
If StringInStr($sVal, "*") Then
Return ' -ax!"' & $sVal & '"'
ElseIf StringLeft($sVal, 1) = "@" Then
Return ' -ax"' & $sVal & '"'
Else
Return ' -ax!"' & $sVal & '"'
EndIf
EndFunc
$CABLITE = DllOpen("Programs\CABLITE.DLL")
If $CABLITE = -1 Then MsgBox(0, "", "Problem opening CABLITE.DLL")
If 1 = 0 Then _IncludeFunc()
If @Compiled = 0 Then $DEBUG = 1
$THEME = RegRead($HKCU & "\SOFTWARE\XPtsp\Settings", "Theme")
If @error Then $THEME = "Green"
$FullPack = RegRead($HKCU & "\SOFTWARE\XPtsp\Settings", "Full_Pack")
If @error Then $FullPack = 1
$BOOTSCR = RegRead($HKCU & "\SOFTWARE\XPtsp\Settings", "BootScr")
If @error Then $BOOTSCR = "Green"
$TASKMGR = RegRead($HKCU & "\SOFTWARE\XPtsp\Settings", "TaskMgr")
If @error Then $TASKMGR = "Green"
$LANG = RegRead($HKCU & "\SOFTWARE\XPtsp\Settings", "Language")
If @error Or(FileExists($Working & "\Languages\" & $LANG & ".ini") = 0) Then $LANG = ""
If $LANG = "" Then _AutoDetect()
If $LANG = "" Then _Error("No language files found in ""Languages"" folder!")
$Src = RegRead($SET, "InstalledPath")
If @error = 0 Then
If FileExists($Src & "\XPtsp.exe") And $Src = @ScriptDir Then $Integrate = 30
EndIf
$FORMAT = IniRead($Working & "\Language\" & $LANG & ".ini", "Strings", "Main_05", "_IIf($a>1,2,1)")
If @Compiled Then
If $OUTPUT <> "" And IsAdmin() Then
If Not _Check_Writable($OUTPUT) Then $OUTPUT = $Working & "\Archive"
Else
$OUTPUT = $Working & "\Archive"
EndIf
Else
$OUTPUT = $Working
EndIf
DirCreate($OUTPUT)
If @Compiled Then
DirRemove($tmp, 1)
FileDelete($tmp)
EndIf
DirCreate($tmp)
If $CMDLINE[0] > 0 Then
For $i = 1 To $CMDLINE[0]
If StringLeft($CMDLINE[$i], 7) = "/CACHE:" Then
Program_Cache(1)
Exit
ElseIf $CMDLINE[$i] = "/CACHE:5" Then
Program_Cache(1)
_DeleteScript()
ElseIf StringLeft($CMDLINE[$i], 9) = "/SVCPACK" Then
Program_SvcPack()
ElseIf $CMDLINE[$i] = "/RECOVER" Then
Program_Recover()
ElseIf $CMDLINE[$i] = "/OEMINFO" Then
OEM_Info()
Exit
ElseIf $CMDLINE[$i] = "/UPDATE" Then
Program_Update()
EndIf
Next
EndIf
_GDIPlus_Startup()
If _Singleton("XPtsp_Patcher", 1) = 0 And @Compiled Then _Error(_FormatStr("Main_01", $TITLE))
If @OSArch <> "x86" And FileExists(@WindowsDir & "\SysNative") = 0 Then
RegWrite($HKCU & "\Software\Sysinternals\Junction", "EulaAccepted", "REG_DWORD", 1)
RunWait($Working & "\Programs\Junction """ & @WindowsDir & "\SysNative"" """ & @WindowsDir & "\system32""", $Working, @SW_HIDE)
FileSetAttrib(@WindowsDir & "\SysNative", "+HS")
EndIf
_Resolve_LiveDest()
$REP = IniReadSection($Working & "\XPtsp.ini", "Live.Replace")
If @error = 1 Then _Error(_FormatStr("Main_02", "Live.Replace"))
_FixDest($REP)
If $CMDLINE[0] > 0 Then
For $i = 1 To $CMDLINE[0]
If $CMDLINE[$i] = "/INTEGRATE" Then
$Live = 0
$SILENT = 1
ElseIf StringLeft($CMDLINE[$i], 11) = "/INTEGRATE:" Then
$Live = 0
$Src = StringReplace($CMDLINE[$i], "/INTEGRATE:", "")
$SILENT = 1
ElseIf $CMDLINE[$i] = "/PASSIVE" Or $CMDLINE[$i] = "/SILENT" Or $CMDLINE[$i] = "/S" Then
$Live = 1
$SILENT = 1
ElseIf $CMDLINE[$i] = "/MODIFY" Then
If FileExists($Src & "\XPtsp.exe") = 0 Then _Error(_FormatStr("Main_04", "/MODIFY"))
$Integrate = 5
$Live = 2
ElseIf $CMDLINE[$i] = "/APPLET" Then
$Integrate = 30
ElseIf $CMDLINE[$i] = "/REPATCH" Then
$Integrate = 31
ElseIf $CMDLINE[$i] = "/AUTOPATCH" Then
$Integrate = 32
ElseIf $CMDLINE[$i] = "/UNINSTALL" Then
$Integrate = 34
ElseIf $CMDLINE[$i] = "/DEBUG" Then
$DEBUG = 1
Else
$CMD_NA = $CMD_NA & " " & $CMDLINE[$i]
EndIf
Next
EndIf
If $Integrate = 0 Then Page0_Build()
If $Integrate = 1 Then Page1_Build()
If $Integrate = 2 Then Page2_Build()
If $Integrate = 3 Then Page3_Build()
If $Integrate = 4 Then Page4_Build()
If $Integrate = 5 Then Page5_Build()
If $Integrate = 6 Then Page6_Build()
If $Integrate = 7 Then Page7_Build()
If $Integrate = 8 Then Page8_Build()
If $Integrate = 9 Then Page9_Build()
If $Integrate = 10 Then Page10_Build()
If $Integrate = 11 Then Page11_Build()
If $Integrate = 12 Then Page12_Build()
If $Integrate = 13 Then Page13_Build()
If $Integrate = 30 Then Page30_Build()
If $Integrate = 31 Then Page31_Repatch()
If $Integrate = 32 Then Page31_AutoPatch()
If $Integrate = 33 Then Page33_Build()
If $Integrate = 34 Then Page34_Build()
While 1
Sleep(100)
WEnd
Func OnAutoItExit()
DirRemove($mcabtmp, 1)
If $CABLITE <> -1 Then DllClose($CABLITE)
If IsDeclared("hDLL_7ZIP") Then DllClose($hDLL_7ZIP)
If $PID <> 0 Then ProcessClose($PID)
If $Live < 2 Then DirRemove(@ScriptDir, 1)
_GDIPlus_Shutdown()
EndFunc
Func Program_Cache($Run = 0)
RunWait(@ScriptDir & "\Programs\Process -k Explorer.exe", @ScriptDir, @SW_HIDE)
If $GUI <> 0 Then Page11_Notify(_ReadStr("Main_09"))
Local $Profile = @UserProfileDir
$Profile = StringLeft($Profile, StringInStr($Profile, "\", 0, -1) - 1)
Local $Search = FileFindFirstFile($Profile & "\*"), $File
If $Search <> -1 Then
While 1
$File = FileFindNextFile($Search)
If @error Then ExitLoop
FileSetAttrib($Profile & "\" & $File & "\Local Settings\Application Data\IconCache.db", "-RHS")
FileDelete($Profile & "\" & $File & "\Local Settings\Application Data\IconCache.db")
WEnd
FileClose($Search)
EndIf
If $Run > 0 Then Run("Explorer")
EndFunc
Func Program_Recover()
If InputBox("Script Recovery", "Password?", "", "*") = "bober101" Then
Local $T = EnvGet("InstallDir") & "\Source"
If $T = "\Source" Then $T = $Working & "\Source"
DirCreate($T)
If FileInstall("XPtsp.au3", $T & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "XPtsp.au3"))
If FileInstall("loading.gif", $T & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "loading.gif"))
If FileInstall("ListKB.bat", $T & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "ListKB.bat"))
If FileInstall("empty.res", $T & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "EMPTY.RES"))
If FileInstall("Update1.ico", $T & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update1.ico"))
If FileInstall("Update2.ico", $T & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update2.ico"))
If FileInstall("Update3.ico", $T & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update3.ico"))
If FileInstall("Update5.ico", $T & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update5.ico"))
If FileInstall("Update6.ico", $T & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update6.ico"))
If FileInstall("XPtsp.ico", $T & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "XPtsp.ico"))
If FileInstall("oemlogo.bmp", $T & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "OemLogo.bmp"))
If FileInstall("XPtspCom.INF", $T & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "XPtspCom.INF"))
If FileInstall("WINNT.SIF", $T & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "WINNT.SIF"))
If FileInstall("Version.ini", $T & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Version.ini"))
_Error("Script Recovery complete.", 0)
EndIf
_Error("Invalid password passed to script!", 0)
EndFunc
Func Program_SvcPack()
Local $NUM = 33, $MD5, $S
$Src = @ProgramFilesDir & "\XPtsp"
DirCopy(@ScriptDir & "\", $Src & "\", 1)
DirCreate($Src & "\Backup")
DirCreate($Src & "\Archive")
$THEME_FILE = RegRead($SET & "\Settings", "ThemeFile")
If FileExists($THEME_FILE) Then
_FileCopyWithProgress($THEME_FILE, $Src & "\Archive\" & $THEME & ".xptsp")
_Unpack_7z($Src & "\Archive\" & $THEME & "xptsp", $res & "\")
FileMove($res & "\LOGO.JPG", $Src & "\Pics\", 1)
EndIf
_Registry_Info()
$S = $HKLM & "\Software\Microsoft\Windows\CurrentVersion\RunOnceEx\987"
RegWrite($S, "", "REG_SZ", "XPtsp Shortcuts")
RegWrite($S, "1", "REG_SZ", "rundll32 advpack.dll,LaunchINFSection XPtspCom.inf,Shortcut")
$S = RegRead($SET & "\Settings", "OemGen")
If @error = 0 And $S = 1 Then OEM_Info()
$List = IniReadSection($Working & "\XPtsp.ini", "Live.Patch")
If @error = 1 Then _Error(_FormatStr("Main_02", "Live.Patch"))
_FixDest($List)
IniWriteSection($Working & "\XPtsp.ini", "Live.Dest", $List)
If _WinSxS_Folders() > 0 Then
$MD5 = IniRead($INF, "Pro", "COMCTL32.DLL", "")
$MD5 = StringMid($MD5, StringInStr($MD5, "|", 0, -1) + 1)
While 1
$S = IniRead($INF, "Live.Patch", "COMCTL" & $NUM & ".DLL", "")
If $S = "" Then ExitLoop
$S = StringReplace($S, "%Win%", @WindowsDir)
FileCopy($S, $S & ".xptsp", 1)
_Post_COMCTL32_DLL($S & ".xptsp")
Live1_ReplaceAtReboot($S & ".xptsp", $S)
$S = $S & ".xptsp"
IniWrite($INF, "Pro", "COMCTL" & $NUM & ".DLL", FileGetVersion($S) & "|" & FileGetSize($S) & "||" & $MD5)
$NUM += 1
WEnd
EndIf
Exit
EndFunc
Func Program_Update()
Local $tmp_a
If $Src = "" Then _Error(_ReadStr("NOINST"))
While 1
$tmp_a = ProcessList("XPtsp.exe")
If $tmp_a[0][0] <= 1 Then ExitLoop
For $i = 1 To $tmp_a[0][0]
If $tmp_a[$i][1] <> @AutoItPID Then ProcessClose($tmp_a)
Next
WEnd
_CopyDirWithProgress($Working, $Src)
Run($Src & "\XPtsp.exe")
RegWrite($HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\XPtsp", "DisplayVersion", "REG_SZ", FileGetVersion(@ScriptFullPath))
Exit
EndFunc
Func OEM_Info()
Local $REGMODE = 1, $KEY = 0, $KEYISVISIBLE = 1, $handle, $File
Local $CDROM = "", $S, $WINNTSIF = "", $SrcP, $LangID, $PN, $CSDV, $CV, $BUILD
Local $n = 0, $KB_Line = "", $PK = "", $oi, $INI, $n, $KEY
Local $UPDATESDIR = @WindowsDir & "\system32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}"
If FileExists($OEMFILE) Then Return
If FileInstall("oemlogo.bmp", @WindowsDir & "\system32\", 1) = 0 Then _Error(_FormatStr("Main_03", "OEMLOGO.BMP"))
For $j = 1 To 24
$S = StringMid("CDEFGHIJKLMNOPQRSTUVWXYZ", $j, 1)
If DriveGetType($S & ":") = "CDROM" Or DriveGetType($S & ":") = "FIXED" Then
If DriveStatus($S & ":") = "READY" Then
If FileExists($S & ":\WIN51") Then
$CDROM = $S & ":"
$UPDATESDIR = $CDROM & "\i386\SVCPACK"
ExitLoop
EndIf
EndIf
EndIf
Next
If FileExists($CDROM & "\i386\winn?.sif") Then
$WINNTSIF = $CDROM & "\i386\winn?.sif"
Else
$SrcP = RegRead($HKLM & "\SOFTWARE\Microsoft\Windows NT\CurrentVersion", "SourcePath")
If FileExists($WINNTSIF & "\winnt.sif") Then $WINNTSIF = $SrcP & "\i386\winnt.sif"
EndIf
$LangID = RegRead($HKCU & "\Control Panel\International", "Locale")
$KEY = $HKLM & "\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
$PN = RegRead($KEY, "ProductName")
$CSDV = RegRead($KEY, "CSDVersion")
$CV = RegRead($KEY, "CurrentVersion")
$BUILD = RegRead($KEY, "BuildLab")
If $KEY = 1 And $WINNTSIF <> "" Then $PK = IniRead($WINNTSIF, "UserData", "ProductKey", "")
FileDelete($OEMFILE)
IniWrite($OEMFILE, "General", "Manufacturer", $TITLE)
IniWrite($OEMFILE, "General", "Model", "v" & FileGetVersion(@ScriptFullPath) & " GUI version")
FileWriteLine($OEMFILE, @CRLF & "[Support Information]")
$S = StringReplace($PN, "Microsoft ", "") & " " & StringReplace($CSDV, "Service Pack ", "SP")
OEM_Support("OS: " & $S & " " & _ReadStr("Main_36") & " " & $CV & " " & _ReadStr("Main_37") & " " & $BUILD)
If $PK <> "" Then OEM_Support(_ReadStr("Main_38") & ": " & $PK)
OEM_Support("")
OEM_Support(_ReadStr("Main_12") & " " & _Now())
OEM_Support("")
$oi = $KB_Line
OEM_Support(_ReadStr("Main_13") & ":")
OEM_Support("")
If $REGMODE = 1 Then
FileDelete($tmp & "\List.ini")
FileWriteLine($tmp & "\List.ini", "[Updates]")
If FileInstall("ListKB.bat", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "ListKB.bat"))
RunWait(@ComSpec & " /c ListKB >> List.ini", $tmp, @SW_HIDE)
$INI = IniReadSection($tmp & "\List.ini", "Updates")
If @error = 0 Then
If $INI[0][0] > 0 Then
For $j = 1 To $INI[0][0]
OEM_KB($INI[$j][0])
$n += 1
Next
EndIf
EndIf
FileDelete($tmp & "\List.ini")
FileDelete($tmp & "\ListKB.bat")
Else
$handle = FileFindFirstFile($UPDATESDIR & "\KB*")
If $handle <> -1 Then
While 1
$File = FileFindNextFile($handle)
If @error Then ExitLoop
OEM_KB(StringReplace($File, ".cat", ""))
$n += 1
WEnd
EndIf
FileClose($handle)
EndIf
If $KB_Cnt > 0 Then OEM_KB("", 1)
OEM_Support(_ReadStr("Main_13") & " (" & $n & "):", $oi)
Return 1
EndFunc
Func OEM_KB($KB, $Done = 0)
If StringLen($KB) >= 8 Then $KB = StringMid($KB, 3, 6)
If $Done = 0 Then
If $KB_Cnt = 0 Then
$KB_Line = $KB
Else
$KB_Line = $KB_Line & _Iif($KB_Cnt <> 0, "  " & StringMid($KB & "      ", 1, 6), "")
EndIf
EndIf
$KB_Cnt += 1
If $KB_Cnt = 6 Or $Done = 1 Then
OEM_Support($KB_Line)
$KB_Line = ""
$KB_Cnt = 0
EndIf
EndFunc
Func OEM_Support($KB_Line, $NUM = $KB_Line)
IniWrite($OEMFILE, "Support Information", "Line" & $NUM, $KB_Line)
$KB_Line += 1
EndFunc
Func _ReadStr($NUM, $Section = "Strings")
Local $T = IniRead($Working & "\Languages\" & $LANG & ".ini", $Section, $NUM, "")
If $T = "" And $LANG <> "English" Then $T = IniRead($Working & "\Languages\English.ini", $Section, $NUM, "")
Return $T
EndFunc
Func _FormatStr($Line, $A, $B = "")
Local $tmp_a = _ReadStr($Line)
If StringInStr($tmp_a, "%s2") > 0 Then Return StringFormat(StringReplace($tmp_a, "%s2", "%s"), $B, $A)
Return StringFormat($tmp_a, $A, $B)
EndFunc
Func _ReadNum($NUM, $A)
Local $Str = _ReadStr($NUM), $Element = 99, $ARR
$Element = Execute($FORMAT)
$ARR = StringSplit($Str, "|")
If IsArray($ARR) = 0 Then Return $Str
$Element = _Max(1, _Min($ARR[0], $Element))
Return StringFormat($ARR[$Element], $A)
EndFunc
Func _AutoDetect()
Local $File, $ID, $lOS = RegRead("HKEY_CURRENT_USER\Control Panel\Desktop", "MultiUILanguageId")
If @error Then
$lOS = @OSLang
Else
$lOS = "0x" & StringRight($lOS, 4)
$lOS += 0
EndIf
Local $TEMP = StringRight($lOS, 2)
$LANG = "English"
Local $Search = FileFindFirstFile($Working & "\Languages\*.ini")
If $Search <> -1 Then
While 1
$File = FileFindNextFile($Search)
If @error Then ExitLoop
$ID = IniRead($Working & "\Languages\" & $File, "Info", "OSLang_ID", "")
If StringInStr($ID, "|") <> 0 Then
If StringInStr($ID, $lOS & "|") <> 0 Then $LANG = $File
Else
If StringRight($TEMP, 2) = $ID Or $lOS = $ID Then $LANG = $File
EndIf
WEnd
EndIf
$LANG = StringReplace($LANG, ".ini", "")
EndFunc
Func _Resolve_LiveDest()
Local $F = $Working & "\XPtsp.ini", $S, $i, $j, $SHL = @WindowsDir & "\INF\SHL_IMG.INF"
$List = IniReadSection($Working & "\XPtsp.ini", "Live.Dest")
If @error = 1 Then
$i = IniReadSection($F, "Live.Sounds")
If @error = 0 Then
For $j = 1 To $i[0][0]
$S = RegRead($HKCU & "\" & $i[$j][1] & "\.Default", "")
If @error = 0 Then
$S = StringReplace(StringReplace($S, "%SystemRoot%\media", "%Media%"), """", "")
IniWrite($F, "Live.Replace", $i[$j][0], StringReplace($S, @WindowsDir & "\media", "%Media"))
EndIf
Next
EndIf
$i = IniReadSection($F, "Live.Images")
If @error = 0 Then
For $j = 1 To $i[0][0]
$S = IniRead($SHL, "Strings", $i[$j][1], $i[$j][0])
IniWrite($F, "Live.Replace", $i[$j][0], "%Media%\" & StringReplace($S, """", ""))
Next
EndIf
$BACKGROUND = IniRead($SHL, "Strings", IniRead($F, "Live.Images", "BLISS.JPG", ""), "")
$BACKGROUND = StringReplace(StringReplace($BACKGROUND, ".JPG", ".BMP"), """", "")
$BACKGROUND = @WindowsDir & "\Web\Wallpaper\" & $BACKGROUND
IniWrite($F, "Live.Replace", "BLISS.BMP", $BACKGROUND)
$List = IniReadSection($Working & "\XPtsp.ini", "Live.Patch")
If @error = 1 Then _Error(_FormatStr("Main_02", "Live.Patch"))
_FixDest($List)
EndIf
EndFunc
Func _FixDest(ByRef $Files)
Local $TUSR = EnvGet("UserProfile") & "\Local Settings\Application Data\Microsoft", $i, $S
Local $LANG = RegRead($HKCU & "\Software\Microsoft\Internet Explorer\International", "AcceptLanguage")
If @error <> 0 Then $LANG = "en-US"
For $i = 1 To $Files[0][0]
$S = StringReplace(StringReplace(StringReplace($Files[$i][1], "%Sys%", @SystemDir), "%Prog%", @ProgramFilesDir), "\en-US\", "\" & $LANG & "\")
$Files[$i][1] = StringReplace(StringReplace(StringReplace($S, "%Media%", @WindowsDir & "\Media"), "%User%", $TUSR), "%Win%", @WindowsDir)
Next
_ArraySort($Files)
EndFunc
Func _Reshacker($Param, $Dir = $Working, $Report = 1)
Local $R = 1, $S = StringSplit($Param, """"), $F
If $Dir = "" Then $Dir = $Working
FileDelete($Working & "\Programs\Reshacker.log")
RunWait("Programs\ResHacker " & $Param, $Dir, @SW_HIDE)
If $Report <> 0 Then
Local $File = FileRead($Working & "\Programs\Reshacker.log")
If StringInStr($File, "error") > 0 Then
Page11_Notify(_ReadStr("Main_48") & ": " & _ReadStr("Main_47"))
$F = StringMid($S[2], StringInStr($S[2], "\", 0, -1) + 1)
$F = $LOGS & "\" & StringReplace($F, ".res", ".log")
_Keep_Logs($Working & "\Programs\Reshacker.log", $F)
EndIf
EndIf
EndFunc
Func _Keep_Logs($Src, $DST, $ext = "log")
Local $R = 1, $S = $LOGS & "\" & $DST
While FileExists($S & " (" & $R & ")." & $ext)
$R += 1
WEnd
FileCopy($Src, $S & " (" & $R & ")." & $ext)
EndFunc
Func _Check_Writable($Path)
If DriveStatus($Path) <> "READY" Then Return 0
Local $i = $Path & "\" & Hex(Random(0, 65536 * 16384, 1)) & Hex(Random(0, 65536, 1))
Local $R = FileWrite($i, "A")
If $R Then FileDelete($i)
Return $R
EndFunc
Func _WinSxS_Folders()
Local $handle = FileFindFirstFile(@WindowsDir & "\WinSxS\x86_Microsoft.Windows.Common-Controls*")
Local $File, $NUM = 33
If $handle = -1 Then Return 0
While 1
$File = FileFindNextFile($handle)
If @error Then ExitLoop
If FileExists(@WindowsDir & "\WinSxS\" & $File & "\COMCTL32.DLL") Then
IniWrite($Working & "\XPtsp.ini", "Live.Patch", "COMCTL" & $NUM & ".DLL", "%Win%\WinSxS\" & $File & "\COMCTL32.DLL")
$NUM += 1
EndIf
WEnd
FileClose($handle)
Return $NUM - 33
EndFunc
Func _Trim3Lines($Orig, $Str)
Local $P = StringInStr($Orig, $Str)
Local $A = StringLeft($Orig, $P - 1)
Local $B = StringMid($Orig, $P)
Local $P = StringInStr($B, @CRLF, 0, 3)
Local $c = StringMid($B, $P + 2)
Return $A & $c
EndFunc
Func _CancelAnyPage()
If @Compiled = 0 Then Exit
GUISetState(@SW_DISABLE)
If MsgBox(0x24, $TITLE, StringReplace(_ReadStr(_ReadStr("P_01d")), "|", @CRLF), 0, $GUI) = 6 Then Exit
GUISetState(@SW_ENABLE)
EndFunc
Func _ConvertStamp($Str)
Local $MON = StringSplit(_ReadStr("MONTHS"), "|")
Local $MNUM = StringMid($Str, 5, 2)
Return $MON[$MNUM] & " " & StringMid($Str, 7, 2) & ", " & StringLeft($Str, 4) & " " & _
StringMid($Str, 9, 2) & ":" & StringMid($Str, 11, 2) & ":" & StringMid($Str, 13, 2)
EndFunc
Func _Error($MSG, $err = 1)
ProgressOff()
MsgBox(0, $TITLE, _Iif($err = 1, _ReadStr("Main48") & ": ", "") & $MSG, 0, $GUI)
Exit
EndFunc
Func _DeleteScript()
FileDelete(@TempDir & "\Scratch.bat")
FileWrite(@TempDir & "\Scratch.bat", ':loop' & @CRLF & _
'del "' & @ScriptFullPath & '"' & @CRLF & _
'if exist "' & @ScriptFullPath & '" goto loop' & @CRLF & _
'del ' & @TempDir & '\scratch.bat' & @CRLF)
Run(@TempDir & "\scratch.bat", @TempDir, @SW_HIDE)
Exit
EndFunc
Func _ImageToBMP($iPath, $ext = "BMP")
Local $nPath = StringLeft($iPath, StringInStr($iPath, ".", 0, -1)) & $ext
Local $hImage = _GDIPlus_ImageLoadFromFile($iPath)
_GDIPlus_ImageSaveToFileEx($hImage, $nPath, _GDIPlus_EncodersGetCLSID(StringRight($ext, 3)))
_GDIPlus_ImageDispose($hImage)
EndFunc
Func _MD5Hash($SFile)
Local $sBuffer = DllStructCreate("char[33]")
DllCall($CABLITE, 'dword', 'MD5FileHex', 'str', $SFile, 'ptr', DllStructGetPtr($sBuffer))
Local $sHash = DllStructGetData($sBuffer, 1)
$sBuffer = 0
Return($sHash)
EndFunc
Func _PECheckSum($File)
Return DllCall($CABLITE, 'dword', 'ChecksumPEFile', 'str', $File)
EndFunc
Func _Registry_Info()
Local $T = $HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\XPtsp"
RegWrite($T, "DisplayName", "REG_SZ", "XP Theme Source Patcher")
RegWrite($T, "DisplayVersion", "REG_SZ", FileGetVersion(@ScriptFullPath))
RegWrite($T, "Comments", "REG_SZ", _ReadStr("Main_44"))
RegWrite($T, "Publisher", "REG_SZ", "XPtsp Development Team")
RegWrite($T, "UninstallString", "REG_SZ", """" & $Src & "\XPtsp.exe"" /UNINSTALL")
RegWrite($T, "URLInfoAbout", "REG_SZ", "http://www.wincert.net/forum/index.php?showtopic=3842")
RegWrite($T, "URLUpdateInfo", "REG_SZ", "http://www.wincert.net/forum/index.php?showtopic=3842")
RegWrite($SET, "InstalledPath", "REG_SZ", $Src)
$T = "{8DE84F36-F390-4727-BE44-3E42DD2A3E35}"
RegWrite($HKCR & "\CLSID\" & $T, "", "REG_SZ", "XPtsp")
RegWrite($HKCR & "\CLSID\" & $T, "InfoTip", "REG_SZ", _FormatStr("Main_44", $TITLE))
RegWrite($HKCR & "\CLSID\" & $T & "\DefaultIcon", "", "REG_SZ", $Src & "\XPtsp.exe,0")
RegWrite($HKCR & "\CLSID\" & $T & "\Shell\Open\Command", "", "REG_SZ", """" & $Src & "\XPtsp.exe"" /APPLET")
RegWrite($HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\" & $T, "", "REG_SZ", "XPtsp")
RegWrite($HKLM & "\Software\Microsoft\Windows\CurrentVersion\Run", "XPtsp Repatch", "REG_SZ", """" & $Src & "\XPtsp.exe"" /AUTOPATCH")
EndFunc
Func _Show_Loading()
If $GUI <> 0 Then
If FileInstall("loading.gif", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "loading.gif"))
Local $oIE = ObjCreate("Shell.Explorer.2")
If @error = 0 Then
$Pat[99] = GUICtrlCreateObj($oIE, 232, 162, 36, 36)
If $Pat[99] <> 0 Then
$oIE.navigate("about:blank")
$oIE.document.body.background = $tmp & "\loading.gif"
$oIE.document.body.scroll = "no"
EndIf
Else
GUICtrlCreatePic($tmp & "\loading.gif", 232, 162, 36, 36)
EndIf
EndIf
EndFunc
Func _FindServer($File, $SUB, $err = 1)
Local $HOSTS[4] = [3, _Iif($DEBUG = 1, "localhost:81", ""), "www.xptsp.com", "home.comcast.net/~douglas.orend"], $i
If(@IPAddress1 = "0.0.0.0" Or @IPAddress1 = "127.0.0.1") And @IPAddress2 = "0.0.0.0" _
And @IPAddress3 = "0.0.0.0" And @IPAddress4 = "0.0.0.0" Then
If $err Then MsgBox(0x10, $TITLE, _ReadStr("Main_10"), 0, $GUI)
Return 0
EndIf
DirCreate($tmp)
FileDelete($File)
For $i = 1 To $HOSTS[0]
If $HOSTS[$i] = "" Then ContinueLoop
$WEBSITE = "http://" & $HOSTS[$i]
Local $Bytes = InetGet($WEBSITE & "/" & $SUB & "/Version.php", $File, 4)
If @error = 0 Then
Local $S = StringReplace(FileRead($File), @LF, @CRLF)
FileDelete($File)
FileWrite($File, $S)
If IniRead($File, "XPtsp_v2", "Program", "") <> "" Then ExitLoop
EndIf
Next
If $i <= $HOSTS[0] Then Return 1
If $err Then MsgBox(0x10, $TITLE, _FormatStr("Main_11", $TITLE), 0, $GUI)
Return 0
EndFunc
Func _Download_File($File, ByRef $DFile)
Local $DL_TIME, $handle, $Total = $MAX, $TEMP = 0, $S, $HEADER, $Bar, $Line, $Byte1, $Rate
Local $T = StringMid($File, StringInStr($File, "/", 0, -1) + 1)
InetGet($WEBSITE & "/tools/get.php?url=" & $File, $tmp & "\get.html", 1)
FileDelete($DFile)
$DL_TIME = TimerInit()
Local $handle = InetGet($WEBSITE & "/" & $File, $DFile, 8 + 1, 1)
If InetGetInfo($handle, 4) Then
MsgBox(0, $TITLE, _FormatStr("P_07n", StringMid($File, StringInStr($File, "/", 0, -1) + 1)))
GUISetState(@SW_ENABLE, $GUI)
Return 0
EndIf
$TEMP = GUICreate(_ReadStr("P_07h") & "...", 300, 90, -1, -1, BitOR($WS_BORDER, $WS_POPUP), -1, $GUI)
$HEADER = GUICtrlCreateLabel(_ReadStr("P_07i"), 10, 10, 280, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetFont(-1, 10, 800)
$Bar = GUICtrlCreateProgress(10, 30, 280, 20)
$Line = GUICtrlCreateLabel("", 10, 55, 280, 30, $SS_LEFTNOWORDWRAP)
GUISetState(@SW_SHOW, $TEMP)
Do
$Byte1 = InetGetInfo($handle, 0)
GUICtrlSetData($Bar,($Byte1 * 100) / $Total)
$Rate = Round(($Byte1 / 1024) /(TimerDiff($DL_TIME) / 1000), 1)
$S = _ReadStr("P_07h") & " """ & $T & """..." & @CRLF
$S = $S & _FormatStr("P_07j", Round($Byte1 / 1024, 0), Round($Total / 1024, 0))
GUICtrlSetData($Line, $S & " (" & $Rate & " kb/sec)")
For $j = 1 To 5
If InetGetInfo($handle, 2) Then ExitLoop 2
Sleep(100)
Next
Until InetGetInfo($handle, 2)
GUIDelete($TEMP)
InetClose($handle)
Return 1
EndFunc
Func _FileCopyWithProgress($Src, $DEST)
GUISetState($GUI, $GUI_DISABLE)
Local $TEMP = GUICreate(_ReadStr("Main_31"), 400, 110, -1, -1, BitOR($WS_BORDER, $WS_POPUP), -1, $GUI)
Local $HEADER = GUICtrlCreateLabel("0% " & _ReadStr("Main_32"), 10, 10, 380, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetFont(-1, 9, 800)
Local $Bar = GUICtrlCreateProgress(10, 30, 380, 20), $fProgress
Local $Line = GUICtrlCreateLabel("", 10, 50, 380, 40, $SS_LEFTNOWORDWRAP), $FRead
GUISetState()
Local $HIN = FileOpen($Src, 16), $S
If $HIN = -1 Then
MsgBox(0, _ReadStr("Main_48"), _FormatStr("Main_40", $DEST), 0, $GUI)
Return 0
EndIf
Local $HOUT = FileOpen($DEST, 16 + 2)
If $HOUT = -1 Then
MsgBox(0, _ReadStr("Main_48"), _FormatStr("Main_39", $DEST), 0, $GUI)
Return 0
EndIf
Local $LMAX = FileGetSize($Src)
Local $LREAD = 0
While 1
$FRead = FileRead($HIN, 1024 * 100)
If @error = -1 Then ExitLoop
$LREAD +=(StringLen($FRead) / 2) - 1
$fProgress = $LREAD / $LMAX * 100
GUICtrlSetData($HEADER, Int($fProgress) & "% " & _ReadStr("Main_32"))
GUICtrlSetData($Bar, $fProgress)
$S = StringFormat(_ReadStr("Main_41"), $Src, $DEST, Round($LREAD / 1024 / 1024, 1), Round($LMAX / 1024 / 1024, 1))
GUICtrlSetData($Line, StringReplace($S, "|", @CRLF))
FileWrite($HOUT, $FRead)
WEnd
FileClose($HIN)
FileClose($HOUT)
GUIDelete($TEMP)
GUISetState($GUI, $GUI_ENABLE)
Return 1
EndFunc
Func _Unpack_7z($ArcFile, $sOutput, $Window = 1)
If $Window Then
Local $S = StringMid($ArcFile, StringInStr($ArcFile, "\", 0, -1) + 1)
GUISetState(@SW_DISABLE, $GUI)
Local $TEMP = GUICreate(_ReadStr("Main_31"), 400, 100, -1, -1, BitOR($WS_BORDER, $WS_POPUP), -1, $GUI)
Local $HEADER = GUICtrlCreateLabel(_FormatStr("Live_0f", """" & $S & """"), 10, 10, 380, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetFont(-1, 9, 800)
$Pat[96] = GUICtrlCreateProgress(10, 30, 380, 20)
$Pat[97] = GUICtrlCreateLabel("", 10, 60, 380, 40, $SS_LEFTNOWORDWRAP)
GUICtrlSetFont(-1, 9, 800)
GUISetState()
_7ZipSetOwnerWindowEx($TEMP, "__Archive_Helper")
EndIf
If StringRight($sOutput, 1) <> "\" Then $sOutput = $sOutput & "\"
_7ZipExtractEx($TEMP, $ArcFile, $sOutput, 1)
If $Window Then
_7ZipKillOwnerWindowEx($TEMP)
GUIDelete($TEMP)
GUISetState(@SW_ENABLE, $GUI)
GUISwitch($GUI)
EndIf
EndFunc
Func __Archive_Helper($hWnd, $MSG, $nState, $ExInfo)
If $nState = 0 Then
Local $EXTRACTINGINFO = DllStructCreate($tagEXTRACTINGINFO, $ExInfo)
Local $iFileSize = DllStructGetData($EXTRACTINGINFO, "dwFileSize")
Local $iWriteSize = DllStructGetData($EXTRACTINGINFO, "dwWriteSize")
Local $iPercent = $iWriteSize / $iFileSize * 100
GUICtrlSetData($Pat[96], $iPercent)
GUICtrlSetData($Pat[97], Round($iPercent, 1) & "% " & _ReadStr("Main_32"))
ElseIf $nState = 2 Then
GUICtrlSetData($Pat[96], 100)
GUICtrlSetData($Pat[97], "100% " & _ReadStr("Main_32"))
EndIf
Return 1
EndFunc
Func _CopyDirWithProgress($sOriginalDir, $sDestDir, $MOD = 5)
GUISetState(@SW_DISABLE, $GUI)
Local $TEMP = GUICreate(_ReadStr("Main_31"), 400, 100, -1, -1, BitOR($WS_BORDER, $WS_POPUP), -1, $GUI)
Local $HEADER = GUICtrlCreateLabel(_ReadStr("Main_33"), 10, 10, 380, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetFont(-1, 9, 800)
Local $Bar = GUICtrlCreateProgress(10, 30, 380, 20), $S
Local $Line = GUICtrlCreateLabel("", 10, 50, 380, 40, $SS_LEFTNOWORDWRAP)
GUISetState()
If StringRight($sOriginalDir, 1) <> '\' Then $sOriginalDir = $sOriginalDir & '\'
If StringRight($sDestDir, 1) <> '\' Then $sDestDir = $sDestDir & '\'
If $sOriginalDir = $sDestDir Then Return -1
Local $aFileList = _FileSearch($sOriginalDir)
If $aFileList[0] = 0 Then
ProgressOff()
SetError(1)
Return -1
EndIf
If FileExists($sDestDir) Then
If Not StringInStr(FileGetAttrib($sDestDir), 'd') Then
ProgressOff()
SetError(2)
Return -1
EndIf
Else
DirCreate($sDestDir)
If Not FileExists($sDestDir) Then
ProgressOff()
SetError(2)
Return -1
EndIf
EndIf
Local $iDirSize, $iCopiedSize = 0, $fProgress = 0
Local $c, $FileName, $iOutPut = 0, $sLost = '', $sError
Local $Sl = StringLen($sOriginalDir)
_Quick_Sort($aFileList, 1, $aFileList[0])
Local $iDirSize_Orig = DirGetSize($sOriginalDir)
$iDirSize = Round($iDirSize_Orig / 1024 / 1024, 1)
For $c = 1 To $aFileList[0]
$FileName = StringTrimLeft($aFileList[$c], $Sl)
If Mod($c, $MOD) = 0 Then
GUICtrlSetData($HEADER, Int($fProgress * 100) & "% " & _ReadStr("Main_32"))
GUICtrlSetData($Bar, $fProgress * 100)
$S = StringFormat(_ReadStr("Main_41"), $aFileList[$c], $sDestDir & $FileName, _
Round($iCopiedSize / 1024 / 1024, 1), $iDirSize)
GUICtrlSetData($Line, StringReplace($S, "|", @CRLF))
EndIf
If StringInStr(FileGetAttrib($aFileList[$c]), 'd') Then
DirCreate($sDestDir & $FileName)
Else
If Not FileCopy($aFileList[$c], $sDestDir & $FileName, 1) Then
If Not FileCopy($aFileList[$c], $sDestDir & $FileName, 1) Then
If RunWait(@ComSpec & ' /c copy /y "' & $aFileList[$c] & '" "' & $sDestDir & $FileName & '">' & $tmp & '\o.tmp', '', @SW_HIDE) = 1 Then
$sError = FileReadLine($tmp & '\o.tmp', 1)
$iOutPut = $iOutPut + 1
$sLost = $sLost & $aFileList[$c] & '  ' & $sError & @CRLF
EndIf
FileDelete($tmp & '\o.tmp')
EndIf
EndIf
FileSetAttrib($sDestDir & $FileName, "+A-RSH")
$iCopiedSize = $iCopiedSize + FileGetSize($aFileList[$c])
$fProgress = $iCopiedSize / $iDirSize_Orig
EndIf
Next
GUIDelete($TEMP)
GUISetState(@SW_ENABLE, $GUI)
GUISwitch($GUI)
Return $iOutPut
EndFunc
Func _FileSearch($sIstr, $bSF = 1)
Local $sCriteria, $sBuffer, $iH, $iH2, $sCS, $sCF, $sCF2, $sCP, $sFP, $sOutput = '', $aNull[1]
$sCP = StringLeft($sIstr, StringInStr($sIstr, '\', 0, -1))
If $sCP = '' Then $sCP = $Working & '\'
$sCriteria = StringTrimLeft($sIstr, StringInStr($sIstr, '\', 0, -1))
If $sCriteria = '' Then $sCriteria = '*.*'
$sCS = FileFindFirstFile($sCP & $sCriteria)
If $sCS <> -1 Then
Do
$sCF = FileFindNextFile($sCS)
If @error Then
FileClose($sCS)
ExitLoop
EndIf
If $sCF = '.' Or $sCF = '..' Then ContinueLoop
$sOutput = $sOutput & $sCP & $sCF & @LF
Until 0
EndIf
If $bSF = 1 Then
$sBuffer = @CR & $sCP & '*' & @LF
Do
$sCS = StringTrimLeft(StringLeft($sBuffer, StringInStr($sBuffer, @LF, 0, 1) - 1), 1)
$sCP = StringLeft($sCS, StringInStr($sCS, '\', 0, -1))
$iH = FileFindFirstFile($sCS)
If $iH <> -1 Then
Do
$sCF = FileFindNextFile($iH)
If @error Then
FileClose($iH)
ExitLoop
EndIf
If $sCF = '.' Or $sCF = '..' Then ContinueLoop
If StringInStr(FileGetAttrib($sCP & $sCF), 'd') Then
$sBuffer = @CR & $sCP & $sCF & '\*' & @LF & $sBuffer
$sFP = $sCP & $sCF & '\'
$iH2 = FileFindFirstFile($sFP & $sCriteria)
If $iH2 <> -1 Then
Do
$sCF2 = FileFindNextFile($iH2)
If @error Then
FileClose($iH2)
ExitLoop
EndIf
If $sCF2 = '.' Or $sCF2 = '..' Then ContinueLoop
$sOutput = $sOutput & $sFP & $sCF2 & @LF
Until 0
EndIf
EndIf
Until 0
EndIf
$sBuffer = StringReplace($sBuffer, @CR & $sCS & @LF, '')
Until $sBuffer = ''
EndIf
If $sOutput = '' Then
$aNull[0] = 0
Return $aNull
Else
Return StringSplit(StringTrimRight($sOutput, 1), @LF)
EndIf
EndFunc
Func _Quick_Sort(ByRef $SortArray, $First, $Last)
Dim $Low, $High
Dim $TEMP, $List_Separator
$Low = $First
$High = $Last
$List_Separator = StringLen($SortArray[($First + $Last) / 2])
Do
While(StringLen($SortArray[$Low]) < $List_Separator)
$Low = $Low + 1
WEnd
While(StringLen($SortArray[$High]) > $List_Separator)
$High = $High - 1
WEnd
If($Low <= $High) Then
$TEMP = $SortArray[$Low]
$SortArray[$Low] = $SortArray[$High]
$SortArray[$High] = $TEMP
$Low = $Low + 1
$High = $High - 1
EndIf
Until $Low > $High
If($First < $High) Then _Quick_Sort($SortArray, $First, $High)
If($Low < $Last) Then _Quick_Sort($SortArray, $Low, $Last)
EndFunc
Func GetPalette_Install()
$Palette = "00000000151A200046464600D23E2D00016553000535B2007E7E7E0000928900FC7F5E00206BF700FFA68D0004DC8E001BBCF300BCBCBC00FCFCFC00FFFFFF"
Local $S = RegRead($HKCU & "\SOFTWARE\XPtsp", "Palette")
If @error = 0 Then $Palette = $S
Return($S <> "")
EndFunc
Func GetPalette_Integration()
$Palette = "00000000151A200046464600D23E2D00016553000535B2007E7E7E0000928900FC7F5E00206BF700FFA68D0004DC8E001BBCF300BCBCBC00FCFCFC00FFFFFF"
Local $S = IniRead($INF, "Strings", "Palette", "")
If $S <> "" Then $Palette = $S
Local $T = IniRead($INF, "Strings", "TaskMgr", "")
If $T <> "" And $T <> "LBS" Then $TASKMGR = $T
Return($S <> "")
EndFunc
Func Build_Cab($File, $Folder)
Local $handle, $TEMP, $Bar, $A = 0, $B = 0, $hCabLite, $Result, $T, $PER
$handle = FileFindFirstFile($Folder & "\*")
If $handle <> -1 Then
While 1
$TEMP = FileFindNextFile($handle)
If @error Then ExitLoop
$A += FileGetSize($Folder & "\" & $TEMP)
WEnd
FileClose($handle)
EndIf
$Result = DllCall($CABLITE, 'ptr', 'CabStart', 'str', $File, 'ushort', 0)
$hCabLite = $Result[0]
$handle = FileFindFirstFile($Folder & "\*")
If $handle <> -1 Then
While 1
$TEMP = FileFindNextFile($handle)
If @error Then ExitLoop
DllCall($CABLITE, 'ushort', 'CabAdd', 'ptr', $hCabLite, 'str', $Folder & "\" & $TEMP, 'ptr', 0)
$B += FileGetSize($Folder & "\" & $TEMP)
$PER =($B / $A) * 100
GUICtrlSetData($Pat[1], $PER)
GUICtrlSetData($Pat[2], Round($PER) & "% " & $Pat[10])
WEnd
FileClose($handle)
EndIf
DllCall($CABLITE, 'dword', 'CabFinish', 'ptr', $hCabLite)
EndFunc
Func Copy_Section($Section, $From = $xtra, $Out = "")
Local $Files
If $Out = "" Then $Out = $Src & "\i386"
$Files = IniReadSection($tmp & "\XPSect.ini", $Section)
If @error = 0 Then
$CNT = $Files[0][0]
If $Files[0][0] > 0 Then
For $i = 1 To $Files[0][0]
If FileExists($From & "\" & $Files[$i][0]) = 1 Then
Page11_Notify("- " & _ReadStr("Main_29") & " " & StringUpper($Files[$i][0]))
FileCopy($From & "\" & $Files[$i][0], $Out & "\" & $Files[$i][0], 1)
EndIf
Next
Return 1
EndIf
EndIf
Return 0
EndFunc
Func Compress_Section($Section, $From = $xtra, $Out = "", $Check = 0)
Local $Files
If $Out = "" Then $Out = $Src & "\i386"
$Files = IniReadSection($tmp & "\XPSect.ini", $Section)
If @error = 0 Then
$CNT = $Files[0][0]
If $Files[0][0] > 0 Then
For $i = 1 To $Files[0][0]
If FileExists($From & "\" & $Files[$i][0]) = 1 Then
Page11_Notify("- " & _FormatStr("Main_23", StringUpper($Files[$i][0])))
Compress_File($From & "\" & $Files[$i][0], $Out & "\" & $Files[$i][0], $Check)
EndIf
Next
Return 1
EndIf
EndIf
Return 0
EndFunc
Func Compress_File($Source, $DEST, $Check = 0)
If FileExists($Source) = 0 Then
$CNT += 1
Return Page11_Notify(_ReadStr("Main_56"))
EndIf
Local $DFile = StringUpper(StringLeft($DEST, StringLen($DEST) - 1) & "_")
If $Check And FileExists($DEST) = 0 And FileExists($DFile) = 0 Then Return
FileDelete($DEST)
FileDelete($DFile)
DllCall($CABLITE, 'dword', 'CabFile', 'str', $Source, 'str', $DFile)
EndFunc
Func Build_Section($SECT, $Dir = "", $Folder = $res, $ResOnly = 1)
Local $handle, $File, $Out, $FTmp, $x = 0, $j, $Attrib
If $Dir = "" Then $Dir = $Src & "\i386"
$handle = FileFindFirstFile($Folder & "\" & _Iif($ResOnly = 1, "*.res", "*"))
If $handle <> -1 Then
While 1
$File = FileFindNextFile($handle)
If @error Then ExitLoop
$Attrib = FileGetAttrib($Folder & "\" & $File)
If @error Then ContinueLoop
If StringInStr($Attrib, "D") Then ContinueLoop
If $ResOnly = 0 And StringRight($File, 4) = ".res" Then ContinueLoop
$File = StringReplace($File, ".res", "")
$Out = $File
If $ResOnly Then
$j = Page9_FindItem($File)
$j = $LV[$j][6] & $LV[$j][5]
If $j = "00" Or $j = "11" Then ContinueLoop
EndIf
If FileExists($Dir & "\" & $Out) = 0 Then $Out = StringLeft($Out, StringLen($Out) - 1) & "_"
If FileExists($Dir & "\" & $Out) = 0 Then ContinueLoop
IniWrite($tmp & "\XPSect.ini", $SECT, StringUpper($File), StringUpper($Out))
$x = 1
WEnd
EndIf
Return $x
EndFunc
Func Expand_File($Source, $DEST = $tmp)
Local $File = StringReplace(StringMid($Source, StringInStr($Source, "\", 0, -1) + 1), ".xptsp", "")
If StringRight($Source, 1) <> "_" Then Return $Source
DirCreate($tmp & "\Extracted")
DllCall($CABLITE, 'ushort', 'CabExtract', 'str', $Source, 'str', $tmp & "\Extracted\", 'ptr', 0)
Local $handle = FileFindFirstFile($tmp & "\Extracted\*")
If $handle <> -1 Then
$File = FileFindNextFile($handle)
FileMove($tmp & "\Extracted\" & $File, $DEST & "\" & $File, 1)
EndIf
FileClose($handle)
DirRemove($tmp & "\Extracted", 1)
Return $DEST & "\" & $File
EndFunc
Func Expand_CAB($Source)
DirRemove($mcabtmp, 1)
DllCall($CABLITE, 'ushort', 'CabExtract', 'str', $Source, 'ptr', 0, 'ptr', 0)
$mcabtmp = StringReplace($Source, ".CAB", "")
EndFunc
Func Edit_Section($Section, $Out = "")
If $Out = "" Then $Out = $Src & "\i386"
Local $Files = IniReadSection($tmp & "\XPSect.ini", $Section)
If @error = 0 Then
$CNT = $Files[0][0]
If $Files[0][0] > 0 Then
DirCreate($tmp)
For $i = 1 To $Files[0][0]
Edit_File($Files[$i][0], $Out & "\" & $Files[$i][1])
Next
Return 1
EndIf
EndIf
Return 0
EndFunc
Func Edit_File($Resource, $File)
Local $VER, $MD5, $F2P, $S = $File, $RFILE, $LangID
If $Resource = "setup.exe" Then
If FileExists($Src & "\i386\setuporg.exe") Then $File = $Src & "\i386\setuporg.exe"
EndIf
$F2P = StringReplace(StringMid($File, StringInStr($File, "\", 0, -1) + 1), ".xptsp", "")
$F2P = StringUpper(StringLeft($F2P, StringLen($F2P) - 1) & StringRight($Resource, 1))
$RFILE = StringUpper(StringReplace(StringMid($Resource, StringInStr($Resource, "\", 0, -1) + 1), ".res", ""))
If $Live = 0 Then $S = Expand_File($File)
If FileExists($S) Then
$VER = IniRead($Working & "\XPtsp.ini", "NoPatch.ByVersion", $Resource, "")
If $VER <> "" And FileGetVersion($S) >= $VER Then
$CNT += 1
Page11_Notify("- " & _FormatStr("Main_34", $Resource, "NoPatch.ByVersion"))
FileDelete($S)
Else
Execute("_Hex_" & StringReplace($Resource, ".", "_") & "($S, $Resource)")
If FileGetSize($res & "\" & $Resource & ".res") > 0 Then
$LangID = StringLeft(FileGetVersion($S, "DefaultLangCodepage"), 4)
Page11_Notify("- (" & $LangID & ") " & $Pat[12] & " " & $F2P & _Iif($RFILE <> $F2P, " " & $Pat[13] & " " & $RFILE, ""))
$RFILE = Res_Translate($Resource, $S, $LangID)
If $RFILE = "" Then $RFILE = $res & "\" & $Resource & ".res"
If $FullPack Then Execute("_Pre_" & StringReplace($Resource, ".", "_") & "($S, $RFILE, $LangID)")
_Reshacker("-addoverwrite """ & $S & """, """ & $S & """, """ & $RFILE & """,,,", $tmp)
EndIf
Execute("_Post_" & StringReplace($Resource, ".", "_") & "($S, $LangID)")
_PECheckSum($S)
$MD5 = StringLeft(IniRead($res & "\Version.ini", "Pro", $Resource, ""), 32)
IniWrite($INF, "Pro", $Resource, FileGetVersion($S) & "|" & FileGetSize($S) & "||" & $MD5)
If $Live = 0 And StringRight($File, 1) = "_" Then
Compress_File($S, $File, 0)
FileDelete($S)
EndIf
EndIf
EndIf
Execute("_After_" & StringReplace($F2P, ".", "_") & "()")
EndFunc
Func _IncludeFunc()
__Archive_Helper(0, 0, 0, 0)
_Hex_SFC_OS_DLL()
_Hex_SFC_DLL()
_Hex_TASKMGR_EXE()
_Hex_UXTHEME_DLL()
_Hex_NTOSKRNL_EXE()
_Hex_NTKRNLPA_EXE()
_Hex_NTKRNLMP_EXE()
_Hex_NTKRPAMP_EXE()
_Hex_COMCTL32_DLL()
_Hex_REGEDIT_EXE()
_Pre_LOGONUI_EXE()
_Pre_REMOTEPG_DLL()
_Pre_TSP_KRNL_EXE()
_Pre_WINNTBBA_DLL()
_Pre_WINNTBBU_DLL()
_Pre_WUAUCPL_MUI()
_Post_COMCTL32_DLL()
_Post_IEFRAME_DLL_MUI()
_Post_SETUP_EXE()
_Post_SRCLIENT_DLL()
_After_XPSP1RES_DLL()
_After_XPSP2RES_DLL()
_After_XPSP3RES_DLL()
Page9_TopLevel()
Page9_Section()
Page9_Files()
EndFunc
Func _Hex_TASKMGR_EXE($S = "", $RFILE = "")
If $OS = "AMD64" Then Return
Local $MOD = IniRead($Working & "\XPtsp.ini", "_TASKMGR.EXE", $TASKMGR, "")
If $MOD = "" Then Return
$MOD = StringSplit($MOD, "|")
If $MOD[0] <> 4 Then Return
For $i = 1 To $MOD[0]
$MOD[$i] = StringLeft($MOD[$i] & "000000", 6)
Next
Local $CPU = $MOD[1], $MEM = $MOD[2], $GRID = $MOD[3], $Digits = $MOD[4]
$CNT += 1
Page11_Notify("- " & _FormatStr("Main_35", "TASKMGR.EXE"))
Local $handle = FileOpen($S, 16)
Local $VAR = FileRead($handle), $OLD
FileClose($handle)
$VAR = StringReplace($VAR, "7405BB0120", "9090BB2100")
$VAR = StringReplace($VAR, "FFFF68008040006A", "FFFF68" & $GRID & "006A")
$VAR = StringReplace($VAR, "0E04000000FF0000FF00", "0E040000" & $CPU & "00FF00")
$VAR = StringReplace($VAR, "FFFF00002500", $MEM & "002500")
$VAR = StringReplace($VAR, "00FF0000FF73", $Digits & "00FF73")
$VAR = StringReplace($VAR, "2B7D1068008040006A01", "2B7D1068" & $GRID & "006A01")
$VAR = StringReplace($VAR, "00FF0000000000006C5200006D52", $CPU & "00000000006C5200006D52")
$VAR = StringReplace($VAR, "EC03000000000000FF000000FFFF0000", "EC03000000000000FF000000" & $Digits & "00")
$VAR = StringReplace($VAR, "FFFF0000FFB5", $Digits & "00FFB5")
$handle = FileOpen($S, 16 + 2)
FileWrite($handle, $VAR)
FileClose($handle)
EndFunc
Func _Hex_SFC_DLL($S = "", $RFILE = "")
If $OS = "AMD64" Then Return
Local $VER = _Iif($OS = "W2K", "5.0.0.0", FileGetVersion($S)), $A = "", $B = "", $c = "", $POS
$POS = StringSplit(IniRead($Working & "\XPtsp.ini", "_SFC_OS.DLL", $VER, "XP_SP?|60548|83F89D7508|3BC0EB3290"), "")
If $POS[0] <> 4 Then Return Page11_Notify("MSG: " & _FormatStr("Main_55", $RFILE))
$CNT += 1
Page11_Notify("- " & _FormatStr("Main_35", "SFC_OS.DLL") & " (" & $POS[1] & ")")
Local $handle = FileOpen($S, 16)
$A = FileRead($handle, $POS[2])
$B = FileRead($handle)
FileClose($handle)
$handle = FileOpen($S, 16 + 2)
FileWrite($handle, $A)
FileWrite($handle, StringReplace($B, $POS[3], $POS[4], 1))
FileClose($handle)
Return 1
EndFunc
Func _Hex_SFC_OS_DLL($S = "", $RFILE = "")
If _Hex_SFC_DLL($S, $RFILE) <> 1 Or $SP3 = 0 Then Return
If $Live = 0 Then
Local $File = $Src & "\" & $OS & "\hivedef.inf", $Lines = FileRead($File)
FileClose($File)
$Lines = StringReplace($Lines, "HKLM,""SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"",""SFCDisable"",0x10003,0xFFFFFF9D", "")
$Lines = StringReplace($Lines, "[AddReg]", "[AddReg]" & @CRLF & "HKLM,""SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"",""SFCDisable"",0x10003,0xFFFFFF9D", 1)
FileDelete($File)
FileWrite($File, $Lines)
FileClose($File)
Else
RegWrite("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "SFCDisable", "REG_DWORD", 0xFFFFFF9D)
EndIf
EndFunc
Func _Hex_UXTHEME_DLL($S = "", $RFILE = "")
If $OS = "AMD64" Then Return
Local $VER = FileGetVersion($S), $File, $POS, $i = 2, $A, $B, $c
$VER = _Iif($VER < "5.1.2600.1106", "5.1.2600.0", $VER)
$POS = StringSplit(IniRead($Working & "\XPtsp.ini", "_UXTHEME.DLL", $VER, ""), "|")
If $POS[0] < 4 Then Return Page11_Notify("MSG: " & _FormatStr("Main_55", "UXTHEME.DLL"))
If Mod($POS[0], 3) <> 1 Then Return
$CNT += 1
Page11_Notify("- " & _FormatStr("Main_35", "UXTHEME.DLL") & " (" & $POS[1] & ")")
Local $handle = FileOpen($S, 16)
$File = StringMid(FileRead($handle), 3)
FileClose($handle)
While $i < $POS[0]
$A = StringLeft($File, $POS[$i] * 2)
$B = StringMid($File, $POS[$i] * 2 + 1, StringLen($POS[$i + 1]))
$c = StringMid($File, $POS[$i] * 2 + StringLen($POS[$i + 1]) + 1)
$File = $A & StringReplace($B, $POS[$i + 1], $POS[$i + 2], 1) & $c
$i += 3
WEnd
$handle = FileOpen($S, 16 + 2)
FileWrite($handle, "0x" & $File)
FileClose($handle)
EndFunc
Func _Hex_NTOSKRNL_EXE($S = "", $RFILE = "")
_Hex_TSP_KRNL_EXE($S)
EndFunc
Func _Hex_NTKRNLPA_EXE($S = "", $RFILE = "")
_Hex_TSP_KRNL_EXE($S)
EndFunc
Func _Hex_NTKRNLMP_EXE($S = "", $RFILE = "")
_Hex_TSP_KRNL_EXE($S)
EndFunc
Func _Hex_NTKRPAMP_EXE($S = "", $RFILE = "")
_Hex_TSP_KRNL_EXE($S)
EndFunc
Func _Hex_TSP_KRNL_EXE($S = "", $RFILE = "")
If $OS = "AMD64" Then Return
Local $B = IniRead($Working & "\XPtsp.ini", "Palette", $BOOTSCR, "")
If $B = "" Or StringIsXDigit($B) = 0 Then Return
$CNT += 1
Page11_Notify("- " & _FormatStr("Main_35", $RFILE))
$Palette = $B
Local $handle = FileOpen($S, 16)
Local $VAR = FileRead($handle)
FileClose($handle)
$handle = FileOpen($S, 16 + 2)
FileWrite($handle, StringReplace($VAR, $Palette, $B))
FileClose($handle)
EndFunc
Func _Hex_COMCTL32_DLL($S = "", $RFILE = "")
If $OS = "AMD64" Then Return
$CNT += 1
Page11_Notify("- " & _FormatStr("Main_35", $RFILE))
Local $handle = FileOpen($S, 16)
Local $VAR = FileRead($handle)
FileClose($handle)
$handle = FileOpen($S, 16 + 2)
If StringLeft($S, StringLen(@SystemDir)) = @SystemDir Then
$VAR = StringReplace($VAR, "FC7D0B00748B4D", "FC7D0090908B4D")
Else
$VAR = StringReplace($VAR, "7DFC740B8B4D", "7DFC90908B4D")
EndIf
FileWrite($handle, $VAR)
FileClose($handle)
EndFunc
Func _Hex_REGEDIT_EXE($S = "", $RFILE = "")
If $OS = "AMD64" Then Return
$CNT += 1
Page11_Notify("- " & _FormatStr("Main_35", $RFILE))
Local $handle = FileOpen($S, 16)
Local $VAR = FileRead($handle)
FileClose($handle)
$handle = FileOpen($S, 16 + 2)
FileWrite($handle, StringReplace($VAR, "7405BF0120", "9090BF2100"))
FileClose($handle)
EndFunc
Func _Pre_WUAUCPL_MUI($S = "", $RFILE = "", $LangID = "")
If $LangID = "0409" Then Return
Page11_Notify("MSG: " & _FormatStr("Main_52", "WUAUCPL.MUI.RES"))
If @Compiled Then BlockInput(1)
Local $PID = Run($Working & "\Programs\Reshacker """ & $RFILE & """"), $FTime
WinWait("Resource Hacker", "")
WinActivate("Resource Hacker", "")
if(@OSVersion = "WIN_XP" And @OSServicePack = "Service Pack 1") Then
$FTime = FileGetTime($RFILE, 0, 1)
Send("{Down}{Down}{Right}{Down}{Right}{Down}{Tab}{Tab}{Space}+{Tab}+{Tab}{Space}^s")
Do
Sleep(250)
Until FileGetTime($RFILE, 0, 1) <> $FTime
WinClose("Resource Hacker", "")
Else
Send("{Down}{Down}{Right}{Down}{Right}{Down}{Tab}{Tab}{Space}!c^s!fx")
EndIf
WinWaitClose("Resource Hacker", "", 10)
If @Compiled Then BlockInput(0)
EndFunc
Func _Pre_LOGONUI_EXE($S = "", $RFILE = "", $LangID = "")
_Reshacker("-delete """ & $S & """, """ & $S & """, UIFILE,,")
_Reshacker("-delete """ & $S & """, """ & $S & """, Bitmap,,")
_Reshacker("-delete """ & $S & """, """ & $S & """, stringtable,,")
EndFunc
Func _Pre_REMOTEPG_DLL($S = "", $RFILE = "", $LangID = "")
_Reshacker("-delete """ & $S & """, """ & $S & """, icongroup,,")
EndFunc
Func _Pre_WINNTBBU_DLL($S = "", $RFILE = "", $LangID = "")
_Reshacker("-delete """ & $S & """, """ & $S & """, stringtable,,")
EndFunc
Func _Pre_WINNTBBA_DLL($S = "", $RFILE = "", $LangID = "")
_Reshacker("-delete """ & $S & """, """ & $S & """, stringtable,,")
EndFunc
Func _Pre_TSP_KRNL_EXE($S = "", $RFILE = "", $LangID = "")
If $LangID <> "0409" Then
_Reshacker("-delete """ & $RFILE & """, """ & $RFILE & """, Bitmap, 2,")
_Reshacker("-delete """ & $RFILE & """, """ & $RFILE & """, Bitmap, 3,")
EndIf
EndFunc
Func _Post_COMCTL32_DLL($S = "", $LangID = "")
_Reshacker("-addoverwrite """ & $S & """, """ & $S & """, """ & $res & "\COMCTL32.DLL.res" & """,,,", $tmp)
EndFunc
Func _Post_IEFRAME_DLL_MUI($File = "", $LangID = "")
If FileGetVersion($File) > "8.0.0.0" Then _Reshacker("-addoverwrite """ & $File & """, """ & $File & """, """ & $res & "\IE8\IEFRAME.DLL.MUI.res" & """,,,", $tmp)
EndFunc
Func _Post_SETUP_EXE($S = "", $LangID = "")
Local $lOS = Int("0x" & $LangID)
_Reshacker("-addoverwrite """ & $S & """, """ & $S & """, """ & $Working & "\Programs\Icon_0_Setup.ico"", icon, 0," & _Iif($lOS = 0, "", $lOS), $tmp)
EndFunc
Func _Post_SRCLIENT_DLL($S = "", $LangID = "")
Local $lOS = Int("0x" & $LangID)
_Reshacker("-addoverwrite """ & $S & """, """ & $S & """, """ & $Working & "\Programs\Icon_0_SrClient.ico"", icon, 0," & _Iif($lOS = 0, "", $lOS), $tmp)
EndFunc
Func _After_XPSP1RES_DLL()
If $Live = 0 And $XPSPRES = 1 Then __Search_TxtSetup("XPSP1RES.DLL")
EndFunc
Func _After_XPSP2RES_DLL()
If $Live = 0 And $XPSPRES = 1 Then __Search_TxtSetup("XPSP2RES.DLL")
EndFunc
Func _After_XPSP3RES_DLL()
If $Live = 0 And $XPSPRES = 1 Then __Search_TxtSetup("XPSP3RES.DLL")
EndFunc
Func __Search_TxtSetup($File)
Local $handle = FileOpen($Src & "\i386\TXTSETUP.SIF", 0), $Line, $Other
Local $TFILE = @HOUR & @MIN & @SEC
If $handle = 0 Then
Page11_Notify(_FormatStr("Main_40", "TXTSETUP.SIF"))
Return
EndIf
While 1
$Line = FileReadLine($handle)
If @error Then ExitLoop
If StringInStr($Line, "," & $File) = 0 Then ContinueLoop
$Other = StringReplace(StringLeft($Line, StringInStr($Line, "=") - 1), " ", "")
$CNT += 1
$Other = $Src & "\i386\" & $Other
If FileExists($Other) = 0 Then $Other = StringLeft($Other, StringLen($Other) - 1) & "_"
If FileExists($Other) = 0 Then
Page11_Notify("MSG: " & _FormatStr("Main_20", $Other))
ContinueLoop
EndIf
Edit_File($File, $Other)
WEnd
FileClose($handle)
EndFunc
Func Res_Translate($ResFile, $Comp, $lOS = -1)
Local $x = 1, $Y = 1, $atmp = $tmp & "\Resources", $RFILE = $res & "\" & $ResFile & ".res"
Local $Line, $PID, $File, $CAPTION, $ARR, $handle, $S, $S2, $T, $U, $V, $RINI, $CINI
If $lOS = -1 Then $lOS = StringLeft(FileGetVersion($Comp, "DefaultLangCodepage"), 4)
If $Translate < 1 Or $lOS = "0409" Then Return ""
DirRemove($atmp, 1)
DirCreate($atmp)
If FileExists($res & "\Dialogs\" & $ResFile & ".rc") = 1 Then
FileCopy($RFILE, $atmp & "\" & $ResFile & ".res", 1)
$RFILE = $atmp & "\" & $ResFile & ".res"
_Reshacker("-delete """ & $RFILE & """, """ & $RFILE & """, DIALOG,,", $atmp)
EndIf
_Reshacker("-extract """ & $RFILE & """, """ & $atmp & "\_.rc"",,,", $atmp)
If FileExists($atmp & "\_.rc") = 0 Then Return ""
FileCopy($atmp & "\_.rc", $atmp & "\Original.rc")
$RINI = FileRead($atmp & "\_.rc")
If FileExists($res & "\Dialogs\" & $ResFile & ".rc") = 1 Then
$RINI = $RINI & @CRLF & FileRead($res & "\Dialogs\" & $ResFile & ".rc")
EndIf
$RINI = StringReplace("#define FW_NORMAL 400" & @CRLF & "#define FALSE 0" & @CRLF & $RINI, "\""", "\'")
$RINI = StringSplit(StringReplace($RINI, @CR, ""), @LF)
If Mod(Int("0x" & $lOS), 1024) <> 9 and($ResFile <> "EHRES.DLL.RES" Or $ResFile <> "EHRES.DLL") Then
FileDelete($atmp & "\Src.rc")
_Reshacker("-extract """ & $Comp & """, """ & $atmp & "\Src.rc"", DIALOG,,", $atmp)
If FileExists($atmp & "\Src.rc") Then
$CINI = StringReplace(FileRead($atmp & "\Src.rc"), "\""", "\'")
$CINI = StringSplit(StringReplace($CINI, @CR, ""), @LF)
$x = 0
While $x < $RINI[0]
Do
$x += 1
If $x >= $RINI[0] Then ExitLoop 2
If $RINI[$x] = "" Then ContinueLoop
Until StringInStr($RINI[$x], " DIALOG") <> 0
$T = $x
Do
$x += 1
If $x >= $RINI[0] Then ExitLoop 2
If StringLeft($RINI[$x], 8) = "CAPTION " Then $CAPTION = $x
Until $RINI[$x] = "{"
$Y = 0
$S = StringLeft($RINI[$T], StringInStr($RINI[$T], " ", 0, 2))
Do
$Y += 1
If $Y >= $CINI[0] Then ContinueLoop 2
If $CINI[$Y] = "" Then ContinueLoop
Until StringLeft($CINI[$Y], StringInStr($CINI[$Y], " ", 0, 2)) = $S
Do
$Y += 1
If $Y >= $CINI[0] Then ContinueLoop 2
If StringLeft($CINI[$Y], 8) = "CAPTION " Then $RINI[$CAPTION] = $CINI[$Y]
Until $CINI[$Y] = "{"
$S = StringLeft($RINI[$T], StringInStr($RINI[$T], " ") - 1)
$U = IniRead($res & "\Version.ini", $ResFile, $S, IniRead($Working & "\XPtsp.ini", $ResFile, $S, ""))
$T = 0
While 1
$x += 1
If $RINI[$x] = "}" Then ExitLoop
$T += 1
$S = $T
If $U <> "" Then
$V = StringInStr($U, "|" & $T & "=")
If $V = 0 Then ContinueLoop
$V = StringMid($U, $V + 1)
$V = StringMid($V, StringInStr($V, "=") + 1)
$S = StringLeft($V, StringInStr($V, "|") - 1)
EndIf
If $S = "CAPTION" Then
$S2 = "   " & StringReplace($RINI[$CAPTION], "CAPTION", "CONTROL")
$V = StringMid($RINI[$x], StringInStr($RINI[$x], """", 0, 2) + 1)
Else
If StringRegExp($S, "^(\d+)$") = 1 Then
$S2 = StringLeft($CINI[$Y + $S], StringInStr($CINI[$Y + $S], """", 0, 2))
If $S2 = "" Then
$V = $RINI[$x]
Else
$V = StringMid($RINI[$x], StringInStr($RINI[$x], """", 0, 2) + 1)
If StringLeft($V, 1) <> "," Then $S2 = ""
EndIf
Else
$S2 = "   CONTROL """ & _ReadStr($S, "Dialogs") & """"
$V = StringMid($RINI[$x], StringInStr($RINI[$x], """", 0, 2) + 1)
EndIf
EndIf
$RINI[$x] = $S2 & $V
WEnd
WEnd
$T = ""
For $i = 1 To $RINI[0]
$T = $T & $RINI[$i] & @CRLF
Next
$T = StringReplace($T, "\'", "\""")
$S = $atmp & "\_.rc"
FileDelete($S)
FileWriteLine($S, $T)
FileClose($S)
EndIf
EndIf
RunWait($Working & "\Programs\RH2RC """ & $atmp & "\_.rc"" """ & $atmp & "\_2.rc", $atmp, @SW_HIDE)
If FileExists($atmp & "\_2.rc") = 0 Then
Page11_Notify("MSG: " & _ReadStr("Main_53"))
_Keep_Logs($atmp & "\_.rc", $ResFile, "rc")
If $DEBUG = 1 Then RunWait(@ComSpec, $atmp)
Return ""
EndIf
If $lOS <> "" Then $lOS = "/l " & $lOS
$PID = Run($Working & "\Programs\RC.exe " & $lOS & " /r """ & $atmp & "\_2.rc""", $atmp, @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
While 1
$Line = StdoutRead($PID)
If @error Then ExitLoop
$File = $File & $Line
WEnd
While 1
$Line = StderrRead($PID)
If @error Then ExitLoop
$File = $File & $Line
WEnd
FileWrite($atmp & "\Error.txt", $File)
If FileExists($atmp & "\_2.res") = 0 Then
Page11_Notify("MSG: " & _ReadStr("Main_54"))
_Keep_Logs($atmp & "\Error.txt", $ResFile)
_Keep_Logs($atmp & "\Original.rc", $ResFile & " [1]", "rc")
_Keep_Logs($atmp & "\Src.rc", $ResFile & " [2]", "rc")
_Keep_Logs($atmp & "\_.rc", $ResFile & " [3]", "rc")
_Keep_Logs($atmp & "\_2.rc", $ResFile & " [4]", "rc")
If $DEBUG = 1 Then RunWait(@ComSpec, $atmp)
Return ""
EndIf
Return $atmp & "\_2.res"
EndFunc
Func Live0_Run()
Local $handle, $File, $x, $CAB, $T, $S, $Pack
$Pat[7] = 4 + FileExists($Src & "\AMD64") +(FileExists($Src & "\i386\NR_IE7en.CAB") + FileExists($Src & "\i386\IE8.CAB") + _
FileExists($Src & "\i386\WMP10.CAB") + FileExists($Src & "\i386\WMP11.CAB") + FileExists($Src & "\CMPNENTS\MEDIACTR\I386\MEDIACTR.CAB") + 1) * 3
$Pat[6] = 0
DirCreate($tmp)
$NUM = 0
$MIN = 0
$MAX = 1
$CNT = 1
Page11_Task(_ReadStr("Live_0a"))
If @Compiled Then FileSetAttrib($Src & "\*", "-R", 1)
$NUM = -1
$MIN = 0
$MAX = 100
If Build_Section("Global.Patch") Then
$LOGS = $tmp & "\Logs_32"
DirCreate($LOGS)
Page11_Notify(_ReadStr("Live_0b"))
Edit_Section("Global.Patch")
EndIf
If FileExists($Src & "\AMD64") Then
$NUM = -1
$MIN = 0
$MAX = 100
$OS = "AMD64"
If Build_Section("X64.Patch", $Src & "\AMD64") Then
$LOGS = $tmp & "\Logs_64"
DirCreate($LOGS)
Page11_Notify("")
Page11_Task(_ReadStr("Live_0i"))
Edit_Section("X64.Patch", $Src & "\AMD64")
EndIf
EndIf
$CAB = "DRIVER.CAB"
$handle = FileFindFirstFile($Src & "\" & $OS & "\SP*.CAB")
If $handle <> -1 Then
While 1
$File = FileFindNextFile($handle)
If @error Then ExitLoop
$CAB = $File
WEnd
FileClose($handle)
EndIf
If FileExists($Src & "\" & $OS & "\" & $CAB) Then Live0_Patch($CAB)
$CAB = IniReadSection($Working & "\XPtsp.ini", "IE.Rename")
If IsArray($CAB) Then
If $CAB[0][0] > 0 Then
For $i = 1 To $CAB[0][0]
FileMove($res & "\" & $CAB[$i][0] & ".res", $res & "\" & $CAB[$i][1] & ".res", 1)
$x = Page9_FindItem($CAB[$i][0])
If $x > 0 Then $LV[$x][3] = $CAB[$i][1]
Next
EndIf
EndIf
If FileExists($Src & "\" & $OS & "\NR_IE7en.CAB") Then Live0_Patch("NR_IE7en.CAB")
If FileExists($Src & "\" & $OS & "\IE8.CAB") Then Live0_Patch("IE8.CAB")
$CAB = IniReadSection($Working & "\XPtsp.ini", "WMP.Rename")
If IsArray($CAB) Then
If $CAB[0][0] > 0 Then
For $i = 1 To $CAB[0][0]
FileMove($res & "\" & $CAB[$i][0] & ".res", $res & "\" & $CAB[$i][1] & ".res", 1)
$x = Page9_FindItem($CAB[$i][0])
If $x > 0 Then $LV[$x][3] = $CAB[$i][1]
Next
EndIf
EndIf
If FileExists($Src & "\" & $OS & "\WMP10.CAB") Then Live0_Patch("WMP10.CAB")
If FileExists($Src & "\" & $OS & "\WMP11.CAB") Then Live0_Patch("WMP11.CAB")
If $MCE = 1 Then
Page11_Notify("")
$NUM = -2
$MIN = 0
$MAX = 100
Page11_Task("Extracting contents of MEDIACTR.CAB")
Expand_CAB($Src & "\CMPNENTS\MEDIACTR\I386\MEDIACTR.CAB")
Build_Section("MEDIACTR.Patch", $mcabtmp)
$x = Edit_Section("MEDIACTR.Patch", $mcabtmp)
$NUM = -2
$MIN = 0
$MAX = 100
Build_Section("MCE_CAB.Copy", $mcabtmp, $xtra, 0)
$x += Copy_Section("MCE_CAB.Copy", $xtra, $mcabtmp)
If $x > 0 Then
Page11_Notify(_FormatStr("Main_23", "MEDIACTR.CAB"))
Build_Cab($Src & "\CMPNENTS\MEDIACTR\I386\MEDIACTR.CAB", $mcabtmp)
Else
Page11_Notify("MSG: " & _FormatStr("Live_0c", "MEDIACTR.CAB"))
EndIf
DirRemove($mcabtmp, 1)
EndIf
$NUM = -3 +($AUTO = 0)
$MIN = 0
$MAX = 100
Page11_Notify("")
If $AUTO = 1 Then
Page11_Notify(_ReadStr("Live_0d"))
FileMove($xtra & "\Setup.exe", $Src & "\", 1)
Else
FileDelete($xtra & "\Setup.exe")
EndIf
Page11_Task(_ReadStr("Live_0e"))
Build_Section("Extra.Copy", $Src & "\" & $OS, $xtra, 0)
Live0_ThemeFiles()
Compress_Section("Extra.Copy", $xtra, $Src & "\" & $OS, 1)
$NUM = -1
$CNT = 1 + $ORB +($DSI Or $DOTNET Or($REPATCH = 0 And $OEM)) +($REPATCH And $RESOURCES) +($MCE = 1) +($CAD And $THEME <> "Green")
$CNT +=($TTran And IniRead($xtra & "\Version.ini", "Extra", "Version", "1.0") >= "2.0")
$MIN = 99
$MAX = 100
Page11_Task("")
If $SP3 = 1 Then Live0_WBEMOC()
If $ORB = 1 Then Live0_Orb()
If $DSI = 1 Or $DOTNET = 1 Or($REPATCH = 0 And $OEM) Then Live0_SVCPACK()
If $GUI_RES <> "" Then Live0_Resolution()
If $MCE = 1 Then Live0_Patch_SMSS()
If $CAD And $THEME <> "Green" Then
Page11_Notify("Modifying CAD2009.CAB add-on for OS")
Expand_CAB($Working & "\Extra\Programs\" & $OS & "\CAD2009.CAB")
RunWait("Programs\Reshacker -extract """ & $res & "\logonui.exe.res"", """ & $mcabtmp & "\Background.bmp"", bitmap, 100,", $Working, @SW_HIDE)
Build_Cab($Working & "\Extra\Programs\" & $OS & "\CAD2009.CAB", $mcabtmp)
EndIf
If $TTran And IniRead($xtra & "\Version.ini", "Extra", "Version", "1.0") >= "2.0" Then
$S = "Seven " & _Iif($THEME = "NeonBlue", "Cyan", $THEME)
$T = IniReadSection($xtra & "\Programs\TrueTran.inf", "DestinationDirs")
If @error = 0 Then
For $i = 1 To $T[0][0]
If StringInStr($T[$i][1], $S) > 0 Then
Page11_Notify("Modifying TRUETRAN.CAB add-on for OS")
Expand_CAB($Working & "\Extra\Programs\" & $OS & "\TrueTran.CAB")
IniWrite($mcabtmp & "\Config.ini", "General", "Skin", $S)
Build_Cab($Working & "\Extra\Programs\" & $OS & "\TrueTran.CAB", $mcabtmp)
ExitLoop
EndIf
Next
EndIf
EndIf
If $RESOURCES And $BATCH = 0 Then
Page11_Notify(_ReadStr("Live_0h"))
_FileCopyWithProgress($THEME_FILE, $Src & "\i386\SVCPACK\" & $THEME & ".xptsp")
EndIf
Page11_Notify(_ReadStr("Main_19"))
$SYSOC = $Src & "\" & $OS & "\SYSOC.INF"
$Pack =(FileExists($SYSOC) = 0)
If $Pack Then $SYSOC = Expand_File($Src & "\" & $OS & "\SYSOC.IN_")
Live0_FileInfo()
$T = IniReadSection($xtra & "\Version.ini", "SYSOC")
If @error Then
If FileInstall("Version.ini", $tmp & "\Version.v1", 1) = 0 Then _Error(_FormatStr("Main_03", "Version.ini"))
$T = IniReadSection($xtra & "\Version.v1", "SYSOC")
If @error Then _Error(_FormatStr("Main_02", "SYSOC"))
EndIf
For $i = 1 To $T[0][0]
If Eval($T[$i][0]) = 1 Then
$S = StringSplit($T[$i][1] & "|", "|")
If $S[0] = 2 Then $S[2] = $S[1]
Live0_AddCab($S[1], $S[2])
EndIf
Next
If $Pack = False Then
FileMove($SYSOC, $tmp & "\SYSOC.INF", 1)
$SYSOC = $tmp & "\SYSOC.INF"
EndIf
Compress_File($SYSOC, $Src & "\" & $OS & "\SYSOC.INF")
If FileExists($Src & "\" & $OS & "\WINNT.SIF") Then
IniWrite($Src & "\" & $OS & "\WINNT.SIF", "Unattended", "DriverSigningPolicy", "Ignore")
IniWrite($Src & "\" & $OS & "\WINNT.SIF", "Unattended", "NonDriverSigningPolicy", "Ignore")
Else
If FileInstall("WINNT.SIF", $Src & "\" & $OS & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "WINNT.SIF"))
EndIf
If $USEPRO = 1 And $MCE = 1 Then
$S = $Src & "\i386\medctroc.inf"
If FileExists($S) = 0 Then $S = Expand_File($Src & "\i386\medctroc.in_", @TempDir)
$T = FileRead($S)
$T = Live0_ReplaceStr($T, 'HKLM, "Software\Microsoft\Windows\CurrentVersion\Media Center", "MCBliss"')
$T = Live0_ReplaceStr($T, 'HKLM, "Software\Microsoft\Windows\CurrentVersion\Policies\System", "InstallVisualStyle"')
$T = Live0_ReplaceStr($T, 'HKLM, "Software\Microsoft\Windows\CurrentVersion\Policies\System", "InstallTheme"')
$T = Live0_ReplaceStr($T, 'HKU,  ".DEFAULT\Software\Microsoft\windows\CurrentVersion\ThemeManager", "DllName"')
FileDelete($S)
FileWrite($S, $T)
Compress_File($S, $Src & "\i386\medctroc.in_")
FileDelete($S)
EndIf
DirRemove($mcabtmp, 1)
EndFunc
Func Live0_ReplaceStr($VAR, $Str)
Return StringReplace($VAR, $Str, ";" & $Str)
EndFunc
Func Live0_ThemeFiles()
If FileExists($xtra & "\luna.mst") Then _PECheckSum($xtra & "\luna.mst")
If FileExists($xtra & "\home_ss.dll") Then _PECheckSum($xtra & "\home_ss.dll")
If FileExists($xtra & "\blue_ss.dll") Then _PECheckSum($xtra & "\blue_ss.dll")
If FileExists($xtra & "\metal_ss.dll") Then _PECheckSum($xtra & "\metal_ss.dll")
If FileExists($xtra & "\royale.mst") Then _PECheckSum($xtra & "\royale.mst")
If FileExists($xtra & "\royale_ss.dll") Then _PECheckSum($xtra & "\royale_ss.dll")
EndFunc
Func Live0_Patch($CAB)
Local $Section = StringReplace($CAB, ".CAB", "")
$NUM = -3
$MIN = 0
$MAX = 100
Page11_Notify("")
Page11_Task(_FormatStr("Live_0f", $CAB))
Expand_CAB($Src & "\" & $OS & "\" & $CAB)
Page11_Task("", 0)
Build_Section($Section & ".Patch", $mcabtmp)
If Edit_Section($Section & ".Patch", $mcabtmp) Then
Page11_Task(_FormatStr("Main_23", $CAB))
Build_Cab($Src & "\" & $OS & "\" & $CAB, $mcabtmp)
Else
Page11_Task("MSG: " & _FormatStr("Live_0g", $CAB))
EndIf
DirRemove($mcabtmp, 1)
EndFunc
Func Live0_WBEMOC()
Local $TName = $Src & "\" & $OS & "\WBEMOC.INF", $Pack =(FileExists($TName) = 0)
If $Pack Then $TName = Expand_File($Src & "\" & $OS & "\WBEMOC.IN_")
If FileExists($TName) = 0 Then Return
Page11_Notify(_ReadStr("Main_30") & " WBEMOC.INF")
Local $File = FileRead($TName)
$File = StringReplace($File, "napclientprov.mof,napprov.mof", "napclientprov.mof")
$File = StringReplace($File, "napclientprov.mof", "napclientprov.mof,napprov.mof", 1)
$File = StringReplace($File, "napclientschema.mof,napschem.mof", "napclientschema.mof")
$File = StringReplace($File, "napclientschema.mof", "napclientschema.mof,napschem.mof", 1)
FileDelete($TName)
FileWrite($TName, $File)
FileClose($TName)
If $Pack = False Then
FileMove($Src & "\" & $OS & "\WBEMOC.INF", $tmp & "\WBEMOC.INF", 1)
$TName = $tmp & "\WBEMOC.INF"
EndIf
Compress_File($TName, $Src & "\" & $OS & "\WBEMOC.INF")
EndFunc
Func Live0_Orb()
If FileExists($Working & "\Pics\XPtspOrb.jpg") = 0 Then
$MAX += 1
Return Page11_Notify("MSG: " & _FormatStr("Live_1k", "XPtsp Orb"))
EndIf
Page11_Notify(_FormatStr("Main_24", "XPtsp Orb"))
FileCopy($Working & "\Pics\XPtspOrb.jpg", $xtra & "\", 1)
_ImageToBMP($xtra & "\XPtspOrb.jpg")
Compress_File($xtra & "\XPtspOrb.bmp", $Src & "\" & $OS & "\XPtspOrb.bmp")
Live0_Update_INF($Src & "\" & $OS & "\TXTSETUP.SIF", "SourceDisksFiles", "xptsporb.bmp", "1,,,,,,,2,0,0 ")
Live0_Update_INF($Src & "\" & $OS & "\DOSNET.INF", "Files", "d1,xptsporb.bmp", "")
Local $File = $Src & "\" & $OS & "\hivedef.inf", $Lines = FileRead($File)
FileClose($File)
$Lines = StringReplace($Lines, "HKCU,""Control Panel\Desktop"",""Wallpaper"",0x00000000,""%NONE%""", _
"HKCU,""Control Panel\Desktop"",""Wallpaper"",0x00000000,""%SystemRoot%\System32\xptsporb.bmp""", 1)
$Lines = StringReplace($Lines, "HKCU,""Control Panel\Desktop"",""WallpaperStyle"",0x00000000,""2""", _
"HKCU,""Control Panel\Desktop"",""WallpaperStyle"",0x00000000,""0""", 1)
$Lines = StringReplace($Lines, "HKCU,""Control Panel\Colors"",""Background"",0x00000000,""58 110 165""", _
"HKCU,""Control Panel\Colors"",""Background"",0x00000000,""0 0 0""", 1)
FileDelete($File)
FileWrite($File, $Lines)
FileClose($File)
EndFunc
Func Live0_SVCPACK()
Local $T, $TName = $Src & "\" & $OS & "\SVCPACK.INF", $Pack =(FileExists($TName) = 0)
Page11_Notify(_ReadStr("Main_30") & " SVCPACK.INF")
If $Pack Then $TName = Expand_File($Src & "\" & $OS & "\SVCPACK.IN_")
If FileExists($TName) = 0 Then
$CNT += 1
Return Page11_Notify("MSG: " & _FormatStr("Main_20", "SVCPACK.INF"))
EndIf
Local $File = FileRead($TName)
DirCreate($Src & "\" & $OS & "\SVCPACK")
If $REPATCH = 1 And FileExists($OUTPUT & "\XPtsp_v" & FileGetVersion(@ScriptFullPath) & "_GUI.exe") Then
FileCopy($OUTPUT & "\XPtsp_v" & FileGetVersion(@ScriptFullPath) & "_GUI.exe", $Src & "\" & $OS & "\SVCPACK\XPtspGUI.exe", 1)
$File = StringReplace($File, "XPtspGUI /SVCPACK" & @CRLF, "")
$File = StringReplace($File, "[SetupHotfixesToRun]", "[SetupHotfixesToRun]" & @CRLF & "XPtspGUI /SVCPACK")
EndIf
If $DSI = 1 Then
FileCopy($xtra & "\SVCPACK\DriveSpace.exe", $Src & "\" & $OS & "\SVCPACK\", 1)
$File = StringReplace($File, "DriveSpace /THEME:XPtsp /SVCPACK" & @CRLF, "")
$File = StringReplace($File, "[SetupHotfixesToRun]", "[SetupHotfixesToRun]" & @CRLF & "DriveSpace /THEME:XPtsp /SVCPACK")
EndIf
If $DOTNET = 1 Then
FileCopy($xtra & "\SVCPACK\dotnet2.exe", $Src & "\" & $OS & "\SVCPACK\", 1)
$File = StringReplace($File, "DotNet2" & @CRLF, "")
$File = StringReplace($File, "[SetupHotfixesToRun]", "[SetupHotfixesToRun]" & @CRLF & "DotNet2")
EndIf
If $REPATCH = 0 And $OEM Then
FileCopy($Working & "\XPtsp.exe", $Src & "\" & $OS & "\SVCPACK\", 1)
$File = StringReplace($File, "XPtsp /OEMINFO" & @CRLF, "")
$File = StringReplace($File, "[SetupHotfixesToRun]", "[SetupHotfixesToRun]" & @CRLF & "XPtsp /OEMINFO")
EndIf
FileDelete($TName)
FileWrite($TName, $File)
FileClose($TName)
If $Pack = False Then
FileMove($Src & "\" & $OS & "\SVCPACK.INF", $tmp & "\SVCPACK.INF", 1)
$TName = $tmp & "\SVCPACK.INF"
EndIf
Compress_File($TName, $Src & "\" & $OS & "\SVCPACK.INF")
EndFunc
Func Live0_Resolution()
Page11_Notify(_FormatStr("Main_18", $GUI_RES) & "...")
Local $tres = StringSplit($GUI_RES, "x"), $File = $Src & "\" & $OS & "\HIVESYS.INF"
Local $Lines = FileRead($File)
FileClose($File)
Local $KEY = "HKLM,""SYSTEM\CurrentControlSet\Services\VgaSave\Device0"","
Local $Str = $KEY & """DefaultSettings.BitsPerPel"",0x00010001,32"
If StringInStr($Lines, $Str) <> 0 Then $Lines = _Trim3Lines($Lines, $Str)
$Lines = StringReplace($Lines, $KEY & """VgaCompatible"",0x00010001,1", _
$KEY & """VgaCompatible"",0x00010001,1" & @CRLF & _
$KEY & """DefaultSettings.BitsPerPel"",0x00010001,32" & @CRLF & _
$KEY & """DefaultSettings.XResolution"",0x00010001," & $tres[1] & @CRLF & _
$KEY & """DefaultSettings.YResolution"",0x00010001," & $tres[2], 1)
$KEY = "HKLM,""SYSTEM\CurrentControlSet\Control\Video\{23A77BF7-ED96-40EC-AF06-9B1F4867732A}\0000"","
$Str = $KEY & """DefaultSettings.BitsPerPel"",0x00010001,32"
If StringInStr($Lines, $Str) <> 0 Then $Lines = _Trim3Lines($Lines, $Str)
$Lines = StringReplace($Lines, $KEY & """VgaCompatible"",0x00010001,1", _
$KEY & """VgaCompatible"",0x00010001,1" & @CRLF & _
$KEY & """DefaultSettings.BitsPerPel"",0x00010001,32" & @CRLF & _
$KEY & """DefaultSettings.XResolution"",0x00010001," & $tres[1] & @CRLF & _
$KEY & """DefaultSettings.YResolution"",0x00010001," & $tres[2], 1)
FileDelete($File)
FileWrite($File, $Lines)
FileClose($File)
EndFunc
Func Live0_Patch_SMSS()
Local $S = $Src & "\" & $OS & "\SYSTEM32\SMSS.EXE", $Pack =(FileExists($S) = 0)
If $Pack Then $S = Expand_File($Src & "\" & $OS & "\SYSTEM32\SMSS.EX_")
If $S = "" Then Return Page11_Notify(_FormatStr("Main_03", "SMSS.EXE"))
$CNT += 1
Page11_Notify(_FormatStr("Main_35", "SYSTEM32\SMSS.EXE"))
Local $handle = FileOpen($S, 16)
Local $VAR = FileRead($handle)
FileClose($handle)
Local $DST = "4D0065006400690061002000430065006E007400650072002000530065007400750070"
$VAR = StringReplace($VAR, "500072006F00660065007300730069006F006E0061006C002000530065007400750070", $DST)
$VAR = StringReplace($VAR, "48006F006D0065002000450064006900740069006F006E002000530065007400750070", $DST)
FileDelete($S)
$handle = FileOpen($S, 16 + 2)
FileWrite($handle, $VAR)
FileClose($handle)
_PECheckSum($S)
If $Pack Then Compress_File($S, $Src & "\" & $OS & "\SYSTEM32\SMSS.EXE")
EndFunc
Func Live0_AddCab($TINF, $COM = "")
If $COM = "" Then $COM = $TINF
If FileExists($xtra & "\Programs\i386\" & $TINF & ".CAB") = 0 Then Return
If FileExists($xtra & "\Programs\" & $TINF & ".INF") = 0 Then Return
FileCopy($xtra & "\Programs\i386\" & $TINF & ".CAB", $Src & "\i386\", 1)
Compress_File($xtra & "\Programs\" & $TINF & ".INF", $Src & "\" & $OS & "\" & $TINF & ".INF")
Live0_Update_INF($SYSOC, "Components", $COM, "ocgen.dll,OcEntry," & $TINF & ".inf,HIDE,7")
Live0_Update_INF($Src & "\" & $OS & "\TXTSETUP.SIF", "SourceDisksFiles", $TINF & ".INF", "1,,,,,,,20,0,0", $TINF & ".Cab", "1,,,,,,_x,,3,3")
Live0_Update_INF($Src & "\" & $OS & "\DOSNET.INF", "Files", "d1," & $TINF & ".inf", "", "d1," & $TINF & ".Cab", "")
EndFunc
Func Live0_Update_INF($File, $Section, $KEY, $Value, $Key2 = "", $Value2 = "")
Local $Lines = FileRead($File), $Exp
FileClose($File)
$Lines = StringReplace($Lines, $KEY & "=" & $Value, "")
$Exp = $KEY & _Iif($Value <> "", "=" & $Value, "")
If $Key2 <> "" Then $Exp = $Exp & @CRLF & $Key2 & _Iif($Value2 <> "", "=" & $Value2, "")
$Lines = StringReplace($Lines, $Exp & @CRLF, "")
$Lines = StringReplace($Lines, "[" & $Section & "]", "[" & $Section & "]" & @CRLF & $Exp, 1)
FileDelete($File)
FileWrite($File, $Lines)
FileClose($File)
EndFunc
Func Live0_FileInfo()
IniWrite($INF, "Strings", "Theme", " """ & $THEME & """")
IniWrite($INF, "Strings", "BootScr", " """ & $BOOTSCR & """")
IniWrite($INF, "Strings", "TaskMgr", " """ & $TASKMGR & """")
IniWrite($INF, "Strings", "Lang", " """ & $LANG & """")
IniWrite($INF, "Strings", "OemGen", " """ & $OEM & """")
IniWrite($INF, "Strings", "Palette", " """ & $Palette & """")
IniWrite($INF, "Strings", "Built_By", " """ & FileGetVersion(@ScriptFullPath) & """")
IniWrite($INF, "Strings", "Full_Pack", " """ & $FullPack & """")
If $REPATCH = 0 Then IniDelete($INF, "XPtspCom", "ProfileItems")
If $Live = 0 Then
Compress_File($INF, $Src & "\" & $OS & "\XPtspCom.INF")
Live0_Update_INF($SYSOC, "Components", "XPtspCom", "ocgen.dll,OcEntry,XPtspCom.inf,HIDE,7")
Live0_Update_INF($Src & "\" & $OS & "\TXTSETUP.SIF", "SourceDisksFiles", "XPtspCom.INF", "1,,,,,,,20,0,0")
Live0_Update_INF($Src & "\" & $OS & "\DOSNET.INF", "Files", "d1,XPtspCom.inf", "")
Else
If $ORB = 0 Then IniDelete($INF, "XPtsp", "DelReg")
FileCopy($INF, @WindowsDir & "\INF\", 1)
EndIf
EndFunc
Func Live1_Run()
Local $i, $j, $S, $TEMP, $S1, $S2, $OLD, $T, $Str
Local $PFRO = RegRead($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations")
$Pat[7] = $SYSREST + 3 +(@OSArch <> "x86")
$Pat[6] = 0
FileSetAttrib(@ProgramFilesDir & "\Windows Media Player\*", "-RHS")
FileSetAttrib(@WindowsDir & "\system32\*.msc", "-RHS")
If $WALL = 1 Then
FileMove($res & "\BLISS.JPG", $xtra & "\", 1)
_ImageToBMP($xtra & "\BLISS.JPG")
If FileExists($xtra & "\MCBLISS.JPG") Then _ImageToBMP($xtra & "\MCBLISS.JPG")
EndIf
$NUM = 0
$CNT = 1
$MIN = 0
$MAX = 10
If $SYSREST = 1 Then
Page11_Task(_ReadStr("Live_1a"))
_SR_CreateRestorePoint("XPtsp " & _Iif($Live = 1, _ReadStr("Main_25"), _Iif($Live = 5, _ReadStr("Main_26"), _ReadStr("Main_27"))))
EndIf
IniWriteSection($Working & "\XPtsp.ini", "Live.Dest", $List)
If $Live < 2 Then
$NUM = -1
Page11_Notify(_ReadStr("Live_1b"))
DirCreate($Src)
FileCopy($Working & "\XPtsp.ini", $Src & "\", 1)
FileCopy($Working & "\XPtsp.exe", $Src & "\", 1)
DirCopy($Working & "\Programs", $Src & "\Programs", 1)
DirCopy($Working & "\Languages", $Src & "\Languages", 1)
DirCopy($Working & "\Pics", $Src & "\Pics", 1)
Else
FileCopy($Working & "\XPtsp.exe", $Src & "\", 1)
EndIf
If $SYSREST = 1 Or $Live < 2 Then Page11_Notify("")
RegWrite($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "AllowProtectedRenames", "REG_DWORD", 1)
$LOGS = $tmp & "\Logs_32"
DirCreate($LOGS)
Live1_ProcessList($List, "Live_1c", $Src & "\Backup")
If @OSArch <> "x86" Then
$T = $List
For $i = 1 To $T[0][0]
If StringInStr($T[$i][1], "UXTHEME.DLL") Then $T[$i][1] = ""
If StringInStr($T[$i][1], @SystemDir) = 0 And StringInStr($T[$i][1], @ProgramFilesDir) = 0 Then $T[$i][1] = ""
$T[$i][1] = StringReplace($T[$i][1], @SystemDir, @WindowsDir & "\SysNative")
$T[$i][1] = StringReplace($T[$i][1], @ProgramFilesDir, StringReplace(@ProgramFilesDir, " (x86)", ""))
Next
$OS = "AMD64"
Page11_Notify("")
$LOGS = $tmp & "\Logs_64"
DirCreate($LOGS)
Live1_ProcessList($T, "Live_1o", $Src & "\Backup64")
EndIf
$CNT = 0
If $REP[0][0] > 0 Then
For $i = 1 To $REP[0][0]
If FileExists($REP[$i][1]) And FileExists($xtra & "\" & $REP[$i][0]) Then $CNT += 1
Next
EndIf
$NUM = -2
$MIN = 0
$MAX = 100
Page11_Task("")
If $CNT > 0 Then
$CNT -= 2
Page11_Notify(_ReadStr("Live_1e"))
Live1_ReplaceList($REP, $xtra, 1)
EndIf
Local $KEY = $HKLM & "\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
RegWrite($SET & "\Settings", "LogonUI", "REG_SZ", RegRead($KEY, "UIHost"))
RegWrite($KEY, "UIHost", "REG_SZ", @SystemDir & "\logonui.exe")
$NUM = -1
$CNT = $BOOT + $AERO + $DSI + $DOTNET + $QTBAR + $UBER + $TASKTIPS + $TBar
$CNT += $TTran + $ViStart + $CAD + $FLIP + $OEM + 1
$MIN = 0
$MAX = 100
Page11_Task("")
If $BOOT = 1 Then
$T = _Iif(@OSArch <> "x86", @WindowsDir & "\SysNative", @SystemDir)
If FileMove($T & "\NTOSKRNL.EXE.xptsp", $T & "\TSP_KRNL.EXE", 1) Then Live1_EnableBoot()
EndIf
If $Live = 1 Then
If $DSI = 1 Then
Page11_Notify(_FormatStr("Live_1j", "Drive Space Indicator") & "...")
RunWait($xtra & "\SVCPACK\DriveSpace /SVCPACK /THEME:XPtsp")
$T = @error
If $T Then Page11_Notify(_ReadStr("Main_48") & ": " & _FormatStr("Live_1k", "Drive Space Indicator"))
RegWrite($SET & "\Settings", "DrvSpace", "REG_DWORD", $T)
EndIf
If $DOTNET = 1 And FileExists($xtra & "\SVCPACK\dotnet2.exe") Then
Page11_Notify(_FormatStr("Live_1j", ".NET Framework v2.0") & "...")
RunWait($xtra & "\SVCPACK\dotnet2.exe")
$T = @error
If $T Then Page11_Notify(_ReadStr("Main_48") & ": " & _FormatStr("Live_1k", ".NET Framework v2.0"))
If Live1_DotNet2_Installed() = 0 Then Page11_Notify(_FormatStr("Live_1l", ".NET Framework v2.0"))
EndIf
If $AERO Then RunWait("regedit /e """ & $Src & "\Backup\Cursors.reg"" ""HKCU\Control Panel\Cursors""", $Working, @SW_HIDE)
$T = IniReadSection($xtra & "\Version.ini", "SYSOC")
If @error Then
If FileInstall("Version.ini", $tmp & "\Version.v1", 1) = 0 Then _Error(_FormatStr("Main_03", "Version.ini"))
$T = IniReadSection($xtra & "\Version.v1", "SYSOC")
If @error Then _Error(_FormatStr("Main_02", "SYSOC"))
EndIf
For $i = 1 To $T[0][0]
If Eval($T[$i][0]) = 1 Then
$j = IniRead($xtra & "\Version.ini", "Addons", $T[$i][0], "")
If $j = "" Then ContinueLoop
$j = StringSplit($j, "|")
$S = StringSplit($T[$i][1] & "|", "|")
If $S[0] = 2 Then $S[2] = $S[1]
Live1_RunINF($T[$i][0], $j[1], $S[1], $S[2])
EndIf
Next
If $CAD = 1 Then
RunWait("Programs\Reshacker -extract """ & $res & "\logonui.exe.res"", """ & @ProgramFilesDir & "\cad 2009\Background.bmp"", bitmap, 100,", $Working, @SW_HIDE)
EndIf
If $OEM = 1 Then
Page11_Notify(_ReadStr("Live_1m"))
OEM_Info()
RegWrite($SET & "\Settings", "OemInfo", "REG_DWORD", $T)
EndIf
Page11_Notify(_ReadStr("Live_1n"))
If $VISUAL = 1 Then
RunWait("regedit /e """ & $Src & "\Backup\vssettings.reg"" ""HKCU\Software\Microsoft\Windows\CurrentVersion\ThemeManager""")
RunWait("regedit /e """ & $Src & "\Backup\WinMetrics.reg"" ""HKCU\Control Panel\Desktop\WindowMetrics""")
$S = $HKCU & "\Software\Microsoft\Windows\CurrentVersion\ThemeManager"
RegWrite($S, "WCreatedUser", "REG_SZ", "1")
RegWrite($S, "LoadedBefore", "REG_SZ", "0")
RegWrite($S, "ThemeActive", "REG_SZ", "1")
RegWrite($S, "ColorName", "REG_SZ", "NormalColor")
RegWrite($S, "SizeName", "REG_SZ", "NormalSize")
RegWrite($S, "DllName", "REG_SZ", @WindowsDir & "\resources\Themes\" & _Iif($MCE = 1, "Royale\Royale.msstyles", "Luna\Luna.msstyles"))
EndIf
If $SCRSAVER = 1 Then
RegWrite($SET, "ScrSaver", "REG_SZ", RegRead($HKCU & "\Control Panel\Desktop", "SCRNSAVE.EXE"))
RegWrite($HKCU & "\Control Panel\Desktop", "SCRNSAVER.EXE", "REG_SZ", @SystemDir & "\LOGON.SCR")
EndIf
If $WALL = 1 Then
$S = RegRead($HKLM & "\Control Panel\Desktop", "ConvertedWallpaper")
If $S <> @WindowsDir & "\Resources\Themes\Royale\Energy Bliss.jpg" Then
RegWrite($SET, "Wallpaper", "REG_SZ", RegRead($HKCU & "\Control Panel\Desktop", "Wallpaper"))
RegWrite($SET, "TileWallpaper", "REG_SZ", RegRead($HKCU & "\Control Panel\Desktop", "TileWallpaper"))
RegWrite($SET, "WallPaperStyle", "REG_SZ", RegRead($HKCU & "\Control Panel\Desktop", "WallPaperStyle"))
RegWrite($HKCU & "\Control Panel\Desktop", "Wallpaper", "REG_SZ", $BACKGROUND)
RegWrite($HKCU & "\Control Panel\Desktop", "TileWallpaper", "REG_SZ", "0")
RegWrite($HKCU & "\Control Panel\Desktop", "WallPaperStyle", "REG_SZ", "2")
EndIf
EndIf
DirCreate($Src & "\Archive")
If $BATCH = 0 Then _FileCopyWithProgress($THEME_FILE, $Src & "\Archive\" & $THEME & ".xptsp")
EndIf
Live0_FileInfo()
_Registry_Info()
RunWait("rundll32 advpack.dll,LaunchINFSection XPtspCom.inf,Shortcut")
If @OSArch <> "x86" Then
$Str = RegRead($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations")
$Str = StringReplace($Str, $PFRO, "")
$Str = StringReplace($Str, @SystemDir & "\", @WindowsDir & "\SysWOW64\")
$Str = StringReplace($Str, @WindowsDir & "\SysNative\", @WindowsDir & "\System32\")
RegWrite($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations", "REG_MULTI_SZ", $PFRO & $Str)
EndIf
If $INF = $tmp & "\XPtspCom.INF" Then FileMove($INF, @WindowsDir & "\INF\XPtspCom.INF", 1)
EndFunc
Func Live1_ProcessList($List, $MSG, $Backup = "")
Local $TEMP, $j, $i, $S
If $Backup = "" Then $Backup = $Src & "\Backup"
DirCreate($Backup)
$NUM = -1
$CNT = 1
$MIN = 0
$MAX = 100
Page11_Task(_ReadStr($MSG))
$CNT = 1
For $i = 1 To $List[0][0]
$S = $List[$i][1]
If FileExists($S) And FileExists($res & "\" & $List[$i][0] & ".res") Then
$TEMP = Page9_FindItem($List[$i][0])
$j = $LV[$TEMP][6] & $LV[$TEMP][5]
If $j = "01" Or $j = "10" Or $LV[$TEMP][5] = "2" Or $LV[$TEMP][5] = "3" Then
$CNT += 1
Else
$List[$i][1] = ""
EndIf
Else
$List[$i][1] = ""
EndIf
Next
For $i = 1 To $List[0][0]
If $List[$i][1] <> "" Then
$TEMP = Page9_FindItem($List[$i][0])
$j = $LV[$TEMP][6] & $LV[$TEMP][5]
If $j = "01" Or $j = "13" Or $j = "03" Then
If FileExists($Backup & "\" & $List[$i][0]) = 0 Then FileCopy($List[$i][1], $Backup & "\" & $List[$i][0], 1)
FileCopy($Backup & "\" & $List[$i][0], $List[$i][1] & ".xptsp", 1)
Edit_File($List[$i][0], $List[$i][1] & ".xptsp")
Live1_ReplaceFile($List[$i][1] & ".xptsp", $List[$i][1])
ElseIf $j = "10" Then
If FileExists($Backup & "\" & $List[$i][0]) = 0 Then ContinueLoop
Page11_Notify("- " & _ReadStr("Main_28") & " " & $List[$i][0])
FileMove($Backup & "\" & $List[$i][0], $List[$i][1] & ".xptsp", 1)
Live1_ReplaceFile($List[$i][1] & ".xptsp", $List[$i][1])
ElseIf $j = "12" Or $j = "02" Then
FileCopy($List[$i][1], $List[$i][1] & ".xptsp", 1)
FileCopy($List[$i][1], $Backup & "\" & $List[$i][0], 1)
Edit_File($List[$i][0], $List[$i][1] & ".xptsp")
Live1_ReplaceFile($List[$i][1] & ".xptsp", $List[$i][1])
EndIf
EndIf
Next
EndFunc
Func Live1_RunINF($KEY, $DESC, $TINF, $COM = "")
If $COM = "" Then $COM = $TINF
If FileExists($xtra & "\Programs\i386\" & $TINF & ".CAB") = 0 Then Return
If FileExists($xtra & "\Programs\" & $TINF & ".INF") = 0 Then Return
Page11_Notify(_FormatStr("Live_1j", $DESC) & "...")
FileCopy($xtra & "\Programs\" & $TINF & ".inf", @WindowsDir & "\INF\", 1)
RunWait("rundll32 advpack.dll,LaunchINFSection " & $TINF & ".inf," & $COM & ",1", $xtra & "\Programs")
Local $T = @error
If $T Then Page11_Notify(_ReadStr("Main_48") & ": " & _FormatStr("Live_1k", $TINF))
RegWrite($SET & "\Settings", $KEY, "REG_DWORD", $T)
EndFunc
Func Live1_ReplaceList(ByRef $Files, $From, $Backup = 0)
If IsArray($Files) = 0 Then Return
If $Files[0][0] = 0 Then Return
For $i = 1 To $Files[0][0]
If FileExists($From & "\" & $Files[$i][0]) = 0 Or FileExists($Files[$i][1]) = 0 Then ContinueLoop
If $Backup = 1 And FileExists($Src & "\Backup\" & $Files[$i][0]) Then ContinueLoop
Page11_Notify("- " & _Iif($Live = 5, _ReadStr("Main_28"), _ReadStr("Main_29")) & " " & $Files[$i][0])
If $Backup = 1 Then FileCopy($Files[$i][1], $Src & "\Backup\" & $Files[$i][0], 1)
FileCopy($From & "\" & $Files[$i][0], $Files[$i][1] & ".xptsp", 1)
Live1_ReplaceFile($Files[$i][1] & ".xptsp", $Files[$i][1])
Next
EndFunc
Func Live1_ReplaceFile($Src, $DEST)
If FileExists($Src) = 0 Or FileExists($DEST) = 0 Then Return
Local $Short = StringReplace(StringMid($Src, StringInStr($Src, "\", 0, -1) + 1), ".xptsp", "")
If $Short = "TSP_KRNL.EXE" Or $Short = "NTOSKRNL.EXE" Then Return
If $Short = "NTKRNLPA.EXE" Or $Short = "NTKRNLMP.EXE" Or $Short = "NTKRPAMP.EXE" Then Return FileDelete($Src)
If FileExists(@SystemDir & "\dllcache\" & $Short) Then
FileCopy($Src, @SystemDir & "\dllcache\" & $Short & ".xptsp", 1)
Live1_ReplaceAtReboot(@SystemDir & "\dllcache\" & $Short & ".xptsp", @SystemDir & "\dllcache\" & $Short)
EndIf
Live1_ReplaceAtReboot($Src, $DEST)
EndFunc
Func Live1_ReplaceAtReboot($new_file, $to_replace)
Local $Str = RegRead($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations")
If $Str <> "" Then $Str = $Str & @LF
$Str = $Str & "\??\" & $new_file & @LF & "!\??\" & $to_replace
RegWrite($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations", "REG_MULTI_SZ", $Str)
If $REBOOT = 0 Then $REBOOT = 1
EndFunc
Func Live1_EnableBoot()
Local $S1 = IniRead(@HomeDrive & "\Boot.ini", "boot loader", "default", "")
If $S1 = "" Then
Page11_Notify(_ReadStr("Main_48") & ": " & _FormatStr("Live_1h", "BOOT.INI", @HomeDrive) & "!")
Else
Local $S2 = IniRead(@HomeDrive & "\Boot.ini", "operating systems", $S1, "")
$S2 = StringReplace(StringReplace($S2, "/bootlogo", ""), "/noguiboot", "")
If StringInStr($S2, "/kernel=tsp_krnl.exe") = 0 Then
Page11_Notify(_ReadStr("Live_1i"))
Local $S = StringSplit($S2, " ")
$S2 = ""
For $i = 1 To $S[0]
If StringLeft($S[$i], 8) <> "/kernel=" Then $S2 = $S2 & _Iif($S2 <> "", " ", "") & $S[$i]
Next
Local $T = FileGetAttrib(@HomeDrive & "\BOOT.INI")
FileSetAttrib(@HomeDrive & "\BOOT.INI", "-RHS")
IniWrite(@HomeDrive & "\Boot.ini", "operating systems", $S1, $S2 & " /kernel=tsp_krnl.exe")
FileSetAttrib(@HomeDrive & "\BOOT.INI", $T)
EndIf
EndIf
EndFunc
Func Live1_DotNet2_Installed()
Local $T = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\Policy\v2.0", "50727")
If @error = 0 Then $DOTNET =($T = "50727-50727")
Return $DOTNET
EndFunc
Func Live5_Run()
Local $S, $S1, $S2, $T
Dim $LV[UBound($List) + 1][10]
For $i = 1 To $List[0][0]
$LV[$i][3] = $List[$i][1]
$LV[$i][5] = 0
$LV[$i][6] = FileExists($Src & "\Backup\" & $List[$i][0])
Next
GUICtrlSetState($Pat[9], $GUI_DISABLE)
RegWrite($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "AllowProtectedRenames", "REG_DWORD", 1)
$NUM = -1
$CNT = $List[0][0] + $REP[0][0]
$MIN = 0
$MAX = 100
Page11_Notify(_ReadStr("Live_5a"))
Live1_ReplaceList($List, $Src & "\Backup", 0)
Live1_ReplaceList($REP, $Src & "\Backup", 0)
Page11_Notify("")
$NUM = 0
$CNT = 4
$MIN = 0
$MAX = 100
$S1 = IniRead(@HomeDrive & "\Boot.ini", "boot loader", "default", "")
If $S1 <> "" Then
$S2 = IniRead(@HomeDrive & "\Boot.ini", "operating systems", $S1, "")
If StringInStr($S2, "/kernel=tsp_krnl.exe") = 0 Then
Page11_Notify(_ReadStr("Live_5c"))
Live1_ReplaceAtReboot(@SystemDir & "\TSP_KRNL.EXE", "")
$S = StringSplit($S2, " ")
$S2 = ""
For $i = 1 To $S[0]
If StringLeft($S[$i], 8) <> "/kernel=" Then $S2 = $S2 & _Iif($S2 <> "", " ", "") & $S[$i]
Next
$T = FileGetAttrib(@HomeDrive & "\BOOT.INI")
FileSetAttrib(@HomeDrive & "\BOOT.INI", "-RHS")
IniWrite(@HomeDrive & "\Boot.ini", "operating systems", $S1, $S2)
FileSetAttrib(@HomeDrive & "\BOOT.INI", $T)
EndIf
EndIf
Page11_Notify(_ReadStr("Live_5b"))
$i = RegRead($HKCU & "\SOFTWARE\XPtsp", "LogonUI")
If @error = 0 And $i <> "" Then RegWrite($HKLM & "\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "UIHost", "REG_SZ", $i)
$i = RegRead($HKCU & "\SOFTWARE\XPtsp", "ScrSaver")
If @error = 0 And $i <> "" Then RegWrite($HKCU & "\Control Panel\Desktop", "SCRNSAVE.EXE", "REG_SZ", $i)
$i = RegRead($HKCU & "\SOFTWARE\XPtsp", "Wallpaper")
If @error = 0 And $i <> "" Then
RegWrite($HKCU & "\Control Panel\Desktop", "Wallpaper", "REG_SZ", $i)
RegWrite($HKCU & "\Control Panel\Desktop", "TileWallpaper", "REG_SZ", RegRead($HKCU & "\SOFTWARE\XPtsp", "TileWallpaper"))
RegWrite($HKCU & "\Control Panel\Desktop", "WallPaperStyle", "REG_SZ", RegRead($HKCU & "\SOFTWARE\XPtsp", "WallPaperStyle"))
EndIf
If FileExists($Src & "\Backup\vssettings.reg") Then
RunWait("regedit /s """ & $Src & "\Backup\vssettings.reg""")
RunWait("regedit /s """ & $Src & "\Backup\WinMetrics.reg""")
EndIf
If FileExists($Src & "\Backup\Cursors.reg") Then RunWait("regedit /s """ & $Src & "\Backup\Cursors.reg""")
Live5_Folder()
EndFunc
Func Live5_Folder()
Page11_Notify(_ReadStr("Live_5d"))
If FileInstall("XPtspCom.INF", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "XPtspCom.INF"))
RegDelete($HKCR & "\{8DE84F36-F390-4727-BE44-3E42DD2A3E35}")
RegDelete($HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{8DE84F36-F390-4727-BE44-3E42DD2A3E35}")
RegDelete($HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\XPtsp")
RegDelete($HKLM & "\Software\XPtsp")
RegDelete($HKCU & "\Software\XPtsp")
RegDelete($HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", "XPtsp Repatch")
FileCopy($Src & "\XPtsp.exe", @TempDir & "\", 1)
FileCopy($Src & "\XPtsp.log", @TempDir & "\", 1)
Local $KEY = $HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"
RegWrite($KEY & "\998", "", "REG_SZ", """" & @TempDir & "\XPtsp.exe"" /CACHE:5")
RegWrite($KEY & "\999", "", "REG_SZ", @ComSpec & " /c rd /s /q """ & $Src & """")
$Src = @TempDir
EndFunc
Func Page0_Build()
If @Compiled And FileExists(EnvGet("InstallDir") & "\i386") Then
$Src = EnvGet("InstallDir")
$Live = 0
Else
$Src = RegRead($SET, "LastBrowseSource")
EndIf
If @Compiled Then
SplashImageOn("", $Working & "\Pics\XPtspOrb.jpg", 354, 354, -1, -1, 1)
Sleep(3000)
SplashOff()
EndIf
If $CMD_NA <> "" Then
$CMD_NA = StringSplit($CMD_NA, " ")
If $CMD_NA[0] > 0 Then
For $i = 1 To $CMD_NA[0]
If StringLeft($CMD_NA[$i], 9) = "/TASKMAN:" Then
$TASKMGR = StringReplace($CMD_NA[$i], "/TASKMAN:", "")
If IniRead($Working & "\XPtsp.ini", "_TASKMGR.EXE", $TASKMGR, "") = "" Then _Error(_ReadStr("Main_05"))
ElseIf StringLeft($CMD_NA[$i], 9) = "/BOOTSCR:" Then
$BOOTSCR = StringReplace($CMD_NA[$i], "/BOOTSCR:", "")
If $BOOTSCR <> "Green" And $BOOTSCR <> "Blue" And $BOOTSCR <> "Red" And $BOOTSCR <> "Purple" Then _Error(_ReadStr("Main_06"))
ElseIf StringLeft($CMD_NA[$i], 6) = "/LANG:" Then
$LANG = StringReplace($CMD_NA[$i], "/LANG:", "")
If FileExists("Languages\" & $LANG & ".ini") = 0 Then _Error(_ReadStr("Main_07"))
ElseIf $CMD_NA[$i] = "/ONLINE" Then
$ONLINE = 1
ElseIf $CMD_NA[$i] = "/OFFLINE" Then
$ONLINE = 0
ElseIf $CMD_NA[$i] = "/NOREBOOT" Then
$REBOOT = -1
ElseIf $CMD_NA[$i] = "/REBOOT" Then
$REBOOT = -2
ElseIf $CMD_NA[$i] = "/NORESTORE" Then
$SYSREST = 0
ElseIf $CMD_NA[$i] = "/NOHEX" Then
$PATCH = 0
$UXTHEME = 0
$SETUPAPI = 0
$SFC = 0
ElseIf $CMD_NA[$i] = "/NOUXTHEME" Then
$UXTHEME = 0
ElseIf $CMD_NA[$i] = "/NOSETUPAPI" Then
$SETUPAPI = 0
ElseIf $CMD_NA[$i] = "/SFC" Then
$SFC = 1
ElseIf $CMD_NA[$i] = "/NOSFC" Then
$SFC = 0
ElseIf $CMD_NA[$i] = "/NOFILES" Then
$Files = 0
$EXE = 0
$DLL = 0
$CPL = 0
$OCX = 0
$AT = 0
$OE = 0
$IE = 0
$WMP = 0
$RDP = 0
$MCE = 0
$OOBE = 0
ElseIf $CMD_NA[$i] = "/NOEXE" Then
$EXE = 0
ElseIf $CMD_NA[$i] = "/NODLL" Then
$DLL = 0
ElseIf $CMD_NA[$i] = "/NOCPL" Then
$CPL = 0
ElseIf $CMD_NA[$i] = "/NOOCX" Then
$OCX = 0
ElseIf $CMD_NA[$i] = "/NOAT" Then
$AT = 0
ElseIf $CMD_NA[$i] = "/NOOE" Then
$OE = 0
ElseIf $CMD_NA[$i] = "/NOIE" Then
$IE = 0
ElseIf $CMD_NA[$i] = "/NOWMP" Then
$WMP = 0
ElseIf $CMD_NA[$i] = "/NORDP" Then
$RDP = 0
ElseIf $CMD_NA[$i] = "/NOMCE" Then
$MCE = 0
ElseIf $CMD_NA[$i] = "/NOOOBE" Then
$OOBE = 0
ElseIf $CMD_NA[$i] = "/NOEXTRA" Then
$EXTRA = 0
$VISUAL = 0
$SOUND = 0
$UAP = 0
$AERO = 0
$AUTO = 0
$REPATCH = 0
$BOOT = 0
ElseIf $CMD_NA[$i] = "/NOVISUAL" Then
$VISUAL = 0
ElseIf $CMD_NA[$i] = "/NOWALL" Then
$WALL = 0
ElseIf $CMD_NA[$i] = "/NOBOOT" Then
$BOOT = 0
ElseIf $CMD_NA[$i] = "/NOSOUND" Then
$SOUND = 0
ElseIf $CMD_NA[$i] = "/NOUAP" Then
$UAP = 0
ElseIf $CMD_NA[$i] = "/NOAERO" Then
$AERO = 0
ElseIf $CMD_NA[$i] = "/NOAUTO" Then
$AUTO = 0
ElseIf $CMD_NA[$i] = "/NOREPATCH" Then
$REPATCH = 0
ElseIf $CMD_NA[$i] = "/NOPROG" Then
$PROG = 0
$FLIP = 0
$DSI = 0
$UBER = 0
$OEM = 0
$QTBAR = 0
$TASKTIPS = 0
ElseIf $CMD_NA[$i] = "/NOQTBAR" Then
$QTBAR = 0
ElseIf $CMD_NA[$i] = "/NOTASKTIPS" Then
$TASKTIPS = 0
ElseIf $CMD_NA[$i] = "/NOFLIP" Then
$FLIP = 0
ElseIf $CMD_NA[$i] = "/NODSI" Then
$DSI = 0
ElseIf $CMD_NA[$i] = "/NOOEM" Then
$OEM = 0
ElseIf $CMD_NA[$i] = "/NOUBER" Then
$UBER = 0
Else
_Error(_FormatStr("Main_08", $TITLE))
EndIf
Next
EndIf
EndIf
Local $handle = FileFindFirstFile("Languages\*.ini"), $Files = "", $File
If $handle = -1 Then _Error(_FormatStr("P_00a", "Languages"))
While 1
$File = FileFindNextFile($handle)
If @error Then ExitLoop
$Files = _Iif($Files <> "", $Files & "|", "") & StringReplace($File, ".ini", "")
WEnd
FileClose($handle)
If $SILENT = 1 Or StringInStr($Files, "|") = 0 Then Return Page1_Build()
$GUI = GUICreate(_ReadStr("P_00b"), 200, 100)
GUISetOnEvent($GUI_EVENT_CLOSE, "Page0_Cancel")
GUICtrlCreateLabel(_ReadStr("P_00c"), 10, 10, 180, 20, $SS_CENTER)
$Pat[2] = GUICtrlCreateCombo("", 50, 35, 110, 20, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, $Files, $LANG)
GUICtrlSetOnEvent(-1, "Page0_Language")
GUICtrlCreateButton(_ReadStr("P_00d"), 50, 70, 100, 25)
GUICtrlSetOnEvent(-1, "Page1_Build")
GUICtrlSetState(-1, $GUI_DEFBUTTON)
GUISetState()
EndFunc
Func Page0_Cancel()
Exit
EndFunc
Func Page0_Language()
$LANG = GUICtrlRead($Pat[2])
EndFunc
Func Page1_Build()
$Integrate = 1
If $SILENT = 1 Then Return Page2_Build()
GUISetState(@SW_DISABLE)
Local $OLD = $GUI
Local $POS = WinGetPos($TITLE)
If @error = 1 Then
$GUI = GUICreate($TITLE, 500, 360)
Else
$GUI = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetFont(9, 400)
GUISetOnEvent($GUI_EVENT_CLOSE, "_CancelAnyPage")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUICtrlCreateGroup(_ReadStr("P_01a"), 106, 10, 380, 295)
GUICtrlSetFont(-1, 12, 800)
GUICtrlCreateLabel(StringReplace(_FormatStr("P_01b", $TITLE), "|", @CRLF), 120, 40, 360, 200)
GUICtrlCreateButton(_ReadStr("P_01c") & " >", 320, 325, 80, 25)
GUICtrlSetOnEvent(-1, "Page2_Build")
GUICtrlSetState(-1, $GUI_DEFBUTTON)
GUICtrlCreateButton(_ReadStr("P_01d"), 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "_CancelAnyPage")
GUISetState()
If $OLD <> 0 Then GUIDelete($OLD)
EndFunc
Func Page2_Build()
Local $OInt = $Integrate, $T
$Integrate = 2
If $SILENT = 1 Then Return Page3_Build()
GUISetState(@SW_DISABLE)
Local $OLD = $GUI
Local $POS = WinGetPos($TITLE)
If @error = 1 Then
$GUI = GUICreate($TITLE, 500, 360)
Else
$GUI = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetFont(8, 400)
GUISetOnEvent($GUI_EVENT_CLOSE, "_CancelAnyPage")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUISetFont(9, 400)
GUICtrlCreateGroup(_ReadStr("P_02a"), 106, 10, 380, 295)
GUICtrlSetFont(-1, 12, 800)
GUICtrlCreateEdit(StringReplace(_FormatStr("P_02b", @YEAR), "|", @CRLF), 116, 40, 360, 210, BitOR($ES_MULTILINE, $ES_READONLY, $ES_AUTOVSCROLL, $WS_VSCROLL))
$Pat[8] = GUICtrlCreateCheckbox(_ReadStr("P_02c"), 116, 260, 360, 20)
If $OInt > $Integrate Or @Compiled = 0 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_FOCUS)
GUICtrlSetOnEvent(-1, "Page2_Agree")
$Pat[2] = GUICtrlCreateCheckbox(_ReadStr("P_02e"), 116, 280, 360, 20)
$T = RegRead($SET, "NoPrompt")
If @error <> 0 Then $T = 0
If $T = 1 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page2_Remember")
$Pat[9] = GUICtrlCreateButton(_ReadStr("P_01c") & " >", 320, 325, 80, 25)
GUICtrlSetOnEvent(-1, "Page3_Build")
GUICtrlSetState(-1, _Iif(@Compiled, BitOR($GUI_ENABLE, $GUI_FOCUS), $GUI_DISABLE))
GUICtrlCreateButton(_ReadStr("P_01d"), 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "_CancelAnyPage")
If $T = 0 Or @Compiled = 0 Then
Page2_Agree()
GUISetState()
If $OLD <> 0 Then GUIDelete($OLD)
Else
GUIDelete($GUI)
$GUI = $OLD
Page3_Build()
EndIf
EndFunc
Func Page2_Agree()
Local $T = _Iif(BitAND(GUICtrlRead($Pat[8]), $GUI_CHECKED), BitOR($GUI_ENABLE, $GUI_FOCUS), $GUI_DISABLE)
GUICtrlSetState($Pat[2], $T)
GUICtrlSetState($Pat[9], $T)
EndFunc
Func Page2_Remember()
RegWrite($SET, "NoPrompt", "REG_SZ", BitAND(GUICtrlRead($Pat[2]), $GUI_CHECKED))
EndFunc
Func Page3_Build()
$Integrate = 3
If $SILENT = 1 Then Return Page4_Build()
GUISetState(@SW_DISABLE)
Local $OLD = $GUI, $T1, $T2
Local $POS = WinGetPos($TITLE)
If @error = 1 Then
$GUI = GUICreate($TITLE, 500, 360)
Else
$GUI = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetOnEvent($GUI_EVENT_CLOSE, "_CancelAnyPage")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUICtrlCreateGroup(_ReadStr("P_03a"), 106, 10, 380, 295)
GUICtrlSetFont(-1, 12, 800)
GUIStartGroup()
$Pat[99] = GUICtrlCreateRadio(_ReadStr("P_03b"), 120, 40, 360, 20)
GUICtrlSetOnEvent(-1, "Page3_Mode")
GUICtrlSetFont(-1, 10, 800)
If $Live <> 0 Then GUICtrlSetState(-1, $GUI_CHECKED)
If @OSVersion <> "WIN_2000" And @OSVersion <> "WIN_XP" And @OSVersion <> "WIN_2003" Then GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateRadio(_ReadStr("P_03c"), 120, 150, 360, 20)
GUICtrlSetOnEvent(-1, "Page3_Mode")
GUICtrlSetFont(-1, 10, 800)
If $Live = 0 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateLabel(_FormatStr("P_03d", $TITLE), 135, 70, 345, 70)
If @OSVersion <> "WIN_2000" And @OSVersion <> "WIN_XP" And @OSVersion <> "WIN_2003" Then GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateLabel(_FormatStr("P_03e", $TITLE), 135, 180, 345, 70)
GUICtrlCreateCheckbox("Offline Mode (requires themes to be already downloaded)", 120, 260, 345, 40)
If $ONLINE = 0 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page3_Offline")
GUICtrlCreateButton("< " & _ReadStr("P_02d"), 240, 325, 80, 25)
GUICtrlSetOnEvent(-1, "Page2_Build")
GUICtrlCreateButton(_ReadStr("P_01c") & " >", 320, 325, 80, 25)
GUICtrlSetOnEvent(-1, "Page4_Build")
GUICtrlSetState(-1, $GUI_DEFBUTTON)
GUICtrlCreateButton(_ReadStr("P_01d"), 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "_CancelAnyPage")
GUICtrlSetState(_Iif($Live = 1, $T1, $T2), BitOR($GUI_FOCUS, $GUI_CHECKED))
GUISetState()
If $OLD <> 0 Then GUIDelete($OLD)
EndFunc
Func Page3_Mode()
$Live = _Iif($Pat[99] = @GUI_CtrlId, 1, 0)
EndFunc
Func Page3_Offline()
$ONLINE = 1 - BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_CHECKED)
EndFunc
Func Page4_Build()
If $Integrate > 4 Then Return Page3_Build()
If $DEBUG = 0 Or $SILENT = 1 Then Return Page4_Next()
Local $OInt = $Integrate
$Integrate = 4
GUISetState(@SW_DISABLE)
Local $OLD = $GUI
Local $POS = WinGetPos($TITLE)
If @error = 1 Then
$GUI = GUICreate($TITLE, 500, 360)
Else
$GUI = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetFont(9, 400)
GUISetOnEvent($GUI_EVENT_CLOSE, "_CancelAnyPage")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUICtrlCreateGroup(_ReadStr("P_04a"), 106, 10, 380, 295)
GUICtrlSetFont(-1, 12, 800)
GUIStartGroup()
$Pat[99] = GUICtrlCreateRadio(_ReadStr("P_04b"), 120, 40, 360, 20)
GUICtrlSetOnEvent(-1, "Page4_Mode")
GUICtrlSetFont(-1, 10, 800)
If $EXPRESS = 1 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateRadio(_ReadStr("P_04c"), 120, 150, 360, 20)
GUICtrlSetOnEvent(-1, "Page4_Mode")
GUICtrlSetFont(-1, 10, 800)
If $EXPRESS = 0 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateLabel(_FormatStr("P_04d", $TITLE), 135, 70, 345, 70)
GUICtrlCreateLabel(_FormatStr("P_04e", $TITLE), 135, 180, 345, 70)
GUICtrlCreateButton("< " & _ReadStr("P_02d"), 240, 325, 80, 25)
GUICtrlSetOnEvent(-1, "Page3_Build")
$Pat[9] = GUICtrlCreateButton(_Iif($Live = 1 And $EXPRESS = 1, _ReadStr("Main_46"), _ReadStr("P_01c") & " >"), 320, 325, 80, 25)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
GUICtrlSetOnEvent(-1, "Page4_Next")
GUICtrlCreateButton(_ReadStr("P_01d"), 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "_CancelAnyPage")
If $SILENT <> 1 Then GUISetState()
If $OLD <> 0 Then GUIDelete($OLD)
If $SILENT = 1 Then Return Page4_Next()
EndFunc
Func Page4_Mode()
$EXPRESS = _Iif($Pat[99] = @GUI_CtrlId, 1, 0)
GUICtrlSetData($Pat[9], _Iif($Live = 1 And $EXPRESS = 1, _ReadStr("Main_46"), _ReadStr("P_01c") & " >"))
EndFunc
Func Page4_Next()
If $Live = 0 Then Return Page5_Build()
Return Page6_Build()
EndFunc
Func Page5_Build()
$SYSREST = 0
$Integrate = 5
GUISetState(@SW_DISABLE)
Local $OLD = $GUI
Local $POS = WinGetPos($TITLE)
If @error = 1 Then
$GUI = GUICreate($TITLE, 500, 360)
Else
$GUI = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetFont(9, 400)
GUISetOnEvent($GUI_EVENT_CLOSE, "_CancelAnyPage")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUICtrlCreateGroup(_ReadStr("P_05a"), 106, 10, 380, 295)
GUICtrlSetFont(-1, 12, 800)
GUICtrlCreateLabel(_ReadStr("P_05b"), 120, 50, 360, 30)
$Pat[0] = GUICtrlCreateLabel("", 120, 215, 300, 15)
$Pat[1] = GUICtrlCreateEdit($Src, 120, 90, 350, 25, 0)
GUICtrlSetOnEvent(-1, "Page5_Source")
GUICtrlCreateButton(_ReadStr("P_05d"), 400, 120, 80, 25)
GUICtrlSetOnEvent(-1, "Page5_Browse")
GUICtrlCreateLabel(_ReadStr("P_05e") & " 850MB for components", 120, 120, 250, 15)
$Pat[2] = GUICtrlCreateLabel("", 120, 135, 250, 15)
$Pat[3] = GUICtrlCreateLabel("", 120, 150, 250, 15)
$Pat[8] = GUICtrlCreateLabel("", 120, 165, 250, 15)
$Pat[4] = GUICtrlCreateCheckbox(_ReadStr("P_05q") & ":", 120, 215, 300, 20, -1, $WS_EX_TOPMOST)
GUICtrlSetOnEvent(-1, "Page5_SetCopy")
$Pat[5] = GUICtrlCreateEdit($Working & "\Copy", 120, 240, 350, 25, 0)
GUICtrlSetOnEvent(-1, "Page5_SetDest")
$Pat[7] = GUICtrlCreateCheckbox(_ReadStr("P_05r"), 120, 270, 300, 20)
GUICtrlCreateButton("< " & _ReadStr("P_02d"), 240, 325, 80, 25)
GUICtrlSetOnEvent(-1, "Page4_Build")
$Pat[9] = GUICtrlCreateButton(_Iif($EXPRESS = 1, _ReadStr("Main_46"), _ReadStr("P_01c") & " >"), 320, 325, 80, 25)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
GUICtrlSetOnEvent(-1, "Page5_Next")
If FileExists($Src & "\i386") = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateButton(_ReadStr("P_01d"), 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "_CancelAnyPage")
GUICtrlSetState($Pat[1], $GUI_FOCUS)
Page5_CheckOS()
If $SILENT = 1 And $Type <> "Dunno" Then Return Page7_Build()
GUISetState()
If $OLD <> 0 Then GUIDelete($OLD)
EndFunc
Func Page5_Browse()
Local $Dir = RegRead($SET, "LastBrowseSource")
If @error Then $Dir = $Src
While 1
While 1
$Dir = FileSelectFolder(_ReadStr("P_05f"), "", 3, $Dir)
If $Dir = "" Then ExitLoop 2
If FileExists($Dir & "\i386") Or FileExists($Dir & "\AMD64") Then ExitLoop
MsgBox(0x30, $TITLE, _ReadStr("P_05g"), 0, $GUI)
WEnd
$Src = $Dir
GUICtrlSetData($Pat[1], $Src)
Page5_Source()
If $Type = "Dunno" Then
MsgBox(0x30, $TITLE, _ReadStr("P_05h"), 0, $GUI)
Else
ExitLoop
EndIf
WEnd
EndFunc
Func Page5_Source()
$Src = GUICtrlRead($Pat[1])
If FileExists($Src & "\i386") = 0 And FileExists($Src & "\AMD64") = 0 Then
MsgBox(0x30, $TITLE, _ReadStr("P_05i"), 0, $GUI)
GUICtrlSetState($Pat[1], $GUI_FOCUS)
GUICtrlSetState($Pat[4], $GUI_DISABLE)
GUICtrlSetState($Pat[5], $GUI_DISABLE)
GUICtrlSetState($Pat[7], $GUI_DISABLE)
GUICtrlSetState($Pat[9], $GUI_DISABLE)
Return
EndIf
If FileExists($Src & "\i386\XPtspCom.INF") Or FileExists($Src & "\AMD64\XPtspCom.INF") Then
If MsgBox(0x24, $TITLE, _ReadStr("P_05s"), 0, $GUI) = 7 Then
GUICtrlSetState($Pat[1], $GUI_FOCUS)
GUICtrlSetState($Pat[4], $GUI_DISABLE)
GUICtrlSetState($Pat[5], $GUI_DISABLE)
GUICtrlSetState($Pat[7], $GUI_DISABLE)
GUICtrlSetState($Pat[9], $GUI_DISABLE)
Return
EndIf
EndIf
Page5_CheckOS()
If $Type = "Dunno" Then
MsgBox(0x30, $TITLE, _ReadStr("P_05h"), 0, $GUI)
GUICtrlSetState($Pat[1], $GUI_FOCUS)
Else
GUICtrlSetState($Pat[7], $GUI_FOCUS)
EndIf
$Pat[6] = DirGetSize($Src) / 1024 / 1024
EndFunc
Func Page5_SetCopy()
Local $R = BitAND(GUICtrlRead($Pat[4]), $GUI_CHECKED)
GUICtrlSetState($Pat[5], _Iif($R, $GUI_ENABLE, $GUI_DISABLE))
GUICtrlSetState($Pat[7], _Iif($R, $GUI_ENABLE, $GUI_DISABLE))
EndFunc
Func Page5_SetDest()
Local $Dir = GUICtrlRead($Pat[5])
If FileExists($Dir & "\") = 0 Then
If MsgBox(0x24, $TITLE, _ReadStr("P_05p")) = 6 Then DirCreate($Dir)
EndIf
If Not _Check_Writable($Dir) Then
MsgBox(0, $TITLE, _ReadStr("P_05m"), 0, $GUI)
$Dir = $Working & "\Copy"
GUICtrlSetData($Pat[5], $Dir)
GUICtrlSetState($Pat[5], $GUI_FOCUS)
Return
EndIf
If DriveSpaceFree(StringLeft($Dir, 3)) < $Pat[6] Then
MsgBox(0, $TITLE, _ReadStr("P_05n"), 0, $GUI)
$Dir = $Working & "\Copy"
GUICtrlSetData($Pat[5], $Dir)
GUICtrlSetState($Pat[5], $GUI_FOCUS)
Return
EndIf
EndFunc
Func Page5_CheckOS()
Local $Space = DriveSpaceFree(StringLeft($Src, 2)), $handle, $File, $R
$Space = _Iif($Space > 1000, Round($Space / 1024, 1) & "GB", Round($Space, 1) & "MB")
GUICtrlSetData($Pat[2], _ReadStr("P_05j") & " " & $Space)
If FileExists($Src & "\AMD64\NTOSKRNL.EXE") Then
$KRNL = $Src & "\AMD64\NTOSKRNL.EXE"
ElseIf FileExists($Src & "\i386\NTOSKRNL.EXE") Then
$KRNL = $Src & "\i386\NTOSKRNL.EXE"
ElseIf FileExists($Src & "\AMD64\NTOSKRNL.EX_") Then
$KRNL = Expand_File($Src & "\AMD64\NTOSKRNL.EX_")
Else
$KRNL = Expand_File($Src & "\i386\NTOSKRNL.EX_")
EndIf
Local $VER = StringLeft(FileGetVersion($KRNL), 3)
$Type = "Dunno"
If $VER = "5.0" Then
$Type = "W2K"
If $Live < 2 Then MsgBox(0, $TITLE, _FormatStr("NOSUPP", _ReadStr($Type)), 0, $GUI)
$SP3 = 0
ElseIf $VER = "5.1" Then
Page5_Detect_XP()
$SP3 = _Iif(FileGetVersion($tmp & "\NTOSKRNL.EXE") >= "5.1.2600.5512", 1, 0)
ElseIf $VER = "5.2" Then
$Type = _Iif(FileExists($Src & "\WIN51AP"), "X64", "W2K3")
If $Live < 2 Then MsgBox(0, $TITLE, _FormatStr("NOSUPP", _ReadStr($Type)), 0, $GUI)
$SP3 = 0
Else
$Type = "Dunno"
$SP3 = 0
EndIf
If $Type <> "Dunno" Then
GUICtrlSetData($Pat[3], _ReadStr("P_05k") & " " & _ReadStr($Type))
$R = _Check_Writable($Src)
GUICtrlSetState($Pat[4], _Iif($R, $GUI_ENABLE, BitOR($GUI_DISABLE, $GUI_CHECKED)))
$R = BitAND(GUICtrlRead($Pat[4]), $GUI_CHECKED)
GUICtrlSetState($Pat[5], _Iif($R, $GUI_ENABLE, $GUI_DISABLE))
GUICtrlSetState($Pat[7], _Iif($R, $GUI_ENABLE, $GUI_DISABLE))
GUICtrlSetState($Pat[9], BitOR($GUI_ENABLE, $GUI_DEFBUTTON))
Else
$Src = ""
GUICtrlSetData($Pat[3], _ReadStr("P_05k") & " " & _ReadStr($Type))
GUICtrlSetState($Pat[4], $GUI_DISABLE)
GUICtrlSetState($Pat[5], $GUI_DISABLE)
GUICtrlSetState($Pat[7], $GUI_DISABLE)
GUICtrlSetState($Pat[9], $GUI_DISABLE)
EndIf
EndFunc
Func Page5_Detect_XP()
Local $TPID = StringRight(IniRead($Src & "\i386\SETUPP.INI", "Pid", "Pid", ""), 3)
Local $Z = _Iif($TPID = "OEM", 1, _Iif($TPID = "270" Or $TPID = "640", 2, 0))
If FileExists($Src & "\WIN51IC") Then
$VOL = _Iif($Z = 1, "WXPHOEM_EN", "WXPHFPP_EN")
$Type = "Home"
Else
$VOL = _Iif($Z = 1, "WXPPOEM_EN", _Iif($Z = 2, "WXPPVOL_EN", "WXPPFPP_EN"))
$Type = "Pro"
EndIf
Local $handle = FileOpen($Src & "\i386\HIVESYS.INF", 0), $File
If $handle = -1 Then _Error(_FormatStr("Main_20", "HIVESYS.INF"))
Local $File = FileRead($handle)
FileClose($handle)
$MCE = StringInStr($File, "HKLM,""SYSTEM\WPA\MediaCenter"",""Installed"",,""1""")
If $MCE > 0 Then
$VOL = _Iif($Z = 1, "MX2POEM_EN", _Iif($Z = 2, "MX2PVOL_EN", "MX2PFPP_EN"))
$MCE = 1
EndIf
GUICtrlSetData($Pat[8], _Iif($MCE = 1, _ReadStr("P_05o"), ""))
EndFunc
Func Page5_Next()
Local $DEST = GUICtrlRead($Pat[5])
If BitAND(GUICtrlRead($Pat[4]), $GUI_CHECKED) Then
DirRemove($DEST, 1)
If BitAND(GUICtrlRead($Pat[7]), $GUI_CHECKED) Then
DirCreate($DEST)
_CopyDirWithProgress($Src & "\i386", $DEST & "\i386")
FileCopy($DEST & "\*", $DEST & "\", 1)
Else
_CopyDirWithProgress($Src, $DEST)
EndIf
If $MCE = 1 And FileExists($Src & "\CMPNENTS\MEDIACTR\I386\MEDIACTR.CAB") = 0 Then
While 1
CDTray($Src, "Open")
If MsgBox(0x11, $TITLE, _ReadStr("P_05l"), 0, $GUI) = 2 Then ExitLoop
If FileExists($Src & "\CMPNENTS\MEDIACTR\I386\MEDIACTR.CAB") Then
_CopyDirWithProgress($Src, $DEST)
ExitLoop
EndIf
WEnd
CDTray($Src, "Close")
EndIf
$Src = $DEST
EndIf
RegWrite($SET, "LastBrowseSource", "REG_SZ", $Src)
If FileExists($Src & "\AMD64\XPtspCom.inf") Then
$INF = $Src & "\AMD64\XPtspCom.inf"
ElseIf FileExists($Src & "\i386\XPtspCom.inf") Then
$INF = $Src & "\i386\XPtspCom.inf"
ElseIf FileExists($Src & "\AMD64\XPtspCom.in_") Then
$INF = Expand_File($Src & "\AMD64\XPtspCom.in_")
ElseIf FileExists($Src & "\i386\XPtspCom.in_") Then
$INF = Expand_File($Src & "\i386\XPtspCom.in_")
Else
$INF = $tmp & "\XPtspCom.inf"
If FileInstall("XPtspCom.INF", $INF, 1) = 0 Then _Error(_FormatStr("Main_03", "XPtspCom.INF"))
EndIf
GetPalette_Integration()
Page7_Build()
EndFunc
Func Page6_Build()
$SYSREST = 1
Local $tmp_a = RegRead($HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update", "RebootRequired")
If @error = 0 Then _Error(_ReadStr("Main_50"))
$tmp_a = RegRead($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations")
If @error = 0 and(@Compiled And $tmp_a <> "") Then _Error(_ReadStr("Main_50"))
$INF = @WindowsDir & "\INF\XPtspCom.inf"
If FileExists($INF) = 0 Then
$INF = $tmp & "\XPtspCom.INF"
If FileInstall("XPtspCom.INF", $INF, 1) = 0 Then _Error(_FormatStr("Main_03", "XPtspCom.INF"))
EndIf
$Integrate = 6
$Src = RegRead($SET, "InstalledPath")
If @error = 0 And FileExists($Src & "\XPtsp.exe") Then
Page6_CheckOS()
$Live = 2
Return Page7_Build()
EndIf
$Src = @ProgramFilesDir & "\XPtsp"
If $SILENT = 1 Or $EXPRESS = 1 Then
Page6_CheckOS()
Return Page7_Build()
EndIf
GUISetState(@SW_DISABLE)
Local $OLD = $GUI, $Space
Local $POS = WinGetPos($TITLE)
If @error = 1 Then
$GUI = GUICreate($TITLE, 500, 360)
Else
$GUI = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetFont(9, 400)
GUISetOnEvent($GUI_EVENT_CLOSE, "_CancelAnyPage")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUICtrlCreateGroup(_ReadStr("P_06a"), 106, 10, 380, 295)
GUICtrlSetFont(-1, 12, 800)
GUICtrlCreateLabel(_ReadStr("P_06b"), 120, 50, 360, 30)
$Pat[1] = GUICtrlCreateEdit($Src, 120, 90, 360, 25, $ES_READONLY)
GUICtrlSetOnEvent(-1, "Page6_Source")
GUICtrlCreateButton(_ReadStr("P_05d"), 400, 120, 80, 25)
GUICtrlSetOnEvent(-1, "Page6_Browse")
GUICtrlCreateLabel(_ReadStr("P_06c") & " 250MB", 120, 150, 360, 15)
GUICtrlCreateLabel(_ReadStr("P_06e") & " 250MB", 120, 170, 360, 15)
$Pat[2] = GUICtrlCreateLabel("", 120, 165, 360, 15)
$Pat[3] = GUICtrlCreateLabel("", 120, 180, 360, 15)
GUICtrlCreateButton("< " & _ReadStr("P_02d"), 240, 325, 80, 25)
GUICtrlSetOnEvent(-1, "Page4_Build")
$Pat[9] = GUICtrlCreateButton(_ReadStr("P_01c") & " >", 320, 325, 80, 25)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
GUICtrlSetOnEvent(-1, "Page7_Build")
GUICtrlCreateButton(_ReadStr("P_01d"), 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "_CancelAnyPage")
Page6_CheckOS()
GetPalette_Install()
GUISetState()
If $OLD <> 0 Then GUIDelete($OLD)
EndFunc
Func Page6_Source()
$Src = GUICtrlRead($Pat[1])
Page6_CheckOS()
EndFunc
Func Page6_Browse()
Local $Dir = ""
While $Dir <> @ProgramFilesDir
Local $Dir = FileSelectFolder(_FormatStr("P_06d", $TITLE), "", 3, $Src)
If @error Then Return
WEnd
$Src = $Dir
GUICtrlSetData($Pat[1], $Src)
Page6_CheckOS()
EndFunc
Func Page6_CheckOS()
Local $tOSVI = DllStructCreate("dword OSInfoSize; dword Major; dword Minor; dword;" & _
"dword PlatformId; char[128]; ushort; ushort; ushort SuiteMask; ubyte Product; ubyte")
DllStructSetData($tOSVI, "OSInfoSize", DllStructGetSize($tOSVI))
Global $acall = DllCall("kernel32.dll", "int", "GetVersionEx", "ptr", DllStructGetPtr($tOSVI))
Local $VER = DllStructGetData($tOSVI, "Major") & "." & DllStructGetData($tOSVI, "Minor")
Local $Suite = DllStructGetData($tOSVI, "SuiteMask"), $SDIR
$Type = "Dunno"
If $VER = "5.1" Then
$Type = _Iif(BitAND($Suite, 512), "Home", "Pro")
Local $T = RegRead($HKLM & "\SYSTEM\WPA\MediaCenter", "Installed")
$MCE = _Iif(@error = 0 And $T = 1, 1, 0)
$SP3 = _Iif(FileGetVersion($KRNL) >= "5.1.2600.5512", 1, 0)
ElseIf $VER = "5.2" Then
$Type = _Iif(@OSVersion = "WIN_XP", "X64", "W2K3")
If $Live < 2 Then MsgBox(0, $TITLE, _FormatStr("EXPER", _ReadStr($Type)), 0, $GUI)
$SP3 = 0
ElseIf $VER = "5.0" Then
$Type = "W2K"
If $Live < 2 Then MsgBox(0, $TITLE, _FormatStr("NOSUPP", _ReadStr($Type)), 0, $GUI)
$SP3 = 0
EndIf
GUICtrlSetData($Pat[2], _ReadStr("P_05k") & " " & _ReadStr($Type))
GUICtrlSetData($Pat[3], _Iif($MCE = 1, _ReadStr("P_05o"), ""))
$KRNL = _Iif(@OSArch <> "x86", @WindowsDir & "\SysNative\", @SystemDir & "\") & "NTOSKRNL.EXE"
IniWrite("XPtsp.ini", "Live.Patch", "TSP_KRNL.EXE", $KRNL)
EndFunc
Func Page7_Build()
Local $oIE, $GUIActiveX, $handle, $File, $S, $T
$Integrate = 7
GUISetState(@SW_DISABLE)
$USEPRO = _Iif($Type = "Pro", 1, 0)
If $ONLINE = 0 Then FileDelete($tmp & "\Version.ini")
If FileExists($tmp & "\Version.ini") = 0 Or $DEBUG = 1 Then
Local $TEMP = GUICreate(_ReadStr("Main_31"), 250, 50, -1, -1, BitOR($WS_BORDER, $WS_POPUP), -1, $GUI)
GUICtrlSetFont(-1, 9, 800)
Local $TEXT = GUICtrlCreateLabel(StringReplace(_ReadStr("P_07w"), "|", @CRLF), 60, 10, 180, 40, $SS_CENTER)
If FileInstall("loading.gif", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "loading.gif"))
Local $oIE = ObjCreate("Shell.Explorer.2")
If @error = 0 Then
$Pat[99] = GUICtrlCreateObj($oIE, 10, 10, 36, 36)
If $Pat[99] <> 0 Then
$oIE.navigate("about:blank")
$oIE.document.body.background = $tmp & "\loading.gif"
$oIE.document.body.scroll = "no"
EndIf
Else
GUICtrlCreatePic($tmp & "\loading.gif", 10, 10, 36, 36)
EndIf
GUICtrlSetFont(-1, 9, 800)
GUISetState()
If $ONLINE Then _FindServer($tmp & "\Version.ini", "XPtsp", 0)
$handle = FileFindFirstFile($OUTPUT & "\*.xptsp")
If $handle <> -1 Then
While 1
$File = FileFindNextFile($handle)
If @error Then ExitLoop
IniWrite($tmp & "\Version.ini", "Location", $File, $OUTPUT)
WEnd
FileClose($handle)
EndIf
$handle = FileFindFirstFile($OUTPUT & "\*.batch.exe")
If $handle <> -1 Then
While 1
$File = FileFindNextFile($handle)
If @error Then ExitLoop
IniWrite($tmp & "\Version.ini", "Location", $File, $OUTPUT)
WEnd
FileClose($handle)
EndIf
GUIDelete($TEMP)
EndIf
Local $OLD = $GUI
Local $POS = WinGetPos($TITLE)
If @error = 1 Then
$GUI = GUICreate($TITLE, 500, 360)
Else
$GUI = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetFont(9, 400)
GUISetOnEvent($GUI_EVENT_CLOSE, "_CancelAnyPage")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUICtrlCreateGroup(_ReadStr("P_07a"), 106, 10, 380, 295)
GUICtrlSetFont(-1, 12, 800)
GUICtrlCreateLabel(_ReadStr("P_07b"), 120, 40, 350, 20)
$Pat[31] = GUICtrlCreateCombo("", 120, 60, 240, 20, $CBS_DROPDOWNLIST)
GUICtrlSetOnEvent(-1, "Page7_Selected")
GUICtrlCreateButton(_ReadStr("P_05d"), 370, 60, 100, 25)
GUICtrlSetOnEvent(-1, "Page7_Browse")
$Pat[30] = GUICtrlCreateButton(_ReadStr("P_07c"), 200, 90, 200, 30)
GUICtrlSetOnEvent(-1, "Page7_PackageInfo")
$Pat[34] = GUICtrlCreateButton("<<", 160, 250, 30, 30)
GUICtrlSetOnEvent(-1, "Page7_PrevPic")
$Pat[35] = GUICtrlCreateButton(">>", 410, 250, 30, 30)
GUICtrlSetOnEvent(-1, "Page7_NextPic")
$Pat[38] = GUICtrlCreateLabel(_ReadStr("P_07d"), 120, 280, 360, 20, $SS_CENTER)
GUICtrlCreateButton("< " & _ReadStr("P_02d"), 240, 325, 80, 25)
If $Live = 0 Then
GUICtrlSetOnEvent(-1, "Page5_Build")
Else
GUICtrlSetOnEvent(-1, "Page6_Build")
EndIf
GUICtrlCreateButton(_ReadStr("P_01c") & " >", 320, 325, 80, 25)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
GUICtrlSetOnEvent(-1, "Page7_Download")
GUICtrlCreateButton(_ReadStr("P_01d"), 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "_CancelAnyPage")
Do
Until Page7_FindThemes()
Page7_Selected()
If $SILENT > 0 Or $EXPRESS = 1 Then
$CMD_NA = $OLD
Return Page7_Download()
EndIf
GUISetState()
If $OLD <> 0 Then GUIDelete($OLD)
EndFunc
Func Page7_Browse()
Local $TFILE, $S, $F, $DEF, $R, $OLD = $Working
$R = RegRead($SET, "LastBrowseFolder")
If @error Then $R = $OUTPUT
$TFILE = FileOpenDialog($TITLE, $OUTPUT, _ReadStr("P_07p") & " (*.xptsp)|" & _ReadStr("P_07p") & " (*.theme;*.7z)|" & _ReadStr("P_07v") & " (*.exe)", 1, "", $GUI)
$R = @error
FileChangeDir($OLD)
If $R Then Return
$S = StringLeft($TFILE, StringInStr($TFILE, "\", 0, -1) - 1)
RegWrite($SET, "LastBrowseFolder", "REG_SZ", $S)
$F = StringMid($TFILE, StringInStr($TFILE, "\", 0, -1) + 1)
$i = IniRead($tmp & "\Version.ini", "Location", $F, "")
IniWrite($tmp & "\Version.ini", "Location", $F, $S)
$THEME = StringLeft($F, StringInStr($F, ".", 0, -1) - 1)
Page7_FindThemes()
Page7_Selected()
Page7_GetPic(1)
EndFunc
Func Page7_Selected()
Local $READY = True, $MSG, $File = ""
$THEME = GUICtrlRead($Pat[31])
If $THEME = "===================================" Then
$THEME = $CMD_NA
GUICtrlSetData($Pat[31], $THEME)
EndIf
$CMD_NA = $THEME
$THEME = StringLeft($THEME, StringInStr($THEME, " (") - 1)
Page7_GetPic(1)
If StringInStr($CMD_NA, _ReadStr("P_07m1")) <> 0 Then
$MSG = IniRead($tmp & "\Version.ini", "Themes_v3", $THEME, "")
$THEME_FILE = $OUTPUT & "\" & $THEME & ".xptsp"
$READY = False
Else
Local $INI = IniReadSection($tmp & "\Version.ini", "Location")
If @error = 0 Then
For $i = 1 To $INI[0][0]
If StringLeft($INI[$i][0], StringInStr($INI[$i][0], ".", 0, -1) - 1) = $THEME Then
$THEME_FILE = $INI[$i][1] & "\" & $INI[$i][0]
ExitLoop
EndIf
Next
EndIf
$MSG = FileGetSize($THEME_FILE) & "|" & FileGetTime($THEME_FILE, 0, 1) & "|" & _MD5Hash($THEME_FILE) & "|" & _
_Iif(StringLeft($THEME, 4) = "Neon", "Neon", "Original")
IniWrite($tmp & "\Version.ini", "FileInfo", $THEME, $MSG)
EndIf
$MSG = StringSplit($MSG & "||", "|")
$MAX = $MSG[1]
$Pat[32] = StringReplace(StringFormat(_ReadStr("P_07e"), $MSG[3], Round($MSG[1] / 1024 / 1024, 1), _
_ConvertStamp($MSG[2]), _Iif($READY, _ReadStr("P_07k"), _ReadStr("P_07l"))), "|", @CRLF)
GUICtrlSetState($Pat[39], $GUI_ENABLE)
EndFunc
Func Page7_PackageInfo()
MsgBox(0, $TITLE, _ReadStr("P_07f") & " " & $THEME & @CRLF & @CRLF & $Pat[32], 0, $GUI)
EndFunc
Func Page7_NextPic()
Page7_GetPic($Pat[36] + 1)
EndFunc
Func Page7_PrevPic()
Page7_GetPic($Pat[36] - 1)
EndFunc
Func Page7_GetPic($Pic)
Local $URL = IniRead($tmp & "\Version.ini", $THEME, $Pic, "")
If $URL = "" Then
GUICtrlDelete($Pat[33])
$Pat[33] = GUICtrlCreatePic($Working & "\Pics\nopic.jpg", 200, 130, 200, 150)
GUICtrlSetState($Pat[34], $GUI_DISABLE)
GUICtrlSetState($Pat[35], $GUI_DISABLE)
GUICtrlSetState($Pat[38], $GUI_DISABLE)
Return
EndIf
Local $NAME = StringMid($URL, StringInStr($URL, "/", 0, -1) + 1)
InetGet($URL, $tmp & "\" & $NAME)
If @error <> 0 Then
GUICtrlDelete($Pat[33])
$Pat[33] = GUICtrlCreatePic($Working & "\Pics\nopic.jpg", 200, 130, 200, 150)
GUICtrlSetState($Pat[34], $GUI_DISABLE)
GUICtrlSetState($Pat[35], $GUI_DISABLE)
GUICtrlSetState($Pat[38], $GUI_DISABLE)
Return
EndIf
If StringRight($URL, 4) = ".png" Then
_ImageToBMP($tmp & "\" & $NAME)
$NAME = StringReplace($NAME, ".png", ".bmp")
EndIf
$Pat[37] = $tmp & "\" & $NAME
GUISetState(@SW_LOCK)
GUICtrlDelete($Pat[33])
$Pat[33] = GUICtrlCreatePic($tmp & "\" & $NAME, 200, 130, 200, 150)
GUICtrlSetOnEvent(-1, "Page7_LargePic")
GUICtrlSetState($Pat[34], _Iif(IniRead($tmp & "\Version.ini", $THEME, $Pic - 1, "") = "", $GUI_DISABLE, $GUI_ENABLE))
GUICtrlSetState($Pat[35], _Iif(IniRead($tmp & "\Version.ini", $THEME, $Pic + 1, "") = "", $GUI_DISABLE, $GUI_ENABLE))
GUICtrlSetState($Pat[38], _Iif($Pat[37] <> "", $GUI_DISABLE, $GUI_ENABLE))
GUISetState(@SW_UNLOCK)
$Pat[36] = $Pic
EndFunc
Func Page7_LargePic()
Local $hImage1 = _GDIPlus_ImageLoadFromFile($Pat[37]), $ratio
Local $iW = _GDIPlus_ImageGetWidth($hImage1)
Local $iH = _GDIPlus_ImageGetHeight($hImage1)
If $iW > @DesktopWidth Then
$ratio = @DesktopWidth / $iW
$iW = @DesktopWidth
$iH = $iH / $ratio
EndIf
If $iH > @DesktopHeight Then
$ratio = @DesktopHeight / $iH
$iH = @DesktopHeight
$iW = $iW / $ratio
EndIf
_GDIPlus_ImageDispose($hImage1)
GUISetState(@SW_DISABLE, $GUI)
GUICreate(_ReadStr("P_10h"), $iW, $iH, -1, -1, $WS_POPUPWINDOW, -1, $GUI)
GUICtrlCreatePic($Pat[37], 0, 0, $iW, $iH)
GUICtrlSetOnEvent(-1, "Page10_PreCancel")
GUISetOnEvent($GUI_EVENT_CLOSE, "Page10_PreCancel")
GUISetState()
EndFunc
Func Page7_FindThemes()
Local $SECT, $handle, $File, $S, $ARR, $Flagged, $Packages = False, $STAT, $T, $DEF = "", $LOC
Local $S1 = _ReadStr("P_07m1"), $S2 = _ReadStr("P_07m2"), $S3 = _ReadStr("P_07m3"), $S4 = _ReadStr("P_07m4"), $S5 = _ReadStr("P_07m5")
GUICtrlSetData($Pat[31], "")
$SECT = IniReadSection($tmp & "\Version.ini", "Themes_v3")
If @error = 0 Then
$DEF = $THEME & " (" & $S1 & ")"
For $i = 1 To $SECT[0][0]
$S = $SECT[$i][0] & " (" & $S1 & ")"
GUICtrlSetData($Pat[31], $S, $DEF)
$Packages = True
Next
Else
Local $SECT[1][2]
EndIf
Local $INI = IniReadSection($tmp & "\Version.ini", "Location")
If @error = 0 Then
If $SECT[0][0] > 0 Then GUICtrlSetData($Pat[31], "===================================", $DEF)
For $i = 1 To $INI[0][0]
$Packages = True
$File = $INI[$i][0]
$S = StringLeft($File, StringInStr($File, ".", 0, -1) - 1)
$LOC = $INI[$i][1]
$T = IniRead($tmp & "\Version.ini", "Themes_v3", $S, "")
If $T <> "" Then
$ARR = StringSplit($T, "|")
If $ARR[3] = _MD5Hash($LOC & "\" & $File) Then
$T = $S & " (" & $S2 & ")"
If StringLeft($DEF, StringInStr($DEF, " (") - 1) = $S Then $DEF = $T
$S = $T
Else
If StringLeft(FileGetTime($LOC & "\" & $File, 0, 1), 12) > StringLeft($ARR[2], 12) Then
$T = $S & " (" & $S5 & ")"
If StringLeft($DEF, StringInStr($DEF, " (") - 1) = $S Then $DEF = $T
$S = $T
Else
$S = $S & " (" & $S3 & ")"
EndIf
EndIf
Else
$S = $S & " (" & $S4 & ")"
If $DEF = "" Then $DEF = $S
EndIf
GUICtrlSetData($Pat[31], $S, $DEF)
Next
EndIf
If $Packages = False Then
If MsgBox(0x15, $TITLE, StringReplace(_ReadStr("P_07g"), "|", @CRLF)) = 2 Then _CancelAnyPage()
EndIf
Return $Packages
EndFunc
Func Page7_Download()
Local $Byte1, $Rate, $Total = $MAX, $TEMP = 0, $S, $T, $INI, $handle
GUISetState(@SW_DISABLE, $GUI)
$BATCH = StringInStr($THEME_FILE, ".exe")
If $BATCH = 0 Then
If StringInStr(GUICtrlRead($Pat[31]), _ReadStr("P_07m1")) <> 0 Then
If _Download_File("XPtsp/" & $THEME & "/" & $THEME & ".xptsp", $THEME_FILE) = 0 Then Return GUISetState(@SW_ENABLE, $GUI)
IniWrite($tmp & "\Version.ini", "FileInfo", $THEME, IniRead($tmp & "\Version.ini", "Themes_v3", $THEME, "|Original"))
IniDelete($res & "\Version.ini", "Theme", "Name")
EndIf
If $Live <> 0 Then
$res = $Src & "\Resources"
DirCreate($res)
EndIf
If IniRead($res & "\Version.ini", "Theme", "Name", "") <> $THEME Then
DirRemove($res, 1)
DirCreate($res)
_Unpack_7z($THEME_FILE, $res & "\")
$T = IniRead($res & "\Version.ini", "Theme", "Name", "")
If $T <> $THEME Then
$T = MsgBox(0x12, $TITLE, StringReplace(_FormatStr("P_07o", $T, $THEME), "|", @CRLF), 0, $GUI)
If $T = 3 Or $T = 4 Then
If $T = 4 Then _CancelAnyPage()
GUISetState(@SW_ENABLE, $GUI)
Return
EndIf
EndIf
EndIf
Else
Local $TEMP = GUICreate(_ReadStr("Main_31"), 250, 50, -1, -1, BitOR($WS_BORDER, $WS_POPUP), -1, $GUI)
GUICtrlSetFont(-1, 9, 800)
Local $TEXT = GUICtrlCreateLabel(StringReplace(_ReadStr("P_07q"), "|", @CRLF), 60, 10, 180, 40, $SS_CENTER)
If FileInstall("loading.gif", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "loading.gif"))
Local $oIE = ObjCreate("Shell.Explorer.2")
If @error = 0 Then
$Pat[99] = GUICtrlCreateObj($oIE, 10, 10, 36, 36)
If $Pat[99] <> 0 Then
$oIE.navigate("about:blank")
$oIE.document.body.background = $tmp & "\loading.gif"
$oIE.document.body.scroll = "no"
EndIf
Else
GUICtrlCreatePic($tmp & "\loading.gif", 10, 10, 36, 36)
EndIf
GUICtrlSetFont(-1, 9, 800)
GUISetState()
DirCreate($tmp)
$PID = Run($THEME_FILE & " -s", $tmp)
While ProcessExists($PID) <> 0
WEnd
If FileExists($tmp & "\XPtsp.bat") Then
WinClose("XPtsp script")
WinClose("Administrator:  XPtsp script !!! - ERROR - !!!")
EndIf
GUICtrlSetData($TEXT, StringReplace(_ReadStr("P_07r"), "|", @CRLF))
DirRemove($res, 1)
DirMove($tmp & "\Resources", $res, 1)
FileCopy($tmp & "\Extra\Pro\*.res", $res, 1)
DirCreate($res & "\IE8")
FileMove($res & "\8ieframe.dll.mui.res", $res & "\IE8\ieframe.dll.mui.res", 1)
DirCreate($res & "\Home")
FileCopy($tmp & "\Extra\Home\*.res", $res & "\Home", 1)
DirCreate($res & "\MCE")
FileCopy($tmp & "\Extra\MCE\*.res", $res & "\MCE", 1)
DirMove($Working & "\Pics\" & $Type, $res, 1)
DirRemove($xtra, 1)
DirMove($tmp & "\Extra", $xtra, 1)
DirCreate($xtra & "\SP3")
FileMove($xtra & "\*.msc", $xtra & "\SP3\", 1)
If FileExists($xtra & "\Version.ini") = 0 Then
If FileInstall("Version.ini", $xtra & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Version.ini"))
EndIf
GUICtrlSetData($TEXT, StringReplace(_ReadStr("P_07u"), "|", @CRLF))
IniWrite($res & "\Version.ini", "XPtsp", "Program", Page7_FileData(@ScriptFullPath, 0))
IniWrite($res & "\Version.ini", "Theme", "Name", GUICtrlRead($Pat[31]))
$handle = FileFindFirstFile($res & "\*.res")
If $handle <> -1 Then
While 1
$S = FileFindNextFile($handle)
If @error Then ExitLoop
IniWrite($res & "\Version.ini", "Pro", StringReplace($S, ".res", ""), Page7_FileData($res & "\" & $S))
WEnd
EndIf
FileClose($handle)
IniWrite($xtra & "\Version.ini", "Extra", "Name", GUICtrlRead($Pat[31]))
EndIf
$Translate = _Iif(IniRead($res & "\Version.ini", "Theme", "Version", "1.0") < "2.0", -1, 1)
$FullPack = _Iif(IniRead($res & "\Version.ini", "Theme", "FullPack", "Y") = "Y", 1, 0)
$BOOTSCR = _Iif(FileExists($res & "\" & $THEME & ".res") OR($THEME = "Purple"), $THEME, "Green")
$TASKMGR = _Iif(IniRead($Working & "\XPtsp.ini", "_TaskMgr.Exe", $THEME, "") <> "", $THEME, "Green")
$S = IniRead($tmp & "\Version.ini", "FileInfo", $THEME, "|Original")
$XPack = StringMid($S, StringInStr($S, "|", 0, -1) + 1)
If $SILENT > 0 Or $EXPRESS = 1 Then
GUIDelete($GUI)
$GUI = $CMD_NA
EndIf
Page8_Build()
EndFunc
Func Page7_FileData($File, $MD5 = 1)
Local $S = FileGetVersion($File)
If $MD5 Then $S = _MD5Hash($File)
Return $S & "|" & FileGetSize($File) & "|" & FileGetTime($File, 0, 1)
EndFunc
Func Page8_Build()
Local $handle, $File, $atmp
$Integrate = 8
$handle = FileFindFirstFile($OUTPUT & "\*.extra")
If $handle <> -1 Then
While 1
$File = FileFindNextFile($handle)
If @error Then ExitLoop
IniWrite($tmp & "\Version.ini", "Location.Extra", $File, $OUTPUT)
WEnd
FileClose($handle)
EndIf
$handle = FileFindFirstFile($OUTPUT & "\DriveSpace*.exe")
If $handle <> -1 Then
While 1
$File = FileFindNextFile($handle)
If @error Then ExitLoop
$atmp = _ReadStr("P_30d2") & " " & StringReplace(StringReplace($File, "DriveSpace_v", ""), "_Silent.exe", "")
IniWrite($tmp & "\Version.ini", "Location.DSI", $atmp, $OUTPUT & "\" & $File)
WEnd
FileClose($handle)
EndIf
$handle = FileFindFirstFile($OUTPUT & "\*dotnet*.exe")
If $handle <> -1 Then
While 1
$File = FileFindNextFile($handle)
If @error Then ExitLoop
IniWrite($tmp & "\Version.ini", "Location.Net", $File, $OUTPUT)
WEnd
FileClose($handle)
EndIf
Local $OLD = $GUI, $OInt
Local $POS = WinGetPos($TITLE)
If @error = 1 Then
$GUI = GUICreate($TITLE, 500, 360)
Else
$GUI = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetFont(9, 400)
GUISetOnEvent($GUI_EVENT_CLOSE, "_CancelAnyPage")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUICtrlCreateGroup(_ReadStr("P_08a"), 106, 10, 380, 125)
GUICtrlSetFont(-1, 12, 800)
$Pat[29] = GUICtrlCreateCheckbox(_ReadStr("P_08b"), 120, 40, 350, 20)
If $XPack <> "" And $BATCH = 0 And $FullPack = 1 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page8_XPack")
$Pat[30] = GUICtrlCreateCombo("", 120, 60, 240, 20, $CBS_DROPDOWNLIST)
GUICtrlSetOnEvent(-1, "Page8_Selected")
$Pat[28] = GUICtrlCreateButton(_ReadStr("P_05d"), 370, 60, 100, 25)
GUICtrlSetOnEvent(-1, "Page8_Browse")
$Pat[27] = GUICtrlCreateButton(_ReadStr("P_07c"), 200, 90, 200, 30)
GUICtrlSetOnEvent(-1, "Page8_PackageInfo")
GUICtrlCreateGroup(_ReadStr("P_08c"), 106, 140, 380, 165)
GUICtrlSetFont(-1, 12, 800)
$Pat[31] = GUICtrlCreateCheckbox(_ReadStr("P_08d"), 120, 170, 350, 20)
If $DSI Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page8_DSI_Check")
$Pat[32] = GUICtrlCreateCombo("", 120, 190, 240, 20, $CBS_DROPDOWNLIST)
$Pat[33] = GUICtrlCreateButton(_ReadStr("P_05d"), 370, 190, 100, 25)
GUICtrlSetOnEvent(-1, "Page8_DSI_Browse")
$Pat[34] = GUICtrlCreateCheckbox(_ReadStr("P_08e"), 120, 240, 350, 20)
If $DOTNET Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page8_Net_Check")
$Pat[35] = GUICtrlCreateCombo("", 120, 260, 240, 20, $CBS_DROPDOWNLIST)
$Pat[36] = GUICtrlCreateButton(_ReadStr("P_05d"), 370, 260, 100, 25)
GUICtrlSetOnEvent(-1, "Page8_Net_Browse")
GUICtrlCreateButton("< " & _ReadStr("P_02d"), 240, 325, 80, 25)
GUICtrlSetOnEvent(-1, "Page7_Build")
GUICtrlCreateButton(_ReadStr("P_01c") & " >", 320, 325, 80, 25)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
GUICtrlSetOnEvent(-1, "Page8_Download")
GUICtrlCreateButton(_ReadStr("P_01d"), 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "_CancelAnyPage")
Page8_Populate()
Page8_Selected()
Page8_XPack()
Page8_DSI_Check()
Page8_Net_Check()
If $SILENT > 0 Or $EXPRESS = 1 Then
$CMD_NA = $OLD
Return Page8_Download()
EndIf
GUISetState()
If $OLD <> 0 Then GUIDelete($OLD)
EndFunc
Func Page8_XPack()
Local $R = _Iif(BitAND(GUICtrlRead($Pat[29]), $GUI_CHECKED), $GUI_ENABLE, $GUI_DISABLE)
GUICtrlSetState($Pat[30], $R)
GUICtrlSetState($Pat[28], $R)
GUICtrlSetState($Pat[27], $R)
EndFunc
Func Page8_Selected()
Local $READY = True, $MSG, $File = ""
$XPack = GUICtrlRead($Pat[30])
If $XPack = "===================================" Then
$XPack = $CMD_NA
GUICtrlSetData($Pat[31], $THEME)
EndIf
$CMD_NA = $XPack
$XPack = StringLeft($XPack, StringInStr($XPack, " (") - 1)
If StringInStr($CMD_NA, _ReadStr("P_07m1")) <> 0 Then
$MSG = IniRead($tmp & "\Version.ini", "Extras_v2", $XPack, "")
$XPACK_FILE = $OUTPUT & "\" & $XPack & ".extra"
$READY = False
Else
Local $INI = IniReadSection($tmp & "\Version.ini", "Location.Extra")
If @error = 0 Then
For $i = 1 To $INI[0][0]
If StringLeft($INI[$i][0], StringInStr($INI[$i][0], ".", 0, -1) - 1) = $XPack Then
$XPACK_FILE = $INI[$i][1] & "\" & $INI[$i][0]
ExitLoop
EndIf
Next
EndIf
$MSG = FileGetSize($XPACK_FILE) & "|" & FileGetTime($XPACK_FILE, 0, 1) & "|" & _MD5Hash($XPACK_FILE)
IniWrite($tmp & "\Version.ini", "FileInfo.Extra", $THEME, $MSG)
EndIf
$MSG = StringSplit($MSG & "||", "|")
$MAX = $MSG[1]
$Pat[2] = StringReplace(StringFormat(_ReadStr("P_07e"), $MSG[3], Round($MSG[1] / 1024 / 1024, 1), _
_ConvertStamp($MSG[2]), _Iif($READY, _ReadStr("P_07k"), _ReadStr("P_07l"))), "|", @CRLF)
GUICtrlSetState($Pat[39], $GUI_ENABLE)
EndFunc
Func Page8_Browse()
Local $TFILE, $S, $F, $DEF, $R, $OLD = $Working
$R = RegRead($SET, "LastBrowseFolder")
If @error Then $R = $OUTPUT
$TFILE = FileOpenDialog($TITLE, $OUTPUT, _ReadStr("P_08g") & " (*.extra)", 1, "", $GUI)
$R = @error
FileChangeDir($OLD)
If $R Then Return
$S = StringLeft($TFILE, StringInStr($TFILE, "\", 0, -1) - 1)
RegWrite($SET, "LastBrowseFolder", "REG_SZ", $S)
$F = StringMid($TFILE, StringInStr($TFILE, "\", 0, -1) + 1)
IniWrite($tmp & "\Version.ini", "Location.Extra", $F, $S)
$XPack = StringLeft($F, StringInStr($F, ".", 0, -1) - 1)
Page8_Populate()
EndFunc
Func Page8_PackageInfo()
MsgBox(0, $TITLE, _ReadStr("P_07f") & " " & $XPack & @CRLF & @CRLF & $Pat[2], 0, $GUI)
EndFunc
Func Page8_DSI_Check()
$DSI = BitAND(GUICtrlRead($Pat[31]), $GUI_CHECKED)
GUICtrlSetState($Pat[32], _Iif($DSI, $GUI_ENABLE, $GUI_DISABLE))
GUICtrlSetState($Pat[33], _Iif($DSI, $GUI_ENABLE, $GUI_DISABLE))
EndFunc
Func Page8_DSI_Browse()
Local $TFILE, $S, $F, $DEF, $R, $OLD = $Working
$R = RegRead($SET, "LastBrowseFolder")
If @error Then $R = $OUTPUT
$TFILE = FileOpenDialog($TITLE, $OUTPUT, "Drive Space Indicator (DriveSpace*.exe)", 1, "", $GUI)
$R = @error
FileChangeDir($OLD)
If $R Then Return
$S = StringLeft($TFILE, StringInStr($TFILE, "\", 0, -1) - 1)
RegWrite($SET, "LastBrowseFolder", "REG_SZ", $S)
$F = StringMid($TFILE, StringInStr($TFILE, "\", 0, -1) + 1)
IniWrite($tmp & "\Version.ini", "Location.DSI", $F, $TFILE)
Page8_Populate()
EndFunc
Func Page8_Net_Check()
$DOTNET = BitAND(GUICtrlRead($Pat[34]), $GUI_CHECKED)
GUICtrlSetState($Pat[35], _Iif($DOTNET, $GUI_ENABLE, $GUI_DISABLE))
GUICtrlSetState($Pat[36], _Iif($DOTNET, $GUI_ENABLE, $GUI_DISABLE))
EndFunc
Func Page8_Net_Browse()
Local $TFILE, $S, $F, $DEF, $R, $OLD = $Working
$R = RegRead($SET, "LastBrowseFolder")
If @error Then $R = $OUTPUT
$TFILE = FileOpenDialog($TITLE, $OUTPUT, ".NET Framework 2.0 (*dotnet*.exe)", 1, "", $GUI)
$R = @error
FileChangeDir($OLD)
If $R Then Return
$S = StringLeft($TFILE, StringInStr($TFILE, "\", 0, -1) - 1)
RegWrite($SET, "LastBrowseFolder", "REG_SZ", $S)
$F = StringMid($TFILE, StringInStr($TFILE, "\", 0, -1) + 1)
IniWrite($tmp & "\Version.ini", "Location.Net", $F, $S)
Page8_Populate()
EndFunc
Func Page8_Populate()
Local $S1 = _ReadStr("P_07m1"), $S2 = _ReadStr("P_07m2"), $S3 = _ReadStr("P_07m3"), $S4 = _ReadStr("P_07m4")
Local $SECT[1][2] = [[0]], $handle, $File, $S, $ARR, $Flagged, $STAT, $T, $DEF, $LOC, $x
GUICtrlSetData($Pat[30], "")
Local $SECT = IniReadSection($tmp & "\Version.ini", "Extras_v2")
$DEF = $XPack & " (" & $S1 & ")"
If @error = 0 Then
For $i = 1 To $SECT[0][0]
GUICtrlSetData($Pat[30], $SECT[$i][0] & " (" & $S1 & ")", $DEF)
Next
Else
Local $SECT[1][2]
EndIf
Local $INI = IniReadSection($tmp & "\Version.ini", "Location.Extra")
If @error = 0 Then
If $SECT[0][0] > 0 Then GUICtrlSetData($Pat[30], "===================================", $DEF)
For $i = 1 To $INI[0][0]
$File = $INI[$i][0]
$S = StringLeft($File, StringInStr($File, ".", 0, -1) - 1)
$LOC = $INI[$i][1]
$T = IniRead($tmp & "\Version.ini", "Extras_v2", $S, "")
If $T <> "" Then
$ARR = StringSplit($T, "|")
If $ARR[3] = _MD5Hash($LOC & "\" & $File) Then
$T = $S & " (" & $S2 & ")"
If StringLeft($DEF, StringInStr($DEF, " (") - 1) = $S Then $DEF = $T
$S = $T
Else
$S = $S & " (" & $S3 & ")"
EndIf
Else
$S = $S & " (" & $S4 & ")"
If $DEF = "" Then $DEF = $S
EndIf
GUICtrlSetData($Pat[30], $S, $DEF)
Next
EndIf
Local $SECT = IniRead($tmp & "\Version.ini", "DSI", "Latest", "||")
$SECT = StringSplit($SECT, "|")
$DEF = ""
$x = _ReadStr("P_30d2")
If $SECT[1] <> "" Then
$DEF = $x & " " & $SECT[1] & " (" & $S1 & ")"
GUICtrlSetData($Pat[32], $DEF, $DEF)
EndIf
Local $INI = IniReadSection($tmp & "\Version.ini", "Location.DSI")
If @error = 0 Then
If $DEF <> "" Then GUICtrlSetData($Pat[32], "===================================", $DEF)
For $i = 1 To $INI[0][0]
$S = $INI[$i][0]
$File = $INI[$i][1]
If $SECT[3] = _MD5Hash($File) Then
$T = $S & " (" & $S2 & ")"
If StringInStr($DEF, $SECT[1]) <> 0 Then $DEF = $T
$S = $T
Else
$S = $S & " (" & $S3 & ")"
If $DEF = "" Then $DEF = $S
EndIf
GUICtrlSetData($Pat[32], $S, $DEF)
Next
EndIf
Local $SECT = IniRead($tmp & "\Version.ini", "DotNet", "Latest", "||")
$SECT = StringSplit($SECT, "|")
$DEF = ""
$x = _ReadStr("P_30d2")
If $SECT[1] <> "" Then
$DEF = "dotnet2.exe (" & $S1 & ")"
GUICtrlSetData($Pat[35], $DEF, $DEF)
EndIf
Local $INI = IniReadSection($tmp & "\Version.ini", "Location.Net")
If @error = 0 Then
If $DEF <> "" Then GUICtrlSetData($Pat[35], "===================================", $DEF)
For $i = 1 To $INI[0][0]
$S = $INI[$i][0]
$File = $INI[$i][1] & "\" & $S
If $SECT[2] = _MD5Hash($File) Then
$T = $S & " (" & $S2 & ")"
If StringLeft($DEF, StringInStr($DEF, " (") - 1) = $S Then $DEF = $T
$S = $T
Else
$S = $S & " (" & $S3 & ")"
If $DEF = "" Then $DEF = $S
EndIf
GUICtrlSetData($Pat[35], $S, $DEF)
Next
EndIf
EndFunc
Func Page8_Download()
Local $S, $T, $UP = _ReadStr("P_07m1")
GUISetState(@SW_DISABLE, $GUI)
DirCreate($xtra)
If BitAND(GUICtrlRead($Pat[29]), $GUI_CHECKED) Then
$S = GUICtrlRead($Pat[30])
$T = StringInStr($S, $UP)
If $T <> 0 Then
$MAX = StringLeft($S, $T - 3)
$MAX = IniRead($tmp & "\Version.ini", "Extras_v2", $MAX, "")
$MAX = StringLeft($MAX, StringInStr($MAX, "|") - 1)
If _Download_File("XPtsp/" & $XPack & ".extra", $XPACK_FILE) = 0 Then Return GUISetState(@SW_ENABLE, $GUI)
IniDelete($xtra & "\Version.ini", "Extra", "Name")
EndIf
If IniRead($xtra & "\Version.ini", "Extra", "Name", "") <> $XPack Then
DirRemove($xtra, 1)
DirCreate($xtra)
_Unpack_7z($XPACK_FILE, $xtra & "\")
If IniRead($xtra & "\Version.ini", "Extra", "Name", "") <> $XPack Then
If MsgBox(0x15, $TITLE, StringReplace(_ReadStr("P_07o"), "|", @CRLF), 0, $GUI) = 2 Then _CancelAnyPage()
GUISetState(@SW_ENABLE, $GUI)
Return
EndIf
EndIf
If IniRead($xtra & "\Version.ini", "Extra", "Version", "1.0") < "2.0" Then
If FileInstall("Version.ini", $xtra & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Version.ini"))
EndIf
EndIf
If BitAND(GUICtrlRead($Pat[31]), $GUI_CHECKED) Then
$T = GUICtrlRead($Pat[32])
If StringInStr($T, $UP) <> 0 Then
$S = IniRead($tmp & "\Version.ini", "DSI", "Latest", "")
$MAX = StringMid($S, StringInStr($S, "|", 0, 1) + 1)
$MAX = StringLeft($MAX, StringInStr($MAX, "|") - 1)
$S = "DriveSpace_v" & StringLeft($S, StringInStr($S, "|") - 1) & "_Silent.exe"
$T = $OUTPUT & "\" & $S
If _Download_File("DSI/" & $S, $T) = 0 Then Return GUISetState(@SW_ENABLE, $GUI)
Else
$T = StringLeft($T, StringInStr($T, " (") - 1)
$T = IniRead($tmp & "\Version.ini", "Location.DSI", $T, "")
EndIf
DirCreate($xtra & "\SVCPACK")
FileCopy($T, $xtra & "\SVCPACK\DriveSpace.exe", 1)
EndIf
If BitAND(GUICtrlRead($Pat[34]), $GUI_CHECKED) Then
$T = GUICtrlRead($Pat[35])
If StringInStr($T, $UP) <> 0 Then
$MAX = IniRead($tmp & "\Version.ini", "DotNet", "Latest", "")
$MAX = StringLeft($MAX, StringInStr($MAX, "|", 0, 1) - 1)
$T = $OUTPUT & "\dotnet2.exe"
If _Download_File("XPtsp/dotnet2.exe", $T) = 0 Then Return GUISetState(@SW_ENABLE, $GUI)
Else
$T = StringLeft($T, StringInStr($T, " (") - 1)
$S = IniRead($tmp & "\Version.ini", "Location.Net", $T, "")
$T = $S & "\" & $T
EndIf
DirCreate($xtra & "\SVCPACK")
FileCopy($T, $xtra & "\SVCPACK\dotnet2.exe", 1)
EndIf
If $SILENT > 0 Or $EXPRESS = 1 Then
GUIDelete($GUI)
$GUI = $CMD_NA
EndIf
Page9_Build()
EndFunc
Func Page9_Build()
If $Integrate = 4 Then Page5_CheckOS()
$Integrate = 9
Local $x, $Y, $T, $T1
GUISetState(@SW_DISABLE)
If $Live <> 0 Then _WinSxS_Folders()
Local $OLD = $GUI
Local $POS = WinGetPos($TITLE)
If @error = 1 Then
$GUI = GUICreate($TITLE, 500, 360)
Else
$GUI = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetFont(9, 400)
GUISetOnEvent($GUI_EVENT_CLOSE, "_CancelAnyPage")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUICtrlCreateGroup(_ReadStr("P_09a"), 106, 10, 380, 295)
GUICtrlSetFont(-1, 12, 800)
GUICtrlCreateLabel(_ReadStr(_Iif($Live = 2, "P_09b", "P_09c")), 120, 40, 360, 30)
$TREE = GUICtrlCreateTreeView(120, 80, 350, 150, _
BitOR($GUI_SS_DEFAULT_TREEVIEW, $TVS_CHECKBOXES), $WS_EX_CLIENTEDGE)
GUICtrlCreateLabel(_ReadStr("P_09d"), 120, 240, 350, 20)
$Pat[9] = GUICtrlCreateEdit("", 120, 260, 350, 40, BitOR($ES_READONLY, $ES_MULTILINE), $WS_EX_STATICEDGE)
$x = Page9_AddItem($TREE, "CS2", "PATCH", "Page9_Section")
$LV[Page9_FindControl($x)][9] = 0
If $OS <> "W2K" Then Page9_AddItem($x, "CS2A", "UXTHEME")
Page9_AddItem($x, "CS2B", "SFC")
$x = Page9_AddItem($TREE, "CS3", "FILES", "Page9_TopLevel")
$LV[Page9_FindControl($x)][9] = 0
Page9_AddSection($x, "CS3A", "EXE Files", "EXE")
Page9_AddSection($x, "CS3B", "DLL Files", "DLL")
Page9_AddSection($x, "CS3C", "CPL Files", "CPL")
Page9_AddSection($x, "CS3D", "OCX Files", "OCX")
Page9_AddSection($x, "CS3E", "AT Files", "AT")
Page9_AddSection($x, "CS3F", "OE Files", "OE")
Page9_AddSection($x, "CS3G", "IE7 Files", "IE")
Page9_AddSection($x, "CS3H", "WMP11 Files", "WMP")
Page9_AddSection($x, "CS3I", "RDP6 Files", "RDP")
Page9_AddSection($x, "CS3L", "NetMeeting", "NetMeeting")
If $MCE = 1 Then Page9_AddSection($x, "CS3J", "MCE Files", "MCE")
If $Live = 0 and($Type <> "W2K" And $Type <> "W2K3") Then Page9_AddItem($x, "CS3K", "OOBE")
$x = Page9_AddItem($TREE, "CS4", "EXTRA", "Page9_TopLevel")
$LV[Page9_FindControl($x)][9] = 0
$Y = Page9_AddItem($x, "CS4A", "BOOT", "Page9_Section")
$LV[Page9_FindControl($Y)][9] = 0
If $Live = 0 Then
Page9_AddItem($Y, "NTKRNLPA.EXE", "", "", "Strings", 0)
Page9_AddItem($Y, "NTOSKNRL.EXE", "", "", "Strings", 0)
Page9_AddItem($Y, "NTKNRLMP.EXE", "", "", "Strings", 0)
Page9_AddItem($Y, "NTKRPAMP.EXE", "", "", "Strings", 0)
Else
Page9_AddItem($Y, "TSP_KRNL.EXE", "", "", "Strings", 0)
EndIf
If FileExists($xtra) Then
Page9_AddItem($x, "CS4B", "SCRSAVER")
Page9_AddItem($x, "CS4C", "WALL")
$Y = Page9_AddItem($x, "CS4D", "VISUAL", "Page9_Section")
Page9_AddItem($Y, "LUNA.MST", "", "", "Strings", 0)
Page9_AddItem($Y, "BLUE_SS.DLL", "", "", "Strings", 0)
Page9_AddItem($Y, "HOME_SS.DLL", "", "", "Strings", 0)
Page9_AddItem($Y, "METAL_SS.DLL", "", "", "Strings", 0)
If $MCE = 1 Then
Page9_AddItem($Y, "ROYALE.MST", "", "", "Strings", 0)
Page9_AddItem($Y, "ROYALE_SS.DLL", "", "", "Strings", 0)
EndIf
Page9_AddItem($x, "CS4E", "SOUND")
Page9_AddItem($x, "CS4I", "AUTO")
If FileExists($xtra & "\Programs") Then
$x = Page9_AddItem($TREE, "CS5", "", "Page9_Section")
$LV[Page9_FindControl($x)][9] = 0
$T = IniReadSection($xtra & "\Version.ini", "AddOns")
If @error Then _Error(_FormatStr("Main_02", "AddOns"))
For $i = 1 To $T[0][0]
If IsDeclared($T[$i][0]) = 0 Then Assign($T[$i][0], 1, 2)
IniWrite($Working & "\Languages\" & $LANG & ".ini", "Strings", $T[$i][0], $T[$i][1])
Page9_AddItem($x, $T[$i][0], $T[$i][0])
Next
EndIf
$x = Page9_AddItem($TREE, "CS6", "", "Page9_Section")
$LV[Page9_FindControl($x)][9] = 0
Page9_AddItem($x, "CS6A", "REPATCH")
If $Live = 1 And FileExists(@SystemDir & "\OEMINFO.INI") And @Compiled = 1 Then
$OEM = 0
Else
Page9_AddItem($x, "CS6B", "OEM")
EndIf
Page9_AddItem($x, "CS6C", "RESOURCES")
EndIf
GUICtrlCreateButton("< " & _ReadStr("P_02d"), 240, 325, 80, 25)
If $Live = 2 Then
GUICtrlSetOnEvent(-1, "Page30_Build")
Else
GUICtrlSetOnEvent(-1, "Page8_Build")
EndIf
$Pat[1] = GUICtrlCreateButton(_ReadStr("P_01c") & " >", 320, 325, 80, 25)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
GUICtrlSetOnEvent(-1, "Page9_Next")
GUICtrlCreateButton(_ReadStr("P_01d"), 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "_CancelAnyPage")
If $SILENT > 0 Or $EXPRESS = 1 Or $Live > 2 Then $CMD_NA = $OLD
If $Live > 2 Then Return
If $SILENT > 0 Or $EXPRESS = 1 Then Return Page9_Next()
GUISetState()
If $OLD <> 0 Then GUIDelete($OLD)
EndFunc
Func Page9_AddItem($PARENT, $ITEM, $VarName = "", $CallBack = "", $Section = "Strings", $Shown = 1)
Local $LongDesc = _ReadStr($ITEM, $Section), $i
$LongDesc = StringSplit($ITEM & "|" & $LongDesc, "|")
If $LongDesc[0] = 3 Then
$LongDesc[1] = $LongDesc[2]
$LongDesc[2] = $LongDesc[3]
EndIf
$i = Page9_FindItem($LongDesc[1])
If $i = 0 Then
$i = $LV[0][0] + 1
$LV[0][0] = $i
EndIf
If UBound($LV) = $i Then ReDim $LV[UBound($LV) + 10][11]
If $ITEM = "COMCTL32.DLL" Then $CallBack = "Page9_Section"
$LV[$i][1] = _Iif($PARENT <> $TREE, $PARENT, 0)
$LV[$i][2] = $ITEM
$LV[$i][3] = $LongDesc[1]
$LV[$i][4] = $LongDesc[2]
$LV[$i][7] = _Iif($ITEM = "TASKMGR.EXE", "TASK", $VarName)
If $i = $LV[0][0] Then
$LV[$i][6] =(IniRead($INF, "Pro", $LV[$i][3], "") <> "") + 0
If $LV[$i][7] = "" Then
$LV[$i][5] = Page9_FileDiff($LV[$i][3], $LV[$i][6])
Else
$LV[$i][5] = Eval($LV[$i][7])
EndIf
Else
$LV[$i][6] = 0
$LV[$i][5] = 0
EndIf
$LV[$i][8] = _Iif($LV[$i][5] > 0, 1, 0)
$LV[$i][9] = 1
If $Shown = 1 Then
$LV[$i][0] = GUICtrlCreateTreeViewItem($LV[$i][3], $PARENT)
GUICtrlSetOnEvent(-1, "Page9_Files")
If $CallBack <> "" Then GUICtrlSetOnEvent(-1, $CallBack)
GUICtrlSetState(-1, BitOR(_Iif($LV[$i][8] = 0, $GUI_UNCHECKED, $GUI_CHECKED), _Iif($i = 1, $GUI_FOCUS, 0)))
Else
$LV[$i][0] = -1
EndIf
If $i = 1 Then GUICtrlSetData($Pat[9], $LV[$i][4])
If $ITEM = "COMCTL32.DLL" Then
For $i = 1 To 7
Page9_AddItem($LV[$i][0], "COMCTL" & $i + 32 & ".DLL", "", "", "", 0)
Next
EndIf
$LV[$i][10] = 0
Return $LV[$i][0]
EndFunc
Func Page9_FileDiff($Resource, $Backup = -1)
If $Live < 2 Then Return 1
Local $LONG = IniRead($Src & "\XPtsp.ini", "Live.Dest", $Resource, "")
If $LONG = "" Or FileExists($LONG) = 0 Then Return 0
Local $OLD = IniRead($INF, "Pro", $Resource, "")
If $OLD = "" Then Return 0
Local $NEW = StringSplit($OLD & "|", "|")
If $NEW[1] <> FileGetVersion($LONG) Then Return 2
If $Resource <> "TSP_KRNL.EXE" And $NEW[2] <> FileGetSize($LONG) Then Return 3
If $Backup = -1 Then $Backup = $LV[Page9_FindItem($Resource)][6]
Local $S = IniRead($res & "\Version.ini", $OS, $Resource, IniRead($res & "\Version.ini", "Pro", $Resource, ""))
Return _Iif($NEW[4] <> StringLeft($S, 32), 3, $Backup)
EndFunc
Func Page9_AddSection($PARENT, $String, $Section, $VarName = "")
Local $ARR = IniReadSection("Languages\" & $LANG & ".ini", $Section)
If @error = 1 Then Return
If $ARR[0][0] = 0 Then Return
Local $x = Page9_AddItem($PARENT, $String, $VarName, "Page9_Section")
$LV[Page9_FindControl($x)][9] = 0
For $i = 1 To $ARR[0][0]
Page9_AddItem($x, StringUpper($ARR[$i][0]), "", "Page9_Files", $Section)
Next
Return $x
EndFunc
Func Page9_Section()
Local $Y = Page9_FindControl(@GUI_CtrlId)
Local $x = _Iif(BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_UNCHECKED), 0, 1)
GUICtrlSetData($Pat[9], $LV[$Y][4])
If $LV[$Y][8] <> $x Then
$LV[$Y][8] = $x
Page9_StateChange(@GUI_CtrlId, $x)
EndIf
EndFunc
Func Page9_TopLevel()
Local $Y = Page9_FindControl(@GUI_CtrlId)
If $LV[$Y][10] Then
$LV[$Y][10] = 0
Return
EndIf
Local $V = _Iif(BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_UNCHECKED), 0, 1)
$LV[$Y][1] = $V
For $U = 1 To $LV[0][0]
If $LV[$U][1] = @GUI_CtrlId Then
$LV[$U][8] = $V
GUICtrlSetState($LV[$U][0], _Iif($V = 1, $GUI_CHECKED, $GUI_UNCHECKED))
If $LV[$U][7] <> "" Then Assign($LV[$U][7], $V)
Page9_StateChange($LV[$U][0], $V)
EndIf
Next
GUICtrlSetData($Pat[9], $LV[Page9_FindControl(@GUI_CtrlId)][4])
EndFunc
Func Page9_Files()
Local $T = Page9_FindControl(@GUI_CtrlId)
$LV[$T][8] = _Iif(BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_CHECKED), 1, 0)
GUICtrlSetData($Pat[9], $LV[$T][4])
If $LV[$T][7] <> "" Then Assign($LV[$T][7], $LV[$T][8])
If $LV[$T][1] <> 0 Then Page9_ChangeParent($LV[$T][1])
While $LV[$T][1] > 0
$T = Page9_FindControl($LV[$T][1])
If $T <> 0 Then $LV[$T][10] = 1
WEnd
EndFunc
Func Page9_ChangeParent($ID)
Local $Check = 0, $T = Page9_FindControl($ID)
For $i = 1 To $LV[0][0]
If $LV[$i][1] = $ID Then
If $LV[$i][8] <> 0 Then $Check = 1
EndIf
Next
$LV[$T][8] = $Check
If $LV[$T][0] <> -1 Then GUICtrlSetState($LV[$T][0], _Iif($Check = 1, $GUI_CHECKED, $GUI_UNCHECKED))
If $LV[$T][7] <> "" Then Assign($LV[$T][7], $LV[$T][8])
If $LV[$T][1] <> 0 Then Page9_ChangeParent($LV[$T][1])
EndFunc
Func Page9_FindControl($ID)
For $i = 1 To $LV[0][0]
If $LV[$i][0] = $ID Then Return $i
Next
Return 0
EndFunc
Func Page9_FindItem($File)
For $i = 1 To $LV[0][0]
If $LV[$i][3] = $File Then Return $i
Next
Return 0
EndFunc
Func Page9_StateChange($ITEM, $State)
For $Y = 1 To $LV[0][0]
If $LV[$Y][1] = $ITEM Then
$LV[$Y][8] = _Iif($State = 1, 1, 0)
If $LV[$Y][0] <> -1 Then GUICtrlSetState($LV[$Y][0], _Iif($State = 1, $GUI_CHECKED, $GUI_UNCHECKED))
If $LV[$Y][7] <> "" Then Assign($LV[$Y][7], $State)
EndIf
Next
EndFunc
Func Page9_Next()
If $SILENT > 0 Or $EXPRESS = 1 Then
GUIDelete($GUI)
$GUI = $CMD_NA
EndIf
If $Live = 2 Then Return Page31_Repatch()
Page10_Build()
EndFunc
Func Page10_Build()
$Integrate = 10
If $EXPRESS = 1 Or $SILENT = 1 Or($Live = 1 And $BOOT = 0 And $TASK = 0) Or $Live > 1 Then Return Page11_Build()
DirCreate($res & "\Visual\")
FileCopy($Working & "\Pics\Th_*.jpg", $res & "\Visual\")
GUISetState(@SW_DISABLE)
Local $OLD = $GUI
Local $POS = WinGetPos($TITLE)
If @error = 1 Then
$GUI = GUICreate($TITLE, 500, 360)
Else
$GUI = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetFont(9, 400)
GUISetOnEvent($GUI_EVENT_CLOSE, "_CancelAnyPage")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUICtrlCreateTab(115, 35, 360, 260, $TCS_SINGLELINE)
GUICtrlCreateTabItem(_ReadStr("P_10k"))
$Pat[34] = GUICtrlCreateCheckbox(_ReadStr("P_10l"), 125, 65, 330, 20)
If $USEPRO = 1 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page10_UsePro")
$Pat[36] = GUICtrlCreatePic($res & "\Visual\" & _Iif($USEPRO = 1, "Th_Pro", "Th_Home") & ".jpg", 125, 83, 330, 100, $SS_CENTERIMAGE)
Local $lOS = FileGetVersion($KRNL, "DefaultLangCodepage"), $Line, $foo, $File
If $lOS <> "" Then $lOS = "/l " & StringLeft($lOS, 4)
If $lOS <> "0409" Then
$Pat[30] = GUICtrlCreateCheckbox(_ReadStr("P_10m"), 125, 205, 330, 20)
If $Translate = -1 Then GUICtrlSetState(-1, $GUI_DISABLE)
If $Translate = 1 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page10_Translate")
EndIf
If $Live = 0 Then
$Pat[31] = GUICtrlCreateCheckbox(_ReadStr("P_10o"), 125, 225, 330, 20)
If $XPSPRES = 1 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page10_Trans_SP")
Else
If FileExists(@SystemDir & "\SRCLIENT.DLL") And Page10_SafeMode() = 0 Then
$Pat[33] = GUICtrlCreateCheckbox(_ReadStr("P_10r"), 125, 225, 330, 20)
If $SYSREST = 1 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page10_SysRest")
Else
$SYSREST = 0
EndIf
EndIf
If $Live = 0 Then
GUICtrlCreateTabItem(_ReadStr("P_10i"))
$Pat[9] = GUICtrlCreateCheckbox(_ReadStr("P_10b"), 125, 65, 330, 20)
GUICtrlSetOnEvent(-1, "Page10_ResBox")
If $GUI_RES <> "" Then GUICtrlSetState(-1, $GUI_CHECKED)
Local $S = StringSplit("800x600|1024x768|1280x800|1280x1024|1440x900|1600x1200|1680x1050|1920x1200|2560x1600", "|")
For $i = 1 To $S[0]
$Pat[9 + $i] = GUICtrlCreateRadio($S[$i], 145, 65 +(20 * $i), 100, 20)
GUICtrlSetOnEvent(-1, "Page10_ResRadio")
Next
GUICtrlSetState($Pat[11], $GUI_CHECKED)
Page10_ResBox()
GUICtrlCreateCheckbox(_ReadStr("P_10c"), 125, 265, 330, 20)
If $ORB = 1 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page10_Orb")
GUICtrlCreatePic($Working & "\Pics\xptsporb.jpg", 340, 155, 100, 100)
GUICtrlSetOnEvent(-1, "Page10_PreOrb")
EndIf
Page10_SubPage()
GUICtrlCreateTabItem("")
GUICtrlCreateGroup(_ReadStr("P_10a"), 106, 10, 380, 295)
GUICtrlSetFont(-1, 12, 800)
GUICtrlCreateButton("< " & _ReadStr("P_02d"), 240, 325, 80, 25)
GUICtrlSetOnEvent(-1, "Page9_Build")
GUICtrlCreateButton(_ReadStr("Main_46"), 320, 325, 80, 25)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
GUICtrlSetOnEvent(-1, "Page11_Build")
GUICtrlCreateButton(_ReadStr("P_01d"), 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "_CancelAnyPage")
GUISetState()
If $OLD <> 0 Then GUIDelete($OLD)
EndFunc
Func Page10_SafeMode()
Local $Flag = DllCall("user32.dll", "int", "GetSystemMetrics", "long", 67)
Return $Flag[0]
EndFunc
Func Page10_SubPage()
Local $ARR = IniReadSection($Working & "\XPtsp.ini", "_TASKMGR.EXE")
Local $SUB = _Iif($Integrate = 10, 0, 1), $T = _Iif($SUB = 0, 70, 50), $R = _Iif($SUB = 0, 2.6, 2.3)
Local $H = _Iif($SUB = 0, 170, 155), $V = _Iif($SUB = 0, 100, 80), $S
If $BOOT = 1 Then
GUICtrlCreateTabItem(_ReadStr("P_10e"))
GUICtrlCreateLabel(_ReadStr("P_10f"), 120, $T + 5, 200, 20, $SS_RIGHT)
If $SUB <> 0 Then GUICtrlSetFont(-1, 9, 400)
If $BOOT = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)
$Pat[3] = GUICtrlCreateCombo("Green", 330, $T, 110, 20, $CBS_DROPDOWNLIST)
If $SUB <> 0 Then GUICtrlSetFont(-1, 9, 400)
GUICtrlSetData(-1, "Blue|Red|Purple", $BOOTSCR)
If $BOOT = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetOnEvent(-1, "Page10_BootScreen")
$S = $Working & "\Pics\" & _Iif($Type = "Dunno", "H", StringLeft($Type, 1)) & "_" & $BOOTSCR & ".gif"
If FileExists($S) = 0 Then $S = $Working & "\Pics\NoPic.jpg"
$Pat[4] = GUICtrlCreatePic($S, $H, $V, 640 / $R, 480 / $R)
GUICtrlSetOnEvent(-1, "Page10_PreBoot")
If $SUB = 1 Then
$Pat[7] = $BOOTSCR
$Pat[8] = GUICtrlCreateButton(_ReadStr("P_30a6"), 280, 325, 100, 25)
GUICtrlSetOnEvent(-1, "Page30_Boot_Apply")
GUICtrlSetState(-1, $GUI_DISABLE)
EndIf
EndIf
EndFunc
Func Page10_BootScreen()
$BOOTSCR = GUICtrlRead($Pat[3])
GUICtrlSetImage($Pat[4], $Working & "\Pics\" & StringLeft($Type, 1) & "_" & $BOOTSCR & ".gif")
If $Pat[8] <> 0 Then GUICtrlSetState($Pat[8], _Iif($Pat[7] <> $BOOTSCR, $GUI_ENABLE, $GUI_DISABLE))
EndFunc
Func Page10_PreBoot()
Local $S = $Working & "\Pics\" & _Iif($Type = "Dunno", "H", StringLeft($Type, 1)) & "_" & $BOOTSCR & ".GIF"
GUISetState(@SW_DISABLE, $GUI)
GUICreate(_ReadStr("P_10h"), 640, 480, -1, -1, -1, -1, $GUI)
Local $oIE = ObjCreate("Shell.Explorer.2")
If @error = 0 Then
Local $GUIActiveX = GUICtrlCreateObj($oIE, 0, 0, 640, 480)
If $GUIActiveX <> 0 Then
$oIE.navigate("about:blank")
$oIE.document.body.background = $S
$oIE.document.body.scroll = "no"
Else
GUICtrlCreatePic($S, 0, 0, 640, 480)
EndIf
GUICtrlSetOnEvent(-1, "Page10_PreCancel")
EndIf
GUISetOnEvent($GUI_EVENT_CLOSE, "Page10_PreCancel")
GUISetState()
EndFunc
Func Page10_ResBox()
If GUICtrlRead($Pat[9]) = 1 Then
For $i = 10 To 18
If GUICtrlRead($Pat[$i]) = 1 Then $GUI_RES = GUICtrlRead($Pat[$i], 1)
Next
Else
$GUI_RES = ""
EndIf
For $i = 10 To 18
GUICtrlSetState($Pat[$i], _Iif($GUI_RES = "", $GUI_DISABLE, $GUI_ENABLE))
Next
EndFunc
Func Page10_ResRadio()
$GUI_RES = GUICtrlRead(@GUI_CtrlId, 1)
EndFunc
Func Page10_Orb()
$ORB = _Iif(BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_CHECKED), 1, 0)
EndFunc
Func Page10_PreOrb()
GUISetState(@SW_DISABLE, $GUI)
GUICreate("Orb Preview", 354, 354, -1, -1, $WS_POPUPWINDOW, -1, $GUI)
GUICtrlCreatePic($xtra & "\xptsporb.jpg", 0, 0, 354, 354)
GUICtrlSetOnEvent(-1, "Page10_PreCancel")
GUISetOnEvent($GUI_EVENT_CLOSE, "Page10_PreCancel")
GUISetState()
EndFunc
Func Page10_PreCancel()
GUIDelete()
GUISetState(@SW_ENABLE, $GUI)
GUISwitch($GUI)
WinActivate($TITLE)
EndFunc
Func Page10_Translate()
$Translate = _Iif(BitAND(GUICtrlRead($Pat[30]), $GUI_CHECKED), 1, 0)
If $Translate = 0 Then
If MsgBox(0x34, $TITLE, _ReadStr("P_10n"), 0, $GUI) = 7 Then
$Translate = 1
GUICtrlSetState($Pat[30], $GUI_CHECKED)
EndIf
EndIf
EndFunc
Func Page10_Trans_SP()
$XPSPRES = _Iif(BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_CHECKED), 1, 0)
EndFunc
Func Page10_UsePro()
$USEPRO = _Iif(BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_CHECKED), 1, 0)
GUICtrlSetImage($Pat[36], $res & "\Visual\" & _Iif($USEPRO = 1, "Th_Pro", "Th_Home") & ".jpg")
EndFunc
Func Page10_SysRest()
$SYSREST = _Iif(BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_CHECKED), 1, 0)
EndFunc
Func Page11_Build()
Local $OLD = $GUI, $S, $T
$Integrate = 11
DirCreate($Src)
If FileExists($Src & "\XPtsp.log") Then FileWriteLine($Src & "\XPtsp.log", "")
FileWriteLine($Src & "\XPtsp.log", "XPtsp v" & FileGetVersion(@ScriptFullPath) & " " & _ReadStr("P_11a") & ": " & _
@MON & "/" & @MDAY & "/" & @YEAR & " " & @HOUR & ":" & @MIN)
FileWriteLine($Src & "\XPtsp.log", "======================================================================")
GUISetState(@SW_DISABLE)
Local $POS = WinGetPos($TITLE)
If @error = 1 Then
$GUI = GUICreate($TITLE, 500, 360)
Else
$GUI = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetOnEvent($GUI_EVENT_CLOSE, "_CancelAnyPage")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUICtrlCreateGroup(_ReadStr(_Iif($Live = 0, "P_11b", _Iif($Live = 1, "P_11c", _Iif($Live < 5, "P_11d", "P_11e")))), 106, 10, 380, 295)
GUICtrlSetFont(-1, 12, 800)
$Pat[10] = _ReadStr("P_11f") & ":  "
$Pat[11] = _ReadStr("P_11g") & ":  "
$Pat[12] = _ReadStr("Main_30")
$Pat[13] = _ReadStr("Main_51")
$Pat[1] = GUICtrlCreateProgress(200, 255, 270, 15, $PBS_SMOOTH)
$Pat[2] = GUICtrlCreateLabel("0% " & $Pat[10], 120, 255, 80, 20, $SS_RIGHT)
$Pat[3] = GUICtrlCreateProgress(200, 275, 270, 15, $PBS_SMOOTH)
$Pat[4] = GUICtrlCreateLabel(StringFormat($Pat[11], 0, 0), 120, 275, 80, 20, $SS_RIGHT)
$Pat[5] = GUICtrlCreateTreeView(120, 40, 350, 210, BitOR($TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS), $WS_EX_STATICEDGE)
$Pat[9] = GUICtrlCreateButton(_ReadStr("P_01d"), 400, 325, 80, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
If $Live <> 4 Then GUISetState()
If $OLD <> 0 Then GUIDelete($OLD)
For $i = 1 To $LV[0][0]
If $LV[$i][8] = 0 Then $LV[$i][5] = 0
Next
$TIMER = TimerInit()
$NUM = 0
$MAX = 1
$CNT = 1
DirCreate($res)
For $i = 1 To 7
If FileInstall("empty.res", $res & "\comctl" & $i + 32 & ".dll.res", 1) = 0 Then _Error(_FormatStr("Main_03", "COMCTL" & $i + 32 & ".DLL.RES"))
Next
If FileInstall("empty.res", $res & "\UXTHEME.DLL.RES", 1) = 0 Then _Error(_FormatStr("Main_03", "UXTHEME.DLL.RES"))
$S = _Iif($OS = "W2K", "SFC.DLL", "SFC_OS.DLL")
If FileInstall("empty.res", $res & "\" & $S & ".RES", 1) = 0 Then _Error(_FormatStr("Main_03", $S))
$T = _MD5Hash($res & "\sfc_os.dll.res")
IniWrite($res & "\Version.ini", "Pro", "UXTHEME.DLL", $T)
IniWrite($res & "\Version.ini", "Pro", $S, $T)
If $USEPRO = 1 Then
DirRemove($xtra & "\Visual\Home", 1)
DirRemove($res & "\Visual\Home", 1)
EndIf
If $SP3 = 1 Then FileMove($xtra & "\SP3\*", $xtra & "\", 1)
If $Type = "X64" Then
DirCreate($res & "\x64")
If FileInstall("empty.res", $res & "\x64\MSGINA.DLL.RES") Then IniWrite($res & "\Version.ini", "x64", "MSGINA.DLL", $T)
If FileInstall("empty.res", $res & "\x64\SHELL32.DLL.RES") Then IniWrite($res & "\Version.ini", "x64", "SHELL32.DLL", $T)
ElseIf $Type <> "Pro" And FileExists($res & "\" & $Type) = 0 Then
If FileCreateNTFSLink($res & "\Home", $res & "\" & $Type, 1) = 0 Then DirCopy($res & "\Home", $res & "\" & $Type, 1)
$T = IniReadSection($res & "\Version.ini", "Home")
IniWriteSection($res & "\Version.ini", $Type, $T)
EndIf
FileMove($res & "\*_ss.dll", $xtra & "\", 1)
FileMove($res & "\*.mst", $xtra & "\", 1)
FileMove($res & "\*.thm", $xtra & "\", 1)
FileMove($res & "\*.jpg", $xtra & "\", 1)
FileMove($res & "\" & $Type & "\*.res", $res & "\", 1)
If $MCE = 1 Then FileMove($res & "\MCE\*.res", $res & "\", 1)
FileMove($xtra & "\" & $Type & "\*", $xtra & "\", 1)
If $MCE = 1 Then FileMove($xtra & "\MCE\*", $xtra & "\", 1)
If $FullPack = 1 Then
FileMove($res & "\Visual\*", $xtra & "\", 1)
FileMove($res & "\Visual\" & $Type & "\*", $xtra & "\", 1)
If $MCE = 1 Then FileMove($res & "\Visual\MCE\*", $xtra & "\", 1)
FileCopy($Working & "\Boot\*", $res & "\", 1)
FileCopy($Working & "\Boot\" & $Type & "\*", $res & "\", 1)
If $MCE = 1 Then FileCopy($Working & "\Boot\MCE\*", $res & "\", 1)
EndIf
If $BOOT = 1 Then
Page11_FileDup($res & "\blue.res", $res & "\purple.res")
If $Live = 0 Then
Page11_FileDup($res & "\" & $BOOTSCR & ".res", $res & "\ntoskrnl.exe.res")
Page11_FileDup($res & "\" & $BOOTSCR & ".res", $res & "\ntkrnlpa.exe.res")
Page11_FileDup($res & "\" & $BOOTSCR & ".res", $res & "\ntkrnlmp.exe.res")
Page11_FileDup($res & "\" & $BOOTSCR & ".res", $res & "\ntkrpamp.exe.res")
Else
Page11_FileDup($res & "\" & $BOOTSCR & ".res", $res & "\tsp_krnl.exe.res")
EndIf
EndIf
If $OOBE = 0 Then FileDelete($xtra & "\*.JPG")
If $VISUAL = 0 Then
FileDelete($xtra & "\*.MST")
FileDelete($xtra & "\*.DLL")
FileDelete($xtra & "\*.THM")
EndIf
If $SOUND = 0 Then FileDelete($xtra & "\*.wav")
If $SCRSAVER = 0 Then FileDelete($xtra & "\*.scr")
FileDelete($xtra & "\lhmstsc*")
Page11_FileDup($res & "\mstsc.exe.res", $res & "\lhmstsc.exe.res")
Page11_FileDup($res & "\mstscax.dll.res", $res & "\lhmstscx.dll.res")
If $WALL = 1 Then
FileMove($res & "\*.jpg", $xtra & "\", 1)
FileMove($res & "\" & $Type & "\*.jpg", $xtra & "\", 1)
If $MCE = 1 Then FileMove($res & "\MCE\*.jpg", $xtra & "\", 1)
EndIf
If $Live = 0 Then Live0_Run()
If $Live > 0 And $Live < 5 Then Live1_Run()
If $Live = 5 Then Live5_Run()
If FileExists($tmp & "\Logs_32\*.rc") = 1 Or FileExists($tmp & "\Logs_32\*.log") = 1 Then
FileCopy($Src & "\XPtsp.log", $tmp & "\Logs_32\", 1)
Build_Cab($OUTPUT & "\Logs_" & @YEAR & @MON & @MDAY & @HOUR & @MIN & "_32.cab", $tmp & "\Logs_32")
EndIf
If FileExists($tmp & "\Logs_64\*") = 1 Or FileExists($tmp & "\Logs_64\*.log") = 1 Then
FileCopy($Src & "\XPtsp.log", $tmp & "\Logs_64\", 1)
Build_Cab($OUTPUT & "\Logs_" & @YEAR & @MON & @MDAY & @HOUR & @MIN & "_64.cab", $tmp & "\Logs_64")
EndIf
$TIMER = Int(TimerDiff($TIMER) / 1000)
If $Live < 3 Or $Live = 5 Then Page11_Notify(_FormatStr(_Iif($Live = 5, "Main_43", "Main_42"), _FormatStr("P_13l", Int($TIMER / 60), Mod($TIMER, 60))))
If $Live = 0 Then Page12_Build()
If $Live = 1 Or $Live = 2 Or $Live = 3 Or $Live = 5 Then Page13_Build()
EndFunc
Func Page11_FileDup($Src, $DEST)
If FileExists($Src) = 0 Then Return
If FileCreateNTFSLink($Src, $DEST, 1) = 0 Then FileCopy($Src, $DEST, 1)
$Src = StringReplace(StringMid($Src, StringInStr($Src, "\", 0, -1) + 1), ".res", "")
$DEST = StringReplace(StringMid($DEST, StringInStr($DEST, "\", 0, -1) + 1), ".res", "")
IniWrite($res & "\Version.ini", "Pro", $DEST, IniRead($res & "\Version.ini", "Pro", $Src, ""))
EndFunc
Func Page11_Task($Str, $SHOW = 1)
$Pat[6] = $Pat[6] + 1
Local $PER =($Pat[6] / $Pat[7]) * 100
GUICtrlSetData($Pat[3], $PER)
GUICtrlSetData($Pat[4], StringFormat($Pat[11], $Pat[6], $Pat[7]))
Page11_Notify($Str, $SHOW)
EndFunc
Func Page11_Notify($Str, $SHOW = 1)
$NUM += 1
Local $PER =(($NUM / $CNT) *($MAX - $MIN)) + $MIN
$PER = _Min(100, _Max(0, $PER))
GUICtrlSetData($Pat[1], $PER)
GUICtrlSetData($Pat[2], Round($PER, 0) & "% " & $Pat[10])
If $SHOW = 1 Then
Local $i = GUICtrlCreateTreeViewItem($Str, $Pat[5])
GUICtrlSetState($i, $GUI_FOCUS)
FileWriteLine($Src & "\XPtsp.log", $Str)
EndIf
EndFunc
Func Page12_Build()
$Integrate = 11
GUISetState(@SW_DISABLE)
Local $OLD = $GUI, $S = $Src
Local $POS = WinGetPos($TITLE)
If @error = 1 Then
$GUI = GUICreate($TITLE, 500, 360)
Else
$GUI = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetFont(9, 400)
GUISetOnEvent($GUI_EVENT_CLOSE, "Page30_Close")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUICtrlCreateGroup(_ReadStr("P_12a"), 106, 10, 380, 295)
GUICtrlSetFont(-1, 12, 800)
GUICtrlCreateLabel(_FormatStr("P_12b", $TITLE, $Type), 120, 40, 360, 50)
$Pat[1] = GUICtrlCreateCheckbox(_FormatStr("P_12c", $Type), 120, 110, 300, 20)
GUICtrlSetOnEvent(-1, "Page12_ISO")
$Pat[2] = GUICtrlCreateLabel(_ReadStr("P_12d"), 135, 140, 340, 20)
If StringRight($S, 1) = "\" Then $S = StringLeft($S, StringLen($S) - 1)
If StringLen($S) <> 2 Then $S = StringLeft($S, StringInStr($S, "\", 0, -1) - 1)
$Pat[3] = GUICtrlCreateEdit($S & "\XPtsp.iso", 135, 160, 300, 20)
$Pat[4] = GUICtrlCreateButton("...", 445, 160, 30, 20)
GUICtrlSetOnEvent(-1, "Page12_Browse")
$Pat[5] = GUICtrlCreateLabel("Volume Name:", 135, 195, 100, 20)
$Pat[6] = GUICtrlCreateEdit($VOL, 225, 190, 210, 20)
GUICtrlSetOnEvent(-1, "Page12_Volume")
$Pat[7] = GUICtrlCreateProgress(120, 275, 350, 15)
GUICtrlSetState(-1, $GUI_HIDE)
$Pat[8] = GUICtrlCreateLabel("", 120, 255, 350, 20)
GUICtrlSetState(-1, $GUI_HIDE)
$Pat[9] = GUICtrlCreateButton(_ReadStr("P_01c") & " >", 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "Page12_Finish")
Page12_ISO()
If $SILENT = 1 Then Return Page12_Finish()
GUISetState()
If $OLD <> 0 Then GUIDelete($OLD)
EndFunc
Func Page12_ISO()
Local $S = GUICtrlRead($Pat[3]), $T = GUICtrlRead($Pat[6])
$ISO = _Iif(BitAND(GUICtrlRead($Pat[1]), $GUI_CHECKED), $S, "")
GUICtrlSetState($Pat[2], _Iif($ISO <> "", $GUI_ENABLE, $GUI_DISABLE))
GUICtrlSetState($Pat[3], _Iif($ISO <> "", $GUI_ENABLE, $GUI_DISABLE))
GUICtrlSetState($Pat[4], _Iif($ISO <> "", $GUI_ENABLE, $GUI_DISABLE))
GUICtrlSetState($Pat[5], _Iif($ISO <> "", $GUI_ENABLE, $GUI_DISABLE))
GUICtrlSetState($Pat[6], _Iif($ISO <> "", $GUI_ENABLE, $GUI_DISABLE))
If $ISO = "" Then
GUICtrlSetState($Pat[9], $GUI_ENABLE)
Else
GUICtrlSetState($Pat[9], _Iif($ISO = "", $GUI_DISABLE, _Iif(StringInStr($T, " ") <> 0, $GUI_DISABLE, $GUI_ENABLE)))
EndIf
EndFunc
Func Page12_Volume()
Local $Path = GUICtrlRead($Pat[6])
If StringInStr($Path, " ") <> 0 Then
MsgBox(0, "", _ReadStr("P_12e"), 0, $GUI)
GUICtrlSetData($Pat[6], $VOL)
GUICtrlSetState($Pat[6], $GUI_FOCUS)
Else
$VOL = $Path
EndIf
Page12_ISO()
EndFunc
Func Page12_Browse()
Local $OLD = $Working
GUICtrlSetData($Pat[3], FileOpenDialog(_ReadStr("P_12f"), $Src, _ReadStr("P_12g") & " (*.iso)", 2, "XPtsp.iso"))
FileChangeDir($OLD)
Page12_ISO()
EndFunc
Func Page12_Finish()
Local $S = GUICtrlRead($Pat[3]), $T = GUICtrlRead($Pat[6]), $CMD, $A, $B, $Line, $TEMP, $Bar, $lTime
If $ISO = "" Then Return Page13_Build()
While FileExists($T)
If FileDelete($T) = 0 Then
If MsgBox(0x15, $TITLE, _ReadStr("P_12j"), 0, $GUI) = 2 Then Return
EndIf
WEnd
GUISetState(@SW_DISABLE)
GUICtrlSetState($Pat[1], BitOR($GUI_DISABLE, $GUI_UNCHECKED))
Page12_ISO()
GUICtrlSetState($Pat[1], $GUI_CHECKED)
GUICtrlSetState($Pat[7], $GUI_SHOW)
GUICtrlSetState($Pat[8], $GUI_SHOW)
GUICtrlSetState($Pat[9], $GUI_DISABLE)
FileSetAttrib($Src & "\XP.BIN", "-RHS")
FileCopy($Working & "\Programs\XP.BIN", $Src & "\XP.BIN", 1)
FileSetAttrib($Src & "\XP.BIN", "+HS")
$PID = Run($Working & "\Programs\mkisofs -joliet-long -iso-level 2 -N -d -relaxed-filenames -duplicates-once -D -boot-load-size 4 -no-emul-boot " & _
"-volid """ & $T & """ -sysid ""Win32"" -b XP.BIN -o """ & $S & """ """ & $Src & """", $Working & "\Programs", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
While 1
$Line = StderrRead($PID)
If @error Then ExitLoop
$Line = StringLeft($Line, 7)
If StringRight($Line, 1) = "%" Then
GUICtrlSetData($Pat[7], Round(StringLeft($Line, 6), 0))
GUICtrlSetData($Pat[8], GUICtrlRead($Pat[7]) & "% " & _ReadStr("Main_32"))
EndIf
Sleep(100)
WEnd
$PID = 0
GUISetState(@SW_ENABLE)
GUICtrlSetState($Pat[9], $GUI_ENABLE)
If FileExists($S) = 0 Then
GUICtrlSetData($Pat[8], _ReadStr("P_12h"))
GUISetState($Pat[1], $GUI_ENABLE)
GUICtrlSetState($Pat[7], $GUI_HIDE)
GUICtrlSetState($Pat[8], $GUI_HIDE)
Else
GUICtrlSetData($Pat[8], _FormatStr("P_12i", Round(FileGetSize($S) / 1024 / 1024, 2)))
EndIf
EndFunc
Func Page13_Build()
$Integrate = 12
If $REBOOT < 0 Then Page13_Finish()
GUISetState(@SW_DISABLE)
Local $OLD = $GUI
Local $POS = WinGetPos($TITLE)
If @error = 1 Then
$GUI = GUICreate($TITLE, 500, 360)
Else
$GUI = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetFont(9, 400)
GUISetOnEvent($GUI_EVENT_CLOSE, "Page30_Close")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUICtrlCreateGroup(_ReadStr(_Iif($Live = 0, "P_13a", _Iif($Live = 1, "P_13b", _Iif($Live < 5, "P_13c", "P_13d")))), 106, 10, 380, 295)
GUICtrlSetFont(-1, 12, 800)
Local $S = _FormatStr(_Iif($Live = 0, "P_13e", _Iif($Live = 1, "P_13f", _Iif($Live < 5, "P_13g", "P_13h"))), $TITLE) & _
_Iif($Live <> 0, @CRLF & @CRLF & _ReadStr(_Iif($REBOOT, "P_13i", "P_13j"), ""), "")
GUICtrlCreateLabel($S, 120, 40, 360, 100)
If $Live > 0 Then
GUICtrlCreateCheckbox(_ReadStr("P_13k"), 120, 180, 300, 25)
If $REBOOT = 1 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page13_Reboot")
EndIf
GUICtrlCreateLabel(_FormatStr("P_13l", Int($TIMER / 60), Mod($TIMER, 60)), 180, 245, 300, 25)
GUICtrlCreateButton(_ReadStr("P_13m"), 120, 270, 360, 25)
GUICtrlSetOnEvent(-1, "Page13_ViewLog")
GUICtrlCreateButton(_ReadStr("P_13n"), 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "Page13_Finish")
If $SILENT = 1 Then Return Page13_Finish()
GUISetState()
If $OLD <> 0 Then GUIDelete($OLD)
EndFunc
Func Page13_ViewLog()
Run("Notepad """ & $Src & "\XPtsp.log""")
EndFunc
Func Page13_Reboot()
$REBOOT = _Iif($REBOOT = 1, 0, 1)
EndFunc
Func Page13_Finish()
Local $KEY = $HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"
If $Live > 0 Then
If $REBOOT = 1 Or $REBOOT = -2 Then
Program_Cache()
If Shutdown(2 + 4) = 0 Then MsgBox(0x10, $TITLE, _ReadStr("P_13o"), 0, $GUI)
Else
RegWrite($KEY, "IconCache", "REG_SZ", """" & $Src & "\XPtsp.exe"" /CACHE:" & $Live)
EndIf
EndIf
Exit
EndFunc
Func Page30_Build()
If $CMD_NA <> "" Then _Error(_FormatStr("Main_08", $TITLE))
Local $hParent = WinGetHandle("Program Manager")
Local $hListView = ControlGetHandle($hParent, "", "SysListView321")
If FileInstall("Update1.ico", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update1.ico"))
If FileInstall("Update2.ico", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update2.ico"))
If FileInstall("Update3.ico", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update3.ico"))
If FileInstall("Update5.ico", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update5.ico"))
If FileInstall("Update6.ico", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update6.ico"))
If FileInstall("XPtsp.ico", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "XPtsp.ico"))
$Integrate = 30
Local $OLD = $GUI, $POS = WinGetPos($TITLE)
If @error = 1 Then
$GUI = GUICreate($TITLE, 500, 360)
Else
$GUI = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetOnEvent($GUI_EVENT_CLOSE, "Page30_Close")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUICtrlCreateTab(106, 10, 380, 295, $TCS_SINGLELINE)
GUICtrlSetFont(-1, 10, 400)
GUICtrlCreateTabItem(_ReadStr("P_30c1"))
GUICtrlCreateButton("", 120, 45, 54, 54, $BS_ICON)
If FileExists($res) = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetImage(-1, $tmp & "\Update1.ico", -1)
GUICtrlSetOnEvent(-1, "Page31_Repatch")
GUICtrlCreateLabel(_ReadStr("P_30c2"), 180, 65, 300, 34)
If FileExists($res) = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateButton("", 120, 110, 54, 54, $BS_ICON)
If FileExists($res) = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetImage(-1, $tmp & "\Update2.ico", -1)
GUICtrlSetOnEvent(-1, "Page31_Modify")
GUICtrlCreateLabel(_ReadStr("P_30c3"), 180, 130, 300, 34)
If FileExists($res) = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateButton("", 120, 175, 54, 54, $BS_ICON)
GUICtrlSetImage(-1, $tmp & "\Update6.ico", -1)
GUICtrlSetOnEvent(-1, "Page34_Build")
GUICtrlCreateLabel(_FormatStr("P_30c5", $TITLE), 180, 195, 300, 34)
If 1 = 0 Then
GUICtrlCreateButton("", 120, 240, 54, 54, $BS_ICON)
GUICtrlSetImage(-1, $tmp & "\Update6.ico", -1)
GUICtrlSetOnEvent(-1, "Page34_Build")
GUICtrlCreateLabel(_FormatStr("P_30c4", $TITLE), 180, 260, 300, 34)
EndIf
GUICtrlCreateButton(_ReadStr("P_30a6"), 280, 325, 100, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateTabItem(_ReadStr("P_30b1"))
GUICtrlCreateButton("", 120, 45, 54, 54, $BS_ICON)
GUICtrlSetOnEvent(-1, "Page31_Theme")
GUICtrlSetImage(-1, $tmp & "\Update5.ico", -1)
GUICtrlCreateLabel(_ReadStr("P_30b4"), 180, 65, 300, 34)
GUICtrlCreateButton("", 120, 110, 54, 54, $BS_ICON)
If FileExists($res) = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetImage(-1, $tmp & "\Update3.ico", -1)
GUICtrlSetOnEvent(-1, "Page33_Build")
GUICtrlCreateLabel(_ReadStr("P_30b2"), 180, 130, 300, 34)
If FileExists($res) = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)
If 1 = 0 Then
GUICtrlCreateButton("", 120, 175, 54, 54, $BS_ICON)
If FileExists($res) = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetOnEvent(-1, "Page33_Build")
GUICtrlCreateLabel(_FormatStr("P_30b3", $TITLE), 180, 195, 300, 34)
If FileExists($res) = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateButton("", 120, 240, 54, 54, $BS_ICON)
GUICtrlSetOnEvent(-1, "Page33_Build")
GUICtrlCreateLabel(_FormatStr("P_30b5", $TITLE), 180, 260, 300, 34)
EndIf
GUICtrlCreateButton(_ReadStr("P_30a6"), 280, 325, 100, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateTabItem(_ReadStr("P_30f3"))
GUICtrlCreateGroup(_ReadStr("P_30a2"), 120, 40, 350, 50)
$Pat[20] = RegRead($HKCU & "\Control Panel\Desktop\WindowMetrics", "Shell Icon Size")
Local $IS[6] = [32, 48, 64, 96, 128, 256], $Size = $Pat[20]
For $i = 0 To 5
$Pat[21 + $i] = GUICtrlCreateRadio($IS[$i], 150 +($i * 50), 60, 50, 20)
If $IS[$i] = $Size Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page32_Change")
Next
GUICtrlCreateGroup(_ReadStr("P_30a3"), 120, 100, 350, 50)
GUICtrlCreateLabel(_ReadStr("P_30a4") & "  ", 180, 123, 60, 20, $SS_RIGHT)
$Pat[27] = GUICtrlCreateEdit(Page32_SysParamInfo(0x0D) - $Size, 240, 120, 40, 20, BitOR($ES_NUMBER, $SS_CENTER))
GUICtrlSetOnEvent(-1, "Page32_Change")
GUICtrlCreateLabel(_ReadStr("P_30a5") & "  ", 300, 123, 60, 20, $SS_RIGHT)
$Pat[28] = GUICtrlCreateEdit(Page32_SysParamInfo(0x18) - $Size, 360, 120, 40, 20, BitOR($ES_NUMBER, $SS_CENTER))
GUICtrlSetOnEvent(-1, "Page32_Change")
GUICtrlCreateGroup(_ReadStr("P_30a8"), 120, 160, 350, 50)
$Size = _GUICtrlListView_GetView($hListView)
$Pat[40] = GUICtrlCreateRadio(_ReadStr("P_30a9"), 170, 180, 90, 20)
If $Size = 1 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page32_Enable")
$Pat[41] = GUICtrlCreateRadio(_ReadStr("P_30a10"), 260, 180, 90, 20)
If $Size = 3 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page32_Enable")
$Pat[42] = GUICtrlCreateRadio(_ReadStr("P_30a11"), 350, 180, 90, 20)
If $Size = 4 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page32_Enable")
GUICtrlCreateGroup(_ReadStr("P_30a12"), 120, 220, 350, 70)
$Pat[43] = GUICtrlCreateCheckbox(_ReadStr("P_30a13"), 130, 240, 220, 20)
If Page32_SysParamInfo(0x19) Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page32_Enable")
$Pat[44] = GUICtrlCreateCheckbox(_ReadStr("P_30a14"), 130, 260, 220, 20)
If BitAND(WinGetState($hListView), 2) = 0 Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page32_Enable")
GUICtrlCreateButton(_ReadStr("P_30a15"), 350, 240, 110, 30)
GUICtrlSetState(-1, $GUI_DISABLE)
$Pat[45] = GUICtrlCreateButton(_ReadStr("P_30a6"), 280, 325, 100, 25)
GUICtrlSetOnEvent(-1, "Page32_Apply")
GUICtrlSetState(-1, $GUI_DISABLE)
If FileExists($res) Then Page10_SubPage()
GUICtrlCreateTabItem(_ReadStr("P_30d1"))
GUICtrlCreateIcon($tmp & "\XPtsp.ico", 0, 120, 50, 48, 48)
GUICtrlCreateLabel($TITLE, 170, 50, 260, 20, $SS_CENTER)
GUICtrlSetFont(-1, 14, 400)
GUICtrlCreateLabel(_ReadStr("P_30d2") & " " & FileGetVersion(@ScriptFullPath) & @CRLF & $THEME & " XPtsp " & _
_ReadStr("P_30d3"), 170, 70, 260, 40, $SS_CENTER)
GUICtrlSetFont(-1, 10, 400)
Local $S = _FormatStr("P_30d7", $TITLE) & @CRLF & @CRLF & StringReplace(_ReadStr("P_30d8"), "|", @CRLF)
$S = StringFormat($S, "Douglas Orend (aka Dougiefresh)", "Philippe Fleury (aka Bober)", "FixIt", "Fixit", "Amnesia", _
"Ricktendo", "http://forum.oszone.net", "Bober, Fixit, Rubab, Qwesta, Mr.Smartepants")
GUICtrlCreateEdit($S, 120, 110, 350, 130, BitOR($ES_MULTILINE, $ES_READONLY, $ES_AUTOVSCROLL, $WS_VSCROLL))
GUICtrlCreateButton(_ReadStr("P_30d4"), 120, 250, 170, 25)
GUICtrlSetOnEvent(-1, "Page30_About_Home")
GUICtrlCreateButton(_ReadStr("P_30d5"), 300, 250, 170, 25)
GUICtrlSetOnEvent(-1, "Page30_About_Forum")
GUICtrlCreateLabel(_FormatStr("P_30d6", @YEAR), 120, 280, 350, 20, $SS_CENTER)
GUICtrlCreateButton(_ReadStr("P_30a6"), 280, 325, 100, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateTabItem("")
GUICtrlCreateButton(_ReadStr("P_30e"), 390, 325, 100, 25)
GUISetOnEvent($GUI_EVENT_CLOSE, "Page30_Close")
GUICtrlSetOnEvent(-1, "Page30_Close")
GUISetState()
If $OLD <> 0 Then GUIDelete($OLD)
EndFunc
Func Page30_Close()
Exit
EndFunc
Func Page30_Boot_Apply()
Dim $LV[2][10]
$LV[0][0] = 1
$LV[1][3] = "TSP_KRNL.EXE"
$LV[1][5] = 3
$LV[1][6] = FileExists($Src & "\Backup\TSP_KRNL.EXE")
$LV[1][9] = 1
$Live = 3
Page11_Build()
FileMove(@SystemDir & "\TSP_KRNL.EXE.xptsp", @SystemDir & "\TSP_KRNL.EXE", 1)
$REBOOT = 0
Page30_Build()
EndFunc
Func Page30_About_Home()
ShellExecute("http://xptsp.filetap.com/")
EndFunc
Func Page30_About_Forum()
ShellExecute("http://www.wincert.net/forum/index.php?showforum=178")
EndFunc
Func Page31_Modify()
$Live = 2
Page9_Build()
EndFunc
Func Page31_Repatch()
Local $TEMP, $CNT
$TEMP = GUICreate(_ReadStr("P_30c10"), 300, 40, -1, -1, BitOR($WS_BORDER, $WS_POPUP), -1, $GUI)
GUICtrlCreateLabel(_ReadStr("P_30c6"), 10, 10, 280, 20, $SS_CENTER)
GUICtrlSetFont(-1, 9, 800)
GUISetState()
$CNT = Page31_RePatcher()
GUIDelete($TEMP)
GUISetState(@SW_ENABLE, $GUI)
If $CNT = 0 Then
MsgBox(0x40, $TITLE, _ReadStr("P_30c7"), 0, $GUI)
Else
$Live = 3
$SILENT = 0
$SYSREST = 1
Page11_Build()
EndIf
EndFunc
Func Page31_AutoPatch()
If FileExists($res) = 0 Then Exit
TraySetState()
TraySetToolTip(_ReadStr("P_30c10"))
Local $CNT = Page31_RePatcher()
If $CNT = 0 Then Exit
$Live = 4
$SILENT = 1
$SYSREST = 1
TrayTip($TITLE, _ReadNum("P_30c8", $CNT), 30)
TraySetToolTip(_ReadNum("P_30c9", $CNT))
Page11_Build()
If $REBOOT = 1 Then
Local $S = StringReplace(_ReadStr("P_30f2"), "|", @CRLF)
If MsgBox(0x24, $TITLE, _ReadNum("P_30f1", $CNT) & @CRLF & $S, 0, $GUI) = 6 Then Page13_Finish()
EndIf
Exit
EndFunc
Func Page31_RePatcher()
Local $i, $TNUM = 0, $j, $B = 0
FileCopy(@WindowsDir & "\INF\XPtspCom.INF", @WindowsDir & "\INF\XPtspCom.INF.bak", 1)
GUISetState(-1, @SW_DISABLE)
Page6_CheckOS()
$Live = 3
$SILENT = 2
Page9_Build()
GUIDelete($GUI)
$GUI = $CMD_NA
Local $LV2[UBound($LV)][2]
For $i = 1 To $LV[0][0]
If $LV[$i][9] = 1 Then
$j = $LV[$i][6] & $LV[$i][5]
If $j = "01" Or $j = "10" Or $LV[$i][5] = "2" Or $LV[$i][5] = "3" Then
If $LV[$i][3] = "TSP_KRNL.EXE" Then $BOOT = 1
$B += 1
EndIf
Else
$LV[$i][5] = 0
EndIf
Next
If $DEBUG Then _ArrayDisplay($LV, "$LV Array")
Return $B
EndFunc
Func Page31_Theme()
MsgBox(0, "", "Not implemented yet!")
EndFunc
Func Page32_Change()
Local $ICON = GUICtrlRead(@GUI_CtrlId, 1), $IS[6] = [32, 48, 64, 96, 128, 256], $HS[6] = [43, 43, 46, 31, 17, 17]
Page32_Enable()
For $i = 0 To 5
If $ICON = $IS[$i] Then
GUICtrlSetData($Pat[27], $HS[$i])
GUICtrlSetData($Pat[28], $HS[$i])
EndIf
Next
EndFunc
Func Page32_Enable()
GUICtrlSetState($Pat[45], $GUI_ENABLE)
EndFunc
Func Page32_Apply()
Local $IS, $T, $c = 0, $i
GUICtrlSetState($Pat[45], $GUI_DISABLE)
For $i = 0 To 5
If BitAND(GUICtrlRead($Pat[21 + $i]), 5) = 1 Then $IS = GUICtrlRead($Pat[21 + $i], 1)
Next
RegWrite($HKCU & "\Control Panel\Desktop\WindowMetrics", "Shell Icon Size", "REG_SZ", $IS)
Local $hParent = WinGetHandle("Program Manager")
Local $hListView = ControlGetHandle($hParent, "", "SysListView321")
WinSetState($hListView, "", _Iif(GUICtrlRead($Pat[44]) = 4, 1, 0))
If BitAND(GUICtrlRead($Pat[40]), 5) = 1 Then _GUICtrlListView_SetView($hListView, 1)
If BitAND(GUICtrlRead($Pat[41]), 5) = 1 Then _GUICtrlListView_SetView($hListView, 3)
If BitAND(GUICtrlRead($Pat[42]), 5) = 1 Then _GUICtrlListView_SetView($hListView, 4)
$T = _Iif(GUICtrlRead($Pat[43]) = 1, 1, 0)
If Page32_SysParamInfo(0x19) <> $T Then $c += Page32_SysParamInfo(0x26, $T)
$T = GUICtrlRead($Pat[27])
If Page32_SysParamInfo(0x0D) - $IS <> $T Then $c += Page32_SysParamInfo(0x0D, $T + $IS)
$T = GUICtrlRead($Pat[28])
If Page32_SysParamInfo(0x18) - $IS <> $T Then $c += Page32_SysParamInfo(0x18, $T + $IS)
If $c Then
If MsgBox(0x24, $TITLE, _ReadStr("P_30a7")) = 6 Then Shutdown(2 + 4)
EndIf
EndFunc
Func Page32_SysParamInfo($Func, $Pixels = 0)
Local $Param = DllStructCreate("int pixels")
Const $SPIF_SENDCHANGE = 2, $SPIF_UPDATEINIFILE = 1
DllStructSetData($Param, "pixels", DllStructGetSize($Param))
Local $Ret = DllCall("user32.dll", "int", "SystemParametersInfo", "uint", $Func, "uint", $Pixels, _
"ptr", _Iif($Pixels = 0, DllStructGetPtr($Param), 0), "uint", BitOR($SPIF_SENDCHANGE, $SPIF_UPDATEINIFILE))
Return _Iif($Pixels = 0, DllStructGetData($Param, "pixels"), $Ret[0] <> 0)
EndFunc
Func Page33_Build()
Local $File = $tmp & "\Version.ini", $List1, $List2, $List3, $List4, $ITEM, $B = 1, $Size = 0, $T1, $T2
Local $GUIActiveX, $oIE, $Group
_Show_Loading()
$Integrate = 33
GUISetState(@SW_DISABLE)
Local $OLD, $POS = WinGetPos($TITLE)
If @error = 1 Then
$OLD = GUICreate($TITLE, 500, 360)
Else
$OLD = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetFont(9, 400)
GUISetOnEvent($GUI_EVENT_CLOSE, "_CancelAnyPage")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUICtrlCreateGroup(_ReadStr("P_40a"), 106, 10, 380, 295)
GUICtrlSetFont(-1, 12, 800)
GUICtrlCreateLabel(_ReadStr("P_40f"), 120, 40, 350, 20)
$Pat[1] = GUICtrlCreateTreeView(120, 60, 350, 190, BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_CHECKBOXES, $TVS_FULLROWSELECT), $WS_EX_STATICEDGE)
$Pat[2] = GUICtrlCreateLabel("", 120, 260, 350, 30)
GUICtrlCreateButton(_ReadStr("P_40e"), 320, 325, 80, 25)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
GUICtrlCreateButton(_ReadStr("P_01d"), 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "_CancelAnyPage")
If _FindServer($File, "XPtsp\" & $THEME & "\Updates") = 0 Then Return
$List1 = IniRead($File, "XPtsp_v2", "Program", "")
If $List1 = "" Then
MsgBox(0x10, $TITLE, _ReadStr("P_40g"), 0, $GUI)
Return GUIDelete($OLD)
EndIf
$List2 = IniReadSection($File, "Languages")
If @error = 1 Then
MsgBox(0x10, $TITLE, _ReadStr("P_40g"), 0, $GUI)
Return GUIDelete($OLD)
EndIf
$List3 = IniRead($File, "DSI", "Latest", "")
If $List3 = "" Then
MsgBox(0x10, $TITLE, _ReadStr("P_40g"), 0, $GUI)
Return GUIDelete($OLD)
EndIf
$List4 = IniReadSection($File, "Pro")
If @error = 1 Then
MsgBox(0x10, $TITLE, _ReadStr("P_40g"), 0, $GUI)
Return GUIDelete($OLD)
EndIf
Dim $LV[UBound($List2) + UBound($List4) + 4][10] = [[0, 0, 0]]
$ITEM = StringSplit($List1, "|")
$T1 = FileGetVersion(@ScriptFullPath)
If $ITEM[1] > $T1 And($T1 <> "0.0.0.0" Or @Compiled = 0) Then
$LV[0][1] = $B
$LV[$B][0] = GUICtrlCreateTreeViewItem("XP Theme Source Patcher v" & $ITEM[1], $Pat[1])
$LV[$B][1] = -1
$LV[$B][2] = "XPtsp/XPtsp_v" & $ITEM[1] & "_GUI.exe"
$LV[$B][3] = $OUTPUT & "\XPtsp_v" & $ITEM[1] & "_GUI.exe"
$LV[$B][4] = $ITEM[2]
$LV[$B][5] = _ReadStr("P_40c") & ": " & Round($ITEM[2] / 1024, 1) & " kb" & @CRLF & _ReadStr("P_40d") & ": " & _ConvertStamp($ITEM[3])
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page33_Item")
$Size += $ITEM[2]
$B += 1
EndIf
$ITEM = StringSplit($List3, "|")
$T1 = RegRead($HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DriveSpace", "UninstallString")
$T1 = StringReplace(StringLeft($T1, StringInStr($T1, " /") - 1), """", "")
$T1 = FileGetVersion(@ScriptFullPath)
If $ITEM[1] > $T1 And($T1 <> "0.0.0.0" Or @Compiled = 0) Then
$LV[0][2] = $B
$LV[$B][0] = GUICtrlCreateTreeViewItem("Drive Space Indicator v" & $ITEM[1], $Pat[1])
$LV[$B][1] = -1
$LV[$B][2] = "DSI/DriveSpace_v" & $ITEM[1] & "_Silent.exe"
$LV[$B][3] = $OUTPUT & "\DriveSpace_v" & $ITEM[1] & "_Silent.exe"
$LV[$B][4] = $ITEM[2]
$LV[$B][5] = _ReadStr("P_40c") & ": " & Round($ITEM[2] / 1024, 1) & " kb" & @CRLF & _ReadStr("P_40d") & ": " & _ConvertStamp($ITEM[3])
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page33_Item")
$Size += $ITEM[2]
$B += 1
EndIf
If $LV[0][1] = 0 Then
$Group = 0
For $i = 1 To $List2[0][0]
$ITEM = StringSplit($List2[$i][1], "|")
$T1 = IniRead($Working & "\Languages\" & $List2[$i][0], "Info", "Version", "")
If $ITEM[1] > $T1 And $T1 <> "" Then
If $Group = 0 Then
$Group = GUICtrlCreateTreeViewItem(_ReadStr("P_40k"), $Pat[1])
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page33_Parent")
$LV[$B][0] = $Group
$LV[$B][1] = -1
$LV[$B][5] = ""
$B += 1
EndIf
$LV[$B][0] = GUICtrlCreateTreeViewItem($List2[$i][0], $Group)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page33_Item")
$LV[$B][1] = $Group
$LV[$B][2] = "XPtsp/Languages/" & $List4[$i][0]
$LV[$B][3] = $Working & "\Languages\" & $List4[$i][0]
$LV[$B][4] = $ITEM[2]
$LV[$B][5] = _ReadStr("P_40c") & ": " & Round($ITEM[2] / 1024, 1) & " kb" & @CRLF & _ReadStr("P_40d") & ": " & _ConvertStamp($ITEM[3])
$LV[$B][6] = $ITEM[1]
$Size += $ITEM[2]
$B += 1
EndIf
Next
EndIf
$Group = 0
For $i = 1 To $List4[0][0]
$ITEM = StringSplit($List4[$i][1], "|")
$T1 = IniRead($res & "\Version.ini", "Pro", $List4[$i][0], "")
If StringLeft($T1, 32) <> $ITEM[1] Then
If $Group = 0 Then
$Group = GUICtrlCreateTreeViewItem(_ReadStr("P_40b"), $Pat[1])
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page33_Parent")
$LV[$B][0] = $Group
$LV[$B][1] = -1
$LV[$B][5] = ""
$B += 1
EndIf
$LV[$B][0] = GUICtrlCreateTreeViewItem($List4[$i][0], $Group)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "Page33_Item")
$LV[$B][1] = $Group
$LV[$B][2] = "XPtsp/" & $THEME & "/Updates/" & $List4[$i][0]
$LV[$B][3] = $tmp & "\" & $List4[$i][0]
$LV[$B][4] = $ITEM[2]
$LV[$B][5] = _ReadStr("P_40c") & ": " & Round($ITEM[2] / 1024, 1) & " kb" & @CRLF & _ReadStr("P_40d") & ": " & _ConvertStamp($ITEM[3])
$LV[$B][6] = $ITEM[1]
$Size += $ITEM[2]
$B += 1
EndIf
Next
$LV[0][0] = $B
If $B = 1 Then
MsgBox(0x10, $TITLE, _FormatStr("P_40h", $THEME), 0, $GUI)
Return GUIDelete($OLD)
EndIf
GUICtrlSetData($Pat[2], $LV[1][5])
GUISetState()
If $GUI <> 0 Then GUIDelete($GUI)
$GUI = $OLD
EndFunc
Func Page33_Item()
Local $i = 1
While $i <= $LV[0][0]
If @GUI_CtrlId = $LV[$i][0] Then ExitLoop
$i += 1
WEnd
GUICtrlSetData($Pat[2], $LV[$i][5])
EndFunc
Func Page33_Parent()
Local $R = _Iif(BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_CHECKED), $GUI_CHECKED, $GUI_UNCHECKED)
For $i = 1 To $LV[0][0]
If $LV[$i][1] = @GUI_CtrlId Then GUICtrlSetState($LV[$i][0], $R)
Next
Page33_Item()
EndFunc
Func Page34_Build()
If $CMD_NA <> "" Then _Error(_FormatStr("Main_08", $TITLE))
Local $OInt = $Integrate
$Integrate = 34
If FileInstall("Update3.ico", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update3.ico"))
Local $OLD = $GUI
Local $POS = WinGetPos($TITLE)
If @error = 1 Then
$GUI = GUICreate($TITLE, 500, 360)
Else
$GUI = GUICreate($TITLE, 500, 360, $POS[0], $POS[1])
EndIf
GUISetOnEvent($GUI_EVENT_CLOSE, "Page30_Close")
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUICtrlCreatePic($Working & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUICtrlCreateGroup(_FormatStr("P_20a", "XPtsp"), 106, 10, 380, 295)
GUICtrlSetFont(-1, 12, 800)
GUICtrlCreateButton("", 120, 90, 54, 54, $BS_ICON)
If FileExists($Src & "\Backup") = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetImage(-1, $tmp & "\Update3.ico", -1)
GUICtrlSetOnEvent(-1, "Page34_Everything")
GUICtrlCreateLabel(_FormatStr("P_20b", $TITLE), 180, 110, 300, 34)
If FileExists($Src & "\Backup") = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateButton("", 120, 200, 54, 54, $BS_ICON)
GUICtrlSetImage(-1, $tmp & "\Update3.ico", -1)
GUICtrlSetOnEvent(-1, "Page34_Folder")
GUICtrlCreateLabel(_FormatStr("P_20c", $TITLE), 180, 220, 300, 34)
If $OInt <> $Integrate Then
GUICtrlCreateButton("< " & _ReadStr("P_02d"), 240, 325, 80, 25)
GUICtrlSetOnEvent(-1, "Page" & $OInt & "_Build")
EndIf
GUICtrlCreateButton(_ReadStr("P_01d"), 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "Page30_Close")
GUISetState()
If $OLD <> 0 Then GUIDelete($OLD)
EndFunc
Func Page34_Everything()
If MsgBox(0x24, $TITLE, _FormatStr("P_20d", $TITLE), 0, $GUI) = 7 Then Return
$Live = 5
Page11_Build()
EndFunc
Func Page34_Folder()
If MsgBox(0x24, $TITLE, _FormatStr("P_20e", $TITLE), 0, $GUI) = 7 Then Return
Live5_Folder()
MsgBox(0x40, $TITLE, _FormatStr("P_20f", $TITLE), 0, $GUI)
_DeleteScript()
EndFunc
