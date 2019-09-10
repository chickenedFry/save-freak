import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:watcher/watcher.dart';

main(List<String> arguments) async {
  if (arguments.isEmpty) {
    stderr.writeln("No file path provided");
    exit(1);
  } 

  startWatcher(arguments.first);
}

startWatcher(String filePath) {
  var watcher = new FileWatcher(filePath);
  watcher.events.listen(fileListenCallback);
  stdout.writeln("Started to watch '${filePath}'");
}

Future<String> createRootBackupDir(String saveFilePath) async {
  final rootBackupPath = p.canonicalize(p.join(
    p.dirname(saveFilePath),
    'backups',
    new DateFormat('yyyy-MM-dd').format(new DateTime.now())
  ));

  final backupDir = new Directory(rootBackupPath);
  if (!backupDir.existsSync()) {
    await backupDir
      .create(recursive: true)
      .then((Directory directory) {
        stdout.writeln('Created todays backup directory');
      });
  }

  return rootBackupPath;
}

fileListenCallback(WatchEvent event) async {
  final saveFilePath = p.canonicalize(event.path);

  if(event.type == ChangeType.ADD) {
    // This doesn't work, even when creating totally new file
    stdout.writeln('File is back');
  } else if (event.type == ChangeType.MODIFY) {
    // We use event's path name because it keeps letters case intact.
    // In Windows file names letter cases are ignored.
    // canonicalize() lowercases letters just "because it can" if it's Windows.
    // Somehow Dragon's Dogma: Dark Arisen doesn't find save file with lowercased name :shrug:
    final fileName = p.basename(event.path);
    final rootBackupPath = await createRootBackupDir(saveFilePath);
    final newFinalPath = p.join(
      rootBackupPath,
      new DateFormat('hhmmss').format(new DateTime.now()) + '_${fileName}'
    );

    new File(saveFilePath).copy(newFinalPath).then((File copiedFile) {
      stdout.writeln('Copied file to ${copiedFile.path}');
    });
  } else {
    stdout.writeln('File has been removed/renamed, trying to restart watcher');
    startWatcher(event.path);
  }
}