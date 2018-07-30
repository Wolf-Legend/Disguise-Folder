
:::::: Requires 3 inputs ..... Key_Name , Value_Name, ReturnVariable , Ret_Code .... 
:::::: Return variable returns Value
@echo off

setlocal ENABLEEXTENSIONS
set KEY_NAME=%~1
set VALUE_NAME=%~2

FOR /F "usebackq skip=2 tokens=1-3" %%A IN (`REG QUERY %KEY_NAME% /v %VALUE_NAME% 2^>nul`) DO (
    set ValueName=%%A
    set ValueType=%%B
    set ValueValue=%%C
)

if defined ValueName (   
	set "value=%ValueValue%"
	set "b=0"
) else (
	set "b=1"
)
endlocal & set "%~3=%value%"& set "%~4=%b%"
