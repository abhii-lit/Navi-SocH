import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _ctrl = TextEditingController();
  String _answer = '';

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(title: Text(appState.language == 'pa' ? 'ਚੈਟਬੋਟ' : 'Chatbot')),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: _answer.isEmpty
                  ? Center(child: Text(appState.language == 'pa' ? 'ਆਪਣੇ ਸਵਾਲ ਪੁੱਛੋ' : 'Ask your question'))
                  : Card(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(_answer, style: TextStyle(fontSize: 18)),
                      ),
                    ),
            ),
            Row(
              children: [
                Expanded(child: TextField(controller: _ctrl, decoration: InputDecoration(hintText: appState.language == 'pa' ? 'ਸਵਾਲ ਲਿਖੋ' : 'Type question'))),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final q = _ctrl.text.trim();
                    if (q.isEmpty) return;
                    final ans = appState.findFaqAnswer(q);
                    setState(() {
                      _answer = appState.language == 'pa' ? ans['pa'] ?? '' : ans['en'] ?? '';
                    });
                    _ctrl.clear();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
