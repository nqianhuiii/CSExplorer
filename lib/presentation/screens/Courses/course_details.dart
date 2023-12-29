import 'package:csexplorer/data/model/course.dart';
import 'package:flutter/material.dart';

class CourseDetails extends StatefulWidget {
  final Course courseArguments;
  const CourseDetails({Key? key, required this.courseArguments})
      : super(key: key);
  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}
class _CourseDetailsState extends State<CourseDetails> {
  List<String> courseImage = [
    'Graphic.jpg',
    'Cyber.jpg',
    'DE.png',
    'SE.jpeg',
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
                      'assets/images/course/${courseImage[widget.courseArguments.imageIndex]}',
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
                            widget.courseArguments.name,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Description',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.courseArguments.description),
                          const SizedBox(height: 30),
                          const Text(
                            'Academic Requirements',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.courseArguments.academicRequirements),
                          const SizedBox(height: 30),
                          const Text(
                            'Job Opportunities',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.courseArguments.jobOpportunity),
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
                    color: Colors.black,
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