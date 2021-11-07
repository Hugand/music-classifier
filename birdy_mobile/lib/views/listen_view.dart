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

    _audioOpsController.requestClassification(snippetPath);
  }

  void _recordSnippet() async {
    bool startRecordingResult = await _audioOpsController.recordSnippet();
    setState(()  {
      _recording = startRecordingResult;
    });

    if(_recording) Timer(const Duration(seconds: 3), _handleStopRecording);
  }

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
