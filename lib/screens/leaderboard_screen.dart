import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaderboard"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: CircleAvatar(child: Text("1")),
            title: Text("Player 1"),
            trailing: Text("Score: 95"),
          ),
          ListTile(
            leading: CircleAvatar(child: Text("2")),
            title: Text("Player 2"),
            trailing: Text("Score: 85"),
          ),
          ListTile(
            leading: CircleAvatar(child: Text("3")),
            title: Text("Player 3"),
            trailing: Text("Score: 75"),
          ),
        ],
      ),
    );
  }
}

