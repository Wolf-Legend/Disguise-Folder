@echo off

Set /a num=(%Random% %%9)+1

color %num%
echo .......................................................................................................
echo .......................................................................................................
echo ..........................................................................__________......
echo ............................. _________________________________________ ./           \\___
echo ..........................___/             /..^|        /_/   _____   ^|_ ^|   _______   ^|^|..
echo ..........................__/ ____       //...^|   ____/  ^|  ^|.....^| ^|^|..^|  /...^|^|...\ ^|^|..
echo .........................../_____/      //....^|   ^|^| ....^|  ^|_____^| ^|^|..^|   ___^|^|___  ^|^|..
echo ................................/      //.....^|   ^|____..^|       ___^|^|..^|  ^|___  ___^| ^|^|..
echo .............................../      //......^|    ___/..^|   ^|\   \\ ...^|   ...^|^|...  ^|^|..
echo ............................../      //.......^|   ^|^| ....^|   ^|.\   \\ ..^|   ...^|^|...  ^|^|..
echo ............................./      //_______ ^|   ^|______^|_  ^|..\   \\ .^|  \___^|^|___/ ^|^|..
echo ............................/  ____________ /_^|           /  ^|__.\   \\ ^|             ^|^|..
echo .........................__/_______________/.\___________/_____/..\___\\\____________//...
echo .......................................................................................................
echo .......................................................................................................
echo.
echo.
echo.
echo.
echo.
echo.
:Choice
echo Enter your choice
echo Register (1) or Login(2)
set /p choice="Choice: "

TIMEOUT 3
cls

if %choice%==1 (
call:choice1
) else if %choice%==2 (
call:choice2
) else (
call:choice3
)
exit




:choice1

echo .................... NEW ACCOUNT.................... 
echo.
echo.
set /p un="Enter the username: "
set /p password="Enter the password: "
cls
echo .................... CREATING NEW ACCOUNT.................... 
TIMEOUT 5
cls
set fc=%password:~0,1%
set sc=%password:~1,1%


reg add HKCU\Software\trial\%un%\%fc%\%sc%\%password% /f
reg add HKCU\Software\trial\%un%\%fc%\%sc%\%password% /v PASSWORD /t REG_SZ /d %password% /f



set "regpath=HKCU\Software\trial\%un%\%fc%\%sc%\%password%"

call fo.bat

goto:eof

:choice2

echo ...........LOGIN..........
echo.
echo.
set /p un="Enter the username: "
set /p password="Enter the password: "
clS
echo .................... LOGGING IN .................... 
TIMEOUT 5
cls
set fc=%password:~0,1%
set sc=%password:~1,1%


set "regpath=HKCU\Software\trial\%un%\%fc%\%sc%\%password%"

call:Regquery %regpath% , PASSWORD , passcheck

if "%passcheck%" == "%password%" ( 
    call fo.bat
) else (
    echo wrong username or password.............
    Timeout 5
    goto:choice2
)

goto:eof

:choice3

echo !!!! Stop wasting my time......
echo enter correct choice
TIMEOUT 10
cls
GOTO Choice

goto:eof


:Regquery

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
) 
endlocal&set "%~3=%value%"

goto:eof