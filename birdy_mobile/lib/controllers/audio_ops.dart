
import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'dart:typed_data';

import 'package:birdy_mobile/helpers.dart';
import 'package:birdy_mobile/model/audio_snippet.dart';
import 'package:birdy_mobile/model/result_evaluation_api_result.dart';
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
    // await _convertAudioToRiff(snippetPath);
    AudioSnippet audioSnippet = AudioSnippet(snippetPath);
    audioSnippet = await _setAudioSnippetDuration(audioSnippet);
    // await audioSnippet.readFileBytes();
    
    audioSnippet = await Api.makePrediction(audioSnippet);
    String encodedAudioSnippet = jsonEncode(audioSnippet);
    String audioSnippetsFilesPath = await _getAudioSnippetsFilesPath();

    File newAudioFile = File('$audioSnippetsFilesPath/${audioSnippet.audioName}');
    await newAudioFile.writeAsString(encodedAudioSnippet);

    return audioSnippet;
  }

  Future<ResultEvaluationApiResult> evaluateResult(AudioSnippet audioSnippet, String correctGenre) async {
  ResultEvaluationApiResult resultEvalResult;
    try {
      resultEvalResult = await Api.evaluateResult(audioSnippet.aid, correctGenre);
    } on Exception catch (_) {
      print(_);
      return ResultEvaluationApiResult.empty();
    }

    if(resultEvalResult.success) {
      audioSnippet.setGenre(resultEvalResult.genre);
      await _updateAudioSnippetFile(audioSnippet);
    }

    return resultEvalResult;
  }

  // Maybe this can be also called in the prediction method
  Future<void> _updateAudioSnippetFile(AudioSnippet audioSnippet) async {
    File newAudioFile = File(audioSnippet.filePath);
    String encodedAudioSnippet = jsonEncode(audioSnippet);

    await newAudioFile.writeAsString(encodedAudioSnippet);
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

  Future<void> _convertAudioToRiff(String filePath) async {
    Uint8List bytes = await _readAudioBytes(filePath);
    File recordedFile = File(filePath);
    Uint8List audioRiffData = _createAudioRiffData(bytes, 44100);
    print(audioRiffData.length);
    return recordedFile.writeAsBytesSync(audioRiffData, flush: true);
  }

  Uint8List _createAudioRiffData(List<int> data, int sampleRate) {
    var channels = 1;
    int byteRate = ((16 * sampleRate * channels) / 8).round();
    var size = data.length;
    var fileSize = size + 36;

    return Uint8List.fromList([
      // "RIFF"
      82, 73, 70, 70,
      fileSize & 0xff,
      (fileSize >> 8) & 0xff,
      (fileSize >> 16) & 0xff,
      (fileSize >> 24) & 0xff,
      // WAVE
      87, 65, 86, 69,
      // fmt
      102, 109, 116, 32,
      // fmt chunk size 16
      16, 0, 0, 0,
      // Type of format
      1, 0,
      // One channel
      channels, 0,
      // Sample rate
      sampleRate & 0xff,
      (sampleRate >> 8) & 0xff,
      (sampleRate >> 16) & 0xff,
      (sampleRate >> 24) & 0xff,
      // Byte rate
      byteRate & 0xff,
      (byteRate >> 8) & 0xff,
      (byteRate >> 16) & 0xff,
      (byteRate >> 24) & 0xff,
      // Uhm
      ((16 * channels) / 8).round(), 0,
      // bitsize
      16, 0,
      // "data"
      100, 97, 116, 97,
      size & 0xff,
      (size >> 8) & 0xff,
      (size >> 16) & 0xff,
      (size >> 24) & 0xff,
      ...data
    ]);
  }

  Future<Uint8List> _readAudioBytes(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File audioFile = File.fromUri(myUri);
    
    try {
      return await audioFile.readAsBytes();
    } catch(e) {
      log('Error reading audio file: $e');
    }

    return Uint8List(0);
  }


  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}