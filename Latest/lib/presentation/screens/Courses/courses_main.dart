import "package:csexplorer/customWidget/CustomAppBar.dart";
import "package:csexplorer/data/model/courses.dart";
import "package:csexplorer/data/repositories/courses_repo.dart";
import "package:csexplorer/presentation/screens/Courses/courses_detail.dart";
import "package:csexplorer/presentation/screens/Courses/courses_form.dart";
import "package:flutter/material.dart";

class CoursesMain extends StatefulWidget {
  const CoursesMain({super.key});

  @override
  State<CoursesMain> createState() => _CoursesMainState();
}

class _CoursesMainState extends State<CoursesMain> {
  final CoursesRepo _coursesRepo = CoursesRepo();

  List<String> coursesImage = [
    'JPA.jpg',
    'PTPTN.jpg',
    'parkson.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: "Tertiary Institution",
          description: "Public and Private University/College/Vocational"),
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<List<Courses>>(
          future: _coursesRepo.fetchCoursesList(),
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
                child: Text('No courses found'),
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
                  Courses courses = snapshot.data![index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CoursesDetails(
                                  coursesArguments: courses)));
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
                                  'assets/images/courses/${coursesImage[courses.imageIndex]}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: SizedBox(
                              height: 100,
                              width: 230,
                              child: Column(children: [
                                Text(
                                  courses.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(courses.description)
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
          }),
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
                        builder: (context) => const   CoursesForm()));
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
