import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/database.json');
  }

  Future<String> readDatabaseAsString() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '{}';
    }
  }

  Future<File> saveDatabaseAsString(String jsonAsString) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$jsonAsString', flush: true);
  }
}
