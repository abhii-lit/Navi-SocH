// lib/screens/teacher/teacher_dashboard.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard>
    with SingleTickerProviderStateMixin {
  bool _isChatOpen = false;
  late AnimationController _glowController;

  final List<Map<String, dynamic>> dashboardItems = [
    {
      "icon": Icons.check_circle,
      "label": "Mark Attendance",
      "route": "/attendance",
      "color": Colors.green
    },
    {
      "icon": Icons.bar_chart,
      "label": "Student Progress",
      "route": "/trackProgress",
      "color": Colors.blue
    },
    {
      "icon": Icons.assignment,
      "label": "Upload Assignments",
      "route": "/uploadAssignments",
      "color": Colors.orange
    },
    {
      "icon": Icons.book,
      "label": "Upload Notes",
      "route": "/uploadNotes",
      "color": Colors.purple
    },
    {
      "icon": Icons.video_library,
      "label": "Upload Videos",
      "route": "/uploadVideos",
      "color": Colors.red
    },
    {
      "icon": Icons.school,
      "label": "Upload Results",
      "route": "/uploadResults",
      "color": Colors.teal
    },
    {
      "icon": Icons.feedback,
      "label": "Student Feedback",
      "route": "/feedback",
      "color": Colors.indigo
    },
  ];

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
        centerTitle: true,
        title: AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            final glow = 6 + 6 * _glowController.value;
            return Text(
              "Navi SocH",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.tealAccent.withOpacity(0.9),
                    blurRadius: glow,
                  ),
                  const Shadow(
                    color: Colors.black38,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            );
          },
        ),
      ),

      // 🔹 Drawer
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              accountName: const Text("Teacher Name"),
              accountEmail: const Text("teacher@email.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.teal),
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.home,
              label: "Home",
              route: "/teacherDashboard",
            ),
            _buildDrawerItem(
              context,
              icon: Icons.person,
              label: "Profile",
              route: "/profile",
            ),
            _buildDrawerItem(
              context,
              icon: Icons.help,
              label: "FAQs",
              route: "/progress", // ⚠️ updated (placeholder)
            ),
            _buildDrawerItem(
              context,
              icon: Icons.support,
              label: "Support",
              route: "/chatbot", // ⚠️ updated
            ),
            _buildDrawerItem(
              context,
              icon: Icons.chat,
              label: "Chatbot",
              route: "/chatbot",
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Sign Out"),
              onTap: () async {
                await appState.signOut();
                if (mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/roleSelection", // ✅ fixed
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),

      // 🔹 Dashboard Body
      body: Stack(
        children: [
          Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade400, Colors.teal.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: const Text(
                  "Welcome, Teacher 👩‍🏫\nManage your class, students and resources easily",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Dashboard Grid
              Expanded(
                child: GridView.builder(
                  itemCount: dashboardItems.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final item = dashboardItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, item['route'] as String);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              (item['color'] as Color).withOpacity(0.8),
                              (item['color'] as Color).withOpacity(0.6),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: (item['color'] as Color).withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Icon(
                                item['icon'] as IconData,
                                size: 30,
                                color: item['color'] as Color,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item['label'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // Floating Chatbot
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (_isChatOpen) _buildChatPopup(),
                GestureDetector(
                  onTap: () => setState(() => _isChatOpen = !_isChatOpen),
                  child: _buildChatButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon, required String label, required String route}) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(label),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }

  Widget _buildChatPopup() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 280,
      height: 350,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(4, 6),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Navi Bot 🤖",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.teal,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () => setState(() => _isChatOpen = false),
              ),
            ],
          ),
          const Divider(),
          const Expanded(
            child: Center(
              child: Text(
                "Hi! 👋 I’m your study assistant.\nHow can I help you today?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Type your message...",
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send, color: Colors.teal),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 70,
      width: 70,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.teal, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            offset: Offset(4, 6),
          ),
        ],
      ),
      child: const Icon(
        Icons.chat_bubble_rounded,
        color: Colors.white,
        size: 35,
      ),
    );
  }
}
