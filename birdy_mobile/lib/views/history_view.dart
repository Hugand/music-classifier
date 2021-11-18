import 'package:birdy_mobile/controllers/audio_ops.dart';
import 'package:birdy_mobile/model/audio_snippet.dart';
import 'package:birdy_mobile/views/widgets/audio_snippet_card.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<AudioSnippet> _audioSnippets = [];
  final AudioOpsController _audioOpsController = AudioOpsController();

  @override
  initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() async {
    List<AudioSnippet> tmpAudioSnippets = await _audioOpsController.loadAudioSnippetsHistory();
    setState(() {
      _audioSnippets = tmpAudioSnippets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        child: ListView.builder(
          itemCount: _audioSnippets.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: AudioSnippetCard(audioSnippet: _audioSnippets[i]),
            );
          },
        ),
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), 
            _loadHistory
          );
        },
      )
    );
  }
}
