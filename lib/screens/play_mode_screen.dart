import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class ScoreCardScreen extends StatefulWidget {
  final String playerName; // 👈 Added
  final int score;
  final int total;
  final List<Map<String, dynamic>> answers; // question, userAnswer, correctAnswer, isCorrect
  final Duration timeTaken; // 👈 Added

  const ScoreCardScreen({
    super.key,
    required this.playerName,
    required this.score,
    required this.total,
    required this.answers,
    required this.timeTaken,
  });

  @override
  State<ScoreCardScreen> createState() => _ScoreCardScreenState();
}

class _ScoreCardScreenState extends State<ScoreCardScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));

    if (widget.score > widget.total / 2) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double percentage = (widget.score / widget.total) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Scorecard"),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // 🎯 Title
                      Text(
                        "🎯 Quiz Completed!",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 10),

                      // 👤 Player name
                      Text(
                        "Player: ${widget.playerName}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // 🕒 Time Taken
                      Text(
                        "Time Taken: ${widget.timeTaken.inSeconds} sec",
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),

                      // 📊 Score
                      Text(
                        "${widget.score} / ${widget.total}",
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              color: Colors.orange,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "(${percentage.toStringAsFixed(1)}%)",
                        style: const TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),

                      // 🏆 Badge / Status
                      if (percentage >= 80)
                        Column(
                          children: [
                            const Icon(Icons.emoji_events, color: Colors.amber, size: 80),
                            Text(
                              "🏆 Champion!",
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: Colors.amber[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        )
                      else if (percentage >= 50)
                        Column(
                          children: [
                            const Icon(Icons.military_tech, color: Colors.blue, size: 80),
                            Text(
                              "🥈 Well Done!",
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            const Icon(Icons.bolt, color: Colors.red, size: 80),
                            Text(
                              "⚡ Keep Practicing!",
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),

                      const Divider(thickness: 2),

                      // ✅ List of answers
                      ...widget.answers.map(
                        (answer) => Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          color: answer['isCorrect'] ? Colors.green[100] : Colors.red[100],
                          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                          child: ListTile(
                            leading: Icon(
                              answer['isCorrect'] ? Icons.check_circle : Icons.cancel,
                              color: answer['isCorrect'] ? Colors.green : Colors.red,
                              size: 30,
                            ),
                            title: Text(
                              answer['question'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Your Answer: ${answer['userAnswer']}"),
                            trailing: answer['isCorrect']
                                ? const Icon(Icons.thumb_up, color: Colors.green)
                                : Text(
                                    "✔ ${answer['correctAnswer']}",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),

              // 🎮 Go to Leaderboard button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, "/leaderboard");
                  },
                  icon: const Icon(Icons.leaderboard, color: Colors.white),
                  label: const Text(
                    "Go to Leaderboard",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 🎉 Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0.05,
              numberOfParticles: 25,
              gravity: 0.3,
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.purple,
                Colors.orange,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
