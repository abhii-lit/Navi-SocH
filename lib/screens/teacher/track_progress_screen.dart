import 'package:flutter/material.dart';

class TrackProgressScreen extends StatelessWidget {
  const TrackProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data; replace with Firestore query
    final students = [
      {'name': 'Amit Sharma', 'progress': 0.75},
      {'name': 'Neha Verma', 'progress': 0.40},
      {'name': 'Rahul Singh', 'progress': 0.90},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Student Progress'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final s = students[index];
          final progress = (s['progress'] as double?) ?? 0.0; // ✅ null-safe
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                s['name'] as String,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4), // ✅ apply radius here
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Progress: ${(progress * 100).toStringAsFixed(0)}%',
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  // TODO: Navigate to detailed report page if needed
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
