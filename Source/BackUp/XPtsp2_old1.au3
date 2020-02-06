#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=E:\XPtsp\Source\XPtsp.ico
#AutoIt3Wrapper_Outfile=E:\XPtsp\XPtsp.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=Patches/Overwrites default Windows XP resources
#AutoIt3Wrapper_Res_Description=XP Theme Source Patcher
#AutoIt3Wrapper_Res_Fileversion=3.0.0.20
#AutoIt3Wrapper_Res_LegalCopyright=XPtsp Development Team
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_res_requestedExecutionLevel=requireAdministrator
#Tidy_Parameters=/kv 1
#AutoIt3Wrapper_Tidy_Stop_OnError=n
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/striponly
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;====================================================================================
#include <Constants.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <GDIPlus.au3>
#include <Date.au3>
#include <Math.au3>
#include <GuiTreeView.au3>
#include <GuiListView.au3>
#include <String.au3>
#include <GuiEdit.au3>
#include <Array.au3>

; Perform some necessary operations before proceeding:
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

; Define necessary variables for this script:
Global $Integrate = _Iif(@Compiled = 0, 10, 0)
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
Global $BackDir = $tmp & "\Backup"
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
Global $Palette, $OCNT, $TIMER, $LV[10][11], $MIN, $MAX, $NUM, $CNT, $Pat[100], $I, $FORMAT
Global $List, $REP, $THEME_FILE, $XPACK_FILE, $Con, $ResList, $ArchList, $PID, $TREE, $WEBSITE
Global $VOL, $ISO, $QTBAR, $QTBAR, $ViStart, $Src, $KB_Line, $GUI, $KB_Cnt, $TASKMGRx2
Global $DOTNET, $REBOOT, $SFC, $GUI_RES, $LANG, $BACKGROUND, $CMD_NA

; Include the 7zip.au3 UDF here because it causes errors if included with rest of the UDF's:
#include <7zip.au3>

; Perform some minor work before proceeding:
$CABLITE = DllOpen("Programs\CABLITE.DLL")
If $CABLITE = -1 Then MsgBox(0, "", "Problem opening CABLITE.DLL")
If Abs(1) = 0 Then _IncludeFunc() ; <= Required to include functions called by "Execute" function!
If @Compiled = 0 Then $DEBUG = 1

