import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizOptions = [
      {
        "title": "Practice",
        "route": "/practice",
        "icon": Icons.school,
        "color": Colors.teal.shade100,
      },
      {
        "title": "Play (Gamified)",
        "route": "/play",
        "icon": Icons.videogame_asset_rounded,
        "color": Colors.orange.shade100,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quizzes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade700,
        elevation: 4,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade50, Colors.lightBlue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
            itemCount: quizOptions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, i) {
              final option = quizOptions[i];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  option["route"] as String,
                ),
                child: Card(
                  color: option["color"] as Color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 6,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          option["icon"] as IconData,
                          size: 48,
                          color: Colors.teal.shade700,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          option["title"] as String,
                          textAlign: TextAlign.center,
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
