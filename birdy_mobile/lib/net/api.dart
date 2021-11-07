
import 'package:birdy_mobile/model/audio_snippet.dart';

class Api {
  static Future<AudioSnippet> makePrediction(AudioSnippet audioSnippet) async {
    // Make api call
    
    String genre = 'Rock';
    audioSnippet.setGenre(genre);

    return audioSnippet; // Return object with prediction
  }
}