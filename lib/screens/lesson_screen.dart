import 'package:flutter/material.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

  IconData _iconForLesson(String id) {
    switch (id) {
      case "lectures":
        return Icons.video_library;
      case "notes":
        return Icons.note_alt;
      case "quiz":
        return Icons.quiz;
      case "assignments":
        return Icons.assignment;
      default:
        return Icons.book;
    }
  }

  Color _colorForLesson(String id) {
    switch (id) {
      case "lectures":
        return Colors.blue.shade100;
      case "notes":
        return Colors.orange.shade100;
      case "quiz":
        return Colors.green.shade100;
      case "assignments":
        return Colors.purple.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Lessons")),
        body: const Center(child: Text("⚠️ No subject selected")),
      );
    }

    final subjectId = args['subjectId'] as String?;
    final subjectName = args['name'] as String? ?? "Unknown Subject";

    // ✅ Lesson options with IDs
    final lessonOptions = [
      {"id": "lectures", "title": "Lectures", "route": "/lectures"},
      {"id": "notes", "title": "Notes", "route": "/notes"},
      {"id": "quiz", "title": "Quiz", "route": "/quiz"},
      {"id": "assignments", "title": "Assignments", "route": "/assignments"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          subjectName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade50, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemCount: lessonOptions.length,
            itemBuilder: (context, i) {
              final option = lessonOptions[i];
              final id = option["id"] as String;
              final title = option["title"] as String;
              final route = option["route"] as String;

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    route,
                    arguments: {"subjectId": subjectId, "subjectName": subjectName},
                  );
                },
                child: Card(
                  color: _colorForLesson(id),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 4,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_iconForLesson(id),
                            size: 40, color: Colors.teal.shade700),
                        const SizedBox(height: 10),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
