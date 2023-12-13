// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexplorer/presentation/screens/Authentication/login.dart';
import 'package:csexplorer/presentation/screens/Profile/profile_screen.dart';
import 'package:csexplorer/service/Validator.dart';
import 'package:csexplorer/service/authService.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key, required this.title});

  final String title;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController comfirmPasswordController = TextEditingController();
  var role = "user";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: const Text("CSExplorer"),
        centerTitle: true,
        toolbarHeight: 65,
        /* shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ), */
        elevation: 1,
        titleTextStyle: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.9),
            fontWeight: FontWeight.bold,
            fontSize: 30),
        backgroundColor: Colors.indigo[700],
      ),
      body: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                "Sign up",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Your Name"),
                validator: (value) => Validator.validateName(value!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) => Validator.validateEmail(value!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) => Validator.validatePassword(value!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: TextFormField(
                controller: comfirmPasswordController,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: "Comfirm Password"),
                validator: (value) => Validator.validateComfirmPassword(
                    value!, passwordController.text),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        String username = nameController.text;
                        String email = emailController.text;
                        String password = passwordController.text;

                        signUp(username, email, password, role);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill input')));
                      }
                    },
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
                    child: const Text('Sign up'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage(
                                    title: 'Sign in',
                                  )),
                        );
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          color: Color.fromRGBO(48, 63, 159, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  void signUp(
      String username, String email, String password, String role) async {
    const CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _authService.signUp(username, email, password, role);
      routeSignup();
    }
  }

  void routeSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }
}
