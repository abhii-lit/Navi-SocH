import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/data_service.dart';

class AppState extends ChangeNotifier {
  Map<String, dynamic> _data = {};
  String language = 'en'; // 'en' or 'pa'
  Map<String, int> progress = {};
  SharedPreferences? prefs;

  // ✅ track the user-selected class
  String? selectedClass;

  // ✅ track login state
  bool _loggedIn = false;
  bool get isLoggedIn => _loggedIn;

  // ✅ track user role (student/teacher)
  String _userRole = 'student'; // default
  String get userRole => _userRole;

  Map<String, dynamic> get data => _data;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    _data = await DataService.loadData();

    // Restore saved language
    language = prefs?.getString('language') ?? 'en';

    // Restore saved progress
    final pStr = prefs?.getString('progress') ?? '{}';
    try {
      final Map parsed = jsonDecode(pStr) as Map;
      progress = parsed.map(
        (k, v) => MapEntry(k.toString(), (v as num).toInt()),
      );
    } catch (e) {
      progress = {};
    }

    // Restore saved class if available
    selectedClass = prefs?.getString('selectedClass');

    // ✅ Restore login state & role
    _loggedIn = prefs?.getBool('loggedIn') ?? false;
    _userRole = prefs?.getString('userRole') ?? 'student';

    notifyListeners();
  }

  void setLanguage(String lang) {
    language = lang;
    prefs?.setString('language', lang);
    notifyListeners();
  }

  // ✅ Save the chosen class
  void setSelectedClass(String c) {
    selectedClass = c;
    prefs?.setString('selectedClass', c);
    notifyListeners();
  }

  List<dynamic> getSubjects() {
    return (_data['subjects'] as List<dynamic>?) ?? [];
  }

  List<dynamic> getLessons(String subjectId) {
    final subs = getSubjects();
    for (final s in subs) {
      if (s['id'] == subjectId) {
        return (s['lessons'] as List<dynamic>?) ?? [];
      }
    }
    return [];
  }

  dynamic getLesson(String subjectId, String lessonId) {
    final lessons = getLessons(subjectId);
    for (final l in lessons) {
      if (l['id'] == lessonId) return l;
    }
    return null;
  }

  void saveScore(String key, int score) {
    progress[key] = score;
    prefs?.setString('progress', jsonEncode(progress));
    notifyListeners();
  }

  int getScore(String key) => progress[key] ?? 0;

  /// Simple FAQ matching
  Map<String, String> findFaqAnswer(String query) {
    final faqs = (_data['faq'] as List<dynamic>?) ?? [];
    final qLower = query.toLowerCase().trim();
    for (final f in faqs) {
      final qEn = (f['q_en'] as String).toLowerCase();
      final qPa = (f['q_pa'] as String).toLowerCase();
      if (qLower.contains(qEn) ||
          qLower.contains(qPa) ||
          qEn.contains(qLower) ||
          qPa.contains(qLower)) {
        return {
          'en': f['a_en'] as String,
          'pa': f['a_pa'] as String,
        };
      }
    }
    return {
      'en': "Sorry, I don't know yet.",
      'pa': "ਮਾਫ਼ ਕਰੋ, ਮੈਨੂੰ ਇਹ ਜਾਣਕਾਰੀ ਨਹੀਂ ਹੈ।",
    };
  }

  // ✅ Login with role
  Future<void> login({String role = 'student'}) async {
    _loggedIn = true;
    _userRole = role;
    await prefs?.setBool('loggedIn', true);
    await prefs?.setString('userRole', role);
    notifyListeners();
  }

  // ✅ Logout
  Future<void> signOut() async {
    // clear prefs but keep login flag false
    await prefs?.clear();
    await prefs?.setBool('loggedIn', false);

    // reset local state
    language = 'en';
    progress = {};
    selectedClass = null;
    _loggedIn = false;
    _userRole = 'student';

    notifyListeners();
  }
}
