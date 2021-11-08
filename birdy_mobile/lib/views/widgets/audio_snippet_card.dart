

import 'dart:async';

import 'package:birdy_mobile/controllers/audio_ops.dart';
import 'package:birdy_mobile/model/audio_snippet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AudioSnippetCard extends StatefulWidget {
  final AudioSnippet audioSnippet;
  const AudioSnippetCard({Key? key, required this.audioSnippet}) : super(key: key);

  @override
  State<AudioSnippetCard> createState() => _AudioSnippetCardState();
}

class _AudioSnippetCardState extends State<AudioSnippetCard> {
  double _playbackPosition = 0;
  final AudioOpsController audioOpsController = AudioOpsController();

  void _incrementProgress(int maxValue, DateTime startTime) {
    int timePassed = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;
    
    setState(() { 
      _playbackPosition = 1 - (timePassed / maxValue);
    });
  }

  // TODO: Some bug in this method
  void _handlePlayAudioSnippet() async {
    setState(() { _playbackPosition = 0; });
    DateTime startTime = DateTime.now();
    Timer t = Timer.periodic(const Duration(milliseconds: 1), (Timer t) {
      _incrementProgress(widget.audioSnippet.duration, startTime);
    });
    await audioOpsController.playAudio(widget.audioSnippet);
    t.cancel();
    setState(() { _playbackPosition = 0; });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handlePlayAudioSnippet, // Handle your callback
      child: Ink(
        padding: const EdgeInsets.fromLTRB(30, 18, 30, 18),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16.0)
        ),
        child: Row(children: [
          Stack(children: [
            CircularProgressIndicator(
              strokeWidth: 2,
              value: _playbackPosition,
              color: Colors.white,
            ),
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.all(6),
                child: SvgPicture.asset(
                  'assets/img/play.svg',
                  color: Colors.white,
                ),
              )
            )
          ],),
          Container(
            margin: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Text(
                'genre',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300,
                )
              ),
              Text(
                widget.audioSnippet.genre,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold
                )
              )
            ])
          ),
          const Spacer(),
          Text(
            widget.audioSnippet.date,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
            ))
        ],)
      )
    );
  }

}