// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Color _colorForSubject(Map subj) {
    // If JSON provides a color as hex string (optional), parse it here.
    final c = subj['color'];
    if (c is String && c.startsWith('#')) {
      try {
        // convert "#RRGGBB" or "#AARRGGBB" to Color
        final hex = c.replaceFirst('#', '');
        final intVal = int.parse(hex, radix: 16);
        return hex.length == 6 ? Color(0xFF000000 | intVal) : Color(intVal);
      } catch (e) {
        // fall through to default mapping
      }
    }

    // default mapping by id
    switch (subj['id']) {
      case 'english':
        return Colors.lightBlueAccent;
      case 'punjabi':
        return Colors.orangeAccent;
      case 'physics':
        return Colors.greenAccent;
      case 'chemistry':
        return Colors.tealAccent;
      case 'maths':
        return Colors.purpleAccent;
      case 'history':
        return Colors.brown.shade300;
      case 'geography':
        return Colors.lightGreenAccent;
      case 'social':
        return Colors.pinkAccent;
      default:
        return Colors.blueGrey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final language = appState.language;

    // get subjects from AppState (loaded from assets/data.json)
    final subjectsFromJson = appState.getSubjects();

    // Debug: confirm how many subjects loaded
    // Check debug console to make sure data.json was read.
    // (Remove/disable in production)
    // ignore: avoid_print
    print('DEBUG: loaded subjects count = ${subjectsFromJson.length}');

    // fallback if JSON is empty (keeps UI alive while assets are fixed)
    final fallbackSubjects = [
      {
        'id': 'english',
        'name_en': 'English',
        'name_pa': 'ਅੰਗਰੇਜ਼ੀ',
        'icon': '📘',
      },
      {
        'id': 'punjabi',
        'name_en': 'Punjabi',
        'name_pa': 'ਪੰਜਾਬੀ',
        'icon': '📙',
      },
      {
        'id': 'physics',
        'name_en': 'Physics',
        'name_pa': 'ਭੌਤਿਕ ਵਿਗਿਆਨ',
        'icon': '🧲',
      },
      {
        'id': 'chemistry',
        'name_en': 'Chemistry',
        'name_pa': 'ਰਸਾਇਣ ਵਿਗਿਆਨ',
        'icon': '🧪',
      },
      {
        'id': 'maths',
        'name_en': 'Maths',
        'name_pa': 'ਗਣਿਤ',
        'icon': '➗',
      },
      {
        'id': 'history',
        'name_en': 'History',
        'name_pa': 'ਇਤਿਹਾਸ',
        'icon': '📜',
      },
      {
        'id': 'geography',
        'name_en': 'Geography',
        'name_pa': 'ਭੂਗੋਲ',
        'icon': '🌍',
      },
      {
        'id': 'social',
        'name_en': 'Social Studies',
        'name_pa': 'ਸਮਾਜਿਕ ਅਧਿਐਨ',
        'icon': '👥',
      },
    ];

    final subjects = subjectsFromJson.isNotEmpty ? subjectsFromJson : fallbackSubjects;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rural Learning'),
        backgroundColor: Colors.teal,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: LanguageToggle(),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            itemCount: subjects.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, i) {
              final subject = subjects[i] as Map<String, dynamic>;
              final title = language == 'pa'
                  ? (subject['name_pa'] as String? ?? subject['name_en'] as String)
                  : (subject['name_en'] as String? ?? subject['name_pa'] as String);
              final color = _colorForSubject(subject);

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/lessons',
                    arguments: {
                      'subjectId': subject['id'],
                      'name': title,
                      'icon': subject['icon'] ?? '📘',
                    },
                  );
                },
                child: Card(
                  color: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 6,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          (subject['icon'] ?? '📘') as String,
                          style: const TextStyle(fontSize: 42),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        tooltip: 'Chatbot (FAQ)',
        onPressed: () => Navigator.pushNamed(context, '/chatbot'),
        child: const Icon(Icons.chat_bubble_outline),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            accountName: Text("Rural Learning"),
            accountEmail: Text("Welcome!"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.school, size: 40, color: Colors.teal),
            ),
          ),
          _drawerItem(context, "🏠 Home", '/home'),
          _drawerItem(context, "👩‍🎓 Profile", '/profile'),
          _drawerItem(context, "📝 Quizzes", '/quizzes'),
          _drawerItem(context, "🎓 Exams", '/exams'),
          _drawerItem(context, "📈 Progress", '/progress'),
          _drawerItem(context, "❓ FAQs", '/faqs'),
          _drawerItem(context, "🤝 Support", '/support'),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("🚪 Sign Out"),
            onTap: () async {
              final appState = Provider.of<AppState>(context, listen: false);
              await appState.signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context, String title, String route) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Row(
      children: [
        GestureDetector(
          onTap: () => appState.setLanguage('en'),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'EN',
              style: TextStyle(
                color: appState.language == 'en'
                    ? Colors.white
                    : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => appState.setLanguage('pa'),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'ਪੰਜਾਬੀ',
              style: TextStyle(
                color: appState.language == 'pa'
                    ? Colors.white
                    : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
