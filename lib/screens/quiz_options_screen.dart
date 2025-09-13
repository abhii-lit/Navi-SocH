import 'package:flutter/material.dart';

class QuizOptionsScreen extends StatelessWidget {
  final String subject;

  const QuizOptionsScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final quizOptions = [
      {
        "title": "Practice Mode",
        "subtitle": "Take practice tests at your own pace",
        "icon": Icons.school,
        "color": Colors.blue.shade100,
        "route": "/practice",
      },
      {
        "title": "Play Mode",
        "subtitle": "Gamified learning with badges & leaderboard",
        "icon": Icons.videogame_asset_rounded,
        "color": Colors.green.shade100,
        "route": "/play",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz: $subject",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade700,
        centerTitle: true,
        elevation: 4,
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                "Choose Mode",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
              ),
              const SizedBox(height: 30),

              // Options list
              Expanded(
                child: ListView.separated(
                  itemCount: quizOptions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemBuilder: (context, i) {
                    final option = quizOptions[i];
                    return _buildOptionCard(
                      context,
                      title: option["title"] as String,
                      subtitle: option["subtitle"] as String,
                      icon: option["icon"] as IconData,
                      color: option["color"] as Color,
                      onTap: () =>
                          Navigator.pushNamed(context, option["route"] as String),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 6,
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(icon, size: 42, color: Colors.teal.shade700),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        )),
                    const SizedBox(height: 6),
                    Text(subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        )),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  color: Colors.teal.shade600, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
