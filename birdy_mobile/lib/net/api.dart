
import 'dart:math';

import 'package:birdy_mobile/model/audio_snippet.dart';

class Api {
  static Future<AudioSnippet> makePrediction(AudioSnippet audioSnippet) async {
    // Make api call

    String genre = ['Rock', 'Hip-hop', 'Indie', 'Metal'][Random().nextInt(4)];
    audioSnippet.setGenre(genre);

    return audioSnippet; // Return object with prediction
  }
}