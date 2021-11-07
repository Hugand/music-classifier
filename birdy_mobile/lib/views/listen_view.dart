import 'dart:async';
import 'package:birdy_mobile/controllers/audio_ops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListenView extends StatefulWidget {
  const ListenView({Key? key}) : super(key: key);

  @override
  State<ListenView> createState() => _ListenViewState();
}

class _ListenViewState extends State<ListenView> {
  final AudioOpsController _audioOpsController = AudioOpsController();
  bool _recording = false;

  void _handleStopRecording() async {
    String snippetPath = await _audioOpsController.stopRecording();
    setState(() {  _recording = false; });
    await _audioOpsController.playAudio(snippetPath);
  }

  void _recordSnippet() async {
    bool startRecordingResult = await _audioOpsController.recordSnippet();
    setState(()  {
      _recording = startRecordingResult;
    });

    if(_recording) Timer(const Duration(seconds: 6), _handleStopRecording);
  }

//  void getFiles() async { //asyn function to get list of files
//     // Get the system temp directory.
//     String rootDir = (await getApplicationDocumentsDirectory()).path;
//     Directory systemTempDir = Directory('/data/user/0/com.example.birdy_mobile');
//     // var systemTempDir = Directory.systemTemp;

//     // List directory contents, recursing into sub-directories,
//     // but not following symbolic links.
//     await for (var entity in systemTempDir.list(recursive: true, followLinks: false)) {
//       print(entity.path);
//     }
//   }

  @override
  Widget build(BuildContext context) {
    // getFiles();
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
                width: 4.0,
                color: _recording ? Colors.black : Colors.white,
              ),
              borderRadius: BorderRadius.circular(600.0),
            ),
            child: MaterialButton(
              color: Colors.black,
              shape: const CircleBorder(),
              onPressed: _recordSnippet,
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
