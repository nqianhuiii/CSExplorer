import 'dart:io';

import 'package:csexplorer/data/model/university.dart';
import 'package:csexplorer/data/repositories/university_repo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  XFile? _image;
  String imagePathAsString = "";
  Future<void> _getImage() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = image;
        imagePathAsString = _image?.path ?? '';
      });
    }
  }

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
              Text("Upload image of the university",
                style: TextStyle(color: Colors.grey[600]
                ),
             ),
             const SizedBox(height: 5),
              Container(
                height: 100,
                width: double.infinity, // Make the button full width
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(_image!.path),
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                        ),
                      )
                    : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade600, 
                          width: 1.0, 
                        ),
                      ),
                      child: Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          child: InkWell(
                            onTap: _getImage,
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: Colors.indigo.shade700
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Select Image",
                                    style: TextStyle(
                                      color: Colors.indigo.shade700,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ),
              ),
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
                          name:_universityController.text,
                          location:_locationController.text,
                          description: _descriptionController.text,
                          background:_backgroundController.text,
                          courseNames: courseNames,
                          image: imagePathAsString);

                      _uniRepository.addUniversity(university);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.indigo[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: const Text('Submit'),
                  ),
                ),
              ),
              const SizedBox(height: 70),           
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


