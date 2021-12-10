
import 'dart:convert';
import 'dart:math';
import 'package:birdy_mobile/model/audio_api_result.dart';
import 'package:birdy_mobile/model/result_evaluation_api_result.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:birdy_mobile/model/audio_snippet.dart';

class Api {
  static Future<AudioSnippet> makePrediction(AudioSnippet audioSnippet) async {
    // Make api call
    var req = http.MultipartRequest('POST', Uri.parse('${dotenv.env['BACKEND_URL']}/api/v1/classifier'));
    req.files.add(await http.MultipartFile.fromPath('audioFile', audioSnippet.filePath));

    var res = await req.send();

    var responsed = await http.Response.fromStream(res);  
    AudioApiResults audioApiResult = AudioApiResults.fromJson(json.decode(responsed.body));

    audioSnippet.setGenre(audioApiResult.genre);
    audioSnippet.setAid(audioApiResult.aid);

    return audioSnippet; // Return object with prediction
  }

  static Future<ResultEvaluationApiResult> evaluateResult(int aid, String correctGenre) async {
    // Make api call
    Map<String, String> reqBody = {
      "aid": aid.toString(),
      "correctLabel": correctGenre
    };

    var res = await http.post(Uri.parse('${dotenv.env['BACKEND_URL']}/api/v1/classifier/evaluate'), body: reqBody);
    print(res.body);
    ResultEvaluationApiResult resultEvalResult = ResultEvaluationApiResult.fromJson(json.decode(res.body));


    return resultEvalResult; // Return object with prediction
  }
}