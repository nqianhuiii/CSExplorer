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

  final UniversityRepo _uniRepository = UniversityRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a university"),
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
              const SizedBox(height: 80),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      University university = University(
                          _universityController.text,
                          _locationController.text,
                          _descriptionController.text,
                          _backgroundController.text);

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
}
