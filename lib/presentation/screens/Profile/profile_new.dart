import 'package:csexplorer/bottom_navbar.dart';
import 'package:flutter/material.dart';

class ProfileCreatePage extends StatefulWidget {
  const ProfileCreatePage({super.key, required String title});

  @override
  State<ProfileCreatePage> createState() => ProfileCreatePageState();
}

class ProfileCreatePageState extends State<ProfileCreatePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CSExplorer"),
        centerTitle: true,
        toolbarHeight: 65,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        elevation: 1,
        titleTextStyle: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.9),
            fontWeight: FontWeight.bold,
            fontSize: 30),
        backgroundColor: const Color.fromRGBO(66, 165, 245, 1),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                "Let us know Your Name!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
              child: TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "First Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null; //if input
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
              child: TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Last Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null; //if input
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavBar(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill input')));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.9),
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: const Color.fromRGBO(66, 165, 245, 1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  child: const Text('Done'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
