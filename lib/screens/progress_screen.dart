import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final progress = appState.progress;

    return Scaffold(
      appBar: AppBar(title: Text(appState.language == 'pa' ? 'ਪ੍ਰਗਤੀ' : 'Progress')),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: progress.isEmpty
            ? Center(child: Text(appState.language == 'pa' ? 'ਕੋਈ ਪ੍ਰਗਤੀ ਨਹੀਂ' : 'No progress yet'))
            : ListView(
                children: progress.entries.map((e) {
                  final parts = e.key.split('_');
                  final subjectId = parts.isNotEmpty ? parts[0] : e.key;
                  final lessonId = parts.length > 1 ? parts[1] : '';
                  final lesson = appState.getLesson(subjectId, lessonId);
                  final lessonTitle = lesson != null ? (appState.language == 'pa' ? lesson['title_pa'] : lesson['title_en']) : e.key;
                  return Card(
                    child: ListTile(
                      title: Text(lessonTitle),
                      subtitle: Text(appState.language == 'pa' ? ' ਸਕੋਰ: ${e.value}' : 'Score: ${e.value}'),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
