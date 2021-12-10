
import 'dart:async';

import 'package:birdy_mobile/controllers/audio_ops.dart';
import 'package:birdy_mobile/model/audio_snippet.dart';
import 'package:birdy_mobile/model/result_evaluation_api_result.dart';
import 'package:birdy_mobile/res/colors.dart';
import 'package:birdy_mobile/views/widgets/evaluation_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioGenreEvaluator extends StatefulWidget {
  final AudioSnippet audioSnippet;
  const AudioGenreEvaluator({Key? key, required this.audioSnippet}) : super(key: key);

  @override
  State<AudioGenreEvaluator> createState() => _AudioGenreEvaluatorState();
}

class _AudioGenreEvaluatorState extends State<AudioGenreEvaluator> {
  final AudioOpsController _audioOpsController = AudioOpsController();
  int _hasClickedEvaluation = 0;
  bool _correctEvaluation = false;
  final List<String> _genres = ["blues", "classical", "country", "disco", "hiphop", "jazz", "metal", "pop", "reggae", "rock"];
  String _selectedGenre = "blues";
  bool _awaitingForEvalResponse = false;

  Future<void> _evaluatePrediction() async {
    setState(() {
      _awaitingForEvalResponse = true;
    });

    ResultEvaluationApiResult resultsEval = await _audioOpsController.evaluateResult(widget.audioSnippet, _selectedGenre);

    setState(() {
      _hasClickedEvaluation = resultsEval.success ? 3 : 4;
      _awaitingForEvalResponse = false;
    });
  }

  void _handleEvaluationButtonClick(bool isPredictionRight) {
    setState(() {
      _hasClickedEvaluation = 1;
      _correctEvaluation = isPredictionRight;
    });

    if(isPredictionRight) _evaluatePrediction();
  }

  void _handleEvaluationCorrectionButton() {
    setState(() {
      _hasClickedEvaluation = 2;
    });

    _evaluatePrediction();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: const EdgeInsets.fromLTRB(50, 136.0, 50, 20),
          child: const Divider(height: 2, color: Colors.black),
        ),
        const Text("Evaluate"),
        if(_hasClickedEvaluation == 0 && !_correctEvaluation) ...[
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Row(children: [
              const Spacer(),
              EvaluationButton(
                onTap: () {_handleEvaluationButtonClick(false);},
                icon: 'assets/img/cross.svg',
                color: CustomColors.red,
              ),
              const Spacer(),
              EvaluationButton(
                onTap: () {_handleEvaluationButtonClick(true);},
                icon: 'assets/img/check.svg',
                color: CustomColors.green,
              ),
              const Spacer(),
            ]),
          ),
        ] else if(_hasClickedEvaluation == 1 && !_correctEvaluation) ...[
          DropdownButton<String>(
            value: _selectedGenre,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.black, fontSize: 18),
            underline: Container(
              padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
              height: 2,
              color: Colors.black,
            ),
            onChanged: (String? newValue) {
              setState(() {
                _selectedGenre = newValue!;
              });
            },
            items: _genres.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextButton(
            onPressed: _handleEvaluationCorrectionButton,
            child: const Text('Evaluate', style: TextStyle(fontSize: 18)),
            style: ButtonStyle(
              padding:MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(18, 8, 18, 8)) ,
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            )
          )
        ] else if(_hasClickedEvaluation == 2 && _awaitingForEvalResponse) ...[
          const CircularProgressIndicator()
        ] else if(_hasClickedEvaluation == 3) ...[
          const Text("Done!", style: TextStyle(
            fontSize: 18,
            color: CustomColors.green
          ))
        ] else if(_hasClickedEvaluation == 4) ...[
          const Text("An error occurred", style: TextStyle(
            fontSize: 18,
            color: CustomColors.red
          ))
        ]
    ]);
  }

}