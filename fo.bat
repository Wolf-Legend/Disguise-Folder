@echo off

	

:main
	cls
	echo You want to :
	echo.
	echo 1) Add New Folder
	echo 2) Hide Folders
	echo 3) Unhide Folders
	echo 4) Remove A Folder
	echo 5) Exit
	echo.
	echo.
	set /p op0="Enter your choice : "
	cls

if %op0%==1 (
	call:Add
) else if %op0%==2 (
	call:HU
) else if %op0%==3 (
	call:UH
) else if %op0%==4 (
	call:Remove
) else if %op0%==5 (
	call:Exit
) else (
	echo Enter the correct choice...
	TIMEOUT 5 
	cls 
)    

GOTO main

:Add
	cls
	echo Select the folder you wanna hide....
	TIMEOUT 5



	call folderselector.bat folderpath  
	call:Path "%folderpath%" , fdrive , fpath , fname
	call:Change

	reg add %regpath%\paths\%fdrive% /f
	reg add %regpath%\paths\%fdrive% /v %fname% /t REG_EXPAND_SZ /d %dname% /f
	reg add %regpath%\paths\%fdrive% /v %dname% /t REG_EXPAND_SZ /d %fname% /f
	echo Folder successfully selected ....!!!
	
	
	TIMEOUT 3 
	pause

goto:eof

:HU
	startlocal	

	cls
	echo Select the folder you wanna hide....
	TIMEOUT 5



	call folderselector.bat folderpath  
	call:Path "%folderpath%" , fdrive , fpath , fname
	set "localregpath=%regpath%\paths\%fdrive%"
	call Rquery.bat %localregpath% , %fname% , nname , b
	if %b%==0 (
		
		attrib +s +h "%folderpath%\*.*" /s /d
		setlocal enabledelayedexpansion
		call Renamer.bat "%folderpath%" , nfpath
		attrib +r "!nfpath!" 
		endlocal
		echo Success !!!
		pause
	) else (
		echo First add this folder ....... 
		pause
	)
	

	endlocal	



goto:eof

:UH
	startlocal	

	cls
	echo Select the folder you wanna hide....
	TIMEOUT 5



	call folderselector.bat folderpath  
	call:Path "%folderpath%" , fdrive , fpath , fname
	set "localregpath=%regpath%\paths\%fdrive%"
	call Rquery.bat %localregpath% , %fname% , nname , b
	if %b%==0 (
		attrib -r "%folderpath%"
		setlocal enabledelayedexpansion
		call Renamer.bat "%folderpath%" , nfpath 
		attrib -s -h "!nfpath!\*.*" /s /d
		endlocal
		echo Success !!!
		pause
	) else (
		echo First add this folder ....... 
		pause
	)
	

	endlocal	



goto:eof

:Remove
	startlocal	

	cls
	echo Select the added folder you wanna remove....
	TIMEOUT 5



	call folderselector.bat folderpath  
	call:Path "%folderpath%" , fdrive , fpath , fname
	set "localregpath=%regpath%\paths\%fdrive%"
	call Rquery.bat %localregpath% , %fname% , nname , b
	if %b%==0 (
		reg delete %localregpath% /v %fname% /f
		reg delete %localregpath% /v %nname% /f
		echo Success !!!
		pause
	) else (
		echo This folder is not added to your account ....... 
		pause
	)
	

	endlocal	
goto:eof

:Change
	echo Select the disguised look:
	echo.
	echo 1) My Computer 
	echo 2) My Network Places
	echo 3) Printers and Faxes
	echo 4) Recycle Bin
	echo Default: Recycle Bin 
	echo.
	echo.

	set /p dchoice="Enter the choice: "
	if %dchoice%==1 (
		set dname=%fname%.{20d04fe0-3aea-1069-a2d8-08002b30309d}
	) else if %dchoice%==2 (
		set dname=%fname%.{208d2c60-3aea-1069-a2d7-08002b30309d}
	) else if %dchoice%==3 (
		set dname=%fname%.{2227a280-3aea-1069-a2de-08002b30309d}
	) else if %dchoice%==4 (
		set dname=%fname%.{645ff040-5081-101b-9f08-00aa002f954e}
	) else (
		echo No valid choice selected using default
		set dname=%fname%.{645ff040-5081-101b-9f08-00aa002f954e}
	)
	echo Done disguising ......
	TIMEOUT 5
	cls 


goto:eof


:Path
	for /f "delims=|" %%a in ("%~1") do (
		set %~2=%%~da
		set %~3=%%~pa
		set %~4=%%~nxa
	)
goto:eof



:Exit
exit 





















