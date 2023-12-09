<<<<<<< HEAD
import 'package:csexplorer/bottom_navbar.dart';
import 'package:csexplorer/presentation/screens/Home/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());
=======
//import 'package:csexplorer/bottom_navbar.dart';
import 'package:csexplorer/presentation/screens/Authentication/login.dart';
//import 'package:csexplorer/presentation/screens/Home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    if (kDebugMode) {
      print('Error initializing Firebase: $e');
    }
  }
  runApp(const MyApp());
}
>>>>>>> 0fb28d1 (Sign in and Sign up page)

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IKON Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 19),
        backgroundColor: Colors.white,
      )),
<<<<<<< HEAD
      home: const BottomNavBar(),
=======
      home: const LoginPage(title: 'Sign in'),
      //home: const Home(),
>>>>>>> 0fb28d1 (Sign in and Sign up page)
    );
  }
}
