# SaveFreak
Insanely backups your game save files

Primarly created for game Dragon's Dogma: Dark Arisen. It's save system is incredibly limited (only 1 save file!) thus making a hard time for even expierenced players avoid mistakes and some mistakes can cost you much like missing zones, important items, important NPCs and so on. But no more! With this little script you are not afraid of making crucial mistakes anymore and you even can experiment and try new risky things!

# How to run (tested only for Dragon's Dogma: Dark Arisen from GOG!)
* Download this repository in ZIP format
* Extract and copy bin/ contents anywhere you want
* Open for editing SaveFreak.bat. There you will see some various pre-defined save paths already (for Dragon's Dogma: Dark Arisen). Adjust paths to yours (If DDDA is installed via GOG this .bat file should work without any additional editing)
* Double click on SaveFreak.bat, it will open black console window and will print some messages and will wait. Don't close it.

# How does it work?
It watches for one save file changes. When you save a game script detects that and makes a copy of that file with a unique name. Name consists of timestamp and is put into separate directory with a name of current date. There is no limit of files, you are always safe! If you want to restore to some save file just locate it and replace main save file with it. Attention for GOG users: it will write file copies to folder and ALL content will be synced! Auto-sync happens for _all files_ and it may reach uplaod quota pretty fast. You can disable auto-sync feature for short time and delete old backups.

# How to edit source and build
If you want to do some changes feel free to do so! Script is pretty simple and is written in Dart language. You will need to download Dart SDK: just follow installation instructions in https://dart.dev/get-dart. Then you have basically two ways to run program: by calling dart.exe dart.main or compiling to AOT runtime following instructions in https://dart.dev/tools/dart2aot.