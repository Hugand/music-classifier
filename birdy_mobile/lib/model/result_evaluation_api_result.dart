
class ResultEvaluationApiResult {
  late int _aid;
  late String _genre;
  late bool _success;

  ResultEvaluationApiResult(int aid, String genre, bool success) {
    _aid = aid;
    _genre = genre;
    _success = success;
  }

  ResultEvaluationApiResult.empty() {
    _aid = -1;
    _genre = '';
    _success = false;
  }

  String get genre => _genre;
  int get aid => _aid;
  bool get success => _success;

  factory ResultEvaluationApiResult.fromJson(dynamic json) {
    return ResultEvaluationApiResult(int.parse(json['aid']), json['genre'] as String, json['success'] as bool);
  }
}