
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Helpers {
  static Future<List<String>> getHistoryFilesPaths() async { //asyn function to get list of files
    // Get the system temp directory.
    String rootDir = (await getApplicationDocumentsDirectory()).path;
    Directory systemTempDir = Directory('$rootDir/audio_snippet_files');
    List<String> paths = [];
    // var systemTempDir = Directory.systemTemp;

    // List directory contents, recursing into sub-directories,
    // but not following symbolic links.
    await for (var entity in systemTempDir.list(recursive: true, followLinks: false)) {
      paths.add(entity.path);
    }

    return paths;
  }
}