import 'package:csexplorer/data/model/courses.dart';
import 'package:csexplorer/data/repositories/courses_repo.dart';
import 'package:flutter/material.dart';

class CoursesForm extends StatefulWidget {
  const CoursesForm({super.key});

  @override
  State<CoursesForm> createState() => _CoursesFormState();
}

class _CoursesFormState extends State<CoursesForm> {
  final _coursesController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _careerController = TextEditingController();
  final _salaryController = TextEditingController();

  final CoursesRepo _coursesRepository = CoursesRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add the Course Information"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Course Name",
                style: TextStyle(color: Colors.grey[600]),
              ),
              TextField(
                controller: _coursesController,
                decoration:
                    const InputDecoration(border: UnderlineInputBorder()),
              ),
              const SizedBox(height: 20),
              Text(
                "Description",
                style: TextStyle(color: Colors.grey[600]),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Short description about the Career Pathway'),
              ),
              const SizedBox(height: 20),
              Text("State the Fresh Graduate Salary",
                  style: TextStyle(color: Colors.grey[600])),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      Courses courses = Courses(
                          _coursesController.text,
                          _descriptionController.text,
                          _careerController.text,
                          _salaryController.text);

                      _coursesRepository.addCourses(courses);
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.indigo[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: const Text('Submit'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
