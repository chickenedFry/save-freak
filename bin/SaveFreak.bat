rem "Steam file location below"
set DDDA_STEAM_SAVE_FILE="C:\Program Files (x86)\Steam\userdata\YOUR_STEAM_ID_HERE\367500\DDDA.sav"

rem "GOG file location below"
set DDDA_GOG_SAVE_FILE="%LOCALAPPDATA%\GOG.com\Galaxy\Applications\49987265717041704\Storage\Shared\Files\DDDA.sav"

rem "Check which save file exists and pass the path to script"
if exist %DDDA_GOG_SAVE_FILE% (
    set DDDA_SAVE_FILE=%DDDA_GOG_SAVE_FILE%
) else (
    set DDDA_SAVE_FILE=%DDDA_STEAM_SAVE_FILE%
)

rem "Run!"
.\dartaotruntime.exe SaveFreak.dart.aot "%DDDA_SAVE_FILE%"