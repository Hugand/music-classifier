import 'dart:async';
import 'package:birdy_mobile/controllers/audio_ops.dart';
import 'package:birdy_mobile/model/audio_snippet.dart';
import 'package:birdy_mobile/res/colors.dart';
import 'package:birdy_mobile/views/widgets/audio_snippet_card.dart';
import 'package:birdy_mobile/views/widgets/results_dialog.dart';
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
    // await _audioOpsController.playAudio(AudioSnippet(snippetPath));
    await _audioOpsController.requestClassification(snippetPath);
    _showDialog(context, AudioSnippet(snippetPath));
  }

  void _recordSnippet() async {
    bool startRecordingResult = await _audioOpsController.recordSnippet();
    setState(()  {
      _recording = startRecordingResult;
    });

    if(_recording) Timer(const Duration(seconds: 3), _handleStopRecording);
  }

  void show() async {
    AudioSnippet audioSnippet = (await _audioOpsController.loadAudioSnippetsHistory())[0];
    _showDialog(context, audioSnippet);
  }

  void _showDialog(context, audioSnippet) {
    showDialog(
      context: context,
      builder: (BuildContext builderContext) {
        return ResultsDialog(audioSnippet: audioSnippet);
      });
  }

  @override
  Widget build(BuildContext context) {
    // getFiles();
    show();
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
