
import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:birdy_mobile/helpers.dart';
import 'package:birdy_mobile/model/audio_snippet.dart';
import 'package:birdy_mobile/net/api.dart';
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
      print(arePermissionsGranted);

      if(!arePermissionsGranted) return false;

      String rootDir = (await getApplicationDocumentsDirectory()).path;
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

  Future<AudioSnippet> _setAudioSnippetDuration(AudioSnippet audioSnippet) async {
    Duration? duration = await _audioPlayer.setFilePath(audioSnippet.filePath);
    audioSnippet.setDuration(duration!.inMilliseconds);

    return audioSnippet;
  }

  Future<void> playAudio(AudioSnippet audioSnippet) async {
    try {
      await _audioPlayer.setFilePath(audioSnippet.filePath);
      await _audioPlayer.play();

      // Audio need to be stopped else the next time it is played
      // the .play() method won't be awaited
      await _audioPlayer.stop();
    } catch(e) {
      log(e.toString());
      return;
    }
  }

  Future<String> _getAudioSnippetsFilesPath() async {
    String rootDir = (await getApplicationDocumentsDirectory()).path;
    Directory audioSnippetsFolder = Directory('$rootDir/audio_snippet_files');
    bool audioSnippetsFolderExists = await audioSnippetsFolder.exists();
    if (!audioSnippetsFolderExists) await audioSnippetsFolder.create(recursive: true);

    return audioSnippetsFolder.path;
  }

  Future<AudioSnippet> requestClassification(String snippetPath) async {
    AudioSnippet audioSnippet = AudioSnippet(snippetPath);
    audioSnippet = await _setAudioSnippetDuration(audioSnippet);
    await audioSnippet.readFileBytes();
    
    audioSnippet = await Api.makePrediction(audioSnippet);
    String encodedAudioSnippet = jsonEncode(audioSnippet);
    String audioSnippetsFilesPath = await _getAudioSnippetsFilesPath();

    File newAudioFile = File('$audioSnippetsFilesPath/${audioSnippet.audioName}');
    await newAudioFile.writeAsString(encodedAudioSnippet);

    return audioSnippet;
  }

  Future<List<AudioSnippet>> loadAudioSnippetsHistory() async {
    List<String> historyFilesPaths = await Helpers.getHistoryFilesPaths();
    List<AudioSnippet> audioSnippetsList = [];

    for(String path in historyFilesPaths) {
      File audioSnippetFile = File(path);
      String jsonEncodedAudioSnippet = await audioSnippetFile.readAsString();
      Map<String, dynamic> decodedJson = jsonDecode(jsonEncodedAudioSnippet);
      AudioSnippet audioSnippet = AudioSnippet.fromJson(decodedJson);
      audioSnippetsList.insert(0, audioSnippet);
    }

    return audioSnippetsList;
  }


  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}