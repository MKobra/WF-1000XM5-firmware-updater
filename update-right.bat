@echo off
rem Update ONLY the RIGHT earbud.
rem Change FW below to use a different firmware file (see README "Add your own firmware").

rem Important: connecting XM5 to a PC can be tricky. Hold the button on the back of
rem the charging case, connect the USB-C cable, and open/close the case lid 15-20
rem times to activate the earbuds. Otherwise the PC will not see them.

cd /d "%~dp0"
set FW=firmware\UPG_english_enc.bin

if not exist "%FW%" (
    echo Firmware file not found: %FW%
    echo Put a firmware .bin file into the firmware folder and update the FW variable.
    pause
    exit /b 1
)

yusen.exe update right "%FW%"

echo.
echo Keep the earbuds connected. Wait at least 10 minutes before unplugging.
pause
