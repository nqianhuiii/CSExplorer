// firstname
// lastname
// age
// stream
// email
// password update
// logout button
import 'package:csexplorer/presentation/screens/Authentication/login.dart';
import 'package:flutter/cupertino.dart';
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
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                foregroundColor: Colors.grey[100],
                backgroundColor: Colors.indigo[700],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    CupertinoPageRoute(
                        builder: (context) => const LoginPage(
                              title: 'Sign in',
                            )),
                    (route) => false);
              },
              child: const Text("Logout"),
            ),
          ),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 30),
          ListTile(
            title: Text('Content'),
            trailing: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
