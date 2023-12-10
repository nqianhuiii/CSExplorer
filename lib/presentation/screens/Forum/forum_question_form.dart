import 'package:csexplorer/data/model/forum.dart';
import 'package:csexplorer/data/repositories/forum_repo.dart';
import 'package:flutter/material.dart';

class ForumTopicForm extends StatefulWidget {
  const ForumTopicForm({super.key});

  @override
  State<ForumTopicForm> createState() => _ForumTopicFormState();
}

class _ForumTopicFormState extends State<ForumTopicForm> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final ForumRepository _forumRepository = ForumRepository();

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
              const SizedBox(height: 271),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      Forum forum = Forum(
                          _subjectController.text, _messageController.text);

                      _forumRepository.addForumTopic(forum);
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue[400],
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
