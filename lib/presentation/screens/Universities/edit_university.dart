import "package:csexplorer/data/model/university.dart";
import "package:csexplorer/data/repositories/university_repo.dart";
import "package:flutter/material.dart";

class EditUniversityPage extends StatefulWidget {
  final University university;

  EditUniversityPage({required this.university});

  @override
  _EditUniversityPageState createState() => _EditUniversityPageState();
}

class _EditUniversityPageState extends State<EditUniversityPage> {
  final TextEditingController editNameController = TextEditingController();
  final TextEditingController editLocationController = TextEditingController();
  final TextEditingController editDescriptionController =
      TextEditingController();
  final TextEditingController editBackgroundController =
      TextEditingController();
  final TextEditingController editCourseController = TextEditingController();
  final UniversityRepo universityRepo = UniversityRepo();


  @override
  void initState() {
    super.initState();
    editNameController.text = widget.university.name;
    editLocationController.text = widget.university.location;
    editDescriptionController.text = widget.university.description;
    editBackgroundController.text = widget.university.background;
    editCourseController.text = widget.university.courseNames.join('\n');
  }

  Future<void> _updateUniversity() async {
    String editedName = editNameController.text;
    String editedLocation = editLocationController.text;
    String editedDescription = editDescriptionController.text;
    String editedBackground = editBackgroundController.text;
    List<String> editedCourseName = editCourseController.text.split('\n');
    if (editedName.isNotEmpty) {
      University editedUniversity = University(
        name: editedName,
        location: editedLocation,
        description: editedDescription,
        background: editedBackground,
        courseNames: editedCourseName,
      );

      await universityRepo.editUniversity(
          widget.university.id, editedUniversity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit University'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name", style: TextStyle(color: Colors.grey[600])),
              TextField(
                controller: editNameController,
                decoration:
                    const InputDecoration(border: UnderlineInputBorder()),
              ),
              const SizedBox(height: 20),
              Text("Location", style: TextStyle(color: Colors.grey[600])),
              TextField(
                controller: editLocationController,
                decoration:
                    const InputDecoration(border: UnderlineInputBorder()),
              ),
              const SizedBox(height: 20),
              Text("Description", style: TextStyle(color: Colors.grey[600])),
              TextField(
                controller: editDescriptionController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Short description about the university'),
              ),
              const SizedBox(height: 20),
              Text("Introduce the university",
                  style: TextStyle(color: Colors.grey[600])),
              TextFormField(
                  controller: editBackgroundController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Background of the university')),
              const SizedBox(height: 20),
              Text("Number of computer science courses offered",
                  style: TextStyle(color: Colors.grey[600])),
              TextFormField(
                  controller: editCourseController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Course of the university')),
              SizedBox(height: 80),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _updateUniversity();
                      Navigator.pop(context, true);
                    },
                    child: Text('Save Changes'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.indigo[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
