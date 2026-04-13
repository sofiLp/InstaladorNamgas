@echo off
echo Buscando actualizaciones del programa ...
TASKKILL /F /IM ClientePV.exe
if exist C:\Windows\Hlpcls\Download (xcopy "C:\Windows\Hlpcls\Download\ClientePV.exe" "C:\Program Files\POS NAMAGAS Pre-Alfa\ClientePV.exe" /y) else (echo no)
cd C:\Program Files\POS NAMAGAS Pre-Alfa
start ClientePV.exe
cd C:\Windows\Hlpcls\Download
del ClientePV.exe