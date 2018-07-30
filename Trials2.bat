@echo off
set "regpath=HKCU\Software\ter" /f
set x=trial2


setlocal ENABLEEXTENSIONS
set KEY_NAME=%regpath%\paths\%x%
set VALUE_NAME=%x%

FOR /F "usebackq skip=2 tokens=1-3" %%A IN (`REG QUERY %KEY_NAME% /v %VALUE_NAME% 2^>nul`) DO (
    set ValueName=%%A
    set ValueType=%%B
    set ValueValue=%%C
)

if defined ValueName (
    @echo Value Name = %ValueName%
    @echo Value Type = %ValueType%
    @echo Value Value = %ValueValue%
) else (
    @echo %KEY_NAME%\%VALUE_NAME% not found.
)

pause