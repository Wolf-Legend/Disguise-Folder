@echo off
 

call Rquery.bat key , value , return 
echo errorlevel
pause
if errorlevel 1 (
echo if
) else (
echo else
)
pause


