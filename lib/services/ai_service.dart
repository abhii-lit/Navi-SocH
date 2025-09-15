// lib/services/ai_service.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AIService {
  final String _apiKey;
  final String _baseUrl;
  late Map<String, String> _localFaq;

  AIService._(this._apiKey, this._baseUrl, this._localFaq);

  /// Factory method to create AIService using .env + load local FAQ
  static Future<AIService> create() async {
    final apiKey = dotenv.env['API_KEY'];
    final baseUrl = dotenv.env['BASE_URL'] ?? "https://api.openai.com/v1";

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception("⚠️ API_KEY is missing in .env file");
    }

    // ✅ Load local chatbot_faq.json
    final String jsonString =
        await rootBundle.loadString("assets/chatbot_faq.json");
    final List<dynamic> dataList = json.decode(jsonString);

    final Map<String, String> faq = {
      for (var item in dataList)
        item['question'].toString().toLowerCase(): item['answer'].toString()
    };

    return AIService._(apiKey, baseUrl, faq);
  }

  /// Get chatbot response: local first, fallback to OpenAI
  Future<Map<String, String>> getResponse(String message) async {
    final normalizedQuery = message.toLowerCase();

    // 🔹 Step 1: Check local FAQ
    for (var entry in _localFaq.entries) {
      if (normalizedQuery.contains(entry.key)) {
        return {
          "source": "local",
          "text": entry.value,
        };
      }
    }

    // 🔹 Step 2: If not found, call OpenAI
    final url = Uri.parse("$_baseUrl/chat/completions");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_apiKey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "system",
              "content": "You are Navi SocH, a helpful rural learning assistant."
            },
            {"role": "user", "content": message},
          ],
          "max_tokens": 150,
          "temperature": 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply =
            data["choices"]?[0]?["message"]?["content"]?.trim();

        return {
          "source": "ai",
          "text": reply ?? "⚠️ No response from AI.",
        };
      } else {
        return {
          "source": "error",
          "text": "❌ Error ${response.statusCode}: ${response.body}",
        };
      }
    } catch (e) {
      return {
        "source": "error",
        "text": "⚠️ Failed to connect to AI service: $e",
      };
    }
  }
}
