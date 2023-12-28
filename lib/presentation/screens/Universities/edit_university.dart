

import 'package:csexplorer/data/model/university.dart';
import 'package:csexplorer/data/repositories/university_repo.dart';
import 'package:flutter/material.dart';


  final UniversityRepo universityRepo = UniversityRepo();

  final TextEditingController editNameController = TextEditingController();
  final TextEditingController editLocationController = TextEditingController();
  final TextEditingController editDescriptionController = TextEditingController();
  final TextEditingController editBackgroundController = TextEditingController();

  Future<void> editUniversity(BuildContext context, int index) async {
    List<University> universities = await universityRepo.fetchUniList();

    if (index >= 0 && index < universities.length) {
      University selectedUniversity = universities[index];
      editNameController.text = selectedUniversity.name;
      editLocationController.text = selectedUniversity.location;
      editDescriptionController.text = selectedUniversity.description;
      editBackgroundController.text = selectedUniversity.background;

      // ignore: use_build_context_synchronously
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
                  TextField(
                    decoration: const InputDecoration(labelText: 'Location'),
                    controller: editLocationController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Description'),
                    controller: editDescriptionController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Background'),
                    controller: editBackgroundController,
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
                  await _updateUniversity(index);
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

  Future<void> _updateUniversity(int index) async {
    List<University> universities = await universityRepo.fetchUniList();

    String editedName = editNameController.text;
    String editedLocation = editLocationController.text;
    String editedDescription = editDescriptionController.text;
    String editedBackground = editBackgroundController.text;

    if (editedName.isNotEmpty) {
      University editedUniversity = University(
        name: editedName,
        location: editedLocation,
        description: editedDescription,
        background: editedBackground,
      );

      bool success = await universityRepo.editUniversity(universities[index].id, editedUniversity);
      if (success) {
        editNameController.clear();
        editLocationController.clear();
        editDescriptionController.clear();
        editBackgroundController.clear();
      } else {
        
      }
    }
  }


