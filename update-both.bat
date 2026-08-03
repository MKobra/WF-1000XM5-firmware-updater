@echo off
rem Update BOTH earbuds at the same time (dual target).
rem Use this only when both earbuds are on the same firmware version.
rem Change FW below to use a different firmware file (see README "Add your own firmware").

cd /d "%~dp0"
set FW=firmware\UPG_english_enc.bin

if not exist "%FW%" (
    echo Firmware file not found: %FW%
    echo Put a firmware .bin file into the firmware folder and update the FW variable.
    pause
    exit /b 1
)

yusen.exe update dual "%FW%"

echo.
echo Keep the earbuds connected. Wait at least 10 minutes before unplugging.
pause
