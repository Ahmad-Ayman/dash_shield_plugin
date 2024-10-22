import 'dart:io';

class PrintModificationService {
  static final String importStatement =
      "import 'package:flutter/foundation.dart';";

  static removePrints() async {
    RegExp regExp =
        RegExp(r"^print\([^)]*\);", multiLine: true, caseSensitive: true);
    const String pathToLib = 'lib';
    Directory dir = Directory(pathToLib);
    List<FileSystemEntity> contents = dir.listSync(recursive: true);
    List<String> dartFiles = [];
    for (FileSystemEntity fileSystemEntity in contents) {
      if (fileSystemEntity.path.endsWith('.dart')) {
        dartFiles.add(fileSystemEntity.path);
        print(fileSystemEntity.path.toString().split('/').last);
      }
    }

    for (String fileName in dartFiles) {
      File f = File(fileName);
      String fileContent = await f.readAsString();
      List<String> lines = fileContent.split('\n');
      for (int i = 0; i < lines.length; i++) {
        if (regExp.hasMatch(lines[i].trim())) {
          print('print has been removed in $fileName at line ${i + 1}');
          lines.removeAt(i);
        }
      }
      f.writeAsStringSync(lines.join('\n'));
    }
  }

  static wrapPrintsWithDebugModeChecker() async {
    RegExp regExp =
        RegExp(r"^print\([^)]*\);", multiLine: true, caseSensitive: true);
    RegExp kDebugModeRegExp = RegExp(
        r"if\s*\(kDebugMode\)\s*\{"); // Regex for detecting if (kDebugMode) block

    const String pathToLib = 'lib';
    Directory dir = Directory(pathToLib);
    List<FileSystemEntity> contents = dir.listSync(recursive: true);
    List<String> dartFiles = [];
    for (FileSystemEntity fileSystemEntity in contents) {
      if (fileSystemEntity.path.endsWith('.dart')) {
        dartFiles.add(fileSystemEntity.path);
        print(fileSystemEntity.path.toString().split('/').last);
      }
    }

    for (String fileName in dartFiles) {
      File f = File(fileName);
      String fileContent = await f.readAsString();
      List<String> lines = fileContent.split('\n');
      int counterForPrints = 0;
      bool insideDebugModeBlock = false;

      for (int i = 0; i < lines.length; i++) {
        String line = lines[i].trim();

        if (kDebugModeRegExp.hasMatch(line)) {
          // If we encounter if (kDebugMode) block, we enter it
          insideDebugModeBlock = true;
        } else if (insideDebugModeBlock && line == '}') {
          // If we encounter a closing brace of the kDebugMode block, we exit it
          insideDebugModeBlock = false;
        }

        if (regExp.hasMatch(lines[i].trim()) && !insideDebugModeBlock) {
          counterForPrints++;
          print('Wrapping print statement in $fileName at line ${i + 1}');

          // Wrap the print statement in an if (kDebugMode) block
          String printStatement = lines[i].trim();
          lines[i] = 'if (kDebugMode) {\n  $printStatement\n}';
        }
      }
      if (counterForPrints > 0) {
        if (!fileContent.contains(importStatement)) {
          print('Adding missing import to $fileName');
          lines.insert(0, importStatement);
        }
      }
      f.writeAsStringSync(lines.join('\n'));
    }
  }
}
