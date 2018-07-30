@echo off


	call :Rename "%~1" , nfpath
	set "%~2=%nfpath%"





goto:eof



:Rename

	setlocal ENABLEEXTENSIONS
	
	call:Path "%~1" , fdrive , fpath , fname
	
	set "fp=%fdrive%%fpath%"
	set KEY_NAME=%regpath%\paths\%fdrive%
	set VALUE_NAME=%fname%

	FOR /F "usebackq skip=2 tokens=1-3" %%A IN (`REG QUERY %KEY_NAME% /v %VALUE_NAME% 2^>nul`) DO (
		    set ValueName=%%A
		    set ValueType=%%B
		    set ValueValue=%%C
	)

	if defined ValueName ( 
		ren "%~1" "%ValueValue%"
	) else (
		@echo %KEY_NAME%\%VALUE_NAME% not found.
	)

	endlocal&set "%~2=%fp%%ValueValue%"

goto:eof


:Path
	for /f "delims=|" %%a in ("%~1") do (
		set %~2=%%~da
		set %~3=%%~pa
		set %~4=%%~nxa
	)
goto:eof
