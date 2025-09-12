import 'package:flutter/material.dart';

class QuizSubjectScreen extends StatelessWidget {
  final List<Map<String, dynamic>> subjects = [
    {"name": "English", "icon": Icons.menu_book, "color": Colors.blue.shade200},
    {"name": "Punjabi", "icon": Icons.book, "color": Colors.green.shade200},
    {"name": "Physics", "icon": Icons.science, "color": Colors.orange.shade200},
    {"name": "Chemistry", "icon": Icons.bubble_chart, "color": Colors.purple.shade200},
    {"name": "Maths", "icon": Icons.calculate, "color": Colors.teal.shade200},
    {"name": "History", "icon": Icons.history_edu, "color": Colors.red.shade200},
    {"name": "Geography", "icon": Icons.public, "color": Colors.indigo.shade200},
    {"name": "Social Studies", "icon": Icons.people, "color": Colors.brown.shade200},
  ];

  QuizSubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose a Subject"),
        backgroundColor: Colors.teal.shade700,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: subjects.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/quizOptions',
                arguments: subject["name"],
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: subject["color"],
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 3),
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Icon(
                      subject["icon"],
                      size: 28,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      subject["name"],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
