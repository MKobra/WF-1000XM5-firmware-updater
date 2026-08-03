@echo off
rem Check the firmware version of both earbuds and the charging case.
rem WF-1000XM5

cd /d "%~dp0"

yusen.exe get mainver all
yusen.exe get cradlever

echo.
echo If both earbuds show the same version, they are paired correctly.
pause
