import 'package:flutter/material.dart';
import 'score_card_screen.dart';

class PlayQuizScreen extends StatefulWidget {
  final String playerName;
  final List<Map<String, dynamic>> questions;

  const PlayQuizScreen({
    super.key,
    required this.playerName,
    required this.questions,
  });

  @override
  State<PlayQuizScreen> createState() => _PlayQuizScreenState();
}

class _PlayQuizScreenState extends State<PlayQuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  List<Map<String, dynamic>> _answers = [];

  void _answerQuestion(String selected) {
    final currentQ = widget.questions[_currentIndex];
    final isCorrect = selected == currentQ["answer"];

    if (isCorrect) _score++;

    _answers.add({
      "question": currentQ["question"],
      "userAnswer": selected,
      "correctAnswer": currentQ["answer"],
      "isCorrect": isCorrect,
    });

    if (_currentIndex < widget.questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ScoreCardScreen(
            playerName: widget.playerName,
            score: _score,
            total: widget.questions.length,
            answers: _answers,
          ),
        ),
      ).then((result) {
        if (result == "playAgain") {
          // 🔁 Restart quiz
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => PlayQuizScreen(
                playerName: widget.playerName,
                questions: widget.questions,
              ),
            ),
          );
        } else if (result == "leaderboard") {
          // 🏆 Go to leaderboard
          Navigator.pushReplacementNamed(context, "/leaderboard");
        } else if (result == "home") {
          // 🏠 Go back to home
          Navigator.pushReplacementNamed(context, "/home");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQ = widget.questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Quiz - ${widget.playerName}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Question ${_currentIndex + 1} of ${widget.questions.length}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              currentQ["question"],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            ...currentQ["options"].map<Widget>((opt) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: ListTile(
                  title: Text(opt),
                  onTap: () => _answerQuestion(opt),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
