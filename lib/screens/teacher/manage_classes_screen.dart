// lib/screens/teacher/manage_classes_screen.dart
import 'package:flutter/material.dart';

class ManageClassesScreen extends StatelessWidget {
  const ManageClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "List / Create / Edit Classes",
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

// lib/screens/teacher/upload_content_screen.dart
class UploadContentScreen extends StatelessWidget {
  const UploadContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Upload Videos / PDFs / Quizzes",
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

// lib/screens/teacher/track_progress_screen.dart
class TrackProgressScreen extends StatelessWidget {
  const TrackProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "View Reports & Student Scores",
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
