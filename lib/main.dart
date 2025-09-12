// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

// Import your screens
import 'screens/home_screen.dart';
import 'screens/lesson_screen.dart'; // lessons with 4 options (lectures/notes/quiz/assignments)
import 'screens/quiz_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/chatbot_screen.dart';
import 'screens/login_screen.dart';
import 'screens/credential_login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/lectures_screen.dart';
import 'screens/notes_screen.dart';
import 'screens/assignments_screen.dart';
import 'screens/practice_tests_screen.dart';
import 'screens/play_mode_screen.dart'; // contains PlayMScreen
import 'screens/leaderboard_screen.dart';
import 'screens/play_quiz_screen.dart';


// Quiz flow screens
import 'screens/quiz_subject_screen.dart';
import 'screens/quiz_options_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appState = AppState();
  await appState.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => appState,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        return MaterialApp(
          title: 'Rural Learning',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),

          // start screen based on login state
          home: appState.isLoggedIn ? const HomeScreen() : const LoginScreen(),

          routes: {
            // Auth routes
            '/login': (_) => const LoginScreen(),
            '/loginCredentials': (_) => const CredentialLoginScreen(),

            // Main navigation
            '/home': (_) => const HomeScreen(),
            '/lessons': (_) => const LessonScreen(),

            // NOTE: '/quizzes' is from side-menu -> show subjects first
            '/quizzes': (_) => QuizSubjectScreen(),

            // the actual quiz-taking screen (expects subjectId/lessonId args)
            '/quiz': (_) => QuizScreen(),

            '/progress': (_) => ProgressScreen(),
            '/chatbot': (_) => ChatbotScreen(),
            '/profile': (_) => const ProfileScreen(),
            '/editProfile': (_) => const EditProfileScreen(),

            // Lesson sub-pages
            '/lectures': (_) => const LecturesScreen(),
            '/notes': (_) => const NotesScreen(),
            '/assignments': (_) => const AssignmentsScreen(),

            // practice/play screens
            '/practice': (_) => const PracticeTestsScreen(),
            '/play': (_) => PlayQuizScreen(
  playerName: "Guest",
  questions: [
    {
      "question": "2 + 2 = ?",
      "options": ["3", "4", "5", "6"],
      "answer": "4",
    },
    {
      "question": "Capital of India?",
      "options": ["Mumbai", "Delhi", "Chennai", "Kolkata"],
      "answer": "Delhi",
    },
    {
      "question": "5 × 3 = ?",
      "options": ["8", "15", "20", "12"],
      "answer": "15",
    },
  ],
),


            '/leaderboard': (_) => const LeaderboardScreen(),
          },

          // Use onGenerateRoute for routes that need access to runtime arguments
          onGenerateRoute: (settings) {
            // quizOptions requires a subject string argument
            if (settings.name == '/quizOptions') {
              final subject = settings.arguments as String? ?? 'Unknown Subject';
              return MaterialPageRoute(
                builder: (_) => QuizOptionsScreen(subject: subject),
                settings: settings,
              );
            }
            // fallback (if not matched)
            return null;
          },
        );
      },
    );
  }
}
