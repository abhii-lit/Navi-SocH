import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class DataService {
  static Future<Map<String, dynamic>> loadData() async {
    final s = await rootBundle.loadString('assets/data.json');
    return jsonDecode(s) as Map<String, dynamic>;
  }
}
