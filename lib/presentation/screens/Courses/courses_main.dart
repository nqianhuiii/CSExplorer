import 'package:csexplorer/customWidget/CustomAppBar.dart';
import 'package:csexplorer/data/model/course.dart';
import 'package:csexplorer/data/repositories/course_repo.dart';
import 'package:csexplorer/presentation/screens/Courses/course_details.dart';
import 'package:flutter/material.dart';

class CourseMain extends StatefulWidget {
  const CourseMain({super.key});

  @override
  State<CourseMain> createState() => _CourseMainState();
}


class _CourseMainState extends State<CourseMain> {
  final CourseRepo _courseRepo = CourseRepo();
  List<String> courseImage = [
    'Graphic.jpg',
    'Cyber.jpg',
    'DE.png',
    'SE.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Courses",
        description: "Computer Science courses and its description",
        colour: Colors.indigo.shade700,
      ),
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<List<Course>>(
        future: _courseRepo.fetchCourseList(),
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
              child: Text('No course found'),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemBuilder: (context, index) {
                Course course = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetails(
                          courseArguments: course,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Container(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/course/${courseImage[course.imageIndex]}',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            course.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
