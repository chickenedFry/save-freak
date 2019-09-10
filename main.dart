import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:watcher/watcher.dart';

main(List<String> arguments) {
  if (arguments.isEmpty) {
    stderr.writeln("No file path provided");
    exit(1);
  } 

  final filePath = arguments.first;
  final fileName = p.basename(filePath);
  final rootBackupPath = p.dirname(filePath) + p.separator + 'backups' + p.separator + 
    new DateFormat('yyyy-MM-dd').format(new DateTime.now());

  final backupDir = new Directory(rootBackupPath);
  if (!backupDir.existsSync()) {
    backupDir
      .create(recursive: true)
      .then((Directory directory) {
        stdout.writeln('Created todays backup directory');
      });
  } else {
    stdout.writeln('Found backup directory: ${rootBackupPath}');
  }

  var watcher = new FileWatcher(filePath);
  watcher.events.listen((event) {
    if (event.type == ChangeType.MODIFY) {
      final newFinalPath = rootBackupPath + p.separator + 
        new DateFormat('hhmmss').format(new DateTime.now()) + '_${fileName}';

      new File(filePath).copy(newFinalPath).then((File copiedFile) {
        stdout.writeln('Copied file to ${copiedFile.path}');
      });
    } else {
      stdout.writeln('File has been removed?');
    }
  });
}