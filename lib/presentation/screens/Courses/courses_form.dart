import 'package:csexplorer/data/model/course.dart';
import 'package:csexplorer/data/repositories/course_repo.dart';
import 'package:csexplorer/data/repositories/university_repo.dart';
import 'package:flutter/material.dart';
class CourseForm extends StatefulWidget {
  const CourseForm({super.key});
  @override
  State<CourseForm> createState() => _UniversityFormState();
}
class _UniversityFormState extends State<CourseForm> {
  final _courseController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _academicReqController = TextEditingController();
  final _jobOpportunityController = TextEditingController();

  final CourseRepo _courseRepository = CourseRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a course"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                controller: _courseController,
                decoration:
                    const InputDecoration(border: UnderlineInputBorder()),
              ),
              const SizedBox(height: 20),
              Text(
                "Description",
                style: TextStyle(color: Colors.grey[600]),
              ),
              TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Description of the course')),
              const SizedBox(height: 20),
              Text("Academic Requirements",
                  style: TextStyle(color: Colors.grey[600])),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: _academicReqController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Any specific knowledge or skills requirements')),
              const SizedBox(height: 20),
              Text(
                "Job Opportunities",
                style: TextStyle(color: Colors.grey[600]),
              ),
              TextField(
                controller: _jobOpportunityController,
                decoration:
                    const InputDecoration(border: UnderlineInputBorder()),
              ),
              const SizedBox(height: 50),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      Course course = Course(
                          name:_courseController.text,
                          description:_descriptionController.text,
                          academicRequirements: _academicReqController.text,
                          jobOpportunity:_jobOpportunityController.text,
                          );

                      _courseRepository.addCourse(course);
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


