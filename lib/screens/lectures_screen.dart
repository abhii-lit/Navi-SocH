// lib/screens/lectures_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import 'video_player_screen.dart';

class LecturesScreen extends StatelessWidget {
  const LecturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final subjectId = args?['subjectId'] as String?;
    final subjectName = args?['subjectName'] as String? ?? 'Lectures';

    if (subjectId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Lectures')),
        body: const Center(child: Text('No subject selected')),
      );
    }

    final appState = Provider.of<AppState>(context);
    final lessons = appState.getLessons(subjectId);

    // Build a flat list of lectures: either nested lesson['lectures'] or lesson-level video_url
    final List<Map<String, String>> lectureList = [];
    for (final lesson in lessons) {
      // If lesson has a nested "lectures" array with {title, url}
      if (lesson is Map && lesson['lectures'] is List) {
        for (final l in (lesson['lectures'] as List)) {
          lectureList.add({
            'title': l['title']?.toString() ?? (lesson['title_en'] ?? 'Lecture').toString(),
            'url': l['url']?.toString() ?? '',
            'lessonId': lesson['id']?.toString() ?? '',
          });
        }
      } else {
        // fallback: if lesson has single "video_url"
        final url = lesson['video_url']?.toString();
        if (url != null && url.isNotEmpty) {
          lectureList.add({
            'title': (lesson['title_en'] ?? lesson['title_pa'] ?? 'Lecture').toString(),
            'url': url,
            'lessonId': lesson['id']?.toString() ?? '',
          });
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Lectures - $subjectName')),
      body: lectureList.isEmpty
          ? const Center(child: Text('No lectures available'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: lectureList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final lec = lectureList[i];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.play_circle_fill, size: 40, color: Colors.teal),
                    title: Text(lec['title'] ?? 'Lecture'),
                    subtitle: Text(lec['url'] ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
                    onTap: () {
                      final videoUrl = lec['url'] ?? '';
                      if (videoUrl.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No video URL for this lecture')),
                        );
                        return;
                      }
                      // open the video player
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VideoPlayerScreen(
                            title: lec['title'] ?? 'Lecture',
                            videoUrl: videoUrl,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
