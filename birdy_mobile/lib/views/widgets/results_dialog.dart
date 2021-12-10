
import 'package:birdy_mobile/model/audio_snippet.dart';
import 'package:birdy_mobile/res/colors.dart';
import 'package:birdy_mobile/views/widgets/audio_genre_evaluator.dart';
import 'package:birdy_mobile/views/widgets/evaluation_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'audio_snippet_card.dart';

class ResultsDialog extends StatefulWidget {
  final AudioSnippet audioSnippet;
  const ResultsDialog({Key? key, required this.audioSnippet}) : super(key: key);

  @override
  State<ResultsDialog> createState() => _ResultsDialogState();
}

class _ResultsDialogState extends State<ResultsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 30, 0, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 92),
              child: const Text("Results",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: AudioSnippetCard(audioSnippet: widget.audioSnippet),
            ),
            
            AudioGenreEvaluator(audioSnippet: widget.audioSnippet)
          ])
        )
      );
  }

}