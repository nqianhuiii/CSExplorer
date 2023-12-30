import 'package:csexplorer/customWidget/CustomAppBar.dart';
import 'package:csexplorer/data/model/scholarship.dart';
import 'package:csexplorer/data/repositories/scholarship_repo.dart';
import 'package:csexplorer/presentation/screens/Scholarships/scholarship_details.dart';
import 'package:csexplorer/presentation/screens/Scholarships/scholarship_form.dart';
import 'package:flutter/material.dart';

class ScholarshipMain extends StatefulWidget {
  const ScholarshipMain({super.key});

  @override
  State<ScholarshipMain> createState() => _ScholarshipMainState();
}

class _ScholarshipMainState extends State<ScholarshipMain> {
  final ScholarshipRepo _scholarshipRepo = ScholarshipRepo();
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
        title: "Scholarships",
        description: "Scholarship that can aid your tertiary education",
        colour: Colors.indigo.shade700,
      ),
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<List<Scholarship>>(
          future: _scholarshipRepo.fetchScholarshipList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error fetching data'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No scholarship found'),
              );
            } else {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemBuilder: (context, index) {
                  Scholarship scholarship = snapshot.data![index];
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
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      scholarship.providerName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),  );
  }
}