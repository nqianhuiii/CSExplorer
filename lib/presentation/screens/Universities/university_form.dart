import 'package:csexplorer/data/model/university.dart';
import 'package:csexplorer/data/repositories/university_repo.dart';
import 'package:flutter/material.dart';

class UniversityForm extends StatefulWidget {
  const UniversityForm({super.key});

  @override
  State<UniversityForm> createState() => _UniversityFormState();
}

class _UniversityFormState extends State<UniversityForm> {
  final _universityController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _backgroundController = TextEditingController();
  final _numCourseController = TextEditingController();
  List<TextEditingController> _courseNameController = [];
  Widget? _courseFields;

  final UniversityRepo _uniRepository = UniversityRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a university"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: TextStyle(color: Colors.grey[600]),
              ),
              TextField(
                controller: _universityController,
                decoration:
                    const InputDecoration(border: UnderlineInputBorder()),
              ),
              const SizedBox(height: 20),
              Text(
                "Location",
                style: TextStyle(color: Colors.grey[600]),
              ),
              TextField(
                controller: _locationController,
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
                    hintText: 'Short description about the university'),
              ),
              const SizedBox(height: 20),
              Text("Introduce the university",
                  style: TextStyle(color: Colors.grey[600])),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: _backgroundController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Background of the university')),
              const SizedBox(height: 20),
              Text(
                "Number of computer scince courses offered",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              TextFormField(
                  controller: _numCourseController,
                  onChanged: (value) {
                    setState(() {
                      //dynamically build fields
                      _courseFields = _buildCourseFields();
                    });
                  },
                  decoration:
                      const InputDecoration(border: UnderlineInputBorder())),
              // display empty container if that is null
              _courseFields ?? Container(),
              const SizedBox(height: 80),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      int numCourse =
                          int.tryParse(_numCourseController.text) ?? 0;

                      List<String> courseNames = [];
                      for (int i = 0; i < numCourse; i++) {
                        String courseName = _courseNameController[i].text;
                        courseNames.add(courseName);
                      }

                      University university = University(
                          _universityController.text,
                          _locationController.text,
                          _descriptionController.text,
                          _backgroundController.text,
                          courseNames: courseNames);

                      _uniRepository.addUniversity(university);
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

  Widget _buildCourseFields() {
    int numCourse = int.tryParse(_numCourseController.text) ?? 0;

    _courseNameController =
        List.generate(numCourse, (index) => TextEditingController());

    List<Widget> courseFields = List.generate(
        numCourse,
        (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text("CS Course ${index + 1}"),
                TextField(controller: _courseNameController[index])
              ],
            ));

    _courseFields = Column(children: courseFields);

    return _courseFields!;
  }
}
