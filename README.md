# WF-1000XM5 Firmware Updater

A USB-based firmware updater for **Sony WF-1000XM5** earbuds. It lets you flash firmware
over USB through the charging case, including flashing **a single earbud** when the left
and right earbuds ended up on different firmware versions and the official Sound Connect
app refuses to update them.

This project is built around the same `yusen.exe` HID tool used by the public
WF-1000XM4 updater (audiospare.com), configured for WF-1000XM5
(VID `0x054C`, PID `0x0E63`, model HCTW2).

> ⚠️ **WARNING:** Flashing interrupts device firmware. If the process is interrupted
> (USB unplugged, PC powered off), the earbuds can be damaged. Always read the
> instructions below before starting.

## When is this useful?

- Left and right earbuds are on **different firmware versions** (e.g. `Ver 0331` vs `Ver 0600`).
- The earbuds no longer pair together / the Sound Connect app refuses to update them.
- You bought a replacement single earbud on an older or newer firmware.
- You want to force a specific firmware version.

## What's included

| File | Purpose |
|------|---------|
| `yusen.exe` | HID updater tool |
| `hidapi.dll` | USB HID driver library |
| `msvcr110.dll` | Runtime library required by `yusen.exe` |
| `config.ini` | Device config for WF-1000XM5 (VID/PID/model) |
| `firmware/UPG_english_enc.bin` | Official Sony firmware **6.1.0** |
| `firmware/UPG_600.bin` | Official Sony firmware **6.0.0** |
| `version-check.bat` | Show current firmware versions |
| `update-left.bat` | Flash the LEFT earbud only |
| `update-right.bat` | Flash the RIGHT earbud only |
| `update-both.bat` | Flash both earbuds at once (dual) |

Firmware files are official Sony packages mirrored from the public
[`lzghzr/MDR_Proxy`](https://github.com/lzghzr/MDR_Proxy) firmware library.

## Requirements

- Windows (the tool is a 32-bit Windows executable)
- A USB-C data cable (not a charge-only cable)
- A USB port on the computer (a rear port on desktops is more stable)

## Step 1 — Connect the earbuds

> 💡 **Important Note: Connecting the WF-1000XM5 to a PC can sometimes be tricky.**
> Press and hold the button on the back of the charging case and **keep it held down
> throughout the entire connection process**. Connect the charging case to the computer
> using a USB-C cable, and then **open and close the charging case 15–20 times** to
> activate the earphones and establish a stable connection. If you skip this, the PC
> may not see the earbuds at all.

1. Put **both** earbuds into the charging case.
2. Press and hold the button on the back of the charging case and keep it held.
3. Connect the case to the computer with the USB-C cable.
4. While keeping the button held, open and close the case lid 15–20 times until the
   computer makes a beep (the earbuds are now activated and the connection is stable).
5. Only now release the button.

## Step 2 — Check the current versions

Double-click `version-check.bat`. You should see something like:

```
GET_MAIN_VERSION (LEFT): OK
=> Ver 0600
GET_MAIN_VERSION (RIGHT): OK
=> Ver 0600
GET_CRADLE_VERSION: OK
=> Ver 01.01
```

If both earbuds already show the same version, you can use `update-both.bat`.

## Step 3 — Flash firmware

**If the earbuds are on different versions**, flash them one at a time so they end up
on the same version:

1. Run `update-left.bat` (flashes the left earbud).
2. Wait for it to finish, then **keep the USB connected for at least 10 minutes**.
3. Run `update-right.bat`.
4. Wait for it to finish, then keep the USB connected for at least 10 minutes.
5. Run `version-check.bat` and confirm both earbuds show the same version.

**If both earbuds are already on the same version**, you can run `update-both.bat`
once to flash both at the same time.

By default the scripts use firmware 6.1.0. To use 6.0.0 instead (for example to match
an earbud already on 6.0.0), change the `FW` line in the script:

```
set FW=firmware\UPG_600.bin
```

## Add your own firmware

1. Get an official firmware `.bin` for WF-1000XM5. The easiest source is the
   [`lzghzr/MDR_Proxy`](https://github.com/lzghzr/MDR_Proxy) repository,
   folder `firmware/2963/MDRID296300` (this is a mirror of official Sony firmware).
   Versions there look like `6.0.0_UPG_english_enc_secureboot.<hash>.bin`.
2. Copy the `.bin` into the `firmware/` folder.
3. Edit the `FW` line in the `.bat` script you use, e.g.:
   `set FW=firmware\my_firmware.bin`
4. Run the script.

The `yusen.exe` tool itself accepts any target via the command line:

```
yusen.exe update <left|right|all|dual> <firmware_file.bin>
```

The `*.md5.txt` files next to the firmware are the MD5 checksums of the corresponding
firmware (hash checking is enabled in `config.ini` via `HASH_ONOFF=1`).

## Troubleshooting

**"msvcr110.dll is missing"**
Install the Visual C++ 2012 Redistributable (x86), or copy `msvcr110.dll` from a
working folder into the same folder as `yusen.exe`.

**The computer does not recognize the charging case**
- Try the case-button + open/close lid trick described in Step 1.
- Remove both earbuds from the case and put them back.
- Use a different USB cable (must be a data cable).
- Use a different USB port.

**Version check succeeds but the update fails with `response timeout`**
- The USB connection is unstable. Reconnect using the case-button trick, try another
  cable/port, and retry. Do not unplug during a transfer.
- If the earbuds were on very different firmware versions, flash them one at a time
  (`update-left.bat` / `update-right.bat`) instead of `update-both.bat`.

## Credits

- `yusen.exe`, `hidapi.dll`, `config.ini` — the HID update tooling (same tool used by
  the public WF-1000XM4 updater from [audiospare.com](https://www.audiospare.com)).
- Firmware — official Sony firmware mirrored at
  [`lzghzr/MDR_Proxy`](https://github.com/lzghzr/MDR_Proxy).

## License

MIT — see [LICENSE](LICENSE).
The firmware files are Sony property and are redistributed here only as a convenience
mirror for owners of the devices.
