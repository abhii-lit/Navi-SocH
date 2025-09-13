// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  IconData _iconForSubject(String id) {
    switch (id) {
      case 'english':
        return Icons.menu_book;
      case 'punjabi':
        return Icons.translate;
      case 'physics':
        return Icons.science;
      case 'chemistry':
        return Icons.biotech;
      case 'maths':
        return Icons.calculate;
      case 'history':
        return Icons.history_edu;
      case 'geography':
        return Icons.public;
      case 'social':
        return Icons.group;
      default:
        return Icons.book;
    }
  }

  Color _colorForSubject(String id) {
    switch (id) {
      case 'english':
        return Colors.lightBlue.shade100;
      case 'punjabi':
        return Colors.orange.shade100;
      case 'physics':
        return Colors.green.shade100;
      case 'chemistry':
        return Colors.teal.shade100;
      case 'maths':
        return Colors.purple.shade100;
      case 'history':
        return Colors.brown.shade100;
      case 'geography':
        return Colors.lightGreen.shade100;
      case 'social':
        return Colors.pink.shade100;
      default:
        return Colors.blueGrey.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final language = appState.language;

    final subjectsFromJson = appState.getSubjects();
    final fallbackSubjects = [
      {'id': 'english', 'name_en': 'English', 'name_pa': 'ਅੰਗਰੇਜ਼ੀ'},
      {'id': 'punjabi', 'name_en': 'Punjabi', 'name_pa': 'ਪੰਜਾਬੀ'},
      {'id': 'physics', 'name_en': 'Physics', 'name_pa': 'ਭੌਤਿਕ ਵਿਗਿਆਨ'},
      {'id': 'chemistry', 'name_en': 'Chemistry', 'name_pa': 'ਰਸਾਇਣ ਵਿਗਿਆਨ'},
      {'id': 'maths', 'name_en': 'Maths', 'name_pa': 'ਗਣਿਤ'},
      {'id': 'history', 'name_en': 'History', 'name_pa': 'ਇਤਿਹਾਸ'},
      {'id': 'geography', 'name_en': 'Geography', 'name_pa': 'ਭੂਗੋਲ'},
      {'id': 'social', 'name_en': 'Social Studies', 'name_pa': 'ਸਮਾਜਿਕ ਅਧਿਐਨ'},
    ];

    final subjects = subjectsFromJson.isNotEmpty ? subjectsFromJson : fallbackSubjects;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
        centerTitle: true,
        title: const Text(
          "Navi SocH",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: LanguageToggle(),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade50, Colors.lightBlue.shade50],
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

              final id = subject['id'] as String;
              final color = _colorForSubject(id);
              final icon = _iconForSubject(id);

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/lessons',
                    arguments: {'subjectId': id, 'name': title},
                  );
                },
                child: Card(
                  color: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, size: 38, color: Colors.teal.shade700),
                        const SizedBox(height: 10),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orangeAccent,
        icon: const Icon(Icons.chat_bubble_outline),
        label: const Text("Ask Navi"),
        onPressed: () => Navigator.pushNamed(context, '/chatbot'),
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
            accountName: Text("Navi SocH"),
            accountEmail: Text("Welcome Student!"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.school, size: 40, color: Colors.teal),
            ),
          ),
          _drawerItem(context, Icons.home, "Home", '/home'),
          _drawerItem(context, Icons.person, "Profile", '/profile'),
          _drawerItem(context, Icons.quiz, "Quizzes", '/quizzes'),
          _drawerItem(context, Icons.book, "Exams", '/exams'),
          _drawerItem(context, Icons.show_chart, "Progress", '/progress'),
          _drawerItem(context, Icons.help_outline, "FAQs", '/faqs'),
          _drawerItem(context, Icons.support_agent, "Support", '/support'),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Sign Out"),
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

  Widget _drawerItem(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
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
                color: appState.language == 'en' ? Colors.white : Colors.white70,
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
                color: appState.language == 'pa' ? Colors.white : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
