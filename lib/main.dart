import 'package:csexplorer/firebase_config.dart';
import 'package:csexplorer/presentation/screens/Authentication/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.indigo[700],
          scaffoldBackgroundColor: Colors.grey[100]),
      home: const LoginPage(title: 'Sign in'),
    );
  }
}
