import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Sample fields (replace with values from AppState later)
  String name = "Student Name";
  String email = "student@email.com";
  String phone = "+91 9876543210";
  String address = "Village, District, State";
  String studentClass = "10th";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: "Name"),
                onSaved: (value) => name = value ?? "",
              ),
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => email = value ?? "",
              ),
              TextFormField(
                initialValue: phone,
                decoration: const InputDecoration(labelText: "Phone"),
                keyboardType: TextInputType.phone,
                onSaved: (value) => phone = value ?? "",
              ),
              TextFormField(
                initialValue: address,
                decoration: const InputDecoration(labelText: "Address"),
                onSaved: (value) => address = value ?? "",
              ),
              TextFormField(
                initialValue: studentClass,
                decoration: const InputDecoration(labelText: "Class"),
                onSaved: (value) => studentClass = value ?? "",
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // later hook this into AppState
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profile updated!")),
                    );

                    Navigator.pop(context); // go back to ProfileScreen
                  }
                },
                child: const Text("Save Changes"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
