@echo off
echo Reiniciando el programa ...
TASKKILL /F /PID WebApi.exe
timeout /t 7 /nobreak 
cd C:\Program Files\POS NAMAGAS Pre-Alfa\WEBAPI
start WebApi.exe


