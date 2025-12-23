@echo off
color 0A
setlocal enabledelayedexpansion
:main
title Multitool
cls
echo ===========================
echo          Multitool
echo ===========================
echo.
echo [1] Netzwerk Scanner
echo [2] Exit
echo.
set /p choice="Choose an option: "
if "%choice%"=="1" goto NetworkScanner
if "%choice%"=="2" goto exitmain
if Not "%choice%"=="1" goto main
if Not "%choice%"=="2" goto main

:NetworkScanner
echo Starting Network Scanner v1...
cls
echo Delete old Cache files...
if exist ips.txt del ips.txt 2>nul
if exist output_scan.txt del output_scan.txt 2>nul
if exist live_hits.txt del live_hits.txt 2>nul
if exist hits rmdir /s /q "hits" 2>nul
timeout /t 1 /nobreak >nul
cls
echo Determine Standardgateway...

for /f "tokens=2 delims=:" %%g in ('ipconfig ^| findstr "Standardgateway"') do (
    for /f %%h in ("%%g") do set "gw=%%h"
)

for /f "tokens=1-3 delims=." %%a in ("!gw!") do set "subnet=%%a.%%b.%%c."
timeout /t 1 /nobreak >nul
cls
echo Internet IP was Found:
echo.
echo Standardgateway: !gw!
timeout /t 1 /nobreak >nul
cls
echo.
echo How many repetitions would you like to perform? (Press Enter for Default: 20) Only Numbers allowed
echo The higher the number, the more accurate the result.
echo.
set /p wiederholungen="> "
if "%wiederholungen%"=="" set wiederholungen=20
cls
echo You have selected: %wiederholungen% repetitions.
timeout /t 1 /nobreak >nul
cls
echo ========================================================
echo Netzwerk Scanner v1
echo ========================================================
echo Scanning...   
echo.

set wiederholung1_enabled=0

:wiederholung1
if not exist ips.txt type nul >ips.txt

if not exist hits mkdir hits
del hits\*.txt 2>nul

for /L %%i in (1,1,254) do (
    set "ip=!subnet!%%i"
    start "" /b cmd /c "ping -n 1 -w 50 !ip! >nul && echo !ip!>hits\!ip!.txt"
)

for %%F in (hits\*.txt) do (
    set /p ip=<%%F
    findstr /x "!ip!" ips.txt >nul || (
        echo !ip!: ONLINE
        echo !ip!>>ips.txt
    )
)

set /a wiederholung1_enabled+=1

echo.
cls
echo ========================================================
echo Netzwerk Scanner v1
echo ========================================================
echo Scanning...   
echo.

echo Round: %wiederholung1_enabled% was completed.
echo.

if %wiederholung1_enabled%==%wiederholungen% goto nslookup

goto wiederholung1

:nslookup
cls
echo ========================================================
echo Netzwerk Scanner v1
echo ========================================================
echo.
echo loading NSLookup results...
echo.
for /f %%x in (ips.txt) do (
    for /f "tokens=2 delims=: " %%A in ('nslookup %%x 2^>nul ^| findstr /R "^Name:"') do echo %%x - %%A
)

:output
echo ================================================ >> output_scan.txt
echo The whole Scan: >> output_scan.txt
echo ================================================ >> output_scan.txt
echo. >> output_scan.txt
for /f %%x in (ips.txt) do (
    for /f "tokens=2 delims=: " %%A in ('nslookup %%x 2^>nul ^| findstr /R "^Name:"') do echo %%x - %%A >> output_scan.txt
)

:exit
echo.
echo Delete old Cache files...
if exist ips.txt del ips.txt 2>nul
timeout /t 1 /nobreak >nul
echo Scan completed.
pause
goto main

:exitmain
cls
echo loading Exit...
timeout /t 1 /nobreak >nul