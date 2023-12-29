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
  List<String> scholarImage = [
    'JPA.jpg',
    'PTPTN.jpg',
    'parkson.jpg',
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
                      'assets/images/scholar/${scholarImage[widget.scholarshipArguments.imageIndex]}',
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
                          widget.scholarshipArguments.name,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.scholarshipArguments.description,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Background',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.scholarshipArguments.requirement),
                      ],
                    ),
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
