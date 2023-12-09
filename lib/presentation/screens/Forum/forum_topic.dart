import 'package:csexplorer/data/model/forum.dart';
import 'package:csexplorer/data/repositories/forum_repo.dart';
import 'package:flutter/material.dart';

class ForumTopic extends StatefulWidget {
  const ForumTopic({super.key});

  @override
  State<ForumTopic> createState() => ForumTopicState();
}

class ForumTopicState extends State<ForumTopic> {
  final ForumRepository _forumRepository = ForumRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Forum>>(
        future: _forumRepository.fetchForumList(),
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
              child: Text('No forum topic found'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                Forum forum = snapshot.data![index];

                return Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 340,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5,
                                offset: const Offset(0, 3))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 15,
                              backgroundImage: AssetImage(
                                  'assets/images/defaultProfilePic.jpg'),
                            ),
                            const Text('name'),
                            Text(forum.subject)
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
