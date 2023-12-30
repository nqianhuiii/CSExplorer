import 'dart:io';

import 'package:csexplorer/data/model/university.dart';
import 'package:flutter/material.dart';
class UniversityDetails extends StatefulWidget {
  final University universityArguments;
  const UniversityDetails({Key? key, required this.universityArguments})
      : super(key: key);
  @override
  State<UniversityDetails> createState() => _UniversityDetailsState();
}
class _UniversityDetailsState extends State<UniversityDetails> {
  List<String> uniImage = [
    'UTM.jpg',
    'UM.jpg',
    'USM.jpg',
    'UM.jpg',
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
                    child: _buildImageWidget(widget.universityArguments.image),
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
                            widget.universityArguments.name,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.universityArguments.location,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Background',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.universityArguments.background),
                          const SizedBox(height: 30),
                          const Text(
                            'Computer Science Course Offered',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.universityArguments.courseNames
                                  .map((courseName) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.indigo.shade700),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8))),
                                    padding: const EdgeInsets.all(10),
                                    child: Text(courseName),
                                  ),
                                );
                              }).toList()),
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

Widget _buildImageWidget(String imagePath) {
    // ignore: unnecessary_null_comparison
    if (imagePath == null || imagePath.isEmpty) {
      return Container();
    }

    if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
      return Image.network(
        imagePath,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      );
    } else if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(imagePath),
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      );
    }
  }