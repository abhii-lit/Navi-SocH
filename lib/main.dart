import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/lesson_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/chatbot_screen.dart';
import 'screens/credential_login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/lectures_screen.dart';
import 'screens/notes_screen.dart';
import 'screens/assignments_screen.dart';
import 'screens/practice_tests_screen.dart';
import 'screens/play_mode_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/play_quiz_screen.dart';

// Quiz flow
import 'screens/quiz_subject_screen.dart';
import 'screens/quiz_options_screen.dart';

// Teacher
import 'screens/teacher/teacher_dashboard.dart';
import 'screens/teacher/teacher_login_screen.dart';

// Role Selection
import 'screens/role_selection_screen.dart';

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
          title: "Navi SocH",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),

          // ✅ Always start from Role Selection
          home: const RoleSelectionScreen(),

          routes: {
            // Role selection
            '/roleSelection': (_) => const RoleSelectionScreen(),

            // Teacher flow
            '/teacherLogin': (_) => const TeacherLoginScreen(),
            '/teacherDashboard': (_) => const TeacherDashboard(),

            // Student flow
            '/loginCredentials': (_) => const CredentialLoginScreen(),
            '/home': (_) => const HomeScreen(),

            // Lessons
            '/lessons': (_) => const LessonScreen(),
            '/lectures': (_) => const LecturesScreen(),
            '/notes': (_) => const NotesScreen(),
            '/assignments': (_) => const AssignmentsScreen(),

            // Quizzes
            '/quizzes': (_) => QuizSubjectScreen(),
            '/quiz': (_) => QuizScreen(),

            // Progress & chatbot
            '/progress': (_) => const ProgressScreen(),
            '/chatbot': (_) => ChatbotScreen(), // ✅ FIXED (no const)

            // Profile
            '/profile': (_) => const ProfileScreen(),
            '/editProfile': (_) => const EditProfileScreen(),

            // Practice/Play
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

          // For routes needing arguments
          onGenerateRoute: (settings) {
            if (settings.name == '/quizOptions') {
              final subject = settings.arguments as String? ?? 'Unknown Subject';
              return MaterialPageRoute(
                builder: (_) => QuizOptionsScreen(subject: subject),
                settings: settings,
              );
            }
            return null;
          },
        );
      },
    );
  }
}
