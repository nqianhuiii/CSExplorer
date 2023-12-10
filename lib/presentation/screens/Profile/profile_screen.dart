// firstname
// lastname
// age
// stream
// email
// password update
// logout button
import 'package:csexplorer/presentation/screens/Authentication/login.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CSExplorer"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Logout"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(
                  title: 'Sign in',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
