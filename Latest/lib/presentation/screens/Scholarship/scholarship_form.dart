import 'package:csexplorer/data/model/scholarship.dart';
import 'package:csexplorer/data/repositories/scholarship_repo.dart';
import 'package:flutter/material.dart';

class ScholarshipForm extends StatefulWidget {
  const ScholarshipForm({super.key});

  @override
  State<ScholarshipForm> createState() => _ScholarshipFormState();
}

class _ScholarshipFormState extends State<ScholarshipForm> {
  final _scholarshipController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _requirementController = TextEditingController();

  final ScholarshipRepo _scholarRepository = ScholarshipRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a Scholarship Provider"),
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
                controller: _scholarshipController,
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
                    hintText: 'Short description about the Scholarship'),
              ),
              const SizedBox(height: 20),
              Text("State the Requirements",
                  style: TextStyle(color: Colors.grey[600])),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      Scholarship scholarship = Scholarship(
                          _scholarshipController.text,
                          _descriptionController.text,
                          _requirementController.text);

                      _scholarRepository.addScholarship(scholarship);
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
