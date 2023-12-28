import "package:csexplorer/customWidget/CustomAppBar.dart";
import "package:csexplorer/data/model/university.dart";
import "package:csexplorer/data/repositories/university_repo.dart";
import "package:csexplorer/presentation/screens/Universities/university_details.dart";
import "package:csexplorer/presentation/screens/Universities/university_form.dart";
import "package:flutter/material.dart";



class ManageUniversity extends StatefulWidget {
  const ManageUniversity({super.key});
  @override
  State<ManageUniversity> createState() => _UniversityMainState();
}





class _UniversityMainState extends State<ManageUniversity> {
  
final UniversityRepo universityRepo = UniversityRepo();

final TextEditingController editNameController = TextEditingController();
final TextEditingController editLocationController = TextEditingController();
final TextEditingController editDescriptionController = TextEditingController();
final TextEditingController editBackgroundController = TextEditingController();


 List<University> universities=[];

 
  @override
  void initState() {
    super.initState();
    _loadUniversity();
  }

  Future<void> _loadUniversity() async {
    List<University> universitiess = await universityRepo.fetchUniList();
    setState(() {
      universities = universitiess;
    });
  }
  
  
Future<void> editUniversity(BuildContext context, int index) async {
  List<University> universities = await universityRepo.fetchUniList();

  if (index >= 0 && index < universities.length) {
    University selectedUniversity = universities[index];
    editNameController.text = selectedUniversity.name;
    editLocationController.text = selectedUniversity.location;
    editDescriptionController.text = selectedUniversity.description;
    editBackgroundController.text = selectedUniversity.background;

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit University'),
          content: SizedBox(
            height: 500,
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  controller: editNameController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Location'),
                  controller: editLocationController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  controller: editDescriptionController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Background'),
                  controller: editBackgroundController,
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
                await _updateUniversity(index);
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

Future<void> _updateUniversity(int index) async {
  List<University> universities = await universityRepo.fetchUniList();

  String editedName = editNameController.text;
  String editedLocation = editLocationController.text;
  String editedDescription = editDescriptionController.text;
  String editedBackground = editBackgroundController.text;

  if (editedName.isNotEmpty) {
    University editedUniversity = University(
      name: editedName,
      location: editedLocation,
      description: editedDescription,
      background: editedBackground,
    );

    bool success = await universityRepo.editUniversity(
        universities[index].id, editedUniversity);
    if (success) {
      _loadUniversity();
      editNameController.clear();
      editLocationController.clear();
      editDescriptionController.clear();
      editBackgroundController.clear();
    } else {}
  }
}
  List<String> uniImage = [
    'UTM.jpg',
    'UM.jpg',
    'USM.jpg',
    'UM.jpg',
  ];@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: const CustomAppBar(
        title: "Tertiary Institution",
        description: "Public and Private University/College/Vocational"),
    backgroundColor: Colors.grey[100],
    body: ListView.separated(
      itemCount: universities.length,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemBuilder: (context, index) {
        University university = universities[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UniversityDetails(universityArguments: university),
              ),
            );
          },
          child: Container(
            width: 240,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/university/${uniImage[university.imageIndex]}',
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
                                          university.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Add your edit and delete icons here
                                  IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        editUniversity(context, index);
                                      }),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                    ),
                                    color: const Color.fromARGB(
                                        255, 251, 117, 117),
                                    onPressed: () {
                                      // Handle delete action
                                    },
                                  ),
                                ],
                              ),
                              Text(university.description),
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