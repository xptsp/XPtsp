@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
for /F "tokens=5* delims=\" %%j in ('reg query "HKLM\SOFTWARE\Microsoft\Updates" /s ^| findstr /i /v "REG_ FileList"') do (
	if %ERRORLEVEL%==0 (
		for /F "usebackq tokens=3 delims=\" %%m in ('%%j\%%k') do (
			set tmp=%%m          
			set tmp=!tmp:~0,%UPNAMEL%!
			set kb[!tmp!]=!tmp:~2,6!
		)
		for /F "tokens=2 delims=\" %%m in ('echo %%j\%%k^| findstr /i /c:" .NET"') do (
			set tmp=%%m          
			set tmp=!tmp:~0,%UPNAMEL%!
			set kb[!tmp!]=!tmp:~2,6!
		)
	)
)
for /F "tokens=7 delims=\" %%m in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" ^| findstr /i "\<KB[0-9][0-9][0-9][0-9][0-9][0-9]"') do (
	set tmp=%%m          
	set tmp=!tmp:~0,%UPNAMEL%!
	set kb[!tmp!]=!tmp:~2,6!
)
for /F "tokens=2 delims=[]" %%j in ('set kb[ ^| sort') do (echo %%j)
