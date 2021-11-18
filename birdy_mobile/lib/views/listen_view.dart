import 'dart:async';
import 'package:birdy_mobile/controllers/audio_ops.dart';
import 'package:birdy_mobile/model/audio_snippet.dart';
import 'package:birdy_mobile/res/colors.dart';
import 'package:birdy_mobile/views/widgets/audio_snippet_card.dart';
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
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 92),
                child: const Text("Results",
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: AudioSnippetCard(audioSnippet: audioSnippet),
              ),
              
              Container(
                margin: const EdgeInsets.fromLTRB(50, 136.0, 50, 20),
                child: const Divider(height: 2, color: Colors.black),
              ),

              const Text("Evaluate"),
              
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 40),
                child: Row(children: [
                  const Spacer(),
                  InkWell(
                    onTap: () {}, // Handle your callback
                    child: Ink(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(color: CustomColors.red, width: 2)
                      ),
                      child: SvgPicture.asset(
                        'assets/img/cross.svg',
                        color: CustomColors.red,
                      )
                    )
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {}, // Handle your callback
                    child: Ink(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(color: CustomColors.green, width: 2)
                      ),
                      child: SvgPicture.asset(
                        'assets/img/check.svg',
                        color: CustomColors.green,
                      )
                    )
                  ),
                  const Spacer(),
                ]),
              )
            ])
          );
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
