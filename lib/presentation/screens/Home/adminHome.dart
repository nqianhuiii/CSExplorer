import "package:csexplorer/customWidget/CustomHomeContainer.dart";
import "package:csexplorer/presentation/screens/Courses/manage_course.dart";
import "package:csexplorer/presentation/screens/Universities/manage_university.dart";
import "package:flutter/material.dart";

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _HomeState();
}

class _HomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, Linda",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 7),
              Text(
                "What information are you looking for today ?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.indigo[700],
          toolbarHeight: 130,
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Explore Computer Science Information",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 20),
              CustomHomeContainer(
                link: 'assets/images/main/tertiaryEducation.jpg',
                title: "Tertiary Institution",
                description:
                    "View list of public and private universities, colleges, and vocational schools that provide computer science",
                onTapCallback: (context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManageUniversity()));
                },
              ),
              const SizedBox(height: 15),
              CustomHomeContainer(
                  link: 'assets/images/main/computerScience.jpg',
                  title: "Computer Science Courses",
                  description:
                      "View types of courses under computer science and its details",
                onTapCallback: (context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManageCourse()));
                },
              ), 
              const SizedBox(height: 15),
              const CustomHomeContainer(
                  link: 'assets/images/main/scholarship.jpg',
                  title: "Scholarships",
                  description:
                      "View list of public and private universities, colleges, and vocational schools that provide computer science"),
            ],
          ),
        ));
  }
}
