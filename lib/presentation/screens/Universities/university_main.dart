import "package:csexplorer/customWidget/CustomAppBar.dart";
import "package:csexplorer/presentation/screens/Universities/university_form.dart";
import "package:flutter/material.dart";

class UniversityMain extends StatefulWidget {
  const UniversityMain({super.key});

  @override
  State<UniversityMain> createState() => _UniversityMainState();
}

class _UniversityMainState extends State<UniversityMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Tertiary Institution", description: "Public and Private University/College/Vocational"), 
              floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 60,
            right: 10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UniversityForm()));
              },
              backgroundColor: Colors.indigo[700],
              elevation: 0,
              child: const Icon(Icons.add, color: Colors.white,),
            ),
          ),
        ],
      ),);
  }
}


