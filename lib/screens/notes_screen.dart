import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final subjectName = args?['name'] ?? "Subject";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        title: Text("$subjectName - Notes"),
      ),
      body: const Center(
        child: Text(
          "Notes and PDFs will appear here 📒",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
