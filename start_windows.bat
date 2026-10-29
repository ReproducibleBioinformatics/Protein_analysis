@echo off
REM Start JupyterLab; the folder containing this script is mounted as /sharedFolder
cd /d "%~dp0"

set "IMAGE=ghcr.io/reproduciblebioinformatics/protein_analysis:latest"
if not defined PORT set "PORT=8888"
set "TOKEN=%RANDOM%%RANDOM%%RANDOM%%RANDOM%%RANDOM%"
set "URL=http://127.0.0.1:%PORT%/lab?token=%TOKEN%"

docker info >nul 2>&1
if errorlevel 1 (
  echo Docker Desktop is not running. Start it and try again.
  pause
  exit /b 1
)

docker pull %IMAGE%
echo JupyterLab will be available at: %URL%
echo Press Ctrl+C to stop.
start "" /b powershell -NoProfile -Command "Start-Sleep -Seconds 5; Start-Process '%URL%'"

docker run --rm -it -p 127.0.0.1:%PORT%:8888 -e JUPYTER_TOKEN=%TOKEN% -v "%cd%":/sharedFolder %IMAGE%
pause
