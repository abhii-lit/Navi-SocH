import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: "Edit Profile",
            onPressed: () {
              Navigator.pushNamed(context, "/editProfile");
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Profile Avatar + Name
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal.shade100,
              child: const Icon(Icons.person, size: 60, color: Colors.teal),
            ),
            const SizedBox(height: 12),
            const Text(
              "Student Name",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildSectionTitle("Personal Details"),
            _buildInfoCard(Icons.email, "Email", "student@email.com"),
            _buildInfoCard(Icons.phone, "Phone", "+91 9876543210"),
            _buildInfoCard(Icons.home, "Address", "Village, District, State"),

            const SizedBox(height: 20),

            _buildSectionTitle("Academic Info"),
            _buildInfoCard(Icons.school, "Class", "10th"),
            _buildInfoCard(Icons.book, "Subjects", "English, Maths, Science"),
            _buildInfoCard(Icons.trending_up, "Progress", "75%"),

            const SizedBox(height: 20),

            _buildSectionTitle("Settings"),
            _buildActionCard(Icons.lock, "Change Password", onTap: () {}),
            _buildActionCard(Icons.logout, "Logout", onTap: () {
              Navigator.pushReplacementNamed(context, "/login");
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }

  Widget _buildActionCard(IconData icon, String label, {VoidCallback? onTap}) {
    return Card(
      color: Colors.teal.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(label),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
