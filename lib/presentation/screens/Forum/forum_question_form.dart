import 'dart:io';

import 'package:csexplorer/data/model/forum.dart';
import 'package:csexplorer/data/repositories/forum_repo.dart';
import 'package:csexplorer/service/authService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ForumTopicForm extends StatefulWidget {
  const ForumTopicForm({super.key});

  @override
  State<ForumTopicForm> createState() => _ForumTopicFormState();
}

class _ForumTopicFormState extends State<ForumTopicForm> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final ForumRepository _forumRepository = ForumRepository();
  int likes = 0;
  String userId = AuthService.getCurrentUserId();
  String name = "";
  XFile? _image;
  String imagePathAsString = "";

  Future<void> _getImage() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = image;
        imagePathAsString = _image?.path ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initializeName();
  }

  Future<void> initializeName() async {
    // ignore: await_only_futures
    print("id,$userId");
    name = await AuthService.getUserNameById(userId);
    print("name,$name");
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a topic"),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Subject"),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: _subjectController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 15),
              const Text("Message"),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: _messageController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 15),
              const Text("Upload Image"),
              const SizedBox(
                height: 5,
              ),
              _image != null
                  ? Image.file(
                      File(_image!.path),
                      height: 100,
                    )
                  : ElevatedButton(
                      onPressed: _getImage,
                      child: const Text("Select Image"),
                    ),
              const SizedBox(height: 156),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      Forum forum = Forum(
                          _subjectController.text,
                          _messageController.text,
                          likes,
                          userId,
                          name,
                          imagePathAsString);
                      _forumRepository.addForumTopic(forum);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.indigo.shade700,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: const Text('Submit'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


