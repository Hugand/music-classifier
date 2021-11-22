
class AudioApiResults {
  late int _aid;
  late String _genre;

  AudioApiResults(int aid, String genre) {
    _aid = aid;
    _genre = genre;
  }

  String get genre => _genre;

  factory AudioApiResults.fromJson(dynamic json) {
    return AudioApiResults(json['aid'] as int, json['genre'] as String);
  }

}