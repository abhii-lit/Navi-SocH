import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class ScoreCardScreen extends StatefulWidget {
  final String playerName;
  final int score;
  final int total;
  final List<Map<String, dynamic>> answers; // question, userAnswer, correctAnswer, isCorrect

  const ScoreCardScreen({
    super.key,
    required this.playerName,
    required this.score,
    required this.total,
    required this.answers,
  });

  @override
  State<ScoreCardScreen> createState() => _ScoreCardScreenState();
}

class _ScoreCardScreenState extends State<ScoreCardScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));

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

                      // ✅ Show player name
                      Text(
                        "Player: ${widget.playerName}",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 20),

                      // 🎯 Score progress indicator
                      Center(
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: widget.score / widget.total,
                                strokeWidth: 12,
                                backgroundColor: Colors.grey.shade300,
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.teal),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${widget.score}/${widget.total}",
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${percentage.toStringAsFixed(1)}%",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 🏆 Badge
                      if (percentage >= 80)
                        Column(
                          children: [
                            const Icon(Icons.emoji_events,
                                color: Colors.amber, size: 80),
                            Text(
                              "🏆 Champion!",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: Colors.amber[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        )
                      else if (percentage >= 50)
                        Column(
                          children: [
                            const Icon(Icons.military_tech,
                                color: Colors.blue, size: 80),
                            Text(
                              "🥈 Well Done!",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            const Icon(Icons.bolt,
                                color: Colors.red, size: 80),
                            Text(
                              "⚡ Keep Practicing!",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
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
                          color: answer['isCorrect']
                              ? Colors.green[100]
                              : Colors.red[100],
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 16),
                          child: ListTile(
                            leading: Icon(
                              answer['isCorrect']
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: answer['isCorrect']
                                  ? Colors.green
                                  : Colors.red,
                              size: 30,
                            ),
                            title: Text(
                              answer['question'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                "Your Answer: ${answer['userAnswer'] ?? "—"}"),
                            trailing: answer['isCorrect']
                                ? const Icon(Icons.thumb_up,
                                    color: Colors.green)
                                : Text(
                                    "✔ ${answer['correctAnswer'] ?? "—"}",
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),

              // 🎮 Action buttons
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context, "playAgain"); // 🔹 back signal
                      },
                      icon: const Icon(Icons.replay, color: Colors.white),
                      label: const Text(
                        "Play Again",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context,
                            "leaderboard"); // 🔹 back signal to leaderboard
                      },
                      icon: const Icon(Icons.leaderboard, color: Colors.white),
                      label: const Text(
                        "Go to Leaderboard",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context,
                            "home"); // 🔹 back signal to home
                      },
                      icon: const Icon(Icons.home, color: Colors.white),
                      label: const Text(
                        "Back to Home",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
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
