import 'package:csexplorer/data/model/university.dart';
import 'package:csexplorer/data/repositories/university_repo.dart';
import 'package:flutter/material.dart';

void editUniversity(BuildContext context, int index) async {
  final UniversityRepo universityRepo = UniversityRepo();
  List<University> universities = [];
  TextEditingController editNameController = TextEditingController();

  University selectedUniversity = universities[index];
  editNameController.text = selectedUniversity.name;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit University'),
        content: SizedBox(
          height: 500,
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                controller: editNameController,
              ),
            ],
          ),
        ),
      );
    },
  );
}



