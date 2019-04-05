import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:http/http.dart' as http;

class ExportDatabase {
  String appDirectory;
  String _tempDirectory;
  String _zipFilePath;

  ZipFileEncoder _encoder;
  ExportDatabase({this.appDirectory});

  Future<void> init() async {
    _tempDirectory = '$appDirectory/tmp';
    _zipFilePath = '$_tempDirectory/out.zip';

    print('cleaning up temp directory.');
    var dir = new Directory(_tempDirectory);

    try {
      await dir.delete(recursive: true);
    } catch (e) {
      print('Safe to ignore: ${e.message}');
    }

    await new File(_zipFilePath).create(recursive: true);
    _encoder = new ZipFileEncoder();
    _encoder.create(_zipFilePath);
  }

  void addFile(String path) {
    _encoder.addFile(new File(path));
  }

  Future<bool> post(Uri uri) async {
    // This one should fail if it cant close.
    _encoder.close();

    print('Post database to server');
    _printStat();

    final file = new File(_zipFilePath);

    final streamedRequest = new http.StreamedRequest('PUT', uri);

    streamedRequest.contentLength = await file.length();
    file.openRead().listen((chunk) {
      print(chunk.length);
      streamedRequest.sink.add(chunk);
    }, onDone: () {
      streamedRequest.sink.close();
    });

    try {
      await streamedRequest.send();
    } catch (e) {
      if (e is SocketException) {
        print('is the server running');
      }
      print(e.message);
      deleteTemp();
      return false;
    }

    print('after response');
    deleteTemp();
    return true;
  }

  Future<void> _printStat() async {
    var zipFile = new File(_zipFilePath);
    var stat = await zipFile.stat();
    print(stat);
  }

  Future<void> deleteTemp() async {
    try {
      _encoder.close();
    } catch (e) {
      print('Safe to ignore: ${e.message}');
    }

    print('cleaning up temp directory.');
    var dir = new Directory(_tempDirectory);
    await dir.delete(recursive: true);
  }
}
