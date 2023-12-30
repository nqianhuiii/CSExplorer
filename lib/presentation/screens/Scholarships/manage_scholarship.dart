import "package:csexplorer/customWidget/CustomAppBar.dart";
import "package:csexplorer/data/model/scholarship.dart";
import "package:csexplorer/data/repositories/scholarship_repo.dart";
import "package:csexplorer/presentation/screens/Scholarships/edit_scholarship.dart";
import "package:csexplorer/presentation/screens/Scholarships/scholarship_details.dart";
import "package:csexplorer/presentation/screens/Universities/university_form.dart";
import "package:flutter/material.dart";

class ManageScholarship extends StatefulWidget {
  const ManageScholarship({super.key});

  @override
  State<ManageScholarship> createState() => _ManageScholarshipState();
}

class _ManageScholarshipState extends State<ManageScholarship> {
  final ScholarshipRepo scholarshipRepo = ScholarshipRepo();
  List<Scholarship> sholarships = [];

  @override
  void initState() {
    super.initState();
    _loadScholarship();
  }

  Future<void> _loadScholarship() async {
    List<Scholarship> fetchedScholarship = await scholarshipRepo.fetchScholarshipList();
    setState(() {
      sholarships = fetchedScholarship;
    });
  }

  void _deleteScholarship(int index) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this scholarship?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
               style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.indigo[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                bool success = await scholarshipRepo.deleteScholarship(sholarships[index].id);
                if (success) {
                  _loadScholarship();
                } else {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Cannot Delete the Scholarship'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(); // Close the confirmation dialog
              },
               style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.indigo[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void editScholarship(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScholarshipPage(scholarship: sholarships[index]),
      ),
    ).then((_) {
      _loadScholarship();
    });
  }
  List<String> scholarshipImage = [
    'Petronas.png',
    'BankNegara.png',
    'HLF.jpeg',
    'ytm.jpeg',
  ];

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: CustomAppBar(
        title: "Tertiary Institution",
        description: "Public and Private Scholarship/College/Vocational",
        colour: Colors.indigo.shade700),
    backgroundColor: Colors.grey[100],
    body: ListView.separated(
      itemCount: sholarships.length,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemBuilder: (context, index) {
        Scholarship scholarship = sholarships[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScholarshipDetails(
                                  scholarshipArguments: scholarship)));
                    },
                    child: Container(
                      width: 240,
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              width: 80,
                              height: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/scholarship/${scholarshipImage[scholarship.imageIndex]}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 15),
                  child: SizedBox(
                    height: 100,
                    width: 230,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          scholarship.providerName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold, 
                                              fontSize: 13.0),
                                        ),
                                        const SizedBox(
                                          height: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Add your edit and delete icons here
                                  IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        editScholarship(context, index);
                                      }),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                    ),
                                    color: const Color.fromARGB(
                                        255, 251, 117, 117),
                                    onPressed: () {
                                      _deleteScholarship(index);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                        ],
                      ),
                    ),
                  );
      },
    ),
    floatingActionButton: Stack(
      children: [
        Positioned(
          bottom: 60,
          right: 10,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UniversityForm()));
            },
            backgroundColor: Colors.indigo[700],
            elevation: 0,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
}