import 'package:csexplorer/data/model/scholarship.dart';
import 'package:csexplorer/data/repositories/scholarship_repo.dart';
import 'package:flutter/material.dart';

class ScholarshipForm extends StatefulWidget {
  const ScholarshipForm({super.key});
  @override
  State<ScholarshipForm> createState() => _ScholarshipFormState();
}
class _ScholarshipFormState extends State<ScholarshipForm> {
  final _providerNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _applicationReqController = TextEditingController();
  final _linkController = TextEditingController();

  final ScholarshipRepo _scholarshipRepository = ScholarshipRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a scholarship"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Provider Name",
                style: TextStyle(color: Colors.grey[600]),
              ),
              TextField(
                controller: _providerNameController,
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
                      hintText: 'Description of the scholarship')),
              const SizedBox(height: 20),
              Text("Application Requirements",
                  style: TextStyle(color: Colors.grey[600])),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: _applicationReqController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Any specific academic or financial requirements')),
              const SizedBox(height: 20),
              Text(
                "Link to official or reference website",
                style: TextStyle(color: Colors.grey[600]),
              ),
              TextField(
                controller: _linkController,
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
                      Scholarship scholarship = Scholarship(
                          providerName: _providerNameController.text,
                          description:_descriptionController.text,
                          applicationRequirement: _applicationReqController.text,
                          link: _linkController.text
                          );

                      _scholarshipRepository.addScholarship(scholarship);
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