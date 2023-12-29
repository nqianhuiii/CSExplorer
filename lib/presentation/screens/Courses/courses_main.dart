import 'package:csexplorer/customWidget/CustomAppBar.dart';
import 'package:csexplorer/presentation/screens/Courses/courses_form.dart';
import 'package:flutter/material.dart';

class CourseMain extends StatefulWidget {
  const CourseMain({super.key});

  @override
  State<CourseMain> createState() => _CourseMainState();
}

class _CourseMainState extends State<CourseMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Courses", 
        description: "Computer Science courses and its description",
        colour: Colors.orange.shade700,),
      backgroundColor: Colors.grey[100],
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
                        builder: (context) => const CourseForm()));
              },
              backgroundColor: Colors.orange.shade700,
              elevation: 0,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      );
  }
}