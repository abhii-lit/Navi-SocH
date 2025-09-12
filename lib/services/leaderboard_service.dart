class LeaderboardService {
  static final List<Map<String, dynamic>> _leaderboard = [];

  /// Save score
  static void addScore(String name, int score, int total, Duration timeTaken) {
    _leaderboard.add({
      "name": name,
      "score": score,
      "total": total,
      "time": timeTaken.inSeconds,
    });

    // Sort: higher score first, then faster time
    _leaderboard.sort((a, b) {
      if (b["score"] == a["score"]) {
        return a["time"].compareTo(b["time"]);
      }
      return b["score"].compareTo(a["score"]);
    });
  }

  /// Get leaderboard list
  static List<Map<String, dynamic>> getLeaderboard() {
    return _leaderboard;
  }
}
