#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=D:\XPtsp\Source\Builder.ico
#AutoIt3Wrapper_outfile=D:\XPtsp\Builder.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=XPtsp Theme Uploader
#AutoIt3Wrapper_Res_Description=XPtsp Theme Uploader
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=XPtsp Development Team
#AutoIt3Wrapper_Res_Language=1033
#Tidy_Parameters=/kv 1
#AutoIt3Wrapper_Tidy_Stop_OnError=n
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/cs=0 /cn=0 /cf=0 /cv=0 /sf=1
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;================================= ===================================================
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <FTPEx.au3>
#include <GuiTreeView.au3>
#include <String.au3>
#include <GuiEdit.au3>

; Perform some necessary operations before proceeding:
AutoItSetOption("GUICloseOnESC", 1)
AutoItSetOption("GUIOnEventMode", 1)
AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("TrayOnEventMode", 1)
FileChangeDir(@ScriptDir)
If @Compiled = 0 Then FileChangeDir("..")
If 1 = 0 Then Callback(0)

; Perform some minor work before proceeding:
Global $HKCU = "HKCU" & _Iif(@OSArch <> "x86", "64", "")
Global $User = RegRead($HKCU & "\Software\XPtsp\Updater", "Username")
Global $Pass = RegRead($HKCU & "\Software\XPtsp\Updater", "Password")
If $Pass <> "" And $User <> "" Then $Pass = _StringEncrypt(0, $Pass, $User, 2)
Global $tmp = @WorkingDir & "\temp"
DirCreate($tmp)
;if FileInstall("D:\XPtsp\Programs\CABLITE.DLL", $tmp & "\CABLITE.DLL") = 0 then exit MsgBox(0, "", "Problem extracting CABLITE.DLL")
Global $TITLE = "XPtsp Theme Uploader"
Global $CABLITE = DllOpen("Programs\CABLITE.DLL")
;Global $CABLITE = DllOpen($tmp & "\CABLITE.DLL")
If $CABLITE = -1 Then MsgBox(0, "", "Problem opening CABLITE.DLL")
Global $THEME = RegRead($HKCU & "\SOFTWARE\XPtsp\Settings", "Theme")
If @error Then $THEME = "Green"
Global $GUI, $Pat[60], $res, $FTP, $MAX = 0, $NUM = 0, $T1, $T2

; Let's start by contact the XPtsp server:
While 1
	If InetGet("http://www.xptsp.com/XPtsp/Version.php", $tmp & "\Version.ini", 1 + 4) > 0 Then ExitLoop
	If MsgBox(0x2015, $TITLE, "Unable to download ""Version.ini"" file from the server!" & @CRLF & @CRLF & "Uploader requires access to the Internet in " & _
			"order to function." & @CRLF & "Please connect to the Internet so that Uploader can connect.", 0, $GUI) = 2 Then Exit
WEnd

