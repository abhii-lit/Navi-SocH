import 'package:flutter/material.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

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
    final subjectIcon = args['icon'] as String?;

    // ✅ Fixed Lesson options (4 items)
    final lessonOptions = [
      {
        "title": "📖 Lectures",
        "route": "/lectures",
        "color": Colors.teal.shade100,
      },
      {
        "title": "📝 Notes",
        "route": "/notes",
        "color": Colors.teal.shade200,
      },
      {
        "title": "❓ Quiz",
        "route": "/quiz",
        "color": Colors.teal.shade300,
      },
      {
        "title": "📂 Assignments",
        "route": "/assignments",
        "color": Colors.teal.shade400,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if (subjectIcon != null)
              Text(subjectIcon, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(subjectName),
          ],
        ),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: lessonOptions.length,
          itemBuilder: (context, i) {
            final option = lessonOptions[i];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  (option["route"] as String?) ?? '/unknown',
                  arguments: {
                    "subjectId": subjectId,
                    "subjectName": subjectName,
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: (option["color"] as Color?) ?? Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    (option["title"] as String?) ?? "No Title",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