; Determine current settings, if they are present:
$THEME = RegRead($HKCU & "\SOFTWARE\XPtsp\Settings", "Theme")
If @error Then $THEME = "Green"
$FullPack = RegRead($HKCU & "\SOFTWARE\XPtsp\Settings", "Full_Pack")
If @error Then $FullPack = 1
$BOOTSCR = RegRead($HKCU & "\SOFTWARE\XPtsp\Settings", "BootScr")
If @error Then $BOOTSCR = "Green"
$TASKMGR = RegRead($HKCU & "\SOFTWARE\XPtsp\Settings", "TaskMgr")
If @error Then $TASKMGR = "Green"
$LANG = RegRead($HKCU & "\SOFTWARE\XPtsp\Settings", "Language")
If @error Or (FileExists($Working & "\Languages\" & $LANG & ".ini") = 0) Then $LANG = ""
If $LANG = "" Then _AutoDetect()
If $LANG = "" Then _Error("No language files found in ""Languages"" folder!")
$Src = RegRead($SET, "InstalledPath")
If @error = 0 Then
	If FileExists($Src & "\XPtsp.exe") And $Src = @ScriptDir Then $Integrate = 30
EndIf
$FORMAT = IniRead($Working & "\Language\" & $LANG & ".ini", "Strings", "Main_05", "_IIf($a>1,2,1)")

; Retrieve the current settings for the script:
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

; These actions get processed before any language handling occurs:
If $CMDLINE[0] > 0 Then
	For $I = 1 To $CMDLINE[0]
		If StringLeft($CMDLINE[$I], 7) = "/CACHE:" Then
			Program_Cache(1)
			Exit
		ElseIf $CMDLINE[$I] = "/CACHE:5" Then
			Program_Cache(1)
			_DeleteScript()
		ElseIf StringLeft($CMDLINE[$I], 9) = "/SVCPACK" Then
			Program_SvcPack()
		ElseIf $CMDLINE[$I] = "/RECOVER" Then
			Program_Recover()
		ElseIf $CMDLINE[$I] = "/OEMINFO" Then
			OEM_Info()
			Exit
		ElseIf $CMDLINE[$I] = "/UPDATE" Then
			Program_Update()
		EndIf
	Next
EndIf
_GDIPlus_Startup()

; Make the program exit with error message if there is already a copy of the program running:
If _Singleton("XPtsp_Patcher", 1) = 0 And @Compiled Then _Error(_FormatStr("Main_01", $TITLE))

; Create the SysNative junction in order to circumvent the x64 redirection:
If @OSArch <> "x86" And FileExists(@WindowsDir & "\SysNative") = 0 Then
	RegWrite($HKCU & "\Software\Sysinternals\Junction", "EulaAccepted", "REG_DWORD", 1)
	RunWait($Working & "\Programs\Junction """ & @WindowsDir & "\SysNative"" """ & @WindowsDir & "\system32""", $Working, @SW_HIDE)
	FileSetAttrib(@WindowsDir & "\SysNative", "+HS")
EndIf

; Read & fix the INI Sections responsible for Live Patching:
_Resolve_LiveDest()
$REP = IniReadSection($Working & "\XPtsp.ini", "Live.Replace")
If @error = 1 Then _Error(_FormatStr("Main_02", "Live.Replace"))
_FixDest($REP)

; Process command-line parameters:
If $CMDLINE[0] > 0 Then
	For $I = 1 To $CMDLINE[0]
		If $CMDLINE[$I] = "/INTEGRATE" Then
			$Live = 0
			$SILENT = 1
		ElseIf StringLeft($CMDLINE[$I], 11) = "/INTEGRATE:" Then
			$Live = 0
			$Src = StringReplace($CMDLINE[$I], "/INTEGRATE:", "")
			$SILENT = 1
		ElseIf $CMDLINE[$I] = "/PASSIVE" Or $CMDLINE[$I] = "/SILENT" Or $CMDLINE[$I] = "/S" Then
			$Live = 1
			$SILENT = 1
		ElseIf $CMDLINE[$I] = "/MODIFY" Then
			If FileExists($Src & "\XPtsp.exe") = 0 Then _Error(_FormatStr("Main_04", "/MODIFY"))
			$Integrate = 5
			$Live = 2
		ElseIf $CMDLINE[$I] = "/APPLET" Then
			$Integrate = 30
		ElseIf $CMDLINE[$I] = "/REPATCH" Then
			$Integrate = 31
		ElseIf $CMDLINE[$I] = "/AUTOPATCH" Then
			$Integrate = 32
		ElseIf $CMDLINE[$I] = "/UNINSTALL" Then
			$Integrate = 34
		ElseIf $CMDLINE[$I] = "/DEBUG" Then
			$DEBUG = 1
		Else
			$CMD_NA = $CMD_NA & " " & $CMDLINE[$I]
		EndIf
	Next
EndIf

; Call a routine to create the GUI for the user:
If $Integrate = 0 Then Page0_Build() ; <= Language Selection
If $Integrate = 1 Then Page1_Build() ; <= Welcome Screen
If $Integrate = 2 Then Page2_Build() ; <= License Agreement
If $Integrate = 3 Then Page3_Build() ; <= Choose Live or Integration
If $Integrate = 4 Then Page4_Build() ; <= Choose Express or Custom Method
If $Integrate = 5 Then Page5_Build() ; <= Integration: Source Folder Selection
If $Integrate = 6 Then Page6_Build() ; <= Live: Installation Folder
If $Integrate = 7 Then Page7_Build() ; <= Resource Package Selection/Downloader
If $Integrate = 8 Then Page8_Build() ; <= Extra Package Selection/Downloader
If $Integrate = 9 Then Page9_Build() ; <= Component Selection
If $Integrate = 10 Then Page10_Build() ; <= Additional Options
If $Integrate = 11 Then Page11_Build() ; <= Install or Integrate
If $Integrate = 12 Then Page12_Build() ; <= ISO Creation
If $Integrate = 13 Then Page13_Build() ; <= Completion Page
If $Integrate = 30 Then Page30_Build() ; <= Control Panel Applet Page
If $Integrate = 31 Then Page31_Repatch() ; <= Program launched with "/Repatch" switch
If $Integrate = 32 Then Page31_AutoPatch() ; <= Program launched with "/Autopatch" switch
If $Integrate = 33 Then Page33_Build() ; <= Updates Page
If $Integrate = 34 Then Page34_Build() ; <= Uninstall Page
While 1
	Sleep(100)
WEnd

;====================================================================================
; Function that deals with cleaning up the XPtsp folder:
;====================================================================================
Func OnAutoItExit()
	DirRemove($mcabtmp, 1)
	If $CABLITE <> -1 Then DllClose($CABLITE)
	If IsDeclared("hDLL_7ZIP") Then DllClose($hDLL_7ZIP)
	If $PID <> 0 Then ProcessClose($PID)
	If $Live < 2 Then DirRemove(@ScriptDir, 1)
	_GDIPlus_Shutdown()
EndFunc   ;==>OnAutoItExit

;====================================================================================
; Functions dealing with command-line parameters:
;====================================================================================
Func Program_Cache($Run = 0)
	; Kill any instances of Explorer before proceeding:
	RunWait(@ScriptDir & "\Programs\Process -k Explorer.exe", @ScriptDir, @SW_HIDE)

	; Remove all Icon Caches from all user profiles:
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

	; Restart Explorer if requested to do so:
	If $Run > 0 Then Run("Explorer")
EndFunc   ;==>Program_Cache

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
EndFunc   ;==>Program_Recover

Func Program_SvcPack()
	Local $NUM = 33, $MD5, $S

	; Put a copy of the contents of this folder into the XPtsp folder in Program Files:
	$Src = @ProgramFilesDir & "\XPtsp"
	DirCopy(@ScriptDir & "\", $Src & "\", 1)

	; Extract the resource package into the XPtsp\Resources folder:
	DirCreate($Src & "\Archive")
	$THEME_FILE = RegRead($SET & "\Settings", "ThemeFile")
	If FileExists($THEME_FILE) Then
		_FileCopyWithProgress($THEME_FILE, $Src & "\Archive\" & $THEME & ".xptsp")
		_Unpack_7z($Src & "\Archive\" & $THEME & "xptsp", $res & "\")
		FileMove($res & "\LOGO.JPG", $Src & "\Pics\", 1)
	EndIf

	; Extract backups from the source folder if present:
	$S = StringLeft($THEME_FILE, StringInStr($THEME_FILE, "\", -1)) & "\XPTSPBAK.CAB"
	If FileExists($S) Then Expand_CAB($S, $Src & "\Backup")
	DirCreate($Src & "\Backup")
	$S = StringLeft($THEME_FILE, StringInStr($THEME_FILE, "\", -2)) & "\AMD64\XPTSPBAK.CAB"
	If FileExists($S & "\XPTSPBAK.CAB") Then Expand_CAB($S, $Src & "\Backup64")

	; Add necessary information to the registry:
	_Registry_Info()
	$S = $HKLM & "\Software\Microsoft\Windows\CurrentVersion\RunOnceEx\987"
	RegWrite($S, "", "REG_SZ", "XPtsp Shortcuts")
	RegWrite($S, "1", "REG_SZ", "rundll32 advpack.dll,LaunchINFSection XPtspCom.inf,Shortcut")

	; Run the OEM Info Generator if required:
	$S = RegRead($SET & "\Settings", "OemGen")
	If @error = 0 And $S = 1 Then OEM_Info()

	; Create the "Live.Dest" section of the XPtsp.ini file:
	$List = IniReadSection($Working & "\XPtsp.ini", "Live.Patch")
	If @error = 1 Then _Error(_FormatStr("Main_02", "Live.Patch"))
	_FixDest($List)
	IniWriteSection($Working & "\XPtsp.ini", "Live.Dest", $List)

	; Patch any other copies of COMCTL32.DLL file and queue for replacement next reboot:
	If _WinSxS_Folders() > 0 Then
		$MD5 = IniRead($INF, "Pro", "COMCTL32.DLL", "")
		$MD5 = StringMid($MD5, StringInStr($MD5, "|", 0, -1) + 1)
		While 1
			$S = IniRead($INF, "Live.Patch", "COMCTL" & $NUM & ".DLL", "")
			If $S = "" Then ExitLoop
			$S = StringReplace($S, "%Win%", @WindowsDir)
			FileCopy($S, $S & ".xptsp", 1)
			_Hex_COMCTL32_DLL($S & ".xptsp")
			_Post_COMCTL32_DLL($S & ".xptsp")
			Live1_ReplaceAtReboot($S & ".xptsp", $S)
			$S = $S & ".xptsp"
			IniWrite($INF, "Pro", "COMCTL" & $NUM & ".DLL", FileGetVersion($S) & "|" & FileGetSize($S) & "||" & $MD5)
			$NUM += 1
		WEnd
	EndIf
	Exit
EndFunc   ;==>Program_SvcPack

Func Program_Update()
	; Make sure that XPtsp is actually installed before proceeding:
	Local $tmp_a
	If $Src = "" Then _Error(_ReadStr("NOINST"))

	; Force other copies of XPtsp.exe to close, then copy other new files to specified folder:
	While 1
		$tmp_a = ProcessList("XPtsp.exe")
		If $tmp_a[0][0] <= 1 Then ExitLoop
		For $I = 1 To $tmp_a[0][0]
			If $tmp_a[$I][1] <> @AutoItPID Then ProcessClose($tmp_a)
		Next
	WEnd
	_CopyDirWithProgress($Working, $Src)
	Run($Src & "\XPtsp.exe")

	; Update version number shown in Add/Remove Programs:
	RegWrite($HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\XPtsp", "DisplayVersion", "REG_SZ", FileGetVersion(@ScriptFullPath))
	Exit
EndFunc   ;==>Program_Update

;====================================================================================
; Function dealing with OEM Information Generation:
;====================================================================================
Func OEM_Info()
	; Define the variables:
	Local $REGMODE = 1, $KEY = 0, $KEYISVISIBLE = 1, $Handle, $File
	Local $CDROM = "", $S, $WINNTSIF = "", $SrcP, $LangID, $PN, $CSDV, $CV, $BUILD
	Local $n = 0, $KB_Line = "", $PK = "", $oi, $INI, $n, $KEY
	Local $UPDATESDIR = @WindowsDir & "\system32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}"
	If FileExists($OEMFILE) Then Return

	; Gather all necessary information:
	If FileInstall("oemlogo.bmp", @WindowsDir & "\system32\", 1) = 0 Then _Error(_FormatStr("Main_03", "OEMLOGO.BMP"))
	For $J = 1 To 24
		$S = StringMid("CDEFGHIJKLMNOPQRSTUVWXYZ", $J, 1)
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

	; Begin building the OEMINFO.INI file:
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

	; Process all updates present on the system:
	If $REGMODE = 1 Then
		FileDelete($tmp & "\List.ini")
		FileWriteLine($tmp & "\List.ini", "[Updates]")
		If FileInstall("ListKB.bat", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "ListKB.bat"))
		RunWait(@ComSpec & " /c ListKB >> List.ini", $tmp, @SW_HIDE)
		$INI = IniReadSection($tmp & "\List.ini", "Updates")
		If @error = 0 Then
			If $INI[0][0] > 0 Then
				For $J = 1 To $INI[0][0]
					OEM_KB($INI[$J][0])
					$n += 1
				Next
			EndIf
		EndIf
		FileDelete($tmp & "\List.ini")
		FileDelete($tmp & "\ListKB.bat")
	Else
		$Handle = FileFindFirstFile($UPDATESDIR & "\KB*")
		If $Handle <> -1 Then
			While 1
				$File = FileFindNextFile($Handle)
				If @error Then ExitLoop
				OEM_KB(StringReplace($File, ".cat", ""))
				$n += 1
			WEnd
		EndIf
		FileClose($Handle)
	EndIf
	If $KB_Cnt > 0 Then OEM_KB("", 1)
	OEM_Support(_ReadStr("Main_13") & " (" & $n & "):", $oi)
	Return 1
EndFunc   ;==>OEM_Info

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
EndFunc   ;==>OEM_KB

Func OEM_Support($KB_Line, $NUM = $KB_Line)
	IniWrite($OEMFILE, "Support Information", "Line" & $NUM, $KB_Line)
	$KB_Line += 1
EndFunc   ;==>OEM_Support

;====================================================================================
; String handling functions:
;====================================================================================
Func _ReadStr($NUM, $Section = "Strings")
	Local $T = IniRead($Working & "\Languages\" & $LANG & ".ini", $Section, $NUM, "")
	If $T = "" And $LANG <> "English" Then $T = IniRead($Working & "\Languages\English.ini", $Section, $NUM, "")
	Return $T
EndFunc   ;==>_ReadStr

Func _FormatStr($Line, $A, $B = "")
	Local $tmp_a = _ReadStr($Line)
	If StringInStr($tmp_a, "%s2") > 0 Then Return StringFormat(StringReplace($tmp_a, "%s2", "%s"), $B, $A)
	Return StringFormat($tmp_a, $A, $B)
EndFunc   ;==>_FormatStr

Func _ReadNum($NUM, $A)
	Local $Str = _ReadStr($NUM), $Element = 99, $ARR
	$Element = Execute($FORMAT)
	$ARR = StringSplit($Str, "|")
	If IsArray($ARR) = 0 Then Return $Str
	$Element = _Max(1, _Min($ARR[0], $Element))
	Return StringFormat($ARR[$Element], $A)
EndFunc   ;==>_ReadNum

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
EndFunc   ;==>_AutoDetect

;====================================================================================
; Functions dealing with filename resolution:
;====================================================================================
Func _Resolve_LiveDest()
	Local $F = $Working & "\XPtsp.ini", $S, $I, $J, $SHL = @WindowsDir & "\INF\SHL_IMG.INF"

	; Resolve all filenames to their proper locations:
	$List = IniReadSection($Working & "\XPtsp.ini", "Live.Dest")
	If @error = 1 Then
		; Update the default filenames for the Windows XP sounds:
		$I = IniReadSection($F, "Live.Sounds")
		If @error = 0 Then
			For $J = 1 To $I[0][0]
				$S = RegRead($HKCU & "\" & $I[$J][1] & "\.Default", "")
				If @error = 0 Then
					$S = StringReplace(StringReplace($S, "%SystemRoot%\media", "%Media%"), """", "")
					IniWrite($F, "Live.Replace", $I[$J][0], StringReplace($S, @WindowsDir & "\media", "%Media"))
				EndIf
			Next
		EndIf

		; Update the filenames used for the Windows XP images:
		$I = IniReadSection($F, "Live.Images")
		If @error = 0 Then
			For $J = 1 To $I[0][0]
				$S = IniRead($SHL, "Strings", $I[$J][1], $I[$J][0])
				IniWrite($F, "Live.Replace", $I[$J][0], "%Media%\" & StringReplace($S, """", ""))
			Next
		EndIf
		$BACKGROUND = IniRead($SHL, "Strings", IniRead($F, "Live.Images", "BLISS.JPG", ""), "")
		$BACKGROUND = StringReplace(StringReplace($BACKGROUND, ".JPG", ".BMP"), """", "")
		$BACKGROUND = @WindowsDir & "\Web\Wallpaper\" & $BACKGROUND
		IniWrite($F, "Live.Replace", "BLISS.BMP", $BACKGROUND)

		; Resolve the location of all filenames now:
		$List = IniReadSection($Working & "\XPtsp.ini", "Live.Patch")
		If @error = 1 Then _Error(_FormatStr("Main_02", "Live.Patch"))
		_FixDest($List)
	EndIf
EndFunc   ;==>_Resolve_LiveDest

Func _FixDest(ByRef $Files)
	Local $TUSR = EnvGet("UserProfile") & "\Local Settings\Application Data\Microsoft", $I, $S
	Local $LANG = RegRead($HKCU & "\Software\Microsoft\Internet Explorer\International", "AcceptLanguage")
	If @error <> 0 Then $LANG = "en-US"

	For $I = 1 To $Files[0][0]
		$S = StringReplace(StringReplace(StringReplace($Files[$I][1], "%Sys%", @SystemDir), "%Prog%", @ProgramFilesDir), "\en-US\", "\" & $LANG & "\")
		$Files[$I][1] = StringReplace(StringReplace(StringReplace($S, "%Media%", @WindowsDir & "\Media"), "%User%", $TUSR), "%Win%", @WindowsDir)
	Next
	_ArraySort($Files)
EndFunc   ;==>_FixDest

;====================================================================================
; Internal functions:
;====================================================================================
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
EndFunc   ;==>_Reshacker

Func _Keep_Logs($Src, $DST, $ext = "log")
	Local $R = 1, $S = $LOGS & "\" & $DST
	While FileExists($S & " (" & $R & ")." & $ext)
		$R += 1
	WEnd
	FileCopy($Src, $S & " (" & $R & ")." & $ext)
EndFunc   ;==>_Keep_Logs

Func _Check_Writable($Path)
	If DriveStatus($Path) <> "READY" Then Return 0
	Local $I = $Path & "\" & Hex(Random(0, 65536 * 16384, 1)) & Hex(Random(0, 65536, 1))
	Local $R = FileWrite($I, "A")
	If $R Then FileDelete($I)
	Return $R
EndFunc   ;==>_Check_Writable

Func _WinSxS_Folders()
	Local $Handle = FileFindFirstFile(@WindowsDir & "\WinSxS\x86_Microsoft.Windows.Common-Controls*")
	Local $File, $NUM = 33
	If $Handle = -1 Then Return 0
	While 1
		$File = FileFindNextFile($Handle)
		If @error Then ExitLoop
		If FileExists(@WindowsDir & "\WinSxS\" & $File & "\COMCTL32.DLL") Then
			IniWrite($Working & "\XPtsp.ini", "Live.Patch", "COMCTL" & $NUM & ".DLL", "%Win%\WinSxS\" & $File & "\COMCTL32.DLL")
			$NUM += 1
		EndIf
	WEnd
	FileClose($Handle)
	Return $NUM - 33
EndFunc   ;==>_WinSxS_Folders

Func _Trim3Lines($Orig, $Str)
	Local $P = StringInStr($Orig, $Str)
	Local $A = StringLeft($Orig, $P - 1)
	Local $B = StringMid($Orig, $P)
	Local $P = StringInStr($B, @CRLF, 0, 3)
	Local $c = StringMid($B, $P + 2)
	Return $A & $c
EndFunc   ;==>_Trim3Lines

Func _CancelAnyPage()
	If @Compiled = 0 Then Exit
	GUISetState(@SW_DISABLE)
	If MsgBox(0x24, $TITLE, StringReplace(_ReadStr(_ReadStr("P_01d")), "|", @CRLF), 0, $GUI) = 6 Then Exit
	GUISetState(@SW_ENABLE)
EndFunc   ;==>_CancelAnyPage

Func _ConvertStamp($Str)
	Local $MON = StringSplit(_ReadStr("MONTHS"), "|")
	Local $MNUM = StringMid($Str, 5, 2)
	Return $MON[$MNUM] & " " & StringMid($Str, 7, 2) & ", " & StringLeft($Str, 4) & " " & _
			StringMid($Str, 9, 2) & ":" & StringMid($Str, 11, 2) & ":" & StringMid($Str, 13, 2)
EndFunc   ;==>_ConvertStamp

Func _Error($MSG, $ERR = 1)
	ProgressOff()
	MsgBox(0, $TITLE, _Iif($ERR = 1, _ReadStr("Main48") & ": ", "") & $MSG, 0, $GUI)
	Exit
EndFunc   ;==>_Error

Func _DeleteScript()
	; Use batch file to delete this program, since the program can't delete itself:
	FileDelete(@TempDir & "\Scratch.bat")
	FileWrite(@TempDir & "\Scratch.bat", ':loop' & @CRLF & _
			'del "' & @ScriptFullPath & '"' & @CRLF & _
			'if exist "' & @ScriptFullPath & '" goto loop' & @CRLF & _
			'del ' & @TempDir & '\scratch.bat' & @CRLF)
	Run(@TempDir & "\scratch.bat", @TempDir, @SW_HIDE)
	Exit
EndFunc   ;==>_DeleteScript

Func _ImageToBMP($iPath, $ext = "BMP")
	Local $nPath = StringLeft($iPath, StringInStr($iPath, ".", 0, -1)) & $ext
	Local $hImage = _GDIPlus_ImageLoadFromFile($iPath)
	_GDIPlus_ImageSaveToFileEx($hImage, $nPath, _GDIPlus_EncodersGetCLSID(StringRight($ext, 3)))
	_GDIPlus_ImageDispose($hImage)
EndFunc   ;==>_ImageToBMP

Func _MD5Hash($SFile)
	Local $sBuffer = DllStructCreate("char[33]")
	DllCall($CABLITE, 'dword', 'MD5FileHex', 'str', $SFile, 'ptr', DllStructGetPtr($sBuffer))
	Local $sHash = DllStructGetData($sBuffer, 1)
	$sBuffer = 0
	Return ($sHash)
EndFunc   ;==>_MD5Hash

Func _PECheckSum($File)
	RunWait($Working & "\Programs\PECheckSum  -c """ & $File & """", $Working, @SW_HIDE)
	;Return DllCall($CABLITE, 'dword', 'ChecksumPEFile', 'str', $File)
EndFunc   ;==>_PECheckSum

Func _Registry_Info()
	; Uninstallation settings:
	Local $T = $HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\XPtsp"
	RegWrite($T, "DisplayName", "REG_SZ", "XP Theme Source Patcher")
	RegWrite($T, "DisplayVersion", "REG_SZ", FileGetVersion(@ScriptFullPath))
	RegWrite($T, "Comments", "REG_SZ", _ReadStr("Main_44"))
	RegWrite($T, "Publisher", "REG_SZ", "XPtsp Development Team")
	RegWrite($T, "UninstallString", "REG_SZ", """" & $Src & "\XPtsp.exe"" /UNINSTALL")
	RegWrite($T, "URLInfoAbout", "REG_SZ", "http://www.wincert.net/forum/index.php?showtopic=3842")
	RegWrite($T, "URLUpdateInfo", "REG_SZ", "http://www.wincert.net/forum/index.php?showtopic=3842")

	; XPtsp Patcher Settings:
	RegWrite($SET, "InstalledPath", "REG_SZ", $Src)

	; Add 'XPtsp' to Control Panel
	$T = "{8DE84F36-F390-4727-BE44-3E42DD2A3E35}"
	RegWrite($HKCR & "\CLSID\" & $T, "", "REG_SZ", "XPtsp")
	RegWrite($HKCR & "\CLSID\" & $T, "InfoTip", "REG_SZ", _FormatStr("Main_44", $TITLE))
	RegWrite($HKCR & "\CLSID\" & $T & "\DefaultIcon", "", "REG_SZ", $Src & "\XPtsp.exe,0")
	RegWrite($HKCR & "\CLSID\" & $T & "\Shell\Open\Command", "", "REG_SZ", """" & $Src & "\XPtsp.exe"" /APPLET")
	RegWrite($HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\" & $T, "", "REG_SZ", "XPtsp")

	; Run Repatcher every boot:
	RegWrite($HKLM & "\Software\Microsoft\Windows\CurrentVersion\Run", "XPtsp Repatch", "REG_SZ", """" & $Src & "\XPtsp.exe"" /AUTOPATCH")
EndFunc   ;==>_Registry_Info

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
EndFunc   ;==>_Show_Loading

;====================================================================================
; Function dealing with server issues:
;====================================================================================
Func _FindServer($File, $SUB, $ERR = 1)
	Local $HOSTS[4] = [3, _Iif($DEBUG = 1, "localhost:81", ""), "www.xptsp.com", "home.comcast.net/~douglas.orend"], $I

	; Check if the computer is connected to a network:
	If (@IPAddress1 = "0.0.0.0" Or @IPAddress1 = "127.0.0.1") And @IPAddress2 = "0.0.0.0" _
			And @IPAddress3 = "0.0.0.0" And @IPAddress4 = "0.0.0.0" Then
		If $ERR Then MsgBox(0x10, $TITLE, _ReadStr("Main_10"), 0, $GUI)
		Return 0
	EndIf

	; Get current version number from either update server:
	DirCreate($tmp)
	FileDelete($File)
	For $I = 1 To $HOSTS[0]
		If $HOSTS[$I] = "" Then ContinueLoop
		$WEBSITE = "http://" & $HOSTS[$I]
		Local $Bytes = InetGet($WEBSITE & "/" & $SUB & "/Version.php", $File, 4)
		If @error = 0 Then
			Local $S = StringReplace(FileRead($File), @LF, @CRLF)
			FileDelete($File)
			FileWrite($File, $S)
			If IniRead($File, "XPtsp_v2", "Program", "") <> "" Then ExitLoop
		EndIf
	Next
	If $I <= $HOSTS[0] Then Return 1
	If $ERR Then MsgBox(0x10, $TITLE, _FormatStr("Main_11", $TITLE), 0, $GUI)
	Return 0
EndFunc   ;==>_FindServer

Func _Download_File($File, ByRef $DFile)
	Local $DL_TIME, $Handle, $Total = $MAX, $TEMP = 0, $S, $HEADER, $Bar, $Line, $Byte1, $Rate
	Local $T = StringMid($File, StringInStr($File, "/", 0, -1) + 1)

	InetGet($WEBSITE & "/tools/get.php?url=" & $File, $tmp & "\get.html", 1)
	FileDelete($DFile)
	$DL_TIME = TimerInit()
	Local $Handle = InetGet($WEBSITE & "/" & $File, $DFile, 8 + 1, 1)
	If InetGetInfo($Handle, 4) Then
		MsgBox(0, $TITLE, _FormatStr("P_07n", StringMid($File, StringInStr($File, "/", 0, -1) + 1)))
		GUISetState(@SW_ENABLE, $GUI)
		Return 0
	EndIf

	; Create a downloading progress window:
	$TEMP = GUICreate(_ReadStr("P_07h") & "...", 300, 90, -1, -1, BitOR($WS_BORDER, $WS_POPUP), -1, $GUI)
	$HEADER = GUICtrlCreateLabel(_ReadStr("P_07i"), 10, 10, 280, 30, $SS_LEFTNOWORDWRAP)
	GUICtrlSetFont(-1, 10, 800)
	$Bar = GUICtrlCreateProgress(10, 30, 280, 20)
	$Line = GUICtrlCreateLabel("", 10, 55, 280, 30, $SS_LEFTNOWORDWRAP)
	GUISetState(@SW_SHOW, $TEMP)

	; Display progress of download to user:
	Do
		$Byte1 = InetGetInfo($Handle, 0)
		GUICtrlSetData($Bar, ($Byte1 * 100) / $Total)
		$Rate = Round(($Byte1 / 1024) / (TimerDiff($DL_TIME) / 1000), 1)
		$S = _ReadStr("P_07h") & " """ & $T & """..." & @CRLF
		$S = $S & _FormatStr("P_07j", Round($Byte1 / 1024, 0), Round($Total / 1024, 0))
		GUICtrlSetData($Line, $S & " (" & $Rate & " kb/sec)")
		For $J = 1 To 5
			If InetGetInfo($Handle, 2) Then ExitLoop 2
			Sleep(100)
		Next
	Until InetGetInfo($Handle, 2)
	GUIDelete($TEMP)
	InetClose($Handle)
	Return 1
EndFunc   ;==>_Download_File

;====================================================================================
; Function dealing with copying single file with progress bar:
;====================================================================================
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
		$LREAD += (StringLen($FRead) / 2) - 1
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
EndFunc   ;==>_FileCopyWithProgress

;====================================================================================
; Function dealing with unpacking 7z files with progress bar:
;====================================================================================
Func _Unpack_7z($ArcFile, $sOutPut, $Window = 1)
	; Build the "Decompression Progress" GUI for the user's sake:
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
	If StringRight($sOutPut, 1) <> "\" Then $sOutPut = $sOutPut & "\"
	_7ZIPExtractEx($TEMP, $ArcFile, $sOutPut, 1)
	If $Window Then
		_7ZipKillOwnerWindowEx($TEMP)
		GUIDelete($TEMP)
		GUISetState(@SW_ENABLE, $GUI)
		GUISwitch($GUI)
	EndIf
EndFunc   ;==>_Unpack_7z

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
EndFunc   ;==>__Archive_Helper

;====================================================================================
; Function dealing with copying directories with progress bar:
;====================================================================================
Func _CopyDirWithProgress($sOriginalDir, $sDestDir, $MOD = 5)
	; Build the "Copy Folder Progress" GUI for the user's sake:
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
				If Not FileCopy($aFileList[$c], $sDestDir & $FileName, 1) Then;Tries a second time
					If RunWait(@ComSpec & ' /c copy /y "' & $aFileList[$c] & '" "' & $sDestDir & $FileName & '">' & $tmp & '\o.tmp', '', @SW_HIDE) = 1 Then;and a third time, but this time it takes the error message
						$sError = FileReadLine($tmp & '\o.tmp', 1)
						$iOutPut = $iOutPut + 1
						$sLost = $sLost & $aFileList[$c] & '  ' & $sError & @CRLF
					EndIf
					FileDelete($tmp & '\o.tmp')
				EndIf
			EndIf

			FileSetAttrib($sDestDir & $FileName, "+A-RSH");<- Comment this line if you do not want attribs reset.

			$iCopiedSize = $iCopiedSize + FileGetSize($aFileList[$c])
			$fProgress = $iCopiedSize / $iDirSize_Orig
		EndIf
	Next
	GUIDelete($TEMP)
	GUISetState(@SW_ENABLE, $GUI)
	GUISwitch($GUI)
	Return $iOutPut
EndFunc   ;==>_CopyDirWithProgress

Func _FileSearch($sIstr, $bSF = 1)
	; $bSF = 1 means looking in subfolders
	; $sSF = 0 means looking only in the current folder.
	; An array is returned with the full path of all files found. The pos [0] keeps the number of elements.
	Local $sCriteria, $sBuffer, $iH, $iH2, $sCS, $sCF, $sCF2, $sCP, $sFP, $sOutPut = '', $aNull[1]
	$sCP = StringLeft($sIstr, StringInStr($sIstr, '\', 0, -1))
	If $sCP = '' Then $sCP = $Working & '\'
	$sCriteria = StringTrimLeft($sIstr, StringInStr($sIstr, '\', 0, -1))
	If $sCriteria = '' Then $sCriteria = '*.*'

	;To begin we seek in the starting path.
	$sCS = FileFindFirstFile($sCP & $sCriteria)
	If $sCS <> -1 Then
		Do
			$sCF = FileFindNextFile($sCS)
			If @error Then
				FileClose($sCS)
				ExitLoop
			EndIf
			If $sCF = '.' Or $sCF = '..' Then ContinueLoop
			$sOutPut = $sOutPut & $sCP & $sCF & @LF
		Until 0
	EndIf

	;And after, if needed, in the rest of the folders.
	If $bSF = 1 Then
		$sBuffer = @CR & $sCP & '*' & @LF;The buffer is set for keeping the given path plus a *.
		Do
			$sCS = StringTrimLeft(StringLeft($sBuffer, StringInStr($sBuffer, @LF, 0, 1) - 1), 1);current search.
			$sCP = StringLeft($sCS, StringInStr($sCS, '\', 0, -1));Current search path.
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
						$sBuffer = @CR & $sCP & $sCF & '\*' & @LF & $sBuffer;Every folder found is added in the begin of buffer
						$sFP = $sCP & $sCF & '\';                               for future searches
						$iH2 = FileFindFirstFile($sFP & $sCriteria);         and checked with the criteria.
						If $iH2 <> -1 Then
							Do
								$sCF2 = FileFindNextFile($iH2)
								If @error Then
									FileClose($iH2)
									ExitLoop
								EndIf
								If $sCF2 = '.' Or $sCF2 = '..' Then ContinueLoop
								$sOutPut = $sOutPut & $sFP & $sCF2 & @LF;Found items are put in the Output.
							Until 0
						EndIf
					EndIf
				Until 0
			EndIf
			$sBuffer = StringReplace($sBuffer, @CR & $sCS & @LF, '')
		Until $sBuffer = ''
	EndIf

	If $sOutPut = '' Then
		$aNull[0] = 0
		Return $aNull
	Else
		Return StringSplit(StringTrimRight($sOutPut, 1), @LF)
	EndIf
EndFunc   ;==>_FileSearch

Func _Quick_Sort(ByRef $SortArray, $First, $Last);Larry's code
	Dim $Low, $High
	Dim $TEMP, $List_Separator

	$Low = $First
	$High = $Last
	$List_Separator = StringLen($SortArray[($First + $Last) / 2])
	Do
		While (StringLen($SortArray[$Low]) < $List_Separator)
			$Low = $Low + 1
		WEnd
		While (StringLen($SortArray[$High]) > $List_Separator)
			$High = $High - 1
		WEnd
		If ($Low <= $High) Then
			$TEMP = $SortArray[$Low]
			$SortArray[$Low] = $SortArray[$High]
			$SortArray[$High] = $TEMP
			$Low = $Low + 1
			$High = $High - 1
		EndIf
	Until $Low > $High
	If ($First < $High) Then _Quick_Sort($SortArray, $First, $High)
	If ($Low < $Last) Then _Quick_Sort($SortArray, $Low, $Last)
EndFunc   ;==>_Quick_Sort

;====================================================================================
; Functions that deals with finding the palette for XPtsp bootscreen:
;====================================================================================
Func GetPalette_Install()
	$Palette = "00000000151A200046464600D23E2D00016553000535B2007E7E7E0000928900FC7F5E00206BF700FFA68D0004DC8E001BBCF300BCBCBC00FCFCFC00FFFFFF"
	Local $S = RegRead($HKCU & "\SOFTWARE\XPtsp", "Palette")
	If @error = 0 Then $Palette = $S
	Return ($S <> "")
EndFunc   ;==>GetPalette_Install

Func GetPalette_Integration()
	$Palette = "00000000151A200046464600D23E2D00016553000535B2007E7E7E0000928900FC7F5E00206BF700FFA68D0004DC8E001BBCF300BCBCBC00FCFCFC00FFFFFF"
	Local $S = IniRead($INF, "Strings", "Palette", "")
	If $S <> "" Then $Palette = $S
	Local $T = IniRead($INF, "Strings", "TaskMgr", "")
	If $T <> "" And $T <> "LBS" Then $TASKMGR = $T
	Return ($S <> "")
EndFunc   ;==>GetPalette_Integration

;====================================================================================
; Function that deals with compressing files into the CAB format:
;====================================================================================
Func Build_Cab($File, $Folder)
	Local $Handle, $TEMP, $Bar, $A = 0, $B = 0, $hCabLite, $Result, $T, $PER

	; Get total file size of folder that we are compressing:
	$Handle = FileFindFirstFile($Folder & "\*")
	If $Handle <> -1 Then
		While 1
			$TEMP = FileFindNextFile($Handle)
			If @error Then ExitLoop
			$A += FileGetSize($Folder & "\" & $TEMP)
		WEnd
		FileClose($Handle)
	EndIf

	; Begin compressing the folder:
	$Result = DllCall($CABLITE, 'ptr', 'CabStart', 'str', $File, 'ushort', 0)
	$hCabLite = $Result[0]
	$Handle = FileFindFirstFile($Folder & "\*")
	If $Handle <> -1 Then
		While 1
			$TEMP = FileFindNextFile($Handle)
			If @error Then ExitLoop
			DllCall($CABLITE, 'ushort', 'CabAdd', 'ptr', $hCabLite, 'str', $Folder & "\" & $TEMP, 'ptr', 0)
			$B += FileGetSize($Folder & "\" & $TEMP)
			$PER = ($B / $A) * 100
			GUICtrlSetData($Pat[1], $PER)
			GUICtrlSetData($Pat[2], Round($PER) & "% " & $Pat[10])
		WEnd
		FileClose($Handle)
	EndIf
	DllCall($CABLITE, 'dword', 'CabFinish', 'ptr', $hCabLite)
EndFunc   ;==>Build_Cab

;====================================================================================
; Function that deals with copying files listing in specified INI section:
;====================================================================================
Func Copy_Section($Section, $From = $xtra, $Out = "")
	Local $Files
	If $Out = "" Then $Out = $Src & "\i386"
	$Files = IniReadSection($tmp & "\XPSect.ini", $Section)
	If @error = 0 Then
		$CNT = $Files[0][0]
		If $Files[0][0] > 0 Then
			For $I = 1 To $Files[0][0]
				If FileExists($From & "\" & $Files[$I][0]) = 1 Then
					Page11_Notify("- " & _ReadStr("Main_29") & " " & StringUpper($Files[$I][0]))
					FileCopy($From & "\" & $Files[$I][0], $Out & "\" & $Files[$I][0], 1)
				EndIf
			Next
			Return 1
		EndIf
	EndIf
	Return 0
EndFunc   ;==>Copy_Section

;====================================================================================
; Function that deals with compressing files listing in specified INI section:
;====================================================================================
Func Compress_Section($Section, $From = $xtra, $Out = "", $Check = 0)
	Local $Files
	If $Out = "" Then $Out = $Src & "\i386"
	$Files = IniReadSection($tmp & "\XPSect.ini", $Section)
	If @error = 0 Then
		$CNT = $Files[0][0]
		If $Files[0][0] > 0 Then
			For $I = 1 To $Files[0][0]
				If FileExists($From & "\" & $Files[$I][0]) = 1 Then
					Page11_Notify("- " & _FormatStr("Main_23", StringUpper($Files[$I][0])))
					Compress_File($From & "\" & $Files[$I][0], $Out & "\" & $Files[$I][0], $Check)
				EndIf
			Next
			Return 1
		EndIf
	EndIf
	Return 0
EndFunc   ;==>Compress_Section

;====================================================================================
; Function that deals with compressing the specified file:
;====================================================================================
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
EndFunc   ;==>Compress_File

;====================================================================================
; Functions that deals with building the section listings:
;====================================================================================
Func Build_Section($SECT, $Dir = "", $Folder = $res, $ResOnly = 1)
	Local $Handle, $File, $Out, $FTmp, $X = 0, $J, $Attrib
	If $Dir = "" Then $Dir = $Src & "\i386"
	$Handle = FileFindFirstFile($Folder & "\" & _Iif($ResOnly = 1, "*.res", "*"))
	If $Handle <> -1 Then
		While 1
			$File = FileFindNextFile($Handle)
			If @error Then ExitLoop
			$Attrib = FileGetAttrib($Folder & "\" & $File)
			If @error Then ContinueLoop
			If StringInStr($Attrib, "D") Then ContinueLoop
			If $ResOnly = 0 And StringRight($File, 4) = ".res" Then ContinueLoop
			$File = StringReplace($File, ".res", "")
			$Out = $File
			If $ResOnly Then
				$J = Page9_FindItem($File)
				$J = $LV[$J][6] & $LV[$J][5]
				If $J = "00" Or $J = "11" Then ContinueLoop
			EndIf
			If FileExists($Dir & "\" & $Out) = 0 Then $Out = StringLeft($Out, StringLen($Out) - 1) & "_"
			If FileExists($Dir & "\" & $Out) = 0 Then ContinueLoop
			IniWrite($tmp & "\XPSect.ini", $SECT, StringUpper($File), StringUpper($Out))
			$X = 1
		WEnd
	EndIf
	Return $X
EndFunc   ;==>Build_Section

;====================================================================================
; Functions that deals with expanding the specified file:
;====================================================================================
Func Expand_File($Source, $DEST = $tmp)
	Local $File = StringReplace(StringMid($Source, StringInStr($Source, "\", 0, -1) + 1), ".xptsp", "")
	If StringRight($Source, 1) <> "_" Then Return $Source
	DirCreate($tmp & "\Extracted")
	DllCall($CABLITE, 'ushort', 'CabExtract', 'str', $Source, 'str', $tmp & "\Extracted\", 'ptr', 0)
	Local $Handle = FileFindFirstFile($tmp & "\Extracted\*")
	If $Handle <> -1 Then
		$File = FileFindNextFile($Handle)
		FileMove($tmp & "\Extracted\" & $File, $DEST & "\" & $File, 1)
	EndIf
	FileClose($Handle)
	DirRemove($tmp & "\Extracted", 1)
	Return $DEST & "\" & $File
EndFunc   ;==>Expand_File

Func Expand_CAB($Source, $DEST = "")
	If $DEST <> "" Then DirRemove($mcabtmp, 1)
	DllCall($CABLITE, 'ushort', 'CabExtract', 'str', $Source, _Iif($DEST <> "", 'str', 'ptr'), _Iif($DEST <> "", $DEST, 0), 'ptr', 0)
	$mcabtmp = _Iif($DEST <> "", StringReplace($Source, ".CAB", ""), $DEST)
EndFunc   ;==>Expand_CAB

;====================================================================================
; Function that deals with patching files in the specified INI section:
;====================================================================================
Func Edit_Section($Section, $Out = "")
	If $Out = "" Then $Out = $Src & "\i386"
	Local $Files = IniReadSection($tmp & "\XPSect.ini", $Section)
	If @error = 0 Then
		$CNT = $Files[0][0]
		If $Files[0][0] > 0 Then
			DirCreate($tmp)
			For $I = 1 To $Files[0][0]
				Edit_File($Files[$I][0], $Out & "\" & $Files[$I][1])
			Next
			Return 1
		EndIf
	EndIf
	Return 0
EndFunc   ;==>Edit_Section

;====================================================================================
; Function that deals with patching the specified file:
;====================================================================================
Func Edit_File($Resource, $File)
	; If we are dealing with the SETUP.EXE file, make sure we are patching the correct file!
	Local $VER, $MD5, $F2P, $S = $File, $RFILE, $LangID
	If $Resource = "setup.exe" Then
		If FileExists($Src & "\i386\setuporg.exe") Then $File = $Src & "\i386\setuporg.exe"
	EndIf
	$F2P = StringReplace(StringMid($File, StringInStr($File, "\", 0, -1) + 1), ".xptsp", "")
	$F2P = StringUpper(StringLeft($F2P, StringLen($F2P) - 1) & StringRight($Resource, 1))
	$RFILE = StringUpper(StringReplace(StringMid($Resource, StringInStr($Resource, "\", 0, -1) + 1), ".res", ""))

	; Patch the file, then compress it back into the source folder:
	If $Live = 0 Then
		$S = Expand_File($File)
		If $BackDir <> "" Then FileCopy($S, $BackDir & "\")
	EndIf
	If FileExists($S) Then
		$VER = IniRead($Working & "\XPtsp.ini", "NoPatch.ByVersion", $Resource, "")
		If $VER <> "" And FileGetVersion($S) >= $VER Then
			$CNT += 1
			Page11_Notify("- " & _FormatStr("Main_34", $Resource, "NoPatch.ByVersion"))
			FileDelete($S)
		Else
			; Execute the patches as required by the script:
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

			; Get the MD5 hash, put it in "XPtsp.ini", and add the file to the list:
			$MD5 = StringLeft(IniRead($res & "\Version.ini", "Pro", $Resource, ""), 32)
			IniWrite($INF, "Pro", $Resource, FileGetVersion($S) & "|" & FileGetSize($S) & "||" & $MD5)

			; Move the file back to the i386 folder, compressing as necessary:
			If $Live = 0 And StringRight($File, 1) = "_" Then
				Compress_File($S, $File, 0)
				FileDelete($S)
			EndIf
		EndIf
	EndIf
	Execute("_After_" & StringReplace($F2P, ".", "_") & "()")
EndFunc   ;==>Edit_File

;=================================================================================
; Make sure any functions called via "Execute" commands are listed here.
;=================================================================================
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
	_Post_TASKMGR_EXE()
	_After_XPSP1RES_DLL()
	_After_XPSP2RES_DLL()
	_After_XPSP3RES_DLL()
	Page9_TopLevel()
	Page9_Section()
	Page9_Files()
EndFunc   ;==>_IncludeFunc

;=================================================================================
; This section involves hex-editing files:
;=================================================================================
Func _Hex_TASKMGR_EXE($S = "", $RFILE = "")
	If $OS = "AMD64" Then Return
	Local $MOD = IniRead($Working & "\XPtsp.ini", "_TASKMGR.EXE", $TASKMGR, "")
	If $MOD = "" Then Return
	$MOD = StringSplit($MOD, "|")
	If $MOD[0] <> 4 Then Return
	For $I = 1 To $MOD[0]
		$MOD[$I] = StringLeft($MOD[$I] & "000000", 6)
	Next
	Local $CPU = $MOD[1], $MEM = $MOD[2], $GRID = $MOD[3], $Digits = $MOD[4]
	$CNT += 1
	Page11_Notify("- " & _FormatStr("Main_35", "TASKMGR.EXE"))
	Local $Handle = FileOpen($S, 16)
	Local $VAR = FileRead($Handle), $OLD
	FileClose($Handle)

	; Replace a string for the 32-bit icon patch:
	$VAR = StringReplace($VAR, "7405BB0120", "9090BB2100")

	; Replace some strings for the "Performance" tab:
	$VAR = StringReplace($VAR, "FFFF68008040006A", "FFFF68" & $GRID & "006A") ; cpu grid
	$VAR = StringReplace($VAR, "0E04000000FF0000FF00", "0E040000" & $CPU & "00FF00") ; cpu line
	$VAR = StringReplace($VAR, "FFFF00002500", $MEM & "002500") ; memory line
	$VAR = StringReplace($VAR, "00FF0000FF73", $Digits & "00FF73") ; cpu/memory digits  (this string exists 2 times and both need to be changed)

	; Replace some strings for the "Network" tab:
	$VAR = StringReplace($VAR, "2B7D1068008040006A01", "2B7D1068" & $GRID & "006A01") ; lan grid
	$VAR = StringReplace($VAR, "00FF0000000000006C5200006D52", $CPU & "00000000006C5200006D52") ; lan line
	$VAR = StringReplace($VAR, "EC03000000000000FF000000FFFF0000", "EC03000000000000FF000000" & $Digits & "00") ; lan devider
	$VAR = StringReplace($VAR, "FFFF0000FFB5", $Digits & "00FFB5") ; lan digits

	; Write the hex-edited file back to disk:
	$Handle = FileOpen($S, 16 + 2)
	FileWrite($Handle, $VAR)
	FileClose($Handle)
EndFunc   ;==>_Hex_TASKMGR_EXE

Func _Hex_SFC_DLL($S = "", $RFILE = "")
	If $OS = "AMD64" Then Return
	Local $VER = _Iif($OS = "W2K", "5.0.0.0", FileGetVersion($S)), $A = "", $B = "", $c = "", $POS
	$POS = StringSplit(IniRead($Working & "\XPtsp.ini", "_SFC_OS.DLL", $VER, "XP_SP?|60548|83F89D7508|3BC0EB3290"), "")
	If $POS[0] <> 4 Then Return Page11_Notify("MSG: " & _FormatStr("Main_55", $RFILE))
	$CNT += 1
	Page11_Notify("- " & _FormatStr("Main_35", "SFC_OS.DLL") & " (" & $POS[1] & ")")
	Local $Handle = FileOpen($S, 16)
	$A = FileRead($Handle, $POS[2])
	$B = FileRead($Handle)
	FileClose($Handle)
	$Handle = FileOpen($S, 16 + 2)
	FileWrite($Handle, $A)
	FileWrite($Handle, StringReplace($B, $POS[3], $POS[4], 1))
	FileClose($Handle)
	Return 1
EndFunc   ;==>_Hex_SFC_DLL

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
EndFunc   ;==>_Hex_SFC_OS_DLL

Func _Hex_UXTHEME_DLL($S = "", $RFILE = "")
	If $OS = "AMD64" Then Return
	Local $VER = FileGetVersion($S), $File, $POS, $I = 2, $A, $B, $c
	$VER = _Iif($VER < "5.1.2600.1106", "5.1.2600.0", $VER)
	$POS = StringSplit(IniRead($Working & "\XPtsp.ini", "_UXTHEME.DLL", $VER, ""), "|")
	If $POS[0] < 4 Then Return Page11_Notify("MSG: " & _FormatStr("Main_55", "UXTHEME.DLL"))
	If Mod($POS[0], 3) <> 1 Then Return
	$CNT += 1
	Page11_Notify("- " & _FormatStr("Main_35", "UXTHEME.DLL") & " (" & $POS[1] & ")")
	Local $Handle = FileOpen($S, 16)
	$File = StringMid(FileRead($Handle), 3)
	FileClose($Handle)
	While $I < $POS[0]
		$A = StringLeft($File, $POS[$I] * 2)
		$B = StringMid($File, $POS[$I] * 2 + 1, StringLen($POS[$I + 1]))
		$c = StringMid($File, $POS[$I] * 2 + StringLen($POS[$I + 1]) + 1)
		$File = $A & StringReplace($B, $POS[$I + 1], $POS[$I + 2], 1) & $c
		$I += 3
	WEnd
	$Handle = FileOpen($S, 16 + 2)
	FileWrite($Handle, "0x" & $File)
	FileClose($Handle)
EndFunc   ;==>_Hex_UXTHEME_DLL

Func _Hex_NTOSKRNL_EXE($S = "", $RFILE = "")
	_Hex_TSP_KRNL_EXE($S)
EndFunc   ;==>_Hex_NTOSKRNL_EXE

Func _Hex_NTKRNLPA_EXE($S = "", $RFILE = "")
	_Hex_TSP_KRNL_EXE($S)
EndFunc   ;==>_Hex_NTKRNLPA_EXE

Func _Hex_NTKRNLMP_EXE($S = "", $RFILE = "")
	_Hex_TSP_KRNL_EXE($S)
EndFunc   ;==>_Hex_NTKRNLMP_EXE

Func _Hex_NTKRPAMP_EXE($S = "", $RFILE = "")
	_Hex_TSP_KRNL_EXE($S)
EndFunc   ;==>_Hex_NTKRPAMP_EXE

Func _Hex_TSP_KRNL_EXE($S = "", $RFILE = "")
	If $OS = "AMD64" Then Return
	Local $B = IniRead($Working & "\XPtsp.ini", "Palette", $BOOTSCR, "")
	If $B = "" Or StringIsXDigit($B) = 0 Then Return
	$CNT += 1
	Page11_Notify("- " & _FormatStr("Main_35", $RFILE))
	$Palette = $B
	Local $Handle = FileOpen($S, 16)
	Local $VAR = FileRead($Handle)
	FileClose($Handle)
	$Handle = FileOpen($S, 16 + 2)
	FileWrite($Handle, StringReplace($VAR, $Palette, $B))
	FileClose($Handle)
EndFunc   ;==>_Hex_TSP_KRNL_EXE

Func _Hex_COMCTL32_DLL($S = "", $RFILE = "")
	If $OS = "AMD64" Then Return
	$CNT += 1
	Page11_Notify("- " & _FormatStr("Main_35", $RFILE))
	Local $Handle = FileOpen($S, 16)
	Local $VAR = FileRead($Handle)
	FileClose($Handle)
	$Handle = FileOpen($S, 16 + 2)
	If StringLeft($S, StringLen(@SystemDir)) = @SystemDir Then
		$VAR = StringReplace($VAR, "FC7D0B00748B4D", "FC7D0090908B4D")
	Else
		$VAR = StringReplace($VAR, "7DFC740B8B4D", "7DFC90908B4D")
	EndIf
	FileWrite($Handle, $VAR)
	FileClose($Handle)
EndFunc   ;==>_Hex_COMCTL32_DLL

Func _Hex_REGEDIT_EXE($S = "", $RFILE = "")
	If $OS = "AMD64" Then Return
	$CNT += 1
	Page11_Notify("- " & _FormatStr("Main_35", $RFILE))
	Local $Handle = FileOpen($S, 16)
	Local $VAR = FileRead($Handle)
	FileClose($Handle)
	$Handle = FileOpen($S, 16 + 2)
	FileWrite($Handle, StringReplace($VAR, "7405BF0120", "9090BF2100"))
	FileClose($Handle)
EndFunc   ;==>_Hex_REGEDIT_EXE

;=================================================================================
; This section contains commands used for additional modification:
;=================================================================================
Func _Pre_WUAUCPL_MUI($S = "", $RFILE = "", $LangID = "")
	If $LangID = "0409" Then Return
	Page11_Notify("MSG: " & _FormatStr("Main_52", "WUAUCPL.MUI.RES"))
	If @Compiled Then BlockInput(1)
	Local $PID = Run($Working & "\Programs\Reshacker """ & $RFILE & """"), $FTime
	WinWait("Resource Hacker", "")
	WinActivate("Resource Hacker", "")
	; Special handling required for XP SP1: While user input is blocked, OS may not accept ALT-combos sent by AutoIt!
	if (@OSVersion = "WIN_XP" And @OSServicePack = "Service Pack 1") Then
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
EndFunc   ;==>_Pre_WUAUCPL_MUI

Func _Pre_LOGONUI_EXE($S = "", $RFILE = "", $LangID = "")
	_Reshacker("-delete """ & $S & """, """ & $S & """, UIFILE,,")
	_Reshacker("-delete """ & $S & """, """ & $S & """, Bitmap,,")
	_Reshacker("-delete """ & $S & """, """ & $S & """, stringtable,,")
EndFunc   ;==>_Pre_LOGONUI_EXE

Func _Pre_REMOTEPG_DLL($S = "", $RFILE = "", $LangID = "")
	_Reshacker("-delete """ & $S & """, """ & $S & """, icongroup,,")
EndFunc   ;==>_Pre_REMOTEPG_DLL

Func _Pre_WINNTBBU_DLL($S = "", $RFILE = "", $LangID = "")
	_Reshacker("-delete """ & $S & """, """ & $S & """, stringtable,,")
EndFunc   ;==>_Pre_WINNTBBU_DLL

Func _Pre_WINNTBBA_DLL($S = "", $RFILE = "", $LangID = "")
	_Reshacker("-delete """ & $S & """, """ & $S & """, stringtable,,")
EndFunc   ;==>_Pre_WINNTBBA_DLL

Func _Pre_TSP_KRNL_EXE($S = "", $RFILE = "", $LangID = "")
	If $LangID <> "0409" Then
		_Reshacker("-delete """ & $RFILE & """, """ & $RFILE & """, Bitmap, 2,")
		_Reshacker("-delete """ & $RFILE & """, """ & $RFILE & """, Bitmap, 3,")
	EndIf
EndFunc   ;==>_Pre_TSP_KRNL_EXE

;=================================================================================
; These functions deal with anything that happens after initial resource patching:
;=================================================================================
Func _Post_COMCTL32_DLL($S = "", $LangID = "")
	_Reshacker("-addoverwrite """ & $S & """, """ & $S & """, """ & $res & "\COMCTL32.DLL.res" & """,,,", $tmp)
EndFunc   ;==>_Post_COMCTL32_DLL

Func _Post_IEFRAME_DLL_MUI($File = "", $LangID = "")
	If FileGetVersion($File) > "8.0.0.0" Then _Reshacker("-addoverwrite """ & $File & """, """ & $File & """, """ & $res & "\IE8\IEFRAME.DLL.MUI.res" & """,,,", $tmp)
EndFunc   ;==>_Post_IEFRAME_DLL_MUI

Func _Post_SETUP_EXE($S = "", $LangID = "")
	Local $lOS = Int("0x" & $LangID)
	_Reshacker("-addoverwrite """ & $S & """, """ & $S & """, """ & $Working & "\Programs\Icon_0_Setup.ico"", icon, 0," & _Iif($lOS = 0, "", $lOS), $tmp)
EndFunc   ;==>_Post_SETUP_EXE

Func _Post_SRCLIENT_DLL($S = "", $LangID = "")
	Local $lOS = Int("0x" & $LangID)
	_Reshacker("-addoverwrite """ & $S & """, """ & $S & """, """ & $Working & "\Programs\Icon_0_SrClient.ico"", icon, 0," & _Iif($lOS = 0, "", $lOS), $tmp)
EndFunc   ;==>_Post_SRCLIENT_DLL

Func _Post_TASKMGR_EXE($File = "", $LangID = "")
	If $TASKMGRx2 = True And FileExists($res & "\TaskMgr.exe." & $TASKMGR & ".res") Then
		_Reshacker("-addoverwrite """ & $File & """, """ & $File & """, """ & $res & "\TaskMgr.exe." & $TASKMGR & ".res"",,,", $tmp)
	EndIf
EndFunc   ;==>_Post_TASKMGR_EXE

;=================================================================================
; These functions deal with anything that happens after file compression:
;=================================================================================
Func _After_XPSP1RES_DLL()
	If $Live = 0 And $XPSPRES = 1 Then __Search_TxtSetup("XPSP1RES.DLL")
EndFunc   ;==>_After_XPSP1RES_DLL

Func _After_XPSP2RES_DLL()
	If $Live = 0 And $XPSPRES = 1 Then __Search_TxtSetup("XPSP2RES.DLL")
EndFunc   ;==>_After_XPSP2RES_DLL

Func _After_XPSP3RES_DLL()
	If $Live = 0 And $XPSPRES = 1 Then __Search_TxtSetup("XPSP3RES.DLL")
EndFunc   ;==>_After_XPSP3RES_DLL

;---------------------------------------------------------------------------------
Func __Search_TxtSetup($File)
	Local $Handle = FileOpen($Src & "\i386\TXTSETUP.SIF", 0), $Line, $Other
	Local $TFILE = @HOUR & @MIN & @SEC
	If $Handle = 0 Then
		Page11_Notify(_FormatStr("Main_40", "TXTSETUP.SIF"))
		Return
	EndIf
	While 1
		$Line = FileReadLine($Handle)
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
	FileClose($Handle)
EndFunc   ;==>__Search_TxtSetup

;=================================================================================
; This section contains the code to do language "translations":
;=================================================================================
Func Res_Translate($ResFile, $Comp, $lOS = -1)
	Local $X = 1, $Y = 1, $atmp = $tmp & "\Resources", $RFILE = $res & "\" & $ResFile & ".res"
	Local $Line, $PID, $File, $CAPTION, $ARR, $Handle, $S, $S2, $T, $U, $V, $RINI, $CINI
	If $lOS = -1 Then $lOS = StringLeft(FileGetVersion($Comp, "DefaultLangCodepage"), 4)

	; Exit function if translation is not permitted OR if source file has English lang ID:
	If $Translate < 1 Or $lOS = "0409" Then Return ""

	; If the appropriate dialog file exists, remove existing dialog boxes from the res file:
	DirRemove($atmp, 1)
	DirCreate($atmp)
	If FileExists($res & "\Dialogs\" & $ResFile & ".rc") = 1 Then
		FileCopy($RFILE, $atmp & "\" & $ResFile & ".res", 1)
		$RFILE = $atmp & "\" & $ResFile & ".res"
		_Reshacker("-delete """ & $RFILE & """, """ & $RFILE & """, DIALOG,,", $atmp)
	EndIf

	; Extract the resources from the res file and attach the dialog file to the end if necessary:
	_Reshacker("-extract """ & $RFILE & """, """ & $atmp & "\_.rc"",,,", $atmp)
	If FileExists($atmp & "\_.rc") = 0 Then Return ""
	FileCopy($atmp & "\_.rc", $atmp & "\Original.rc")
	$RINI = FileRead($atmp & "\_.rc")
	If FileExists($res & "\Dialogs\" & $ResFile & ".rc") = 1 Then
		$RINI = $RINI & @CRLF & FileRead($res & "\Dialogs\" & $ResFile & ".rc")
	EndIf
	$RINI = StringReplace("#define FW_NORMAL 400" & @CRLF & "#define FALSE 0" & @CRLF & $RINI, "\""", "\'")
	$RINI = StringSplit(StringReplace($RINI, @CR, ""), @LF)

	; Process the string table portion of the resource file:
	;FileDelete($atmp & "\Src.rc")
	;_Reshacker("-extract """ & $Comp & """, """ & $atmp & "\Src.rc"", stringtable,,")
	;If FileExists($atmp & "\Src.rc") Then
	;	$CINI = FileRead($atmp & "\Src.rc")
	;EndIf

	; Process the dialog portion of the resource file ONLY if it is non-English:
	If Mod(Int("0x" & $lOS), 1024) <> 9 and ($ResFile <> "EHRES.DLL.RES" Or $ResFile <> "EHRES.DLL") Then
		FileDelete($atmp & "\Src.rc")
		_Reshacker("-extract """ & $Comp & """, """ & $atmp & "\Src.rc"", DIALOG,,", $atmp)
		If FileExists($atmp & "\Src.rc") Then
			$CINI = StringReplace(FileRead($atmp & "\Src.rc"), "\""", "\'")
			$CINI = StringSplit(StringReplace($CINI, @CR, ""), @LF)

			; Start the translation loop:
			$X = 0
			While $X < $RINI[0]
				; Locate next dialog box in RES file script:
				Do
					$X += 1
					If $X >= $RINI[0] Then ExitLoop 2
					If $RINI[$X] = "" Then ContinueLoop
				Until StringInStr($RINI[$X], " DIALOG") <> 0
				$T = $X
				Do
					$X += 1
					If $X >= $RINI[0] Then ExitLoop 2
					If StringLeft($RINI[$X], 8) = "CAPTION " Then $CAPTION = $X
				Until $RINI[$X] = "{"

				; Locate same dialog box in source file as in RES file:
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

				; Get the matching pattern to use for this dialog box:
				$S = StringLeft($RINI[$T], StringInStr($RINI[$T], " ") - 1)
				$U = IniRead($res & "\Version.ini", $ResFile, $S, IniRead($Working & "\XPtsp.ini", $ResFile, $S, ""))

				; Copy the text from the source file into the resource script:
				$T = 0
				While 1
					$X += 1
					If $RINI[$X] = "}" Then ExitLoop
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
						$V = StringMid($RINI[$X], StringInStr($RINI[$X], """", 0, 2) + 1)
					Else
						If StringRegExp($S, "^(\d+)$") = 1 Then
							$S2 = StringLeft($CINI[$Y + $S], StringInStr($CINI[$Y + $S], """", 0, 2))
							If $S2 = "" Then
								$V = $RINI[$X]
							Else
								$V = StringMid($RINI[$X], StringInStr($RINI[$X], """", 0, 2) + 1)
								If StringLeft($V, 1) <> "," Then $S2 = ""
							EndIf
						Else
							$S2 = "   CONTROL """ & _ReadStr($S, "Dialogs") & """"
							$V = StringMid($RINI[$X], StringInStr($RINI[$X], """", 0, 2) + 1)
						EndIf
					EndIf
					$RINI[$X] = $S2 & $V
				WEnd
			WEnd

			; Write out the new resources script:
			$T = ""
			For $I = 1 To $RINI[0]
				$T = $T & $RINI[$I] & @CRLF
			Next
			$T = StringReplace($T, "\'", "\""")
			$S = $atmp & "\_.rc"
			FileDelete($S)
			FileWriteLine($S, $T)
			FileClose($S)
		EndIf
	EndIf

	; Convert the Reshacker RC file to a format that Microsoft Resource Compiler understands:
	RunWait($Working & "\Programs\RH2RC """ & $atmp & "\_.rc"" """ & $atmp & "\_2.rc", $atmp, @SW_HIDE)
	If FileExists($atmp & "\_2.rc") = 0 Then
		Page11_Notify("MSG: " & _ReadStr("Main_53"))
		_Keep_Logs($atmp & "\_.rc", $ResFile, "rc")
		If $DEBUG = 1 Then RunWait(@ComSpec, $atmp)
		Return ""
	EndIf

	; Compile the RC file with Microsoft Resource Compiler:
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
EndFunc   ;==>Res_Translate

;====================================================================================
; This function handles integration of resources into XP Source installs:
;====================================================================================
Func Live0_Run()
	Local $Handle, $File, $X, $CAB, $T, $S, $Pack

	; Calculate how many tasks there are to do, if necessary:
	$Pat[7] = 4 + _Iif($BackDir <> "", 1 + FileExists($Src & "\AMD64"), 0) + FileExists($Src & "\AMD64") + _
			(FileExists($Src & "\i386\NR_IE7en.CAB") + FileExists($Src & "\i386\IE8.CAB") + FileExists($Src & "\i386\WMP10.CAB") + _
			FileExists($Src & "\i386\WMP11.CAB") + FileExists($Src & "\CMPNENTS\MEDIACTR\I386\MEDIACTR.CAB") + 1) * 3
	$Pat[6] = 0

	; Remove all read-only attributes from the XP source files:
	DirCreate($tmp)
	$NUM = 0
	$MIN = 0
	$MAX = 1
	$CNT = 1
	Page11_Task(_ReadStr("Live_0a"))
	If @Compiled Then FileSetAttrib($Src & "\*", "-R", 1)
	If $BackDir <> "" Then DirCreate($BackDir)

	; Patch the files in the i386 folder first:
	$NUM = -1
	$MIN = 0
	$MAX = 100
	If Build_Section("Global.Patch") Then
		$LOGS = $tmp & "\Logs_32"
		DirCreate($LOGS)
		Page11_Notify(_ReadStr("Live_0b"))
		Edit_Section("Global.Patch")
		If $BackDir <> "" Then
			Page11_Task(_FormatStr("Main_23", $CAB))
			Build_Cab($Src & "\" & $OS & "\XPTSPBAK.CAB", $BackDir)
			DirRemove($BackDir, 1)
			DirCreate($BackDir)
		EndIf
	EndIf

	; Patch the files in the AMD64 folder next:
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
			If $BackDir <> "" Then
				Page11_Task(_FormatStr("Main_23", $CAB))
				Build_Cab($Src & "\" & $OS & "\XPTSPBAK.CAB", $BackDir)
				DirRemove($BackDir, 1)
				DirCreate($BackDir)
			EndIf
		EndIf
	EndIf

	; Patch some files in SPx.CAB or DRIVER.CAB next (if they exist):
	$CAB = "DRIVER.CAB"
	$Handle = FileFindFirstFile($Src & "\" & $OS & "\SP*.CAB")
	If $Handle <> -1 Then
		While 1
			$File = FileFindNextFile($Handle)
			If @error Then ExitLoop
			$CAB = $File
		WEnd
		FileClose($Handle)
	EndIf
	If FileExists($Src & "\" & $OS & "\" & $CAB) Then
		Live0_Patch($CAB)
		If $BackDir <> "" Then
			Page11_Task(_FormatStr("Main_23", $CAB))
			Build_Cab($Src & "\" & $OS & "\XPTSP_SP.CAB", $BackDir)
			DirRemove($BackDir, 1)
			DirCreate($BackDir)
		EndIf
	EndIf

	; Patch the files in the Internet Explorer files (if they exist):
	$CAB = IniReadSection($Working & "\XPtsp.ini", "IE.Rename")
	If IsArray($CAB) Then
		If $CAB[0][0] > 0 Then
			For $I = 1 To $CAB[0][0]
				FileMove($res & "\" & $CAB[$I][0] & ".res", $res & "\" & $CAB[$I][1] & ".res", 1)
				$X = Page9_FindItem($CAB[$I][0])
				If $X > 0 Then $LV[$X][3] = $CAB[$I][1]
			Next
		EndIf
	EndIf
	If FileExists($Src & "\" & $OS & "\NR_IE7en.CAB") Then Live0_Patch("NR_IE7en.CAB")
	If FileExists($Src & "\" & $OS & "\IE8.CAB") Then Live0_Patch("IE8.CAB")

	; Patch the Windows Media Player 11 files next (if they exist):
	$CAB = IniReadSection($Working & "\XPtsp.ini", "WMP.Rename")
	If IsArray($CAB) Then
		If $CAB[0][0] > 0 Then
			For $I = 1 To $CAB[0][0]
				FileMove($res & "\" & $CAB[$I][0] & ".res", $res & "\" & $CAB[$I][1] & ".res", 1)
				$X = Page9_FindItem($CAB[$I][0])
				If $X > 0 Then $LV[$X][3] = $CAB[$I][1]
			Next
		EndIf
	EndIf
	If FileExists($Src & "\" & $OS & "\WMP10.CAB") Then Live0_Patch("WMP10.CAB")
	If FileExists($Src & "\" & $OS & "\WMP11.CAB") Then Live0_Patch("WMP11.CAB")

	; Patch some files in MEDIACTR.CAB next (if they exist):
	If $Type = "MCE" Then
		Page11_Notify("")
		$NUM = -2
		$MIN = 0
		$MAX = 100
		Page11_Task("Extracting contents of MEDIACTR.CAB")
		Expand_CAB($Src & "\CMPNENTS\MEDIACTR\I386\MEDIACTR.CAB")
		Build_Section("MEDIACTR.Patch", $mcabtmp)
		$X = Edit_Section("MEDIACTR.Patch", $mcabtmp)
		$NUM = -2
		$MIN = 0
		$MAX = 100
		Build_Section("MCE_CAB.Copy", $mcabtmp, $xtra, 0)
		$X += Copy_Section("MCE_CAB.Copy", $xtra, $mcabtmp)
		If $X > 0 Then
			Page11_Notify(_FormatStr("Main_23", "MEDIACTR.CAB"))
			Build_Cab($Src & "\CMPNENTS\MEDIACTR\I386\MEDIACTR.CAB", $mcabtmp)
		Else
			Page11_Notify("MSG: " & _FormatStr("Live_0c", "MEDIACTR.CAB"))
			DirRemove($mcabtmp, 1)
		EndIf
	EndIf

	; Move AutoPlay program into place BEFORE overwriting i386 files!
	; >> If not done, then AutoPlay Setup program will overwrite Windows Setup program, resulting in constant reboots! <<
	$NUM = -3 + ($AUTO = 0)
	$MIN = 0
	$MAX = 100
	Page11_Notify("")
	If $AUTO = 1 Then
		Page11_Notify(_ReadStr("Live_0d"))
		FileMove($xtra & "\Setup.exe", $Src & "\", 1)
	Else
		FileDelete($xtra & "\Setup.exe")
	EndIf

	; Overwrite some files in the proper folder:
	Page11_Task(_ReadStr("Live_0e"))
	Build_Section("Extra.Copy", $Src & "\" & $OS, $xtra, 0)
	Live0_ThemeFiles()
	Compress_Section("Extra.Copy", $xtra, $Src & "\" & $OS, 1)

	; Perform additional alterations:
	$NUM = -1
	$CNT = 1 + $ORB + ($DSI Or $DOTNET Or ($REPATCH = 0 And $OEM)) + ($REPATCH And $RESOURCES) + ($Type = "MCE") + ($CAD And $THEME <> "Green")
	$CNT += ($TTran And IniRead($xtra & "\Version.ini", "Extra", "Version", "1.0") >= "2.0")
	$MIN = 99
	$MAX = 100
	Page11_Task("")
	If $SP3 = 1 Then Live0_WBEMOC()
	If $ORB = 1 Then Live0_Orb()
	If $DSI = 1 Or $DOTNET = 1 Or ($REPATCH = 0 And $OEM) Then Live0_SVCPACK()
	If $GUI_RES <> "" Then Live0_Resolution()
	If $Type = "MCE" Then Live0_Patch_SMSS()

	; Repack the CAD2009 add-on with the background image from LOGONUI.EXE, if required:
	If $CAD And $THEME <> "Green" Then
		Page11_Notify("Modifying CAD2009.CAB add-on for OS")
		Expand_CAB($Working & "\Extra\Programs\" & $OS & "\CAD2009.CAB")
		RunWait("Programs\Reshacker -extract """ & $res & "\logonui.exe.res"", """ & $mcabtmp & "\Background.bmp"", bitmap, 100,", $Working, @SW_HIDE)
		Build_Cab($Working & "\Extra\Programs\" & $OS & "\CAD2009.CAB", $mcabtmp)
	EndIf

	; Modify the TrueTransparency add-on if using v2.0 of Extra's:
	If $TTran And IniRead($xtra & "\Version.ini", "Extra", "Version", "1.0") >= "2.0" Then
		$S = "Seven " & _Iif($THEME = "NeonBlue", "Cyan", $THEME)
		$T = IniReadSection($xtra & "\Programs\TrueTran.inf", "DestinationDirs")
		If @error = 0 Then
			For $I = 1 To $T[0][0]
				If StringInStr($T[$I][1], $S) > 0 Then
					Page11_Notify("Modifying TRUETRAN.CAB add-on for OS")
					Expand_CAB($Working & "\Extra\Programs\" & $OS & "\TrueTran.CAB")
					IniWrite($mcabtmp & "\Config.ini", "General", "Skin", $S)
					Build_Cab($Working & "\Extra\Programs\" & $OS & "\TrueTran.CAB", $mcabtmp)
					ExitLoop
				EndIf
			Next
		EndIf
	EndIf

	; Copy the resource package to the i386 folder if required:
	If $RESOURCES And $BATCH = 0 Then
		Page11_Notify(_ReadStr("Live_0h"))
		_FileCopyWithProgress($THEME_FILE, $Src & "\i386\SVCPACK\" & $THEME & ".xptsp")
	EndIf

	; Modify the XP install source so that each add-on is installed:
	Page11_Notify(_ReadStr("Main_19"))
	$SYSOC = $Src & "\" & $OS & "\SYSOC.INF"
	$Pack = (FileExists($SYSOC) = 0)
	If $Pack Then $SYSOC = Expand_File($Src & "\" & $OS & "\SYSOC.IN_")
	Live0_FileInfo()
	$T = IniReadSection($xtra & "\Version.ini", "SYSOC")
	If @error Then
		If FileInstall("Version.ini", $tmp & "\Version.v1", 1) = 0 Then _Error(_FormatStr("Main_03", "Version.ini"))
		$T = IniReadSection($xtra & "\Version.v1", "SYSOC")
		If @error Then _Error(_FormatStr("Main_02", "SYSOC"))
	EndIf
	For $I = 1 To $T[0][0]
		If Eval($T[$I][0]) = 1 Then
			$S = StringSplit($T[$I][1] & "|", "|")
			If $S[0] = 2 Then $S[2] = $S[1]
			Live0_AddCab($S[1], $S[2])
		EndIf
	Next
	If $Pack = False Then
		FileMove($SYSOC, $tmp & "\SYSOC.INF", 1)
		$SYSOC = $tmp & "\SYSOC.INF"
	EndIf
	Compress_File($SYSOC, $Src & "\" & $OS & "\SYSOC.INF")

	; Add WINNT.SIF to install --OR-- Modify existing WINNT.SIF to add Driver Signing Policy settings:
	If FileExists($Src & "\" & $OS & "\WINNT.SIF") Then
		IniWrite($Src & "\" & $OS & "\WINNT.SIF", "Unattended", "DriverSigningPolicy", "Ignore")
		IniWrite($Src & "\" & $OS & "\WINNT.SIF", "Unattended", "NonDriverSigningPolicy", "Ignore")
	Else
		If FileInstall("WINNT.SIF", $Src & "\" & $OS & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "WINNT.SIF"))
	EndIf

	; Remove the temporary folder created during CAB extraction:
	DirRemove($mcabtmp, 1)
EndFunc   ;==>Live0_Run

Func Live0_ThemeFiles()
	If FileExists($xtra & "\luna.mst") Then _PECheckSum($xtra & "\luna.mst")
	If FileExists($xtra & "\home_ss.dll") Then _PECheckSum($xtra & "\home_ss.dll")
	If FileExists($xtra & "\blue_ss.dll") Then _PECheckSum($xtra & "\blue_ss.dll")
	If FileExists($xtra & "\metal_ss.dll") Then _PECheckSum($xtra & "\metal_ss.dll")
	If FileExists($xtra & "\royale.mst") Then _PECheckSum($xtra & "\royale.mst")
	If FileExists($xtra & "\royale_ss.dll") Then _PECheckSum($xtra & "\royale_ss.dll")
EndFunc   ;==>Live0_ThemeFiles

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
		DirRemove($mcabtmp, 1)
	EndIf
EndFunc   ;==>Live0_Patch

Func Live0_WBEMOC()
	Local $TName = $Src & "\" & $OS & "\WBEMOC.INF", $Pack = (FileExists($TName) = 0)
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
EndFunc   ;==>Live0_WBEMOC

Func Live0_Orb()
	; Make sure that the Orb file is physically present.  If not, message the user about it's absence:
	If FileExists($Working & "\Pics\XPtspOrb.jpg") = 0 Then
		$MAX += 1
		Return Page11_Notify("MSG: " & _FormatStr("Live_1k", "XPtsp Orb"))
	EndIf
	Page11_Notify(_FormatStr("Main_24", "XPtsp Orb"))

	; Add the Orb to the i386 folder and to the TXTSETUP and DOTNET files:
	FileCopy($Working & "\Pics\XPtspOrb.jpg", $xtra & "\", 1)
	_ImageToBMP($xtra & "\XPtspOrb.jpg")
	Compress_File($xtra & "\XPtspOrb.bmp", $Src & "\" & $OS & "\XPtspOrb.bmp")
	Live0_Update_INF($Src & "\" & $OS & "\TXTSETUP.SIF", "SourceDisksFiles", "xptsporb.bmp", "1,,,,,,,2,0,0 ")
	Live0_Update_INF($Src & "\" & $OS & "\DOSNET.INF", "Files", "d1,xptsporb.bmp", "")

	; Alter the registry hive so that the Orb is displayed at Windows GUI Setup:
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
EndFunc   ;==>Live0_Orb

Func Live0_SVCPACK()
	Local $T, $TName = $Src & "\" & $OS & "\SVCPACK.INF", $Pack = (FileExists($TName) = 0)

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
EndFunc   ;==>Live0_SVCPACK

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
EndFunc   ;==>Live0_Resolution

Func Live0_Patch_SMSS()
	Local $S = $Src & "\" & $OS & "\SYSTEM32\SMSS.EXE", $Pack = (FileExists($S) = 0)
	If $Pack Then $S = Expand_File($Src & "\" & $OS & "\SYSTEM32\SMSS.EX_")
	If $S = "" Then Return Page11_Notify(_FormatStr("Main_03", "SMSS.EXE"))
	$CNT += 1
	Page11_Notify(_FormatStr("Main_35", "SYSTEM32\SMSS.EXE"))
	Local $Handle = FileOpen($S, 16)
	Local $VAR = FileRead($Handle)
	FileClose($Handle)
	Local $DST = "4D0065006400690061002000430065006E007400650072002000530065007400750070"
	$VAR = StringReplace($VAR, "500072006F00660065007300730069006F006E0061006C002000530065007400750070", $DST) ; Replace "Professional" with "Media Center"
	$VAR = StringReplace($VAR, "48006F006D0065002000450064006900740069006F006E002000530065007400750070", $DST) ; Replace "Home Edition" with "Media Center"
	FileDelete($S)
	$Handle = FileOpen($S, 16 + 2)
	FileWrite($Handle, $VAR)
	FileClose($Handle)
	_PECheckSum($S)
	If $Pack Then Compress_File($S, $Src & "\" & $OS & "\SYSTEM32\SMSS.EXE")
EndFunc   ;==>Live0_Patch_SMSS

Func Live0_AddCab($TINF, $COM = "")
	If $COM = "" Then $COM = $TINF
	If FileExists($xtra & "\Programs\i386\" & $TINF & ".CAB") = 0 Then Return
	If FileExists($xtra & "\Programs\" & $TINF & ".INF") = 0 Then Return
	FileCopy($xtra & "\Programs\i386\" & $TINF & ".CAB", $Src & "\i386\", 1)
	Compress_File($xtra & "\Programs\" & $TINF & ".INF", $Src & "\" & $OS & "\" & $TINF & ".INF")
	Live0_Update_INF($SYSOC, "Components", $COM, "ocgen.dll,OcEntry," & $TINF & ".inf,HIDE,7")
	Live0_Update_INF($Src & "\" & $OS & "\TXTSETUP.SIF", "SourceDisksFiles", $TINF & ".INF", "1,,,,,,,20,0,0", $TINF & ".Cab", "1,,,,,,_x,,3,3")
	Live0_Update_INF($Src & "\" & $OS & "\DOSNET.INF", "Files", "d1," & $TINF & ".inf", "", "d1," & $TINF & ".Cab", "")
EndFunc   ;==>Live0_AddCab

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
EndFunc   ;==>Live0_Update_INF

Func Live0_FileInfo()
	; Include the other settings in the INF file:
	IniWrite($INF, "Strings", "Theme", " """ & $THEME & """")
	IniWrite($INF, "Strings", "BootScr", " """ & $BOOTSCR & """")
	IniWrite($INF, "Strings", "TaskMgr", " """ & $TASKMGR & """")
	IniWrite($INF, "Strings", "Lang", " """ & $LANG & """")
	IniWrite($INF, "Strings", "OemGen", " """ & $OEM & """")
	IniWrite($INF, "Strings", "Palette", " """ & $Palette & """")
	IniWrite($INF, "Strings", "Built_By", " """ & FileGetVersion(@ScriptFullPath) & """")
	IniWrite($INF, "Strings", "Full_Pack", " """ & $FullPack & """")

	; Remove shortcut info from INF if repatcher isn't gonna be used:
	If $REPATCH = 0 Then IniDelete($INF, "XPtspCom", "ProfileItems")

	; Delete the entries removing the Orb wallpaper if requested:
	If $Live = 0 Then
		Compress_File($INF, $Src & "\" & $OS & "\XPtspCom.INF")
		Live0_Update_INF($SYSOC, "Components", "XPtspCom", "ocgen.dll,OcEntry,XPtspCom.inf,HIDE,7")
		Live0_Update_INF($Src & "\" & $OS & "\TXTSETUP.SIF", "SourceDisksFiles", "XPtspCom.INF", "1,,,,,,,20,0,0")
		Live0_Update_INF($Src & "\" & $OS & "\DOSNET.INF", "Files", "d1,XPtspCom.inf", "")
	Else
		If $ORB = 0 Then IniDelete($INF, "XPtsp", "DelReg")
		FileCopy($INF, @WindowsDir & "\INF\", 1)
	EndIf
EndFunc   ;==>Live0_FileInfo

;====================================================================================
; This function handles integration of resources into Live Installs:
;====================================================================================
Func Live1_Run()
	Local $I, $J, $S, $TEMP, $S1, $S2, $OLD, $T, $Str
	Local $PFRO = RegRead($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations")

	; Calculate how many tasks there are to do:
	$Pat[7] = $SYSREST + 3 + (@OSArch <> "x86")
	$Pat[6] = 0

	; Disable Read-Only, Hidden and System attributes of certain files:
	FileSetAttrib(@ProgramFilesDir & "\Windows Media Player\*", "-RHS")
	FileSetAttrib(@WindowsDir & "\system32\*.msc", "-RHS")

	; Convert files to BMP format for replacement of wallpaper:
	If $WALL = 1 Then
		FileMove($res & "\BLISS.JPG", $xtra & "\", 1)
		_ImageToBMP($xtra & "\BLISS.JPG")
		If FileExists($xtra & "\MCBLISS.JPG") Then _ImageToBMP($xtra & "\MCBLISS.JPG")
	EndIf

	; Create System Restore point if requested:
	$NUM = 0
	$CNT = 1
	$MIN = 0
	$MAX = 10
	If $SYSREST = 1 Then
		Page11_Task(_ReadStr("Live_1a"))
		Live1_SystemRestorePoint()
	EndIf

	; Begin by copying all program files to the Install folder:
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

	; Process the files in the 32-bit System32 folder:
	RegWrite($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "AllowProtectedRenames", "REG_DWORD", 1)
	$LOGS = $tmp & "\Logs_32"
	DirCreate($LOGS)
	Live1_ProcessList($List, "Live_1c", $Src & "\Backup")

	; Process the files in the 64-bit System32 folder if we are running a 64-bit OS:
	If @OSArch <> "x86" Then
		$T = $List
		For $I = 1 To $T[0][0]
			If StringInStr($T[$I][1], "UXTHEME.DLL") Then $T[$I][1] = ""
			If StringInStr($T[$I][1], @SystemDir) = 0 And StringInStr($T[$I][1], @ProgramFilesDir) = 0 Then $T[$I][1] = ""
			$T[$I][1] = StringReplace($T[$I][1], @SystemDir, @WindowsDir & "\SysNative")
			$T[$I][1] = StringReplace($T[$I][1], @ProgramFilesDir, StringReplace(@ProgramFilesDir, " (x86)", ""))
		Next
		$OS = "AMD64"
		Page11_Notify("")
		$LOGS = $tmp & "\Logs_64"
		DirCreate($LOGS)
		Live1_ProcessList($T, "Live_1o", $Src & "\Backup64")
	EndIf

	; Count the number of files in the Extra folder that are being replaced:
	$CNT = 0
	If $REP[0][0] > 0 Then
		For $I = 1 To $REP[0][0]
			If FileExists($REP[$I][1]) And FileExists($xtra & "\" & $REP[$I][0]) Then $CNT += 1
		Next
	EndIf

	; Replace the original files with patched copies:
	$NUM = -2
	$MIN = 0
	$MAX = 100
	Page11_Task("")
	If $CNT > 0 Then
		$CNT -= 2
		Page11_Notify(_ReadStr("Live_1e"))
		Live1_ReplaceList($REP, $xtra, 1)
	EndIf

	; Make sure the logonui.exe is the logon UI being used:
	Local $KEY = $HKLM & "\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
	RegWrite($SET & "\Settings", "LogonUI", "REG_SZ", RegRead($KEY, "UIHost"))
	RegWrite($KEY, "UIHost", "REG_SZ", @SystemDir & "\logonui.exe")

	; Copy the patched kernel into the appropriate location:
	$NUM = -1
	$CNT = $BOOT + $AERO + $DSI + $DOTNET + $QTBAR + $UBER + $TASKTIPS + $TBar
	$CNT += $TTran + $ViStart + $CAD + $FLIP + $OEM + 1
	$MIN = 0
	$MAX = 100
	Page11_Task("")

	; Enable patched bootscreen via BOOT.INI:
	If $BOOT = 1 Then
		$T = _Iif(@OSArch <> "x86", @WindowsDir & "\SysNative", @SystemDir)
		If FileMove($T & "\NTOSKRNL.EXE.xptsp", $T & "\TSP_KRNL.EXE", 1) Then Live1_EnableBoot()
	EndIf

	; Install additional software via SFX if requested:
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

		; Do any special processing that the add-ons need before installation:
		If $AERO Then RunWait("regedit /e """ & $Src & "\Backup\Cursors.reg"" ""HKCU\Control Panel\Cursors""", $Working, @SW_HIDE)

		; Install the "optional components" if requested:
		$T = IniReadSection($xtra & "\Version.ini", "SYSOC")
		If @error Then
			If FileInstall("Version.ini", $tmp & "\Version.v1", 1) = 0 Then _Error(_FormatStr("Main_03", "Version.ini"))
			$T = IniReadSection($xtra & "\Version.v1", "SYSOC")
			If @error Then _Error(_FormatStr("Main_02", "SYSOC"))
		EndIf
		For $I = 1 To $T[0][0]
			If Eval($T[$I][0]) = 1 Then
				$J = IniRead($xtra & "\Version.ini", "Addons", $T[$I][0], "")
				If $J = "" Then ContinueLoop
				$J = StringSplit($J, "|")
				$S = StringSplit($T[$I][1] & "|", "|")
				If $S[0] = 2 Then $S[2] = $S[1]
				Live1_RunINF($T[$I][0], $J[1], $S[1], $S[2])
			EndIf
		Next

		; Do any post-processing that the add-ons require after installation:
		If $CAD = 1 Then
			RunWait("Programs\Reshacker -extract """ & $res & "\logonui.exe.res"", """ & $tmp & "\Background.bmp"", bitmap, 100,", $Working, @SW_HIDE)
			_ImageToBMP($tmp & "\Background.bmp", "PNG")
			FileMove($tmp & "\Background.png", @ProgramFilesDir & "\cad09\1920x1200.png", 1)
		EndIf

		; Run the OEM Info Generator if required:
		If $OEM = 1 Then
			Page11_Notify(_ReadStr("Live_1m"))
			OEM_Info()
			RegWrite($SET & "\Settings", "OemInfo", "REG_DWORD", $T)
		EndIf

		; Execute any other tasks before notifying user that reboot is required:
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
			RegWrite($S, "DllName", "REG_SZ", @WindowsDir & "\resources\Themes\" & _Iif($Type = "MCE", "Royale\Royale.msstyles", "Luna\Luna.msstyles"))
		EndIf
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

	; Copy resource package to the destination folder:
	DirCreate($Src & "\Archive")
	If $BATCH = 0 Then _FileCopyWithProgress($THEME_FILE, $Src & "\Archive\" & $THEME & ".xptsp")
Live0_FileInfo()
_Registry_Info()
RunWait("rundll32 advpack.dll,LaunchINFSection XPtspCom.inf,Shortcut")

; On x64 OSes, change paths so that the files are replaced correctly:
If @OSArch <> "x86" Then
	$Str = RegRead($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations")
	$Str = StringReplace($Str, $PFRO, "")
	$Str = StringReplace($Str, @SystemDir & "\", @WindowsDir & "\SysWOW64\")
	$Str = StringReplace($Str, @WindowsDir & "\SysNative\", @WindowsDir & "\System32\")
	RegWrite($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations", "REG_MULTI_SZ", $PFRO & $Str)
EndIf

; Move XPTSPCOM.INF from temporary folder if it is there:
If $INF = $tmp & "\XPtspCom.INF" Then FileMove($INF, @WindowsDir & "\INF\XPtspCom.INF", 1)
;### Tidy Error: next line creates a negative tablevel.
;### Tidy Error: next line creates a negative tablevel for the line after it.
EndFunc   ;==>Live1_Run

Func Live1_ProcessList($List, $MSG, $Backup = "")
	Local $TEMP, $J, $I, $S
	If $Backup = "" Then $Backup = $Src & "\Backup"
	DirCreate($Backup)

	; Count how many files are actually being processed this time around:
	$NUM = -1
	$CNT = 1
	$MIN = 0
	$MAX = 100
	Page11_Task(_ReadStr($MSG))
	$CNT = 1
	For $I = 1 To $List[0][0]
		$S = $List[$I][1]
		If FileExists($S) And FileExists($res & "\" & $List[$I][0] & ".res") Then
			$TEMP = Page9_FindItem($List[$I][0])
			$J = $LV[$TEMP][6] & $LV[$TEMP][5]
			If $J = "01" Or $J = "10" Or $LV[$TEMP][5] = "2" Or $LV[$TEMP][5] = "3" Then
				$CNT += 1
			Else
				$List[$I][1] = ""
			EndIf
		Else
			$List[$I][1] = ""
		EndIf
	Next

	; Begin copying the resources and files into their proper location:
	For $I = 1 To $List[0][0]
		If $List[$I][1] <> "" Then
			$TEMP = Page9_FindItem($List[$I][0])
			$J = $LV[$TEMP][6] & $LV[$TEMP][5]
			If $J = "01" Or $J = "13" Or $J = "03" Then ; <-- Patch this file if File or Resource has changed
				If FileExists($Backup & "\" & $List[$I][0]) = 0 Then FileCopy($List[$I][1], $Backup & "\" & $List[$I][0], 1)
				FileCopy($Backup & "\" & $List[$I][0], $List[$I][1] & ".xptsp", 1)
				Edit_File($List[$I][0], $List[$I][1] & ".xptsp")
				Live1_ReplaceFile($List[$I][1] & ".xptsp", $List[$I][1])
			ElseIf $J = "10" Then ; <-- Uninstall this file
				If FileExists($Backup & "\" & $List[$I][0]) = 0 Then ContinueLoop
				Page11_Notify("- " & _ReadStr("Main_28") & " " & $List[$I][0])
				FileMove($Backup & "\" & $List[$I][0], $List[$I][1] & ".xptsp", 1)
				Live1_ReplaceFile($List[$I][1] & ".xptsp", $List[$I][1])
			ElseIf $J = "12" Or $J = "02" Then ; <-- File has been updated
				FileCopy($List[$I][1], $List[$I][1] & ".xptsp", 1)
				FileCopy($List[$I][1], $Backup & "\" & $List[$I][0], 1)
				Edit_File($List[$I][0], $List[$I][1] & ".xptsp")
				Live1_ReplaceFile($List[$I][1] & ".xptsp", $List[$I][1])
			EndIf
		EndIf
	Next
EndFunc   ;==>Live1_ProcessList

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
EndFunc   ;==>Live1_RunINF

Func Live1_SystemRestorePoint($EventID = 100)
	Local $SR = ObjGet("winmgmts:\\.\root\default:Systemrestore")
	If IsObj($SR) = 0 Then
		Page11_Notify("MSG: " & _ReadStr("Main_15"))
	Else
		Local $MSG = "XPtsp " & _Iif($Live = 1, _ReadStr("Main_25"), _Iif($Live = 5, _ReadStr("Main_26"), _ReadStr("Main_27")))
		If $SR.CreateRestorePoint($MSG, _Iif($Live = 1, 0, _Iif($Live = 5, 2, 12)), $EventID) <> 0 Then
			Page11_Notify("MSG: " & _ReadStr("Main_15"))
		EndIf
	EndIf
EndFunc   ;==>Live1_SystemRestorePoint

Func Live1_ReplaceList(ByRef $Files, $From, $Backup = 0)
	; Start replacing files with their patched counterparts:
	If IsArray($Files) = 0 Then Return
	If $Files[0][0] = 0 Then Return
	For $I = 1 To $Files[0][0]
		If FileExists($From & "\" & $Files[$I][0]) = 0 Or FileExists($Files[$I][1]) = 0 Then ContinueLoop
		If $Backup = 1 And FileExists($Src & "\Backup\" & $Files[$I][0]) Then ContinueLoop
		Page11_Notify("- " & _Iif($Live = 5, _ReadStr("Main_28"), _ReadStr("Main_29")) & " " & $Files[$I][0])
		If $Backup = 1 Then FileCopy($Files[$I][1], $Src & "\Backup\" & $Files[$I][0], 1)
		FileCopy($From & "\" & $Files[$I][0], $Files[$I][1] & ".xptsp", 1)
		Live1_ReplaceFile($Files[$I][1] & ".xptsp", $Files[$I][1])
	Next
EndFunc   ;==>Live1_ReplaceList

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
EndFunc   ;==>Live1_ReplaceFile

Func Live1_ReplaceAtReboot($new_file, $to_replace)
	Local $Str = RegRead($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations")
	If $Str <> "" Then $Str = $Str & @LF
	$Str = $Str & "\??\" & $new_file & @LF & "!\??\" & $to_replace
	RegWrite($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations", "REG_MULTI_SZ", $Str)
	If $REBOOT = 0 Then $REBOOT = 1
EndFunc   ;==>Live1_ReplaceAtReboot

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
			For $I = 1 To $S[0]
				If StringLeft($S[$I], 8) <> "/kernel=" Then $S2 = $S2 & _Iif($S2 <> "", " ", "") & $S[$I]
			Next
			Local $T = FileGetAttrib(@HomeDrive & "\BOOT.INI")
			FileSetAttrib(@HomeDrive & "\BOOT.INI", "-RHS")
			IniWrite(@HomeDrive & "\Boot.ini", "operating systems", $S1, $S2 & " /kernel=tsp_krnl.exe")
			FileSetAttrib(@HomeDrive & "\BOOT.INI", $T)
		EndIf
	EndIf
EndFunc   ;==>Live1_EnableBoot

Func Live1_DotNet2_Installed()
	Local $T = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\Policy\v2.0", "50727")
	If @error = 0 Then $DOTNET = ($T = "50727-50727")
	Return $DOTNET
EndFunc   ;==>Live1_DotNet2_Installed

;------------------------------------------------------------------------------------
; This function handles restoration of backups for Live Installs:
;------------------------------------------------------------------------------------
Func Live5_Run()
	Local $S, $S1, $S2, $T

	; Start setting up for uninstallation:
	Dim $LV[UBound($List) + 1][10]
	For $I = 1 To $List[0][0]
		$LV[$I][3] = $List[$I][1]
		$LV[$I][5] = 0
		$LV[$I][6] = FileExists($Src & "\Backup\" & $List[$I][0])
	Next
	GUICtrlSetState($Pat[9], $GUI_DISABLE)
	RegWrite($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "AllowProtectedRenames", "REG_DWORD", 1)

	; Start restoring the original files:
	$NUM = -1
	$CNT = $List[0][0] + $REP[0][0]
	$MIN = 0
	$MAX = 100
	Page11_Notify(_ReadStr("Live_5a"))
	Live1_ReplaceList($List, $Src & "\Backup", 0)
	Live1_ReplaceList($REP, $Src & "\Backup", 0)

	Page11_Notify("")

	; Restore the old bootscreen:
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
			For $I = 1 To $S[0]
				If StringLeft($S[$I], 8) <> "/kernel=" Then $S2 = $S2 & _Iif($S2 <> "", " ", "") & $S[$I]
			Next
			$T = FileGetAttrib(@HomeDrive & "\BOOT.INI")
			FileSetAttrib(@HomeDrive & "\BOOT.INI", "-RHS")
			IniWrite(@HomeDrive & "\Boot.ini", "operating systems", $S1, $S2)
			FileSetAttrib(@HomeDrive & "\BOOT.INI", $T)
		EndIf
	EndIf

	; Restore previous settings used before install:
	Page11_Notify(_ReadStr("Live_5b"))
	$I = RegRead($HKCU & "\SOFTWARE\XPtsp", "LogonUI")
	If @error = 0 And $I <> "" Then RegWrite($HKLM & "\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "UIHost", "REG_SZ", $I)
	$I = RegRead($HKCU & "\SOFTWARE\XPtsp", "ScrSaver")
	If @error = 0 And $I <> "" Then RegWrite($HKCU & "\Control Panel\Desktop", "SCRNSAVE.EXE", "REG_SZ", $I)
	$I = RegRead($HKCU & "\SOFTWARE\XPtsp", "Wallpaper")
	If @error = 0 And $I <> "" Then
		RegWrite($HKCU & "\Control Panel\Desktop", "Wallpaper", "REG_SZ", $I)
		RegWrite($HKCU & "\Control Panel\Desktop", "TileWallpaper", "REG_SZ", RegRead($HKCU & "\SOFTWARE\XPtsp", "TileWallpaper"))
		RegWrite($HKCU & "\Control Panel\Desktop", "WallPaperStyle", "REG_SZ", RegRead($HKCU & "\SOFTWARE\XPtsp", "WallPaperStyle"))
	EndIf
	If FileExists($Src & "\Backup\vssettings.reg") Then
		RunWait("regedit /s """ & $Src & "\Backup\vssettings.reg""")
		RunWait("regedit /s """ & $Src & "\Backup\WinMetrics.reg""")
	EndIf
	If FileExists($Src & "\Backup\Cursors.reg") Then RunWait("regedit /s """ & $Src & "\Backup\Cursors.reg""")

	; Finalize the program removal:
	Live5_Folder()
EndFunc   ;==>Live5_Run

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
	;RunWait(@ComSpec & " /c rd /s /q .\", $Src, @SW_HIDE)
	Local $KEY = $HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"
	RegWrite($KEY & "\998", "", "REG_SZ", """" & @TempDir & "\XPtsp.exe"" /CACHE:5")
	RegWrite($KEY & "\999", "", "REG_SZ", @ComSpec & " /c rd /s /q """ & $Src & """")
	$Src = @TempDir
EndFunc   ;==>Live5_Folder

;====================================================================================
; Functions dealing with creating the GUI for the program:
;====================================================================================
Func Page0_Build()
	; If a I386 folders exists in install folder, use it.  Otherwise, use last browsed source folder:
	If @Compiled And FileExists(EnvGet("InstallDir") & "\i386") Then
		$Src = EnvGet("InstallDir")
		$Live = 0
	Else
		$Src = RegRead($SET, "LastBrowseSource")
	EndIf

	; Show the XPtsp Orb as splash screen for 3 seconds:
	If @Compiled Then
		SplashImageOn("", $Working & "\Pics\XPtspOrb.jpg", 354, 354, -1, -1, 1)
		Sleep(3000)
		SplashOff()
	EndIf

	; Parse the rest of the command-line parameters:
	If $CMD_NA <> "" Then
		$CMD_NA = StringSplit($CMD_NA, " ")
		If $CMD_NA[0] > 0 Then
			For $I = 1 To $CMD_NA[0]
				If StringLeft($CMD_NA[$I], 9) = "/TASKMAN:" Then
					$TASKMGR = StringReplace($CMD_NA[$I], "/TASKMAN:", "")
					If IniRead($Working & "\XPtsp.ini", "_TASKMGR.EXE", $TASKMGR, "") = "" Then _Error(_ReadStr("Main_05"))
				ElseIf StringLeft($CMD_NA[$I], 9) = "/BOOTSCR:" Then
					$BOOTSCR = StringReplace($CMD_NA[$I], "/BOOTSCR:", "")
					If $BOOTSCR <> "Green" And $BOOTSCR <> "Blue" And $BOOTSCR <> "Red" And $BOOTSCR <> "Purple" Then _Error(_ReadStr("Main_06"))
				ElseIf StringLeft($CMD_NA[$I], 6) = "/LANG:" Then
					$LANG = StringReplace($CMD_NA[$I], "/LANG:", "")
					If FileExists("Languages\" & $LANG & ".ini") = 0 Then _Error(_ReadStr("Main_07"))
				ElseIf $CMD_NA[$I] = "/ONLINE" Then
					$ONLINE = 1
				ElseIf $CMD_NA[$I] = "/OFFLINE" Then
					$ONLINE = 0
				ElseIf $CMD_NA[$I] = "/NOREBOOT" Then
					$REBOOT = -1
				ElseIf $CMD_NA[$I] = "/REBOOT" Then
					$REBOOT = -2
				ElseIf $CMD_NA[$I] = "/NORESTORE" Then
					$SYSREST = 0
				ElseIf $CMD_NA[$I] = "/NOHEX" Then ; Component Selection: Hex Editing SubMenu
					$PATCH = 0
					$UXTHEME = 0
					$SETUPAPI = 0
					$SFC = 0
				ElseIf $CMD_NA[$I] = "/NOUXTHEME" Then
					$UXTHEME = 0
				ElseIf $CMD_NA[$I] = "/NOSETUPAPI" Then
					$SETUPAPI = 0
				ElseIf $CMD_NA[$I] = "/SFC" Then
					$SFC = 1
				ElseIf $CMD_NA[$I] = "/NOSFC" Then
					$SFC = 0
				ElseIf $CMD_NA[$I] = "/NOFILES" Then ; Component Selection: Files SubMenu
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
				ElseIf $CMD_NA[$I] = "/NOEXE" Then
					$EXE = 0
				ElseIf $CMD_NA[$I] = "/NODLL" Then
					$DLL = 0
				ElseIf $CMD_NA[$I] = "/NOCPL" Then
					$CPL = 0
				ElseIf $CMD_NA[$I] = "/NOOCX" Then
					$OCX = 0
				ElseIf $CMD_NA[$I] = "/NOAT" Then
					$AT = 0
				ElseIf $CMD_NA[$I] = "/NOOE" Then
					$OE = 0
				ElseIf $CMD_NA[$I] = "/NOIE" Then
					$IE = 0
				ElseIf $CMD_NA[$I] = "/NOWMP" Then
					$WMP = 0
				ElseIf $CMD_NA[$I] = "/NORDP" Then
					$RDP = 0
				ElseIf $CMD_NA[$I] = "/NOMCE" Then
					$MCE = 0
				ElseIf $CMD_NA[$I] = "/NOOOBE" Then
					$OOBE = 0
				ElseIf $CMD_NA[$I] = "/NOEXTRA" Then ; Component Selection: Extra SubMenu
					$EXTRA = 0
					$VISUAL = 0
					$SOUND = 0
					$UAP = 0
					$AERO = 0
					$AUTO = 0
					$REPATCH = 0
					$BOOT = 0
				ElseIf $CMD_NA[$I] = "/NOVISUAL" Then
					$VISUAL = 0
				ElseIf $CMD_NA[$I] = "/NOWALL" Then
					$WALL = 0
				ElseIf $CMD_NA[$I] = "/NOBOOT" Then
					$BOOT = 0
				ElseIf $CMD_NA[$I] = "/NOSOUND" Then
					$SOUND = 0
				ElseIf $CMD_NA[$I] = "/NOUAP" Then
					$UAP = 0
				ElseIf $CMD_NA[$I] = "/NOAERO" Then
					$AERO = 0
				ElseIf $CMD_NA[$I] = "/NOAUTO" Then
					$AUTO = 0
				ElseIf $CMD_NA[$I] = "/NOREPATCH" Then
					$REPATCH = 0
				ElseIf $CMD_NA[$I] = "/NOPROG" Then ; Component Selection: Programs SubMenu
					$PROG = 0
					$FLIP = 0
					$DSI = 0
					$UBER = 0
					$OEM = 0
					$QTBAR = 0
					$TASKTIPS = 0
				ElseIf $CMD_NA[$I] = "/NOQTBAR" Then
					$QTBAR = 0
				ElseIf $CMD_NA[$I] = "/NOTASKTIPS" Then
					$TASKTIPS = 0
				ElseIf $CMD_NA[$I] = "/NOFLIP" Then
					$FLIP = 0
				ElseIf $CMD_NA[$I] = "/NODSI" Then
					$DSI = 0
				ElseIf $CMD_NA[$I] = "/NOOEM" Then
					$OEM = 0
				ElseIf $CMD_NA[$I] = "/NOUBER" Then
					$UBER = 0
				Else
					_Error(_FormatStr("Main_08", $TITLE))
				EndIf
			Next
		EndIf
	EndIf

	; Get a list of the languages for "Language Selection":
	Local $Handle = FileFindFirstFile("Languages\*.ini"), $Files = "", $File
	If $Handle = -1 Then _Error(_FormatStr("P_00a", "Languages"))
	While 1
		$File = FileFindNextFile($Handle)
		If @error Then ExitLoop
		$Files = _Iif($Files <> "", $Files & "|", "") & StringReplace($File, ".ini", "")
	WEnd
	FileClose($Handle)
	If $SILENT = 1 Or StringInStr($Files, "|") = 0 Then Return Page1_Build()

	; Ask the user which language to use:
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
EndFunc   ;==>Page0_Build

Func Page0_Cancel()
	Exit
EndFunc   ;==>Page0_Cancel

Func Page0_Language()
	$LANG = GUICtrlRead($Pat[2])
EndFunc   ;==>Page0_Language

;====================================================================================
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
EndFunc   ;==>Page1_Build

;====================================================================================
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
	;GUICtrlCreateGroup("", 0, 314, 500, 1, BitOr($WS_BORDER, $WS_CHILD, $WS_VISIBLE))
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
EndFunc   ;==>Page2_Build

Func Page2_Agree()
	Local $T = _Iif(BitAND(GUICtrlRead($Pat[8]), $GUI_CHECKED), BitOR($GUI_ENABLE, $GUI_FOCUS), $GUI_DISABLE)
	GUICtrlSetState($Pat[2], $T)
	GUICtrlSetState($Pat[9], $T)
EndFunc   ;==>Page2_Agree

Func Page2_Remember()
	RegWrite($SET, "NoPrompt", "REG_SZ", BitAND(GUICtrlRead($Pat[2]), $GUI_CHECKED))
EndFunc   ;==>Page2_Remember

;====================================================================================
Func Page3_Build()
	$Integrate = 3
	If $SILENT = 1 Then Return Page4_Build()

	; Create the "Choose Install Method" page:
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
EndFunc   ;==>Page3_Build

Func Page3_Mode()
	$Live = _Iif($Pat[99] = @GUI_CtrlId, 1, 0)
EndFunc   ;==>Page3_Mode

Func Page3_Offline()
	$ONLINE = 1 - BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_CHECKED)
EndFunc   ;==>Page3_Offline

;====================================================================================
Func Page4_Build()
	; If translation code isn't enabled, then jump to proper page:
	If $Integrate > 4 Then Return Page3_Build()
	If $DEBUG = 0 Or $SILENT = 1 Then Return Page4_Next()

	; Create the "Express or Custom" page:
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
EndFunc   ;==>Page4_Build

Func Page4_Mode()
	$EXPRESS = _Iif($Pat[99] = @GUI_CtrlId, 1, 0)
	GUICtrlSetData($Pat[9], _Iif($Live = 1 And $EXPRESS = 1, _ReadStr("Main_46"), _ReadStr("P_01c") & " >"))
EndFunc   ;==>Page4_Mode

Func Page4_Next()
	If $Live = 0 Then Return Page5_Build()
	Return Page6_Build()
EndFunc   ;==>Page4_Next

;====================================================================================
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
	GUICtrlCreateLabel(_ReadStr("P_05e") & " 250MB", 120, 120, 250, 15)
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
EndFunc   ;==>Page5_Build

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
EndFunc   ;==>Page5_Browse

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
	Page5_CheckOS()
	If $Type = "Dunno" Then
		MsgBox(0x30, $TITLE, _ReadStr("P_05h"), 0, $GUI)
		GUICtrlSetState($Pat[1], $GUI_FOCUS)
	Else
		GUICtrlSetState($Pat[7], $GUI_FOCUS)
	EndIf
	$Pat[6] = DirGetSize($Src) / 1024 / 1024
EndFunc   ;==>Page5_Source

Func Page5_SetCopy()
	Local $R = BitAND(GUICtrlRead($Pat[4]), $GUI_CHECKED)
	GUICtrlSetState($Pat[5], _Iif($R, $GUI_ENABLE, $GUI_DISABLE))
	GUICtrlSetState($Pat[7], _Iif($R, $GUI_ENABLE, $GUI_DISABLE))
EndFunc   ;==>Page5_SetCopy

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
EndFunc   ;==>Page5_SetDest

Func Page5_CheckOS()
	Local $Space = DriveSpaceFree(StringLeft($Src, 2)), $Handle, $File, $R
	$Space = _Iif($Space > 1000, Round($Space / 1024, 1) & "GB", Round($Space, 1) & "MB")
	GUICtrlSetData($Pat[2], _ReadStr("P_05j") & " " & $Space)

	; If version of kernel isn't v5.x.x.x, then OS type is "Dunno":
	; FYI: v5.0 = Windows 2000; v5.1 = XP; v5.2 = XP x64 or Windows 2003
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
		; Detect the difference between XP Home and Pro:
		Local $TPID = StringRight(IniRead($Src & "\i386\SETUPP.INI", "Pid", "Pid", ""), 3)
		Local $Z = _Iif($TPID = "OEM", 1, _Iif($TPID = "270" Or $TPID = "640", 2, 0))
		If FileExists($Src & "\WIN51IC") Then
			$VOL = _Iif($Z = 1, "WXPHOEM_EN", "WXPHFPP_EN")
			$Type = "Home"
		Else
			$VOL = _Iif($Z = 1, "WXPPOEM_EN", _Iif($Z = 2, "WXPPVOL_EN", "WXPPFPP_EN"))
			$Type = "Pro"
		EndIf
		$SP3 = _Iif(FileGetVersion($tmp & "\NTOSKRNL.EXE") >= "5.1.2600.5512", 1, 0)

		; Detect whether there are MCE entry in the Hive:
		Local $Handle = FileOpen($Src & "\i386\HIVESYS.INF", 0), $File
		If $Handle = -1 Then _Error(_FormatStr("Main_20", "HIVESYS.INF"))
		$File = FileRead($Handle)
		FileClose($Handle)
		If StringInStr($File, "HKLM,""SYSTEM\WPA\MediaCenter"",""Installed"",,""1""") > 0 Then
			$VOL = _Iif($Z = 1, "NR1POEM_EN_CD1", "NR1PFRE_EN_CD1")
			$Type = "MCE"
		EndIf
		GUICtrlSetData($Pat[8], _Iif($Type = "MCE", _ReadStr("P_05o"), ""))
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
EndFunc   ;==>Page5_CheckOS

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
		If $Type = "MCE" And FileExists($Src & "\CMPNENTS\MEDIACTR\I386\MEDIACTR.CAB") = 0 Then
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

	; If the XPtspCom.INF file exists, modify it.  Otherwise, use a local copy of the INF in order to get started:
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

	; Build the next page for the GUI:
	Page7_Build()
EndFunc   ;==>Page5_Next

;====================================================================================
Func Page6_Build()
	; If there are any pending file operatings waiting for reboot, abort with a message:
	$SYSREST = 1
	Local $tmp_a = RegRead($HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update", "RebootRequired")
	If @error = 0 Then _Error(_ReadStr("Main_50"))
	$tmp_a = RegRead($HKLM & "\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations")
	If @error = 0 and (@Compiled And $tmp_a <> "") Then _Error(_ReadStr("Main_50"))

	; Use the XPtspCom.Inf in the INF folder if it exists.  Otherwise, create one in the temp folder:
	$INF = @WindowsDir & "\INF\XPtspCom.inf"
	If FileExists($INF) = 0 Then
		$INF = $tmp & "\XPtspCom.INF"
		If FileInstall("XPtspCom.INF", $INF, 1) = 0 Then _Error(_FormatStr("Main_03", "XPtspCom.INF"))
	EndIf

	; Begin building this page for the user:
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
EndFunc   ;==>Page6_Build

Func Page6_Source()
	$Src = GUICtrlRead($Pat[1])
	Page6_CheckOS()
EndFunc   ;==>Page6_Source

Func Page6_Browse()
	Local $Dir = ""
	While $Dir <> @ProgramFilesDir
		Local $Dir = FileSelectFolder(_FormatStr("P_06d", $TITLE), "", 3, $Src)
		If @error Then Return
	WEnd
	$Src = $Dir
	GUICtrlSetData($Pat[1], $Src)
	Page6_CheckOS()
EndFunc   ;==>Page6_Browse

Func Page6_CheckOS()
	; Get Version information from the OS:
	Local $tOSVI = DllStructCreate("dword OSInfoSize; dword Major; dword Minor; dword;" & _
			"dword PlatformId; char[128]; ushort; ushort; ushort SuiteMask; ubyte Product; ubyte")
	DllStructSetData($tOSVI, "OSInfoSize", DllStructGetSize($tOSVI))
	Global $acall = DllCall("kernel32.dll", "int", "GetVersionEx", "ptr", DllStructGetPtr($tOSVI))
	Local $VER = DllStructGetData($tOSVI, "Major") & "." & DllStructGetData($tOSVI, "Minor")
	Local $Suite = DllStructGetData($tOSVI, "SuiteMask"), $SDIR

	; Distiguish which OS we are running on:
	$Type = "Dunno"
	If $VER = "5.1" Then
		$Type = _Iif(BitAND($Suite, 512), "Home", "Pro")
		Local $T = RegRead($HKLM & "\SYSTEM\WPA\MediaCenter", "Installed")
		If @error = 0 And $T = 1 Then $Type = "MCE"
		$SP3 = _Iif(FileGetVersion(@SystemDir & "\NTOSKRNL.EXE") >= "5.1.2600.5512", 1, 0)
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

	; Determine which kernel to use for the bootscreen:
	$KRNL = _Iif(@OSArch <> "x86", @WindowsDir & "\SysNative\", @SystemDir & "\") & "NTOSKRNL.EXE"
	IniWrite("XPtsp.ini", "Live.Patch", "TSP_KRNL.EXE", $KRNL)
EndFunc   ;==>Page6_CheckOS

;====================================================================================
Func Page7_Build()
	Local $oIE, $GUIActiveX, $Handle, $File, $S, $T
	$Integrate = 7
	GUISetState(@SW_DISABLE)
	$USEPRO = _Iif($Type = "Pro" Or $Type = "MCE", 1, 0)

	; If the Version.ini file doesn't exist:
	If $ONLINE = 0 Then FileDelete($tmp & "\Version.ini")
	If FileExists($tmp & "\Version.ini") = 0 Or $DEBUG = 1 Then
		; Show a animated loading image and get the Version.ini file from the server:
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

		; Check to make sure that user has latest version:
		$S = IniRead($tmp & "\Version.ini", "XPtsp_v2", "Program", "")
		If $S <> "" And @Compiled = 1 Then
			$S = StringLeft($S, StringInStr($S, "|") - 1)
			$T = _Iif(IsNumber(StringRight($S, 1)) = 0, StringLeft($S, StringLen($S) - 1), $S)
			If $T > FileGetVersion(@ScriptFullPath) Then
				If MsgBox(0x24, $TITLE, StringReplace(_FormatStr("P_07t", $S), "|", @CRLF), 0, $GUI) = 6 Then
					$File = @DesktopDir & "\XPtsp_v" & $S & "_GUI.exe"
					If _Download_File("XPtsp/XPtsp_v" & $S & "_GUI.exe", $File) = 1 Then Run($File)
					Exit
				EndIf
			EndIf
		EndIf

		; Put location of local theme files into it:
		$Handle = FileFindFirstFile($OUTPUT & "\*.xptsp")
		If $Handle <> -1 Then
			While 1
				$File = FileFindNextFile($Handle)
				If @error Then ExitLoop
				IniWrite($tmp & "\Version.ini", "Location", $File, $OUTPUT)
			WEnd
			FileClose($Handle)
		EndIf

		; Put location of local batch versions of theme files into it:
		$Handle = FileFindFirstFile($OUTPUT & "\*.batch.exe")
		If $Handle <> -1 Then
			While 1
				$File = FileFindNextFile($Handle)
				If @error Then ExitLoop
				IniWrite($tmp & "\Version.ini", "Location", $File, $OUTPUT)
			WEnd
			FileClose($Handle)
		EndIf
		GUIDelete($TEMP)
	EndIf

	; Build the Component Selection GUI page:
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

	; Create the Theme Selection box:
	GUICtrlCreateLabel(_ReadStr("P_07b"), 120, 40, 350, 20)
	$Pat[31] = GUICtrlCreateCombo("", 120, 60, 240, 20, $CBS_DROPDOWNLIST)
	GUICtrlSetOnEvent(-1, "Page7_Selected")
	GUICtrlCreateButton(_ReadStr("P_05d"), 370, 60, 100, 25)
	GUICtrlSetOnEvent(-1, "Page7_Browse")
	$Pat[30] = GUICtrlCreateButton(_ReadStr("P_07c"), 200, 90, 200, 30)
	GUICtrlSetOnEvent(-1, "Page7_PackageInfo")
	;$Pat[33] = GUICtrlCreatePic($Working & "\Pics\nopic.jpg", 200, 130, 200, 150, $SS_SUNKEN)
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
EndFunc   ;==>Page7_Build

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
	$I = IniRead($tmp & "\Version.ini", "Location", $F, "")
	IniWrite($tmp & "\Version.ini", "Location", $F, $S)
	$THEME = StringLeft($F, StringInStr($F, ".", 0, -1) - 1)
	Page7_FindThemes()
	Page7_Selected()
	Page7_GetPic(1)
EndFunc   ;==>Page7_Browse

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
			For $I = 1 To $INI[0][0]
				If StringLeft($INI[$I][0], StringInStr($INI[$I][0], ".", 0, -1) - 1) = $THEME Then
					$THEME_FILE = $INI[$I][1] & "\" & $INI[$I][0]
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
EndFunc   ;==>Page7_Selected

Func Page7_PackageInfo()
	MsgBox(0, $TITLE, _ReadStr("P_07f") & " " & $THEME & @CRLF & @CRLF & $Pat[32], 0, $GUI)
EndFunc   ;==>Page7_PackageInfo

Func Page7_NextPic()
	Page7_GetPic($Pat[36] + 1)
EndFunc   ;==>Page7_NextPic

Func Page7_PrevPic()
	Page7_GetPic($Pat[36] - 1)
EndFunc   ;==>Page7_PrevPic

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
EndFunc   ;==>Page7_GetPic

Func Page7_LargePic()
	; Get image dimensions and scale to max of screen size:
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

	; Open new window with large image:
	GUISetState(@SW_DISABLE, $GUI)
	GUICreate(_ReadStr("P_10h"), $iW, $iH, -1, -1, $WS_POPUPWINDOW, -1, $GUI)
	GUICtrlCreatePic($Pat[37], 0, 0, $iW, $iH)
	GUICtrlSetOnEvent(-1, "Page10_PreCancel")
	GUISetOnEvent($GUI_EVENT_CLOSE, "Page10_PreCancel")
	GUISetState()
EndFunc   ;==>Page7_LargePic

Func Page7_FindThemes()
	Local $SECT, $Handle, $File, $S, $ARR, $Flagged, $Packages = False, $STAT, $T, $DEF = "", $LOC
	Local $S1 = _ReadStr("P_07m1"), $S2 = _ReadStr("P_07m2"), $S3 = _ReadStr("P_07m3"), $S4 = _ReadStr("P_07m4"), $S5 = _ReadStr("P_07m5")

	; Parse information from Version.php:
	GUICtrlSetData($Pat[31], "")
	$SECT = IniReadSection($tmp & "\Version.ini", "Themes_v3")
	If @error = 0 Then
		$DEF = $THEME & " (" & $S1 & ")"
		For $I = 1 To $SECT[0][0]
			$S = $SECT[$I][0] & " (" & $S1 & ")"
			GUICtrlSetData($Pat[31], $S, $DEF)
			$Packages = True
		Next
	Else
		Local $SECT[1][2]
	EndIf

	; See if the themes that already exist are same as those offered online:
	Local $INI = IniReadSection($tmp & "\Version.ini", "Location")
	If @error = 0 Then
		If $SECT[0][0] > 0 Then GUICtrlSetData($Pat[31], "===================================", $DEF)
		For $I = 1 To $INI[0][0]
			$Packages = True
			$File = $INI[$I][0]
			$S = StringLeft($File, StringInStr($File, ".", 0, -1) - 1)
			$LOC = $INI[$I][1]
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

	; If no packages found, notify user about the situation and ask what to do:
	If $Packages = False Then
		If MsgBox(0x15, $TITLE, StringReplace(_ReadStr("P_07g"), "|", @CRLF)) = 2 Then _CancelAnyPage()
	EndIf
	Return $Packages
EndFunc   ;==>Page7_FindThemes

Func Page7_Download()
	Local $Byte1, $Rate, $Total = $MAX, $TEMP = 0, $S, $T, $INI, $Handle
	GUISetState(@SW_DISABLE, $GUI)

	; If we are dealing with a GUI theme package, then:
	$BATCH = StringInStr($THEME_FILE, ".exe")
	If $BATCH = 0 Then
		; Download the specified resource package from the website:
		If StringInStr(GUICtrlRead($Pat[31]), _ReadStr("P_07m1")) <> 0 Then
			If _Download_File("XPtsp/" & $THEME & "/" & $THEME & ".xptsp", $THEME_FILE) = 0 Then Return GUISetState(@SW_ENABLE, $GUI)
			IniWrite($tmp & "\Version.ini", "FileInfo", $THEME, IniRead($tmp & "\Version.ini", "Themes_v3", $THEME, "|Original"))
			IniDelete($res & "\Version.ini", "Theme", "Name")
		EndIf

		; Extract the contents of the package if different from the existing resources:
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
		; Notify user to please wait until decompression has been completed:
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

		; Unpack the batch version, then close the batch file window:
		DirCreate($tmp)
		$PID = Run($THEME_FILE & " -s", $tmp)
		While ProcessExists($PID) <> 0
		WEnd
		If FileExists($tmp & "\XPtsp.bat") Then
			WinClose("XPtsp script")
			WinClose("Administrator:  XPtsp script !!! - ERROR - !!!")
		EndIf

		; Let's move stuff around into the proper folders:
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

		; Let's create the Version.ini files as required by the GUI:
		GUICtrlSetData($TEXT, StringReplace(_ReadStr("P_07u"), "|", @CRLF))
		IniWrite($res & "\Version.ini", "XPtsp", "Program", Page7_FileData(@ScriptFullPath, 0))
		IniWrite($res & "\Version.ini", "Theme", "Name", GUICtrlRead($Pat[31]))
		$Handle = FileFindFirstFile($res & "\*.res")
		If $Handle <> -1 Then
			While 1
				$S = FileFindNextFile($Handle)
				If @error Then ExitLoop
				IniWrite($res & "\Version.ini", "Pro", StringReplace($S, ".res", ""), Page7_FileData($res & "\" & $S))
			WEnd
		EndIf
		FileClose($Handle)
		IniWrite($xtra & "\Version.ini", "Extra", "Name", GUICtrlRead($Pat[31]))
	EndIf
	$Translate = _Iif(IniRead($res & "\Version.ini", "Theme", "Version", "1.0") < "2.0", -1, 1)
	$FullPack = _Iif(IniRead($res & "\Version.ini", "Theme", "FullPack", "Y") <> "Y", 0, 1)
	$BOOTSCR = _Iif(FileExists($res & "\" & $THEME & ".res") OR ($THEME = "Purple"), $THEME, "Green")
	$TASKMGR = _Iif(IniRead($Working & "\XPtsp.ini", "_TaskMgr.Exe", $THEME, "") <> "", $THEME, "Green")
	$S = IniRead($tmp & "\Version.ini", "FileInfo", $THEME, "|Original")
	$XPack = StringMid($S, StringInStr($S, "|", 0, -1) + 1)

	; Delete Page 7 GUI if we are in Silent/Express mode:
	If $SILENT > 0 Or $EXPRESS = 1 Then
		GUIDelete($GUI)
		$GUI = $CMD_NA
	EndIf
	Page8_Build()
EndFunc   ;==>Page7_Download

Func Page7_FileData($File, $MD5 = 1)
	Local $S = FileGetVersion($File)
	If $MD5 Then $S = _MD5Hash($File)
	Return $S & "|" & FileGetSize($File) & "|" & FileGetTime($File, 0, 1)
EndFunc   ;==>Page7_FileData

;====================================================================================
Func Page8_Build()
	Local $Handle, $File, $atmp

	; Search for all local versions:
	$Integrate = 8
	$Handle = FileFindFirstFile($OUTPUT & "\*.extra")
	If $Handle <> -1 Then
		While 1
			$File = FileFindNextFile($Handle)
			If @error Then ExitLoop
			IniWrite($tmp & "\Version.ini", "Location.Extra", $File, $OUTPUT)
		WEnd
		FileClose($Handle)
	EndIf
	$Handle = FileFindFirstFile($OUTPUT & "\DriveSpace*.exe")
	If $Handle <> -1 Then
		While 1
			$File = FileFindNextFile($Handle)
			If @error Then ExitLoop
			$atmp = _ReadStr("P_30d2") & " " & StringReplace(StringReplace($File, "DriveSpace_v", ""), "_Silent.exe", "")
			IniWrite($tmp & "\Version.ini", "Location.DSI", $atmp, $OUTPUT & "\" & $File)
		WEnd
		FileClose($Handle)
	EndIf
	$Handle = FileFindFirstFile($OUTPUT & "\*dotnet*.exe")
	If $Handle <> -1 Then
		While 1
			$File = FileFindNextFile($Handle)
			If @error Then ExitLoop
			IniWrite($tmp & "\Version.ini", "Location.Net", $File, $OUTPUT)
		WEnd
		FileClose($Handle)
	EndIf

	; Build the Component Selection GUI page:
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

	; Create the Extras Selection box:
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

	; Create the DSI box:
	GUICtrlCreateGroup(_ReadStr("P_08c"), 106, 140, 380, 165)
	GUICtrlSetFont(-1, 12, 800)
	$Pat[31] = GUICtrlCreateCheckbox(_ReadStr("P_08d"), 120, 170, 350, 20)
	If $DSI Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetOnEvent(-1, "Page8_DSI_Check")
	$Pat[32] = GUICtrlCreateCombo("", 120, 190, 240, 20, $CBS_DROPDOWNLIST)
	$Pat[33] = GUICtrlCreateButton(_ReadStr("P_05d"), 370, 190, 100, 25)
	GUICtrlSetOnEvent(-1, "Page8_DSI_Browse")

	; Create the .NET box:
	$Pat[34] = GUICtrlCreateCheckbox(_ReadStr("P_08e"), 120, 240, 350, 20)
	If $DOTNET Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetOnEvent(-1, "Page8_Net_Check")
	$Pat[35] = GUICtrlCreateCombo("", 120, 260, 240, 20, $CBS_DROPDOWNLIST)
	$Pat[36] = GUICtrlCreateButton(_ReadStr("P_05d"), 370, 260, 100, 25)
	GUICtrlSetOnEvent(-1, "Page8_Net_Browse")

	; Create rest of dialog box:
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
EndFunc   ;==>Page8_Build

Func Page8_XPack()
	Local $R = _Iif(BitAND(GUICtrlRead($Pat[29]), $GUI_CHECKED), $GUI_ENABLE, $GUI_DISABLE)
	GUICtrlSetState($Pat[30], $R)
	GUICtrlSetState($Pat[28], $R)
	GUICtrlSetState($Pat[27], $R)
EndFunc   ;==>Page8_XPack

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
			For $I = 1 To $INI[0][0]
				If StringLeft($INI[$I][0], StringInStr($INI[$I][0], ".", 0, -1) - 1) = $XPack Then
					$XPACK_FILE = $INI[$I][1] & "\" & $INI[$I][0]
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
EndFunc   ;==>Page8_Selected

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
EndFunc   ;==>Page8_Browse

Func Page8_PackageInfo()
	MsgBox(0, $TITLE, _ReadStr("P_07f") & " " & $XPack & @CRLF & @CRLF & $Pat[2], 0, $GUI)
EndFunc   ;==>Page8_PackageInfo

Func Page8_DSI_Check()
	$DSI = BitAND(GUICtrlRead($Pat[31]), $GUI_CHECKED)
	GUICtrlSetState($Pat[32], _Iif($DSI, $GUI_ENABLE, $GUI_DISABLE))
	GUICtrlSetState($Pat[33], _Iif($DSI, $GUI_ENABLE, $GUI_DISABLE))
EndFunc   ;==>Page8_DSI_Check

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
EndFunc   ;==>Page8_DSI_Browse

Func Page8_Net_Check()
	$DOTNET = BitAND(GUICtrlRead($Pat[34]), $GUI_CHECKED)
	GUICtrlSetState($Pat[35], _Iif($DOTNET, $GUI_ENABLE, $GUI_DISABLE))
	GUICtrlSetState($Pat[36], _Iif($DOTNET, $GUI_ENABLE, $GUI_DISABLE))
EndFunc   ;==>Page8_Net_Check

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
EndFunc   ;==>Page8_Net_Browse

Func Page8_Populate()
	Local $S1 = _ReadStr("P_07m1"), $S2 = _ReadStr("P_07m2"), $S3 = _ReadStr("P_07m3"), $S4 = _ReadStr("P_07m4")
	Local $SECT[1][2] = [[0]], $Handle, $File, $S, $ARR, $Flagged, $STAT, $T, $DEF, $LOC, $X

	; Populate the Extra's combo box with the packages available:
	GUICtrlSetData($Pat[30], "")
	Local $SECT = IniReadSection($tmp & "\Version.ini", "Extras_v2")
	$DEF = $XPack & " (" & $S1 & ")"
	If @error = 0 Then
		For $I = 1 To $SECT[0][0]
			GUICtrlSetData($Pat[30], $SECT[$I][0] & " (" & $S1 & ")", $DEF)
		Next
	Else
		Local $SECT[1][2]
	EndIf
	Local $INI = IniReadSection($tmp & "\Version.ini", "Location.Extra")
	If @error = 0 Then
		If $SECT[0][0] > 0 Then GUICtrlSetData($Pat[30], "===================================", $DEF)
		For $I = 1 To $INI[0][0]
			$File = $INI[$I][0]
			$S = StringLeft($File, StringInStr($File, ".", 0, -1) - 1)
			$LOC = $INI[$I][1]
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

	; Populate the DSI combo box with the DSI packages available:
	Local $SECT = IniRead($tmp & "\Version.ini", "DSI", "Latest", "||")
	$SECT = StringSplit($SECT, "|")
	$DEF = ""
	$X = _ReadStr("P_30d2")
	If $SECT[1] <> "" Then
		$DEF = $X & " " & $SECT[1] & " (" & $S1 & ")"
		GUICtrlSetData($Pat[32], $DEF, $DEF)
	EndIf
	Local $INI = IniReadSection($tmp & "\Version.ini", "Location.DSI")
	If @error = 0 Then
		If $DEF <> "" Then GUICtrlSetData($Pat[32], "===================================", $DEF)
		For $I = 1 To $INI[0][0]
			$S = $INI[$I][0]
			$File = $INI[$I][1]
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

	; Populate the .NET combo box with the .NET packages available:
	Local $SECT = IniRead($tmp & "\Version.ini", "DotNet", "Latest", "||")
	$SECT = StringSplit($SECT, "|")
	$DEF = ""
	$X = _ReadStr("P_30d2")
	If $SECT[1] <> "" Then
		$DEF = "dotnet2.exe (" & $S1 & ")"
		GUICtrlSetData($Pat[35], $DEF, $DEF)
	EndIf
	Local $INI = IniReadSection($tmp & "\Version.ini", "Location.Net")
	If @error = 0 Then
		If $DEF <> "" Then GUICtrlSetData($Pat[35], "===================================", $DEF)
		For $I = 1 To $INI[0][0]
			$S = $INI[$I][0]
			$File = $INI[$I][1] & "\" & $S
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
EndFunc   ;==>Page8_Populate

Func Page8_Download()
	Local $S, $T, $UP = _ReadStr("P_07m1")

	; Download the specified extra package from the website and extract:
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

	; Download DSI if the online version is requested:
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

	; Download .NET Framework 2.0 if the online version is requested:
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

	; Delete Page 8 GUI if we are in Silent/Express mode:
	If $SILENT > 0 Or $EXPRESS = 1 Then
		GUIDelete($GUI)
		$GUI = $CMD_NA
	EndIf
	Page9_Build()
EndFunc   ;==>Page8_Download

;====================================================================================
Func Page9_Build()
	If $Integrate = 4 Then Page5_CheckOS()
	$Integrate = 9
	Local $X, $Y, $T, $T1
	GUISetState(@SW_DISABLE)
	If $Live <> 0 Then _WinSxS_Folders()

	; Build the Component Selection GUI page:
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

	; Create the Patches menu:
	$X = Page9_AddItem($TREE, "CS2", "PATCH", "Page9_Section")
	$LV[Page9_FindControl($X)][9] = 0
	If $OS <> "W2K" Then Page9_AddItem($X, "CS2A", "UXTHEME")
	Page9_AddItem($X, "CS2B", "SFC")

	; Create the Files menu:
	$X = Page9_AddItem($TREE, "CS3", "FILES", "Page9_TopLevel")
	$LV[Page9_FindControl($X)][9] = 0
	Page9_AddSection($X, "CS3A", "EXE Files", "EXE")
	Page9_AddSection($X, "CS3B", "DLL Files", "DLL")
	Page9_AddSection($X, "CS3C", "CPL Files", "CPL")
	Page9_AddSection($X, "CS3D", "OCX Files", "OCX")
	Page9_AddSection($X, "CS3E", "AT Files", "AT")
	Page9_AddSection($X, "CS3F", "OE Files", "OE")
	Page9_AddSection($X, "CS3G", "IE7 Files", "IE")
	Page9_AddSection($X, "CS3H", "WMP11 Files", "WMP")
	Page9_AddSection($X, "CS3I", "RDP6 Files", "RDP")
	Page9_AddSection($X, "CS3L", "NetMeeting", "NetMeeting")
	If $Type = "MCE" Then Page9_AddSection($X, "CS3J", "MCE Files", "MCE")
	If $Live = 0 and ($Type <> "W2K" And $Type <> "W2K3") Then Page9_AddItem($X, "CS3K", "OOBE")

	; Create the Extras menu:
	$X = Page9_AddItem($TREE, "CS4", "EXTRA", "Page9_TopLevel")
	$LV[Page9_FindControl($X)][9] = 0
	$Y = Page9_AddItem($X, "CS4A", "BOOT", "Page9_Section")
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
		Page9_AddItem($X, "CS4B", "SCRSAVER")
		Page9_AddItem($X, "CS4C", "WALL")
		$Y = Page9_AddItem($X, "CS4D", "VISUAL", "Page9_Section")
		Page9_AddItem($Y, "LUNA.MST", "", "", "Strings", 0)
		Page9_AddItem($Y, "BLUE_SS.DLL", "", "", "Strings", 0)
		Page9_AddItem($Y, "HOME_SS.DLL", "", "", "Strings", 0)
		Page9_AddItem($Y, "METAL_SS.DLL", "", "", "Strings", 0)
		If $Type = "MCE" Then
			Page9_AddItem($Y, "ROYALE.MST", "", "", "Strings", 0)
			Page9_AddItem($Y, "ROYALE_SS.DLL", "", "", "Strings", 0)
		EndIf
		Page9_AddItem($X, "CS4E", "SOUND")
		Page9_AddItem($X, "CS4I", "AUTO")

		If FileExists($xtra & "\Programs") Then
			$X = Page9_AddItem($TREE, "CS5", "", "Page9_Section")
			$LV[Page9_FindControl($X)][9] = 0
			$T = IniReadSection($xtra & "\Version.ini", "AddOns")
			If @error Then _Error(_FormatStr("Main_02", "AddOns"))
			For $I = 1 To $T[0][0]
				If IsDeclared($T[$I][0]) = 0 Then Assign($T[$I][0], 1, 2)
				IniWrite($Working & "\Languages\" & $LANG & ".ini", "Strings", $T[$I][0], $T[$I][1])
				Page9_AddItem($X, $T[$I][0], $T[$I][0])
			Next
		EndIf

		$X = Page9_AddItem($TREE, "CS6", "", "Page9_Section")
		$LV[Page9_FindControl($X)][9] = 0
		Page9_AddItem($X, "CS6A", "REPATCH")
		If $Live = 1 And FileExists(@SystemDir & "\OEMINFO.INI") And @Compiled = 1 Then
			$OEM = 0
		Else
			Page9_AddItem($X, "CS6B", "OEM")
		EndIf
		Page9_AddItem($X, "CS6C", "RESOURCES")
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
EndFunc   ;==>Page9_Build

Func Page9_AddItem($PARENT, $ITEM, $VarName = "", $CallBack = "", $Section = "Strings", $Shown = 1)
	Local $LongDesc = _ReadStr($ITEM, $Section), $I
	$LongDesc = StringSplit($ITEM & "|" & $LongDesc, "|")
	If $LongDesc[0] = 3 Then
		$LongDesc[1] = $LongDesc[2]
		$LongDesc[2] = $LongDesc[3]
	EndIf
	$I = Page9_FindItem($LongDesc[1])
	If $I = 0 Then
		$I = $LV[0][0] + 1
		$LV[0][0] = $I
	EndIf
	If UBound($LV) = $I Then ReDim $LV[UBound($LV) + 10][11]
	If $ITEM = "COMCTL32.DLL" Then $CallBack = "Page9_Section"
	$LV[$I][1] = _Iif($PARENT <> $TREE, $PARENT, 0)
	$LV[$I][2] = $ITEM
	$LV[$I][3] = $LongDesc[1]
	$LV[$I][4] = $LongDesc[2]
	$LV[$I][7] = _Iif($ITEM = "TASKMGR.EXE", "TASK", $VarName)
	If $I = $LV[0][0] Then
		$LV[$I][6] = (IniRead($INF, "Pro", $LV[$I][3], "") <> "") + 0
		;$LV[$I][6] = _Iif($Live < 2, 0, FileExists($Src & "\Backup\" & $LV[$I][3]))
		If $LV[$I][7] = "" Then
			$LV[$I][5] = Page9_FileDiff($LV[$I][3], $LV[$I][6])
		Else
			$LV[$I][5] = Eval($LV[$I][7])
		EndIf
	Else
		$LV[$I][6] = 0
		$LV[$I][5] = 0
	EndIf
	$LV[$I][8] = _Iif($LV[$I][5] > 0, 1, 0)
	$LV[$I][9] = 1
	If $Shown = 1 Then
		$LV[$I][0] = GUICtrlCreateTreeViewItem($LV[$I][3], $PARENT)
		GUICtrlSetOnEvent(-1, "Page9_Files")
		If $CallBack <> "" Then GUICtrlSetOnEvent(-1, $CallBack)
		GUICtrlSetState(-1, BitOR(_Iif($LV[$I][8] = 0, $GUI_UNCHECKED, $GUI_CHECKED), _Iif($I = 1, $GUI_FOCUS, 0)))
	Else
		$LV[$I][0] = -1
	EndIf
	If $I = 1 Then GUICtrlSetData($Pat[9], $LV[$I][4])
	If $ITEM = "COMCTL32.DLL" Then
		For $I = 1 To 7
			Page9_AddItem($LV[$I][0], "COMCTL" & $I + 32 & ".DLL", "", "", "", 0)
		Next
	EndIf
	$LV[$I][10] = 0
	Return $LV[$I][0]
EndFunc   ;==>Page9_AddItem

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
EndFunc   ;==>Page9_FileDiff

Func Page9_AddSection($PARENT, $String, $Section, $VarName = "")
	Local $ARR = IniReadSection("Languages\" & $LANG & ".ini", $Section)
	If @error = 1 Then Return
	If $ARR[0][0] = 0 Then Return
	Local $X = Page9_AddItem($PARENT, $String, $VarName, "Page9_Section")
	$LV[Page9_FindControl($X)][9] = 0
	For $I = 1 To $ARR[0][0]
		Page9_AddItem($X, StringUpper($ARR[$I][0]), "", "Page9_Files", $Section)
	Next
	Return $X
EndFunc   ;==>Page9_AddSection

Func Page9_Section()
	Local $Y = Page9_FindControl(@GUI_CtrlId)
	Local $X = _Iif(BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_UNCHECKED), 0, 1)
	GUICtrlSetData($Pat[9], $LV[$Y][4])
	If $LV[$Y][8] <> $X Then
		$LV[$Y][8] = $X
		Page9_StateChange(@GUI_CtrlId, $X)
	EndIf
EndFunc   ;==>Page9_Section

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
EndFunc   ;==>Page9_TopLevel

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
EndFunc   ;==>Page9_Files

Func Page9_ChangeParent($ID)
	Local $Check = 0, $T = Page9_FindControl($ID)
	For $I = 1 To $LV[0][0]
		If $LV[$I][1] = $ID Then
			If $LV[$I][8] <> 0 Then $Check = 1
		EndIf
	Next
	$LV[$T][8] = $Check
	If $LV[$T][0] <> -1 Then GUICtrlSetState($LV[$T][0], _Iif($Check = 1, $GUI_CHECKED, $GUI_UNCHECKED))
	If $LV[$T][7] <> "" Then Assign($LV[$T][7], $LV[$T][8])
	If $LV[$T][1] <> 0 Then Page9_ChangeParent($LV[$T][1])
EndFunc   ;==>Page9_ChangeParent

Func Page9_FindControl($ID)
	For $I = 1 To $LV[0][0]
		If $LV[$I][0] = $ID Then Return $I
	Next
	Return 0
EndFunc   ;==>Page9_FindControl

Func Page9_FindItem($File)
	For $I = 1 To $LV[0][0]
		If $LV[$I][3] = $File Then Return $I
	Next
	Return 0
EndFunc   ;==>Page9_FindItem

Func Page9_StateChange($ITEM, $State)
	For $Y = 1 To $LV[0][0]
		If $LV[$Y][1] = $ITEM Then
			$LV[$Y][8] = _Iif($State = 1, 1, 0)
			If $LV[$Y][0] <> -1 Then GUICtrlSetState($LV[$Y][0], _Iif($State = 1, $GUI_CHECKED, $GUI_UNCHECKED))
			If $LV[$Y][7] <> "" Then Assign($LV[$Y][7], $State)
		EndIf
	Next
EndFunc   ;==>Page9_StateChange

Func Page9_ChangeButton()
	If $TASK = 0 And $BOOT = 0 And $Live = 1 Then
		GUICtrlSetData($Pat[1], "Start")
	Else
		GUICtrlSetData($Pat[1], _ReadStr("P_01c") & " >")
	EndIf
EndFunc   ;==>Page9_ChangeButton

Func Page9_Next()
	; Delete Page 9 GUI if we are in Silent/Express mode:
	If $SILENT > 0 Or $EXPRESS = 1 Then
		GUIDelete($GUI)
		$GUI = $CMD_NA
	EndIf
	If $Live = 2 Then Return Page31_Repatch()
	Page10_Build()
EndFunc   ;==>Page9_Next

;====================================================================================
Func Page10_Build()
	$Integrate = 10
	If $EXPRESS = 1 Or $SILENT = 1 Or ($Live = 1 And $BOOT = 0 And $TASK = 0) Or $Live > 1 Then Return Page11_Build()
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

	; Create the "Misc" tab:
	GUICtrlCreateTabItem(_ReadStr("P_10k"))
	$Pat[34] = GUICtrlCreateCheckbox(_ReadStr("P_10l"), 125, 65, 330, 20)
	If $Type = "Pro" Then GUICtrlSetState(-1, $GUI_DISABLE)
	If $USEPRO = 1 Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetOnEvent(-1, "Page10_UsePro")
	$Pat[36] = GUICtrlCreatePic($res & "\Visual\" & _Iif($USEPRO = 1, "Th_Pro", "Th_Home") & ".jpg", 125, 83, 330, 100, $SS_CENTERIMAGE)

	; Omit the "Enable Resource Translation" if we are patching a non-English OS:
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
		$Pat[37] = GUICtrlCreateCheckbox(_ReadStr("P_10o"), 125, 245, 330, 20)
		If $XPSPRES = 1 Then GUICtrlSetState(-1, $GUI_CHECKED)
		;GUICtrlSetOnEvent(-1, "Page10_Set_Backup")
	Else
		$Pat[33] = GUICtrlCreateCheckbox(_ReadStr("P_10r"), 125, 225, 330, 20)
		If $SYSREST = 1 Then GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetOnEvent(-1, "Page10_SysRest")
	EndIf

	; Create the "Setup" tab only if integrating to a XP source folder:
	If $Live = 0 Then
		GUICtrlCreateTabItem(_ReadStr("P_10i"))
		$Pat[9] = GUICtrlCreateCheckbox(_ReadStr("P_10b"), 125, 65, 330, 20)
		GUICtrlSetOnEvent(-1, "Page10_ResBox")
		If $GUI_RES <> "" Then GUICtrlSetState(-1, $GUI_CHECKED)
		Local $S = StringSplit("800x600|1024x768|1280x800|1280x1024|1440x900|1600x1200|1680x1050|1920x1200|2560x1600", "|")
		For $I = 1 To $S[0]
			$Pat[9 + $I] = GUICtrlCreateRadio($S[$I], 145, 65 + (20 * $I), 100, 20)
			GUICtrlSetOnEvent(-1, "Page10_ResRadio")
		Next
		GUICtrlSetState($Pat[11], $GUI_CHECKED)
		Page10_ResBox()

		GUICtrlCreateCheckbox(_ReadStr("P_10c"), 125, 265, 330, 20)
		If $ORB = 1 Then GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetOnEvent(-1, "Page10_Orb")
		GUICtrlCreatePic($Working & "\Pics\xptsporb.jpg", 340, 155, 100, 100)
		GUICtrlSetOnEvent(-1, "Page10_PreOrb")

		;GUICtrlCreateTabItem(_ReadStr("P_10j"))
	EndIf

	; Create the "Task Manager" and "Boot Screen" tabs:
	Page10_SubPage()

	; Add everything else to the GUI:
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
EndFunc   ;==>Page10_Build

Func Page10_SubPage()
	Local $ARR = IniReadSection($Working & "\XPtsp.ini", "_TASKMGR.EXE")
	Local $SUB = _Iif($Integrate = 10, 0, 1), $T = _Iif($SUB = 0, 70, 50), $R = _Iif($SUB = 0, 2.6, 2.3)
	Local $H = _Iif($SUB = 0, 170, 155), $V = _Iif($SUB = 0, 100, 80), $S

	; Create the "TaskMgr" tab for the GUI only if we are not using a batch version:
	If $TASK = 1 And $BATCH = 0 Then
		GUICtrlCreateTabItem("TaskMgr")
		GUICtrlCreateLabel(_ReadStr("P_10d"), 120, $T + 5, 200, 20, $SS_RIGHT)
		If $SUB <> 0 Then GUICtrlSetFont(-1, 9, 400)
		If $TASK = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)
		$Pat[1] = GUICtrlCreateCombo("", 330, $T, 110, 20, $CBS_DROPDOWNLIST)
		If $SUB <> 0 Then GUICtrlSetFont(-1, 9, 400)
		If $TASK = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)
		GUICtrlSetOnEvent(-1, "Page10_TaskMan")
		For $I = 1 To $ARR[0][0]
			GUICtrlSetData(-1, $ARR[$I][0], $TASKMGR)
		Next
		$S = $Working & "\Pics\T_" & $BOOTSCR & ".jpg"
		If FileExists($S) = 0 Then $S = $Working & "\Pics\NoPic.jpg"
		$Pat[2] = GUICtrlCreatePic($S, $H, $V, 640 / $R, 480 / $R)
		GUICtrlSetOnEvent(-1, "Page10_PreTask")
		If $SUB = 1 Then
			$Pat[5] = $BOOTSCR
			$Pat[6] = GUICtrlCreateButton(_ReadStr("P_30a6"), 280, 325, 100, 25)
			GUICtrlSetOnEvent(-1, "Page30_Task_Apply")
			GUICtrlSetState(-1, $GUI_DISABLE)
		EndIf
	EndIf

	; Create the "Boot" tab for the GUI:
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
EndFunc   ;==>Page10_SubPage

;------------------------------------------------------------------------------------
Func Page10_TaskMan()
	$TASKMGR = GUICtrlRead($Pat[1])
	GUICtrlSetImage($Pat[2], $Working & "\Pics\T_" & $TASKMGR & ".jpg")
	If $Pat[6] <> 0 Then GUICtrlSetState($Pat[6], _Iif($Pat[5] <> $TASKMGR, $GUI_ENABLE, $GUI_DISABLE))
EndFunc   ;==>Page10_TaskMan

Func Page10_PreTask()
	GUISetState(@SW_DISABLE, $GUI)
	GUICreate(_ReadStr("P_10g"), 623, 477, -1, -1, -1, -1, $GUI)
	GUICtrlCreatePic($Working & "\Pics\T_" & $TASKMGR & ".JPG", 0, 0, 623, 477)
	GUISetOnEvent($GUI_EVENT_CLOSE, "Page10_PreCancel")
	GUISetState()
EndFunc   ;==>Page10_PreTask

;------------------------------------------------------------------------------------
Func Page10_BootScreen()
	$BOOTSCR = GUICtrlRead($Pat[3])
	GUICtrlSetImage($Pat[4], $Working & "\Pics\" & StringLeft($Type, 1) & "_" & $BOOTSCR & ".gif")
	If $Pat[8] <> 0 Then GUICtrlSetState($Pat[8], _Iif($Pat[7] <> $BOOTSCR, $GUI_ENABLE, $GUI_DISABLE))
EndFunc   ;==>Page10_BootScreen

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
EndFunc   ;==>Page10_PreBoot

;------------------------------------------------------------------------------------
Func Page10_ResBox()
	If GUICtrlRead($Pat[9]) = 1 Then
		For $I = 10 To 18
			If GUICtrlRead($Pat[$I]) = 1 Then $GUI_RES = GUICtrlRead($Pat[$I], 1)
		Next
	Else
		$GUI_RES = ""
	EndIf
	For $I = 10 To 18
		GUICtrlSetState($Pat[$I], _Iif($GUI_RES = "", $GUI_DISABLE, $GUI_ENABLE))
	Next
EndFunc   ;==>Page10_ResBox

Func Page10_ResRadio()
	$GUI_RES = GUICtrlRead(@GUI_CtrlId, 1)
EndFunc   ;==>Page10_ResRadio

Func Page10_Orb()
	$ORB = _Iif(BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_CHECKED), 1, 0)
EndFunc   ;==>Page10_Orb

Func Page10_PreOrb()
	GUISetState(@SW_DISABLE, $GUI)
	GUICreate("Orb Preview", 354, 354, -1, -1, $WS_POPUPWINDOW, -1, $GUI)
	GUICtrlCreatePic($xtra & "\xptsporb.jpg", 0, 0, 354, 354)
	GUICtrlSetOnEvent(-1, "Page10_PreCancel")
	GUISetOnEvent($GUI_EVENT_CLOSE, "Page10_PreCancel")
	GUISetState()
EndFunc   ;==>Page10_PreOrb

;------------------------------------------------------------------------------------
Func Page10_PreCancel()
	GUIDelete()
	GUISetState(@SW_ENABLE, $GUI)
	GUISwitch($GUI)
	WinActivate($TITLE)
EndFunc   ;==>Page10_PreCancel

;------------------------------------------------------------------------------------
Func Page10_Translate()
	$Translate = _Iif(BitAND(GUICtrlRead($Pat[30]), $GUI_CHECKED), 1, 0)
	If $Translate = 0 Then
		If MsgBox(0x34, $TITLE, _ReadStr("P_10n"), 0, $GUI) = 7 Then
			$Translate = 1
			GUICtrlSetState($Pat[30], $GUI_CHECKED)
		EndIf
	EndIf
EndFunc   ;==>Page10_Translate

Func Page10_Trans_SP()
	$XPSPRES = _Iif(BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_CHECKED), 1, 0)
EndFunc   ;==>Page10_Trans_SP

Func Page10_UsePro()
	$USEPRO = _Iif(BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_CHECKED), 1, 0)
	GUICtrlSetImage($Pat[36], $res & "\Visual\" & _Iif($USEPRO = 1, "Th_Pro", "Th_Home") & ".jpg")
EndFunc   ;==>Page10_UsePro

Func Page10_SysRest()
	$SYSREST = _Iif(BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_CHECKED), 1, 0)
EndFunc   ;==>Page10_SysRest

;====================================================================================
Func Page11_Build()
	Local $OLD = $GUI, $S, $T, $MakeBackup = _Iif(BitAND(GUICtrlRead($Pat[37]), $GUI_CHECKED), 1, 0)

	; Start the install log and create GUI, launching appropriate function:
	If $MakeBackup = 0 Then $BackDir = ""
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

	; Make sure that correct values are in the component array:
	For $I = 1 To $LV[0][0]
		If $LV[$I][8] = 0 Then $LV[$I][5] = 0
	Next

	; Extract the resources to the proper folder if they haven't already been:
	$TIMER = TimerInit()
	$NUM = 0
	$MAX = 1
	$CNT = 1
	DirCreate($res)
	For $I = 1 To 7
		If FileInstall("empty.res", $res & "\comctl" & $I + 32 & ".dll.res", 1) = 0 Then _Error(_FormatStr("Main_03", "COMCTL" & $I + 32 & ".DLL.RES"))
	Next
	If FileInstall("empty.res", $res & "\UXTHEME.DLL.RES", 1) = 0 Then _Error(_FormatStr("Main_03", "UXTHEME.DLL.RES"))
	$S = _Iif($OS = "W2K", "SFC.DLL", "SFC_OS.DLL")
	If FileInstall("empty.res", $res & "\" & $S & ".RES", 1) = 0 Then _Error(_FormatStr("Main_03", $S))
	$T = _MD5Hash($res & "\sfc_os.dll.res")
	IniWrite($res & "\Version.ini", "Pro", "UXTHEME.DLL", $T)
	IniWrite($res & "\Version.ini", "Pro", $S, $T)

	; If we are installing or integrating to SP3, move contents of "Extra\SP3" into "Extra":
	If $SP3 = 1 Then FileMove($xtra & "\SP3\*", $xtra & "\", 1)

	; Perform some other processing before moving resources:
	If $Type = "X64" Then
		; Replace files that are known to cause problems with the patching process on x64 systems:
		DirCreate($res & "\x64")
		If FileInstall("empty.res", $res & "\x64\MSGINA.DLL.RES") Then IniWrite($res & "\Version.ini", "x64", "MSGINA.DLL", $T)
		If FileInstall("empty.res", $res & "\x64\SHELL32.DLL.RES") Then IniWrite($res & "\Version.ini", "x64", "SHELL32.DLL", $T)
	ElseIf $Type <> "Pro" And FileExists($res & "\" & $Type) = 0 Then
		; Duplicate the Home resources for Win2000 and Win2003:
		If FileCreateNTFSLink($res & "\Home", $res & "\" & $Type, 1) = 0 Then DirCopy($res & "\Home", $res & "\" & $Type, 1)
		$T = IniReadSection($res & "\Version.ini", "Home")
		IniWriteSection($res & "\Version.ini", $Type, $T)
	EndIf

	; Remove Luna replacement visual theme for XP Home if required:
	If $USEPRO = 1 Then
		DirRemove($xtra & "\Visual\Home", 1)
		DirRemove($res & "\Visual\Home", 1)
	EndIf

	; Move the resources into their proper location:
	FileMove($res & "\*_ss.dll", $xtra & "\", 1)
	FileMove($res & "\*.mst", $xtra & "\", 1)
	FileMove($res & "\*.thm", $xtra & "\", 1)
	FileMove($res & "\*.jpg", $xtra & "\", 1)
	FileMove($res & "\" & $Type & "\*.res", $res & "\", 1)
	FileMove($xtra & "\" & $Type & "\*", $xtra & "\", 1)
	FileMove($res & "\Visual\*", $xtra & "\", 1)
	FileMove($res & "\Visual\" & $Type & "\*", $xtra & "\", 1)
	FileCopy($Working & "\Boot\*", $res & "\", 1)
	FileCopy($Working & "\Boot\" & $Type & "\*", $res & "\", 1)

	; Move the bootscreen resource file into place and add the MD5 hash:
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

	; Move the correct task manager resource file into place and add the MD5 hash:
	$TASKMGRx2 = (FileExists($res & "\TaskMgr.exe.res") = 1)
	If $TASKMGRx2 = False Then Page11_FileDup($res & "\TaskMgr.exe." & $TASKMGR & ".res", $res & "\TaskMgr.exe.res")

	; Delete some stuff if we are not installing/integrating these options:
	If $OOBE = 0 Then FileDelete($xtra & "\*.JPG")
	If $VISUAL = 0 Then
		FileDelete($xtra & "\*.MST")
		FileDelete($xtra & "\*.DLL")
		FileDelete($xtra & "\*.THM")
	EndIf
	If $SOUND = 0 Then FileDelete($xtra & "\*.wav")
	If $SCRSAVER = 0 Then FileDelete($xtra & "\*.scr")

	; Remove Remote Desktop files from the Extras folder, and duplicate Remote Desktop resource files for patching:
	FileDelete($xtra & "\lhmstsc*")
	Page11_FileDup($res & "\mstsc.exe.res", $res & "\lhmstsc.exe.res")
	Page11_FileDup($res & "\mstscax.dll.res", $res & "\lhmstscx.dll.res")

	; Move stuff around so that we are replacing using the right files:
	If $WALL = 1 Then
		FileMove($res & "\*.jpg", $xtra & "\", 1)
		FileMove($res & "\" & $Type & "\*.jpg", $xtra & "\", 1)
	EndIf

	; Call the appropriate function:
	If $Live = 0 Then Live0_Run()
	If $Live > 0 And $Live < 5 Then Live1_Run()
	If $Live = 5 Then Live5_Run()

	; Archive the contents of the error logs and place them in the folder with the SFX:
	If FileExists($tmp & "\Logs_32\*.rc") = 1 Or FileExists($tmp & "\Logs_32\*.log") = 1 Then
		FileCopy($Src & "\XPtsp.log", $tmp & "\Logs_32\", 1)
		Build_Cab($OUTPUT & "\Logs_" & @YEAR & @MON & @MDAY & @HOUR & @MIN & "_32.cab", $tmp & "\Logs_32")
	EndIf
	If FileExists($tmp & "\Logs_64\*") = 1 Or FileExists($tmp & "\Logs_64\*.log") = 1 Then
		FileCopy($Src & "\XPtsp.log", $tmp & "\Logs_64\", 1)
		Build_Cab($OUTPUT & "\Logs_" & @YEAR & @MON & @MDAY & @HOUR & @MIN & "_64.cab", $tmp & "\Logs_64")
	EndIf

	; Record how long the "action" took the program to complete:
	$TIMER = Int(TimerDiff($TIMER) / 1000)
	If $Live < 3 Or $Live = 5 Then Page11_Notify(_FormatStr(_Iif($Live = 5, "Main_43", "Main_42"), _FormatStr("P_13l", Int($TIMER / 60), Mod($TIMER, 60))))

	; Notify user that installation is complete, reboot is or isn't required:
	If $Live = 0 Then Page12_Build()
	If $Live = 1 Or $Live = 2 Or $Live = 3 Or $Live = 5 Then Page13_Build()
EndFunc   ;==>Page11_Build

Func Page11_FileDup($Src, $DEST)
	If FileExists($Src) = 0 Then Return
	If FileCreateNTFSLink($Src, $DEST, 1) = 0 Then FileCopy($Src, $DEST, 1)
	$Src = StringReplace(StringMid($Src, StringInStr($Src, "\", 0, -1) + 1), ".res", "")
	$DEST = StringReplace(StringMid($DEST, StringInStr($DEST, "\", 0, -1) + 1), ".res", "")
	IniWrite($res & "\Version.ini", "Pro", $DEST, IniRead($res & "\Version.ini", "Pro", $Src, ""))
EndFunc   ;==>Page11_FileDup

Func Page11_Task($Str, $SHOW = 1)
	$Pat[6] = $Pat[6] + 1
	Local $PER = ($Pat[6] / $Pat[7]) * 100
	GUICtrlSetData($Pat[3], $PER)
	GUICtrlSetData($Pat[4], StringFormat($Pat[11], $Pat[6], $Pat[7]))
	Page11_Notify($Str, $SHOW)
EndFunc   ;==>Page11_Task

Func Page11_Notify($Str, $SHOW = 1)
	$NUM += 1
	Local $PER = (($NUM / $CNT) * ($MAX - $MIN)) + $MIN
	$PER = _Min(100, _Max(0, $PER))
	GUICtrlSetData($Pat[1], $PER)
	GUICtrlSetData($Pat[2], Round($PER, 0) & "% " & $Pat[10])
	If $SHOW = 1 Then
		Local $I = GUICtrlCreateTreeViewItem($Str, $Pat[5])
		GUICtrlSetState($I, $GUI_FOCUS)
		FileWriteLine($Src & "\XPtsp.log", $Str)
	EndIf
EndFunc   ;==>Page11_Notify

;====================================================================================
Func Page12_Build()
	; Build the ISO Creation page:
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
EndFunc   ;==>Page12_Build

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
EndFunc   ;==>Page12_ISO

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
EndFunc   ;==>Page12_Volume

Func Page12_Browse()
	Local $OLD = $Working
	GUICtrlSetData($Pat[3], FileOpenDialog(_ReadStr("P_12f"), $Src, _ReadStr("P_12g") & " (*.iso)", 2, "XPtsp.iso"))
	FileChangeDir($OLD)
	Page12_ISO()
EndFunc   ;==>Page12_Browse

Func Page12_Finish()
	Local $S = GUICtrlRead($Pat[3]), $T = GUICtrlRead($Pat[6]), $CMD, $A, $B, $Line, $TEMP, $Bar, $lTime
	If $ISO = "" Then Return Page13_Build()
	While FileExists($T)
		If FileDelete($T) = 0 Then
			If MsgBox(0x15, $TITLE, _ReadStr("P_12j"), 0, $GUI) = 2 Then Return
		EndIf
	WEnd

	; If the ISO is to be built, then disable other controls and begin the process:
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
EndFunc   ;==>Page12_Finish

;====================================================================================
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
EndFunc   ;==>Page13_Build

Func Page13_ViewLog()
	Run("Notepad """ & $Src & "\XPtsp.log""")
EndFunc   ;==>Page13_ViewLog

Func Page13_Reboot()
	$REBOOT = _Iif($REBOOT = 1, 0, 1)
EndFunc   ;==>Page13_Reboot

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
EndFunc   ;==>Page13_Finish

;====================================================================================
Func Page30_Build()
	; If there are any unprocessed command-line parameters, notify user of invalid switches:
	If $CMD_NA <> "" Then _Error(_FormatStr("Main_08", $TITLE))

	; Local variables:
	Local $hParent = WinGetHandle("Program Manager")
	Local $hListView = ControlGetHandle($hParent, "", "SysListView321")

	; Extract required icons to work with:
	If FileInstall("Update1.ico", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update1.ico"))
	If FileInstall("Update2.ico", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update2.ico"))
	If FileInstall("Update3.ico", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update3.ico"))
	If FileInstall("Update5.ico", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update5.ico"))
	If FileInstall("Update6.ico", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "Update6.ico"))
	If FileInstall("XPtsp.ico", $tmp & "\", 1) = 0 Then _Error(_FormatStr("Main_03", "XPtsp.ico"))

	; Create the GUI window:
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

	;------------------------------------------------------------------------------------
	; Create the Tools tab of the CPL applet:
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

	;------------------------------------------------------------------------------------
	; Create the More Tools tab of the CPL applet:
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
		;GUICtrlSetImage(-1, $tmp & "\Update4.ico", -1)
		GUICtrlSetOnEvent(-1, "Page33_Build")
		GUICtrlCreateLabel(_FormatStr("P_30b3", $TITLE), 180, 195, 300, 34)
		If FileExists($res) = 0 Then GUICtrlSetState(-1, $GUI_DISABLE)

		GUICtrlCreateButton("", 120, 240, 54, 54, $BS_ICON)
		;GUICtrlSetImage(-1, $tmp & "\Update4.ico", -1)
		GUICtrlSetOnEvent(-1, "Page33_Build")
		GUICtrlCreateLabel(_FormatStr("P_30b5", $TITLE), 180, 260, 300, 34)
	EndIf

	GUICtrlCreateButton(_ReadStr("P_30a6"), 280, 325, 100, 25)
	GUICtrlSetState(-1, $GUI_DISABLE)

	;------------------------------------------------------------------------------------
	; Create the Settings tab of the CPL applet:
	; REMINDER: This section occupies elements 20 thru 29 in the "$PAT" array:
	GUICtrlCreateTabItem(_ReadStr("P_30f3"))
	GUICtrlCreateGroup(_ReadStr("P_30a2"), 120, 40, 350, 50)
	$Pat[20] = RegRead($HKCU & "\Control Panel\Desktop\WindowMetrics", "Shell Icon Size")
	Local $IS[6] = [32, 48, 64, 96, 128, 256], $Size = $Pat[20]
	For $I = 0 To 5
		$Pat[21 + $I] = GUICtrlCreateRadio($IS[$I], 150 + ($I * 50), 60, 50, 20)
		If $IS[$I] = $Size Then GUICtrlSetState(-1, $GUI_CHECKED)
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

	;------------------------------------------------------------------------------------
	; Create the "Task Manager" and "Boot Screens" tab:
	; REMINDER: This function occupies elements 1 thru 8 in the "$PAT" array:
	If FileExists($res) Then
		Page10_SubPage()
		Page10_TaskMan()
	EndIf

	;------------------------------------------------------------------------------------
	; Create the About tab of the CPL applet:
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

	;------------------------------------------------------------------------------------
	; Close the tab control and create the bottom buttons:
	GUICtrlCreateTabItem("")
	GUICtrlCreateButton(_ReadStr("P_30e"), 390, 325, 100, 25)
	GUISetOnEvent($GUI_EVENT_CLOSE, "Page30_Close")
	GUICtrlSetOnEvent(-1, "Page30_Close")
	GUISetState()
	If $OLD <> 0 Then GUIDelete($OLD)
EndFunc   ;==>Page30_Build

Func Page30_Close()
	Exit
EndFunc   ;==>Page30_Close

Func Page30_Task_Apply()
	Dim $LV[2][10]
	$LV[0][0] = 1
	$LV[1][3] = "TASKMGR.EXE"
	$LV[1][5] = 3
	$LV[1][6] = FileExists($Src & "\Backup\TASKMGR.EXE")
	$LV[1][9] = 1
	$Live = 3
	Page11_Build()
	If FileMove(@SystemDir & "\TaskMgr.exe.xptsp", @SystemDir & "\TaskMgr.exe", 1) = 0 Then
		Local $S = StringReplace(_ReadStr("P_30f2"), "|", @CRLF)
		If MsgBox(0x24, $TITLE, _ReadNum("P_30f1", 1) & @CRLF & $S, 0, $GUI) = 6 Then Page13_Finish()
	EndIf
	Page30_Build()
EndFunc   ;==>Page30_Task_Apply

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
EndFunc   ;==>Page30_Boot_Apply

Func Page30_About_Home()
	ShellExecute("http://xptsp.filetap.com/")
EndFunc   ;==>Page30_About_Home

Func Page30_About_Forum()
	ShellExecute("http://www.wincert.net/forum/index.php?showforum=178")
EndFunc   ;==>Page30_About_Forum

;----------------------------------( Tools )------------------------------------------
Func Page31_Modify()
	$Live = 2
	Page9_Build()
EndFunc   ;==>Page31_Modify

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
EndFunc   ;==>Page31_Repatch

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
EndFunc   ;==>Page31_AutoPatch

Func Page31_RePatcher()
	Local $I, $TNUM = 0, $J, $B = 0
	FileCopy(@WindowsDir & "\INF\XPtspCom.INF", @WindowsDir & "\INF\XPtspCom.INF.bak", 1)
	GUISetState(-1, @SW_DISABLE)
	Page6_CheckOS()
	$Live = 3
	$SILENT = 2
	Page9_Build()
	GUIDelete($GUI)
	$GUI = $CMD_NA

	; Let's count the number of files that need repatched:
	Local $LV2[UBound($LV)][2]
	For $I = 1 To $LV[0][0]
		If $LV[$I][9] = 1 Then
			$J = $LV[$I][6] & $LV[$I][5]
			If $J = "01" Or $J = "10" Or $LV[$I][5] = "2" Or $LV[$I][5] = "3" Then
				If $LV[$I][3] = "TSP_KRNL.EXE" Then $BOOT = 1
				$B += 1
			EndIf
		Else
			$LV[$I][5] = 0
		EndIf
	Next
	If $DEBUG Then _ArrayDisplay($LV, "$LV Array")
	Return $B
EndFunc   ;==>Page31_RePatcher

Func Page31_Theme()
	MsgBox(0, "", "Not implemented yet!")
EndFunc   ;==>Page31_Theme

;-----------------------------------( Settings )----------------------------------------
Func Page32_Change()
	Local $ICON = GUICtrlRead(@GUI_CtrlId, 1), $IS[6] = [32, 48, 64, 96, 128, 256], $HS[6] = [43, 43, 46, 31, 17, 17]
	Page32_Enable()
	For $I = 0 To 5
		If $ICON = $IS[$I] Then
			GUICtrlSetData($Pat[27], $HS[$I])
			GUICtrlSetData($Pat[28], $HS[$I])
		EndIf
	Next
EndFunc   ;==>Page32_Change

Func Page32_Enable()
	GUICtrlSetState($Pat[45], $GUI_ENABLE)
EndFunc   ;==>Page32_Enable

Func Page32_Apply()
	Local $IS, $T, $c = 0, $I
	GUICtrlSetState($Pat[45], $GUI_DISABLE)
	; Set Icon Size:
	For $I = 0 To 5
		If BitAND(GUICtrlRead($Pat[21 + $I]), 5) = 1 Then $IS = GUICtrlRead($Pat[21 + $I], 1)
	Next
	RegWrite($HKCU & "\Control Panel\Desktop\WindowMetrics", "Shell Icon Size", "REG_SZ", $IS)

	; Hide Desktop Icons if requested:
	Local $hParent = WinGetHandle("Program Manager")
	Local $hListView = ControlGetHandle($hParent, "", "SysListView321")
	WinSetState($hListView, "", _Iif(GUICtrlRead($Pat[44]) = 4, 1, 0))

	; Change Desktop Icon View setting if requested:
	If BitAND(GUICtrlRead($Pat[40]), 5) = 1 Then _GUICtrlListView_SetView($hListView, 1)
	If BitAND(GUICtrlRead($Pat[41]), 5) = 1 Then _GUICtrlListView_SetView($hListView, 3)
	If BitAND(GUICtrlRead($Pat[42]), 5) = 1 Then _GUICtrlListView_SetView($hListView, 4)

	; Set all items requiring a reboot (Icon Title Wrap, Horizontal & Vertical Icon Spacing):
	$T = _Iif(GUICtrlRead($Pat[43]) = 1, 1, 0)
	If Page32_SysParamInfo(0x19) <> $T Then $c += Page32_SysParamInfo(0x26, $T)
	$T = GUICtrlRead($Pat[27])
	If Page32_SysParamInfo(0x0D) - $IS <> $T Then $c += Page32_SysParamInfo(0x0D, $T + $IS)
	$T = GUICtrlRead($Pat[28])
	If Page32_SysParamInfo(0x18) - $IS <> $T Then $c += Page32_SysParamInfo(0x18, $T + $IS)
	If $c Then
		If MsgBox(0x24, $TITLE, _ReadStr("P_30a7")) = 6 Then Shutdown(2 + 4)
	EndIf
EndFunc   ;==>Page32_Apply

Func Page32_SysParamInfo($Func, $Pixels = 0)
	Local $Param = DllStructCreate("int pixels")
	Const $SPIF_SENDCHANGE = 2, $SPIF_UPDATEINIFILE = 1
	DllStructSetData($Param, "pixels", DllStructGetSize($Param))
	Local $Ret = DllCall("user32.dll", "int", "SystemParametersInfo", "uint", $Func, "uint", $Pixels, _
			"ptr", _Iif($Pixels = 0, DllStructGetPtr($Param), 0), "uint", BitOR($SPIF_SENDCHANGE, $SPIF_UPDATEINIFILE))
	Return _Iif($Pixels = 0, DllStructGetData($Param, "pixels"), $Ret[0] <> 0)
EndFunc   ;==>Page32_SysParamInfo

;====================================================================================
Func Page33_Build()
	Local $File = $tmp & "\Version.ini", $List1, $List2, $List3, $List4, $ITEM, $B = 1, $Size = 0, $T1, $T2
	Local $GUIActiveX, $oIE, $Group

	; Show a animated loading image on the current page:
	_Show_Loading()

	; Build the "Download Updates" GUI page:
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
	;GUICtrlSetOnEvent(-1, "Page7_Build")
	GUICtrlCreateButton(_ReadStr("P_01d"), 410, 325, 80, 25)
	GUICtrlSetOnEvent(-1, "_CancelAnyPage")

	; Get update information for the theme and read it into memory for processing:
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

	; Parse "Program" section:
	$ITEM = StringSplit($List1, "|")
	$T1 = FileGetVersion(@ScriptFullPath)
	If $ITEM[1] > $T1 And ($T1 <> "0.0.0.0" Or @Compiled = 0) Then
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

	; Parse "DSI" section:
	$ITEM = StringSplit($List3, "|")
	$T1 = RegRead($HKLM & "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DriveSpace", "UninstallString")
	$T1 = StringReplace(StringLeft($T1, StringInStr($T1, " /") - 1), """", "")
	$T1 = FileGetVersion(@ScriptFullPath)
	If $ITEM[1] > $T1 And ($T1 <> "0.0.0.0" Or @Compiled = 0) Then
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

	; Parse "Languages" section:
	If $LV[0][1] = 0 Then
		$Group = 0
		For $I = 1 To $List2[0][0]
			$ITEM = StringSplit($List2[$I][1], "|")
			$T1 = IniRead($Working & "\Languages\" & $List2[$I][0], "Info", "Version", "")
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
				$LV[$B][0] = GUICtrlCreateTreeViewItem($List2[$I][0], $Group)
				GUICtrlSetState(-1, $GUI_CHECKED)
				GUICtrlSetOnEvent(-1, "Page33_Item")
				$LV[$B][1] = $Group
				$LV[$B][2] = "XPtsp/Languages/" & $List4[$I][0]
				$LV[$B][3] = $Working & "\Languages\" & $List4[$I][0]
				$LV[$B][4] = $ITEM[2]
				$LV[$B][5] = _ReadStr("P_40c") & ": " & Round($ITEM[2] / 1024, 1) & " kb" & @CRLF & _ReadStr("P_40d") & ": " & _ConvertStamp($ITEM[3])
				$LV[$B][6] = $ITEM[1]
				$Size += $ITEM[2]
				$B += 1
			EndIf
		Next
	EndIf

	; Parse "Pro" section:
	$Group = 0
	For $I = 1 To $List4[0][0]
		$ITEM = StringSplit($List4[$I][1], "|")
		$T1 = IniRead($res & "\Version.ini", "Pro", $List4[$I][0], "")
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
			$LV[$B][0] = GUICtrlCreateTreeViewItem($List4[$I][0], $Group)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "Page33_Item")
			$LV[$B][1] = $Group
			$LV[$B][2] = "XPtsp/" & $THEME & "/Updates/" & $List4[$I][0]
			$LV[$B][3] = $tmp & "\" & $List4[$I][0]
			$LV[$B][4] = $ITEM[2]
			$LV[$B][5] = _ReadStr("P_40c") & ": " & Round($ITEM[2] / 1024, 1) & " kb" & @CRLF & _ReadStr("P_40d") & ": " & _ConvertStamp($ITEM[3])
			$LV[$B][6] = $ITEM[1]
			$Size += $ITEM[2]
			$B += 1
		EndIf
	Next

	; Report if no updates are available.  Otherwise, show the Update GUI page:
	$LV[0][0] = $B
	If $B = 1 Then
		MsgBox(0x10, $TITLE, _FormatStr("P_40h", $THEME), 0, $GUI)
		Return GUIDelete($OLD)
	EndIf
	GUICtrlSetData($Pat[2], $LV[1][5])
	GUISetState()
	If $GUI <> 0 Then GUIDelete($GUI)
	$GUI = $OLD
EndFunc   ;==>Page33_Build

Func Page33_Item()
	Local $I = 1
	While $I <= $LV[0][0]
		If @GUI_CtrlId = $LV[$I][0] Then ExitLoop
		$I += 1
	WEnd
	GUICtrlSetData($Pat[2], $LV[$I][5])
EndFunc   ;==>Page33_Item

Func Page33_Parent()
	Local $R = _Iif(BitAND(GUICtrlRead(@GUI_CtrlId), $GUI_CHECKED), $GUI_CHECKED, $GUI_UNCHECKED)
	For $I = 1 To $LV[0][0]
		If $LV[$I][1] = @GUI_CtrlId Then GUICtrlSetState($LV[$I][0], $R)
	Next
	Page33_Item()
EndFunc   ;==>Page33_Parent

Func Page33_Download()
	; Figure out how much data has to be downloaded:
	Local $Total = 0, $SUB = 0, $Byte1, $Byte2, $Rate, $S, $T, $Handle
	For $I = 1 To $LV[0][0]
		If BitAND(GUICtrlRead($LV[$I][0]), $GUI_CHECKED) Then $Total += $LV[$I][4]
	Next
	If $Total = 0 Then
		MsgBox(0x10, $TITLE, _ReadStr("P_40i"), 0, $GUI)
		Return
	EndIf

	; Create a downloading progress window:
	GUISetState(@SW_DISABLE, $GUI)
	Local $TEMP = GUICreate(_ReadStr("P_07h") & "....", 300, 90, -1, -1, BitOR($WS_BORDER, $WS_POPUP), -1, $GUI)
	Local $HEADER = GUICtrlCreateLabel(_ReadStr("P_40j"), 10, 10, 280, 30, $SS_LEFTNOWORDWRAP)
	GUICtrlSetFont(-1, 10, 800)
	Local $Bar = GUICtrlCreateProgress(10, 30, 280, 20)
	Local $Line = GUICtrlCreateLabel("", 10, 55, 280, 30, $SS_LEFTNOWORDWRAP)
	GUISetState()

	; Start downloading and extracting the updates:
	DirCreate($mcabtmp)
	$TIMER = TimerInit()
	For $I = 1 To $LV[0][0]
		If $LV[$I][5] > 0 Then
			$Handle = InetGet($WEBSITE & "/" & $LV[$I][2], $LV[$I][3], 1, 1)

			; Display progress of download to user:
			While Not InetGetInfo($Handle, 2)
				$Byte1 = InetGetInfo($Handle, 0)
				$Byte2 = $SUB + $Byte1
				GUICtrlSetData($Bar, ($Byte2 * 100) / $Total)
				$Rate = Round($Byte2 / (TimerDiff($TIMER) / 1000 * 1024), 1)
				GUICtrlSetData($Line, _ReadStr("P_07h") & " """ & $LV[$I][3] & """..." & @CRLF & _
						_ReadStr("P_07h") & StringFormat(" %d kb of %d kb (%d.1 kb/sec)", _
						Round($Byte2 / 1024, 0), Round($Total / 1024, 0), $Rate))
				For $J = 1 To 5
					If Not InetGetInfo($Handle, 2) Then ExitLoop
					Sleep(100)
				Next
			WEnd
			InetClose($Handle)
			$SUB += $LV[$I][4]
			GUICtrlSetData($Bar, ($SUB * 100) / $Total)

			; If this is a 7zip file, copy the new MD5 hashes into the "Version.ini" file:
			If StringRight($LV[$I][3], 3) = ".7z" Then
				$S = StringReplace($LV[$I][3], ".7z", "")
				IniWrite($res & "\Version.ini", "Pro", $S, $LV[$I][6])
			EndIf
		EndIf
	Next
	GUIDelete($TEMP)

	; Extract the contents of the 7z files into the Resources folder:
	If FileExists($tmp & "\*.7z") Then
		Local $Handle = FileFindFirstFile($tmp & "\*.7z")
		If $Handle <> -1 Then
			While 1
				$S = FileFindNextFile($Handle)
				If @error Then ExitLoop
				_Unpack_7z($tmp & "\" & $S, $res & "\")
			WEnd
		EndIf

		FileClose($Handle)
		FileDelete($tmp & "\*.7z")
	EndIf

	; Update Drive Space Indicator if a new update is available:
	If $LV[0][2] <> 0 Then RunWait($LV[$LV[0][2]][3])

	; Update the patcher if a new update is available.  Otherwise, launch the repatcher:
	If $LV[0][1] <> 0 Then
		RunWait($LV[$LV[0][1]][3] & " /UPDATE")
	Else
		Page31_Repatch()
	EndIf
EndFunc   ;==>Page33_Download

;====================================================================================
Func Page34_Build()
	; If there are any unprocessed command-line parameters, notify user of invalid switches:
	If $CMD_NA <> "" Then _Error(_FormatStr("Main_08", $TITLE))

	; Build building GUI:
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
EndFunc   ;==>Page34_Build

Func Page34_Everything()
	If MsgBox(0x24, $TITLE, _FormatStr("P_20d", $TITLE), 0, $GUI) = 7 Then Return
	$Live = 5
	Page11_Build()
EndFunc   ;==>Page34_Everything

Func Page34_Folder()
	If MsgBox(0x24, $TITLE, _FormatStr("P_20e", $TITLE), 0, $GUI) = 7 Then Return
	Live5_Folder()
	MsgBox(0x40, $TITLE, _FormatStr("P_20f", $TITLE), 0, $GUI)
	_DeleteScript()
EndFunc   ;==>Page34_Folder