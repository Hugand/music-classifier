import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'dart:typed_data';

class AudioSnippet {
  String _filePath = '';
  String _genre = '';
  DateTime _dateTime = DateTime.now();
  int _duration = 0;
  // Uint8List _bytes = Uint8List(0);

  AudioSnippet(String filePath) {
    _filePath = filePath;
    _genre = 'None';
  }

  String get audioName {
    List<String> pathStructure = _filePath.split('/');
    return pathStructure.last.split('.').first;
  }

  String get filePath => _filePath;
  String get genre => _genre;
  int get duration => _duration;
  String get date {
    return '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}';
  }

  void setDuration(int duration) {
    _duration = duration;
  }

  Future<void> readFileBytes() async {
    Uri myUri = Uri.parse(_filePath);
    File audioFile = File.fromUri(myUri);
    _dateTime = await audioFile.lastModified();
    
    try {
      final value = await audioFile.readAsBytes();
      // _bytes = Uint8List.fromList(value); 
      log('reading of bytes is completed');
    } catch(e) {
      log('Error reading audio file: $e');
    }
  }

  void setGenre(String genre) {
    _genre = genre;
  }

  AudioSnippet.fromJson(Map<String, dynamic> json)
      : _filePath = json['filePath'],
        _genre = json['genre'],
        _duration = json['duration'].toInt(),
        // _bytes =  Uint8List.fromList(json['bytes']),
        _dateTime = DateTime.parse(json['dateTime']);

  Map<String, dynamic> toJson() => {
    'filePath': _filePath,
    'genre': _genre,
    'dateTime': _dateTime.toUtc().toIso8601String(),
    'duration': _duration,
    // 'bytes': _bytes
  };

  @override
  String toString() {
    return '{ $_filePath, $_genre, $_dateTime}, ${_duration}';
  }
}