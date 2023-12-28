<<<<<<< HEAD
import 'package:csexplorer/bottom_navbar.dart';
import 'package:csexplorer/firebase_config.dart';
import 'package:csexplorer/presentation/screens/Authentication/login.dart';
import 'package:csexplorer/presentation/screens/Authentication/signup.dart';
import 'package:csexplorer/presentation/screens/Profile/profile_screen.dart';
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
          scaffoldBackgroundColor: Colors.grey[100],
          primaryColor: Colors.indigo[700]),
      home: const SignupPage(title: "CSExplorer"),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'addscholar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Manage Scholarship Information'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('No contents currently'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScholarPage()),
          );
        },
        tooltip: 'Add Scholar',
        child: Icon(Icons.add),
      ),
    );
  }
}
>>>>>>> 055d33d498ba48ceb9bc3072173d4db5031c914d
