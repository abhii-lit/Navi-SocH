import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class LessonListScreen extends StatelessWidget {
  const LessonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final subjectId = args?['subjectId'] as String?;
    final appState = Provider.of<AppState>(context);

    if (subjectId == null) {
      return const Scaffold(body: Center(child: Text("No subject selected")));
    }

    final lessons = appState.getLessons(subjectId);

    if (lessons.isEmpty) {
      return const Scaffold(body: Center(child: Text("No lessons available")));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Lessons")),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, i) {
          final lesson = lessons[i];
          return ListTile(
            title: Text(lesson['title_en']),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/lesson',
                arguments: {
                  'subjectId': subjectId,
                  'lessonId': lesson['id'],
                },
              );
            },
          );
        },
      ),
    );
  }
}
