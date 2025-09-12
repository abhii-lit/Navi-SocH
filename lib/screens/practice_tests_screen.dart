import 'package:flutter/material.dart';

class PracticeTestsScreen extends StatelessWidget {
  const PracticeTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final practiceTests = [
      "Test 1: English Basics",
      "Test 2: Punjabi Basics",
      "Test 3: Physics Basics",
      "Test 4: Chemistry Basics",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Practice Tests")),
      body: ListView.builder(
        itemCount: practiceTests.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(practiceTests[index]),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Later link to real test screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Opening ${practiceTests[index]}...")),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
