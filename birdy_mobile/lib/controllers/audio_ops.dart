
import 'dart:io';
import 'dart:developer';

import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class AudioOpsController {
  final Record _audioRecorder = Record();
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<bool> _requestPermissions() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.storage,
      Permission.microphone,
    ].request();

    return permissions[Permission.storage]!.isGranted &&
        permissions[Permission.microphone]!.isGranted;
  }

  Future<bool> recordSnippet() async {
    try {
      bool arePermissionsGranted = await _requestPermissions();
      String rootDir = (await getApplicationDocumentsDirectory()).path;

      if(!arePermissionsGranted) return false;

      Directory appDataFolder = Directory(rootDir);
      bool appDataFolderExists = await appDataFolder.exists();
      if (!appDataFolderExists) await appDataFolder.create(recursive: true);

      final filepath = '$rootDir/${DateTime.now().millisecondsSinceEpoch.toString()}.wav';
      _audioRecorder.start(path: filepath);

      return true;
    } catch(e) {
      log(e.toString());
      return false;
    }
  }

  Future<String> stopRecording() async {
    try {
      return (await _audioRecorder.stop())!;
    } catch(e) {
      log(e.toString());
      return '';
    }
  }

  Future<void> playAudio(String audioFilePath) async {
    try {
      await _audioPlayer.setFilePath(audioFilePath);
      await _audioPlayer.play();
    } catch(e) {
      log(e.toString());
      return;
    }
  }
}