; Start building the GUI:
GUISetState(@SW_DISABLE)
$GUI = GUICreate($TITLE, 500, 360)
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUISetFont(9, 400)
GUISetOnEvent($GUI_EVENT_CLOSE, "CancelAnyPage")
GUICtrlCreatePic(@WorkingDir & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUISetFont(9, 400)
GUICtrlCreateTab(106, 10, 380, 295)

; Settings page:
$Pat[0] = GUICtrlCreateTabItem("Settings")
GUICtrlCreateGroup("FTP Login Credentials:", 120, 40, 350, 80)
GUICtrlSetFont(-1, -1, 800)
GUICtrlCreateLabel("Username: ", 120, 65, 100, 20, $SS_RIGHT)
$Pat[5] = GUICtrlCreateEdit($User, 220, 60, 240, 20, 0)
GUICtrlCreateLabel("Password: ", 120, 95, 100, 20, $SS_RIGHT)
$Pat[6] = GUICtrlCreateEdit($Pass, 220, 90, 240, 20, $ES_PASSWORD)
_GUICtrlEdit_SetPasswordChar(-1, "*")

GUICtrlCreateGroup("Folder Settings:", 120, 130, 350, 160)
GUICtrlSetFont(-1, -1, 800)
GUICtrlCreateLabel("Updating Theme:", 130, 150, 110, 20)
$Pat[4] = GUICtrlCreateCombo("", 240, 145, 220, 20, $CBS_DROPDOWNLIST)
Dim $INI = IniReadSection($tmp & "\Version.ini", "Themes_v3")
If @error = 0 Then
	For $I = 1 To $INI[0][0]
		GUICtrlSetData($Pat[4], $INI[$I][0])
	Next
EndIf
GUICtrlSetData($Pat[4], IniRead($res & "\Version.ini", "Theme", "Name", $INI[1][0]))

GUICtrlCreateLabel("XPtsp Resource Folder to process:", 130, 180, 330, 20)
$Pat[1] = GUICtrlCreateEdit($res, 130, 200, 330, 20, 0)
$Pat[2] = GUICtrlCreateCheckbox("Store Compressed Update Files here:", 130, 230, 330, 20)
$Pat[3] = GUICtrlCreateEdit("", 130, 250, 330, 20, 0)
GUICtrlSetState(-1, $GUI_DISABLE)

; Progress page:
$Pat[10] = GUICtrlCreateTabItem("Progress")
$Pat[11] = GUICtrlCreateTreeView(120, 40, 350, 220, BitOR($TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS), $WS_EX_STATICEDGE)
$Pat[12] = GUICtrlCreateProgress(120, 270, 350, 20, $PBS_SMOOTH)

; Start and Close buttons:
GUICtrlCreateTabItem("")
$Pat[30] = GUICtrlCreateButton("Start", 320, 325, 80, 25)
GUICtrlSetOnEvent(-1, "Process")
GUICtrlSetState(-1, $GUI_DEFBUTTON)
$Pat[31] = GUICtrlCreateButton("Close", 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "CancelAnyPage")
GUISetState()
While 1
	Sleep(100)
WEnd

Func Process()
	Local $Search, $File, $S, $T, $U = False, $A, $Con, $Path, $F, $T2, $Pack
	Local $THEME = GUICtrlRead($Pat[4]), $User = GUICtrlRead($Pat[5])
	$res = GUICtrlRead($Pat[1])

	; Try to open a FTP connection with the server:
	$FTP = _FTP_Open("XPtsp")
	$A = GUICreate($TITLE, 200, 40, -1, -1, $WS_POPUPWINDOW, -1, $GUI)
	GUICtrlCreateLabel("Contacting Server....", 10, 10, 180, 20, $SS_CENTER)
	GUICtrlSetFont(-1, 12, 800)
	GUISetState()
	$Con = _FTP_Connect($FTP, "ftp.xptsp.com", $User, GUICtrlRead($Pat[6]))
	GUIDelete($A)
	GUISwitch($GUI)
	If ($Con = 0) Then
		_FTP_Close($FTP)
		GUICtrlSetState($Pat[5], $GUI_FOCUS)
		Return MsgBox(0, $TITLE, "Invalid Username or Password!", 0, $GUI)
	EndIf
	RegWrite($HKCU & "\Software\XPtsp\Updater", "Username", "REG_SZ", $User)
	RegWrite($HKCU & "\Software\XPtsp\Updater", "Password", "REG_SZ", _StringEncrypt(1, GUICtrlRead($Pat[6]), $User, 2))

	; Find the correct path to store the files:
	GUICtrlSetState($Pat[10], $GUI_SHOW)
	Notify("Theme Processed: " & $THEME)
	Notify("================================================")
	Notify("Getting Version.txt from Server")
	FileDelete($tmp & "\Version.txt")
	$Path = ""
	If _FTP_FileGet($Con, "Updates/Version.txt", $tmp & "\Version.txt") = 0 Then
		$Path = $THEME & "/"
		If _FTP_FileGet($Con, $Path & "Updates/Version.txt", $tmp & "\Version.txt") = 0 Then
			$Path = "public_html/xptsp.com/XPtsp/" & $Path
			If _FTP_FileGet($Con, $Path & "Updates/Version.txt", $tmp & "\Version.txt") = 0 Then
				_FTP_Close($FTP)
				Return MsgBox(0, $TITLE, "Unable to get the Updates file information!", 0, $GUI)
			EndIf
		EndIf
	EndIf
	$S = IniRead($tmp & "\Version.txt", "Theme", "Name", "")
	If $S <> IniRead($res & "\Version.ini", "Theme", "Name", "") Or $S = "" Then
		_FTP_Close($FTP)
		Return MsgBox(0, $TITLE, "Incorrect theme folder for selected theme!")
	EndIf
	Notify("")

	; Open the CABLITE.DLL for use in this script:
	$CABLITE = DllOpen("D:\XPtsp\Programs\CABLITE.DLL")
	If $CABLITE = -1 Then Exit MsgBox(0, "", "Problem opening CABLITE.DLL")
	FileChangeDir(GUICtrlRead($Pat[1]))

	; Counts each of the files in the current directory:
	$Search = FileFindFirstFile("*.res")
	If $Search = -1 Then Exit MsgBox(0, "Error", "No files/directories matched the search pattern")
	While 1
		$File = FileFindNextFile($Search)
		If @error Then ExitLoop
		$MAX += 1
	WEnd
	FileClose($Search)

	; Processes each of the files in the current directory:
	$Search = FileFindFirstFile("*.res")
	While 1
		$File = FileFindNextFile($Search)
		If @error Then ExitLoop
		$NUM += 1
		GUICtrlSetData($Pat[12], $NUM / $MAX * 100)

		; Set $Pack to TRUE if the resources by the specified filename have been changed:
		$Pack = CheckFile($File) Or CheckFile($File, "Home") Or CheckFile($File, "MCE")
		$Pack = $Pack Or CheckFile($File, "X64") Or CheckFile($File, "W2K") Or CheckFile($File, "W2K3")

		; Compress the individual files for that resource ONLY if the resource has changed:
		If $Pack = True Then
			Notify("Uploading " & $File)
			$A = StringReplace($File, ".res", ".7z")
			$F = @WorkingDir & "\" & StringReplace($File, ".res", "")
			RunWait(@ProgramFilesDir & "\7-zip\7z a -r -ms=on -mmt -mx9 """ & @WorkingDir & "\" & $A & """ """ & $F & ".res"" """ & $F & ".rc""", @WorkingDir, @SW_HIDE)
			_FTP_FilePut($Con, @WorkingDir & "\" & $A, $Path & "Updates/" & $A)
			FileDelete(@WorkingDir & "\" & $A)
			$U = True
		EndIf
		Sleep(100)
	WEnd
	FileClose($Search)
	If $U = False Then
		_FTP_Close($FTP)
		Return GUICtrlSetState($Pat[0], $GUI_SHOW)
	EndIf

	; Upload the version information to the server:
	Notify("Uploading Version.txt")
	_FTP_FilePut($Con, $tmp & "\Version.txt", $Path & "Updates/Version.txt", $FTP_TRANSFER_TYPE_ASCII)
	Notify("")

	; Compress and upload the whole folder as the theme package:
	Notify("Building Theme Package")
	ProgressOff()
	FileDelete(@WorkingDir & ".xptsp")
	RunWait(@ProgramFilesDir & "\7-zip\7zG a -r -ms=on -mmt -mx9 """ & @WorkingDir & ".xptsp"" """ & @WorkingDir & "\*""", @WorkingDir)
	Notify("Uploading Theme Package")
	$S = StringMid(@WorkingDir, StringInStr(@WorkingDir, "\", 0, -1) + 1) & ".xptsp"
	_FTP_ProgressUpload($Con, @WorkingDir & ".xptsp", $Path & $S, "Callback")
	Notify("")

	; Notify the user that operation has been completed:
	MsgBox(0, $TITLE, "Operation has been completed!", 0, $GUI)
	GUICtrlSetState($Pat[10], $GUI_SHOW)
EndFunc   ;==>Process

Func Callback($Percent)
	GUICtrlSetData($Pat[12], $Percent)
	Return 1
EndFunc   ;==>Callback

Func CheckFile($File, $Section = "Pro")
	Local $F = @WorkingDir & "\" & _Iif($Section <> "Pro", $Section & "\", "") & $File
	If FileExists($F) = 0 Then Return False
	Local $T = FileGetTime($F, 0, 1), $S
	Local $T2 = IniRead($tmp & "\Version.txt", $Section, StringReplace($File, ".res", ""), ",")
	If StringRight($T2, 2) = ",1" Then $T2 = StringTrimRight($T2, 2)
	$T2 = StringMid($T2, StringInStr($T2, ",", 0, -1) + 1)
	If $T > $T2 Then
		$S = MD5Hash($F) & "|" & FileGetSize($F) & "|" & $T
		IniWrite("Version.ini", $Section, StringReplace($File, ".res", ""), $S)
		IniWrite($tmp & "\Version.txt", $Section, StringReplace($File, ".res", ""), StringReplace($S, "|", ",") & ",1")
		Return True
	EndIf
	Return False
EndFunc   ;==>CheckFile

Func Notify($Str)
	Local $I = GUICtrlCreateTreeViewItem($Str, $Pat[11])
	GUICtrlSetState($I, $GUI_FOCUS)
EndFunc   ;==>Notify

Func CancelAnyPage()
	Exit
EndFunc   ;==>CancelAnyPage

Func MD5Hash($SFile)
	Local $sBuffer = DllStructCreate("char[33]")
	DllCall($CABLITE, 'dword', 'MD5FileHex', 'str', $SFile, 'ptr', DllStructGetPtr($sBuffer))
	Local $sHash = DllStructGetData($sBuffer, 1)
	$sBuffer = 0
	Return ($sHash)
EndFunc   ;==>MD5Hash