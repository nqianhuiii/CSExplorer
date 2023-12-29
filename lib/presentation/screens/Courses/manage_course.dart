import "package:csexplorer/customWidget/CustomAppBar.dart";
import "package:csexplorer/data/model/course.dart";
import "package:csexplorer/data/repositories/course_repo.dart";
import "package:csexplorer/presentation/screens/Courses/course_details.dart";
import "package:csexplorer/presentation/screens/Courses/courses_form.dart";
import "package:csexplorer/presentation/screens/Universities/edit_university.dart";
import "package:flutter/material.dart";


class ManageCourse extends StatefulWidget {
  const ManageCourse({super.key});
  @override
  State<ManageCourse> createState() => _CourseMainState();
}

class _CourseMainState extends State<ManageCourse> {
  
final CourseRepo courseRepo = CourseRepo();

final TextEditingController editNameController = TextEditingController();
final TextEditingController editDescriptionController = TextEditingController();
final TextEditingController editAcademicReqController = TextEditingController();
final TextEditingController editJobOpportunityController = TextEditingController();


 List<Course> courses=[];

 
  @override
  void initState() {
    super.initState();
    _loadCourse();
  }

  Future<void> _loadCourse() async {
    List<Course> courseList = await courseRepo.fetchCourseList();
    setState(() {
      courses = courseList;
    });
  }
  
  
Future<void> editCourse(BuildContext context, int index) async {
  List<Course> courses = await courseRepo.fetchCourseList();

  if (index >= 0 && index < courses.length) {
    Course selectedCourse = courses[index];
    editNameController.text = selectedCourse.name;
    editDescriptionController.text = selectedCourse.description;
    editAcademicReqController.text = selectedCourse.academicRequirements;
    editJobOpportunityController.text = selectedCourse.jobOpportunity;
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Course'),
          content: SizedBox(
            height: 500,
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  controller: editNameController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  controller: editDescriptionController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Academic Requirements'),
                  controller: editAcademicReqController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Job Opportunity'),
                  controller: editJobOpportunityController,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[700],
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[700],
              ),
              onPressed: () async {
                await _updateCourse (index);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  } else {}
}

Future<void> _updateCourse (int index) async {
  List<Course> courses = await courseRepo.fetchCourseList();

  String editedName = editNameController.text;
  String editedDescription = editDescriptionController.text;
  String editedAcademicReq = editAcademicReqController.text;
  String editedJobOpportunity = editJobOpportunityController.text;


  if (editedName.isNotEmpty) {
    Course editedCourse = Course(
      name: editedName,
      description: editedDescription,
      academicRequirements: editedAcademicReq,
      jobOpportunity: editedJobOpportunity
    );

    bool success = await courseRepo.editCourse(
        courses[index].id, editedCourse);
    if (success) {
      _loadCourse();
      editNameController.clear();
      editDescriptionController.clear();
      editAcademicReqController.clear();
      editJobOpportunityController.clear();
    } else {}
  }
}


  void _deleteCourse(int index) async {
    BuildContext dialogContext = context;
    bool success = await courseRepo.deleteCourse(courses[index].id);
    if (success) {
      _loadCourse(); 
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: dialogContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Cannot Delete the Course'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

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
        future: courseRepo.fetchCourseList(),
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
                return Stack(
                  children: [
                    GestureDetector(
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
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.grey[400],
                            onPressed: () {
                              editCourse(context, index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: const Color.fromARGB(
                                        255, 251, 117, 117),
                            onPressed: () {
                              _deleteCourse(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
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
                    builder: (context) => const CourseForm(),
                  ),
                );
              },
              backgroundColor: Colors.indigo.shade700,
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