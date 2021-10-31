@echo off
set dir=%cd%
set datetime=%DATE:~7,2%-%DATE:~4,2%-%DATE:~10,4%
echo.
echo._____________________________________________________
echo.Disclaimer !!!
echo.Toolstack ini menggunakan beberpa software GNU Linux.
echo.Gas bro ??
pause >> %dir%\etc\log_null
REM Backup 
mkdir %dir%\etc\backup\%datetime% %dir%\etc\implen 
cls
echo.
echo.Backup implementasi sebelumnya.
echo._______________________________
robocopy %dir%\etc\implen %dir%\etc\backup\%datetime% /MOV >> %dir%\etc\log_null
timeout 5 >> %dir%\etc\log_null
cls
timeout 5 >> %dir%\etc\log_null
echo.
echo.Downloading new objek.
echo._______________________________
%dir%\etc\curl\curl-7.79.1-win64-mingw\bin\curl -o %dir%\etc\implen\YOUR_APPLICATION.ear http://YOUR_ONLINE_FILE >> %dir%\etc\log_null
REM Copy to Implen
timeout 5 >> %dir%\etc\log_null
cls
echo.________________________________________________________________________________
certutil -hashfile %dir%\etc\implen\YOUR_APPLICATION.ear md5
echo.________________________________________________________________________________
echo.check your md5 file with your file link source
echo.Samakan md5 file hasil donlod dengan SOURCE
echo.Press key to continue..
pause >> %dir%\etc\log_null
timeout 5 >> %dir%\etc\log_null
cls
echo.
echo.Continue execution jboss-cli (Testing) ?
echo.Press untuk lanjoet
echo._________________________________________
pause >> %dir%\etc\log_null
del /q s/ %dir%\etc\log_null

REM ------------------------------
REM CUSTOMIZE YOUR PATH JBOSS CLI
REM ------------------------------

set "NOPAUSE=true"
cls
echo.
echo.Stoping group
echo._______________
call E:\jboss-eap-master\bin\jboss-cli.bat --connect --command="/server-group=example-group:stop-servers"
timeout 5
cls
echo.
echo.Reload master, +group
echo._____________________
call E:\jboss-eap-master\bin\jboss-cli.bat --connect --command="/host=master:reload"
timeout 5 >> %dir%\etc\log_null
call E:\jboss-eap-master\bin\jboss-cli.bat --connect --command="/server-group=example-group:reload-servers"
timeout 5
cls
echo.
echo.Undeploy .EAR
echo._____________________
call E:\jboss-eap-master\bin\jboss-cli.bat --connect --command="undeploy YOUR_APPLICATION.ear --all-relevant-server-groups"
timeout 5
cls
echo.
echo.Deploy new .EAR
echo._____________________
call E:\jboss-eap-master\bin\jboss-cli.bat --connect --command="deploy etc\implen\YOUR_APPLICATION.ear --all-server-groups" 
REM Add value to system properties
timeout 5
cls
:MENU
cls
ECHO. ----------------------------------------------------
ECHO..            ADD VALUE SYSTEM PROPERTIES ?                   .
ECHO. ----------------------------------------------------
echo.
ECHO [1] - YA
ECHO [2] - TIDAK
ECHO.
SET /P M=Pilih 1, 2, 3, dst kemudian ENTER:
IF %M%==1 GOTO ADD
IF %M%==2 GOTO LANJUT
GOTO MENU

:MENU
cls
ECHO. ----------------------------------------------------
ECHO..            ADD VALUE SYSTEM PROPERTIES ?           .
ECHO. ----------------------------------------------------
echo.
ECHO [1] - YA
ECHO [2] - TIDAK
ECHO.
SET /P M=Pilih 1, 2, 3, dst kemudian ENTER:
IF %M%==1 GOTO ADD
IF %M%==2 GOTO LANJUT
GOTO MENU

:ADD
cls
timeout 2 >> %dir%\etc\log_null
start /wait notepad.exe %dir%\etc\VALUE.txt
cls
echo.
echo.oskuy gas..
timeout 2 >> %dir%\etc\log_null
ren %dir%\etc\VALUE.txt VALUE.bat
timeout 2 >> %dir%\etc\log_null
start /wait %dir%\etc\VALUE.bat
timeout 2 >> %dir%\etc\log_null
ren %dir%\etc\VALUE.bat VALUE.txt
GOTO LANJUT
exit

:LANJUT
timeout 5
cls
echo.
echo.Starting group
echo._____________________
call E:\jboss-eap-master\bin\jboss-cli.bat --connect --command="/server-group=example-group:start-servers"
timeout 60 >> %dir%\etc\log_null
cls

:MENU2
cls
ECHO. ----------------------------------------------------
ECHO..                OPEN YOUR WEB                   .
ECHO. ----------------------------------------------------
echo. Kalo misalkan web belum ap, pilih menu 1 aja terus.
echo.
ECHO [1] - NAMA YOUR APP
ECHO [2] - NAME YOUR APP2
ECHO [3] - EXIT
ECHO.
SET /P M=Pilih 1, 2, 3, dst kemudian ENTER:
IF %M%==1 GOTO APP
IF %M%==2 GOTO APP2
IF %M%==3 GOTO EXIT

:APP
taskkill /im iexplore.exe /f 
start iexplore.exe http://url_your_app
GOTO MENU2
exit

:APP2
taskkill /im iexplore.exe /f
start iexplore.exe http://url_your_app2
GOTO MENU2
exit

:EXIT
exit
