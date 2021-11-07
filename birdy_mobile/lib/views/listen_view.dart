import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class ListenView extends StatefulWidget {
  const ListenView({Key? key}) : super(key: key);

  @override
  State<ListenView> createState() => _ListenViewState();
}

class _ListenViewState extends State<ListenView> {
  final Record _audioRecorder = Record();

  void _recordAudio() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.storage,
      Permission.microphone,
    ].request();

    bool permissionsGranted = permissions[Permission.storage]!.isGranted &&
        permissions[Permission.microphone]!.isGranted;
    String rootDir = (await getApplicationDocumentsDirectory()).path;
    if (permissionsGranted) {
      Directory appFolder = Directory(rootDir);
      bool appFolderExists = await appFolder.exists();
      if (!appFolderExists) {
        final created = await appFolder.create(recursive: true);
        // print(created.path);
      }

      final filepath = rootDir + DateTime.now().millisecondsSinceEpoch.toString() + '.wav';

      await _audioRecorder.start(path: filepath);
      print('Starting... ' + filepath);

      sleep(const Duration(seconds: 6));
      stopRecording();
      // emit(RecordOn());
    } else {
      print('Permissions not granted');
    }
  }

  void stopRecording() async {
    try {
      String? path = await _audioRecorder.stop();
      // emit(RecordStopped());
      print('Output path $path');

      AudioPlayer _audioPlayer = AudioPlayer();
      final duration = await _audioPlayer.setFilePath(path!);
      print("DURATION: " + duration.toString());
      await _audioPlayer.play();
      sleep(const Duration(seconds: 4));

      await _audioPlayer.stop();

    } catch(e) {
      print("Error: " + e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - 50.0,
            height: MediaQuery.of(context).size.width - 50.0,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                width: 6.0,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(600.0),
            ),
            child: MaterialButton(
              color: Colors.black,
              shape: const CircleBorder(),
              onPressed: _recordAudio,
              child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(70.0),
                    width: 100.0,
                    height: 100.0,
                    child: SvgPicture.asset(
                      'assets/img/music-alt.svg',
                      color: Colors.white,
                      semanticsLabel: 'A red up arrow'
                    )
                  ),
                )
            )
          )
        ],
      ),
    );
  }
}
