import 'package:flutter/material.dart';

class AssignmentsScreen extends StatelessWidget {
  const AssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final subjectName = args?['name'] ?? "Subject";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        title: Text("$subjectName - Assignments"),
      ),
      body: const Center(
        child: Text(
          "Assignments will appear here ✍️",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
