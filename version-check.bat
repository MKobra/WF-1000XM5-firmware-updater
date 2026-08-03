@echo off
rem Check the firmware version of both earbuds and the charging case.
rem WF-1000XM5

rem Important: connecting XM5 to a PC can be tricky. Hold the button on the back of
rem the charging case, connect the USB-C cable, and open/close the case lid 15-20
rem times to activate the earbuds. Otherwise the PC will not see them.

cd /d "%~dp0"

yusen.exe get mainver all
yusen.exe get cradlever

echo.
echo If both earbuds show the same version, they are paired correctly.
pause
