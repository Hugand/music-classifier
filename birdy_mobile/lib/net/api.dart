
import 'dart:convert';
import 'dart:math';
import 'package:birdy_mobile/model/audio_api_result.dart';
import 'package:http/http.dart' as http;

import 'package:birdy_mobile/model/audio_snippet.dart';

class Api {
  static Future<AudioSnippet> makePrediction(AudioSnippet audioSnippet) async {
    // Make api call
    var req = http.MultipartRequest('POST', Uri.parse('http://192.168.1.88:3001/api/v1/classifier'));
    req.files.add(await http.MultipartFile.fromPath('audioFile', audioSnippet.filePath));

    var res = await req.send();

    var responsed = await http.Response.fromStream(res);  
    AudioApiResults audioApiResult = AudioApiResults.fromJson(json.decode(responsed.body));

    audioSnippet.setGenre(audioApiResult.genre);

    return audioSnippet; // Return object with prediction
  }
}