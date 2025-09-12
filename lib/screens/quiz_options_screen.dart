import 'package:flutter/material.dart';

class QuizOptionsScreen extends StatelessWidget {
  final String subject;

  const QuizOptionsScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz: $subject")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              "Choose Mode",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 40),

            // Practice card
            _buildOptionCard(
              context,
              title: "Practice Mode",
              subtitle: "Take practice tests at your own pace",
              icon: Icons.school,
              color: Colors.blue.shade100,
              onTap: () => Navigator.pushNamed(context, '/practice'),
            ),

            const SizedBox(height: 20),

            // Play card
            _buildOptionCard(
              context,
              title: "Play Mode",
              subtitle: "Gamified learning with badges & leaderboard",
              icon: Icons.videogame_asset,
              color: Colors.green.shade100,
              onTap: () => Navigator.pushNamed(context, '/play'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.teal),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade700)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.teal),
            ],
          ),
        ),
      ),
    );
  }
}
