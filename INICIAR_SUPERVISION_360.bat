@echo off
cd /d "%~dp0"
echo SUPERVISION 360 - V5
start "" http://localhost:8787
py -3 -m http.server 8787
pause
