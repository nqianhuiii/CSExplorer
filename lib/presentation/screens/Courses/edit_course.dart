import 'package:csexplorer/data/model/course.dart';
import 'package:csexplorer/data/repositories/course_repo.dart';
import 'package:flutter/material.dart';


final CourseRepo courseRepo = CourseRepo();

final TextEditingController editNameController = TextEditingController();
final TextEditingController editDescriptionController = TextEditingController();
final TextEditingController editAcademicReqController = TextEditingController();
final TextEditingController editJobOpportunityController = TextEditingController();

Future<void> editCourse(BuildContext context, int index) async {
  List<Course> courses = await courseRepo.fetchCourseList();

  if (index >= 0 && index < courses.length) {
    Course selectedCourse = courses[index];
    editNameController.text = selectedCourse.name;
    editDescriptionController.text = selectedCourse.description;
    editAcademicReqController.text = selectedCourse.academicRequirements;
    editJobOpportunityController.text = selectedCourse.jobOpportunity;

      // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Course'),
          content: SizedBox(
            height: 500,
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  controller: editNameController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  controller: editDescriptionController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Academic Requirements'),
                  controller: editAcademicReqController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Job Opportunity'),
                  controller: editJobOpportunityController,
                ),
              ],
            ),
          ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[700],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[700],
              ),
              onPressed: () async {
                await _updateCourse (index);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Text('Save Changes'),
            ),
            ],
          );
        },
      );
    } else {
     
    }
  }

Future<void> _updateCourse (int index) async {
  List<Course> courses = await courseRepo.fetchCourseList();

  String editedName = editNameController.text;
  String editedDescription = editDescriptionController.text;
  String editedAcademicReq = editAcademicReqController.text;
  String editedJobOpportunity = editJobOpportunityController.text;


  if (editedName.isNotEmpty) {
    Course editedCourse = Course(
      name: editedName,
      description: editedDescription,
      academicRequirements: editedAcademicReq,
      jobOpportunity: editedJobOpportunity
    );

      bool success = await courseRepo.editCourse(
        courses[index].id, editedCourse);
      if (success) {
        editNameController.clear();
        editDescriptionController.clear();
        editAcademicReqController.clear();
        editJobOpportunityController.clear();
      } else {
        
      }
    }
  }


