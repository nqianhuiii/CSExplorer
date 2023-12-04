import 'package:csexplorer/presentation/screens/Forum/forum_question_form.dart';
import 'package:flutter/material.dart';

class ForumMain extends StatefulWidget {
  const ForumMain({super.key});

  @override
  State<ForumMain> createState() => _ForumMainState();
}

class _ForumMainState extends State<ForumMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forum')),
      body: Container(),
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
                        builder: (context) => const ForumTopicForm()));
              },
              backgroundColor: Colors.blue,
              elevation: 0,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
