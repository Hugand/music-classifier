
import 'package:birdy_mobile/model/audio_snippet.dart';
import 'package:birdy_mobile/res/colors.dart';
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
  bool _hasClickedEvaluation = false;

  void _evaluatePrediction(bool isPredictionRight) {
    setState(() {
      _hasClickedEvaluation = true;
    });

    if(isPredictionRight)
      print("Right prediction");
    else
      print("Wrong prediction");
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                
                if(!_hasClickedEvaluation) ...[
                  Container(
                    margin: const EdgeInsets.fromLTRB(50, 136.0, 50, 20),
                    child: const Divider(height: 2, color: Colors.black),
                  ),
                  const Text("Evaluate"),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(children: [
                      const Spacer(),
                      EvaluationButton(
                        onTap: () {_evaluatePrediction(false);},
                        icon: 'assets/img/cross.svg',
                        color: CustomColors.red,
                      ),
                      const Spacer(),
                      EvaluationButton(
                        onTap: () {_evaluatePrediction(true);},
                        icon: 'assets/img/check.svg',
                        color: CustomColors.green,
                      ),
                      const Spacer(),
                    ]),
                  )]
              ])
            )
          );
  }

}