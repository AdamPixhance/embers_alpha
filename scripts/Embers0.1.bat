@echo off
setlocal EnableExtensions
title Embers0.1 - Daily Habits Tracker

pushd "%~dp0.."

set "PYTHON=%cd%\.venv\Scripts\python.exe"
set "APP_FILE=%cd%\app.py"
set "APP_URL=http://localhost:8080"

if not exist "%PYTHON%" (
	echo Python not found in .venv
	echo.
	echo Create and activate the environment:
	echo   python -m venv .venv
	echo   .venv\Scripts\pip install -r requirements.txt
	echo.
	pause
	goto :done
)

REM Check if already running
powershell -NoProfile -Command "if (Test-NetConnection 127.0.0.1 -Port 8080 -InformationLevel Quiet) { exit 0 } else { exit 1 }"
if not errorlevel 1 (
	REM App already running, just open browser
	start "" "%APP_URL%"
	goto :done
)

REM Start Embers0.1 with output suppressed
start "Embers0.1" /b "%PYTHON%" "%APP_FILE%" > nul 2>&1

REM Wait up to 45 seconds for port 8080
for /L %%i in (1,1,45) do (
	powershell -NoProfile -Command "if (Test-NetConnection 127.0.0.1 -Port 8080 -InformationLevel Quiet) { exit 0 } else { exit 1 }"
	if not errorlevel 1 (
		start "" "%APP_URL%"
		goto :done
	)
	timeout /t 1 /nobreak >nul
)

REM Startup failed
echo.
echo Embers0.1 did not start on port 8080.
echo Please check that Python 3.10+ is installed and requirements.txt is installed.
echo.
pause

:done
popd
exit /b 0
