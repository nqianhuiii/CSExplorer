import 'package:csexplorer/data/model/scholarship.dart';
import 'package:flutter/material.dart';
class ScholarshipDetails extends StatefulWidget {
  final Scholarship scholarshipArguments;
  const ScholarshipDetails({Key? key, required this.scholarshipArguments})
      : super(key: key);
  @override
  State<ScholarshipDetails> createState() => _ScholarshipDetailsState();
}
class _ScholarshipDetailsState extends State<ScholarshipDetails> {
  List<String> scholarshipImage = [
    'Petronas.png',
    'BankNegara.png',
    'HLF.jpeg',
    'ytm.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: Image.asset(
                      'assets/images/scholarship/${scholarshipImage[widget.scholarshipArguments.imageIndex]}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.scholarshipArguments.providerName,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Description',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.scholarshipArguments.description),
                          const SizedBox(height: 30),
                          const Text(
                            'Application Requirements',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.scholarshipArguments.applicationRequirement),
                          const SizedBox(height: 30),
                          const Text(
                            'Link to Official or Reference Website',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.scholarshipArguments.link),                          
                          const SizedBox(height: 70),
                        ]),
                  ),
                ],
              ),
              Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
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