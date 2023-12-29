import 'dart:async';
import 'package:csexplorer/data/model/forum.dart' as Forum;
import 'package:csexplorer/data/repositories/forum_repo.dart';
import 'package:csexplorer/data/repositories/reply_repo.dart';
import 'package:csexplorer/presentation/screens/Forum/forum_discussion.dart';
import 'package:flutter/material.dart';

class ForumTopic extends StatefulWidget {
  const ForumTopic({super.key});

  @override
  State<ForumTopic> createState() => ForumTopicState();
}

class ForumTopicState extends State<ForumTopic> {
  final ForumRepository _forumRepository = ForumRepository();
  final ReplyRepository _commentRepository = ReplyRepository();
  late Timer _refreshTimer;
  final int refreshIntervalInMilliseconds = 1000;
  late Future<List<Forum.Forum>> _forumList = _forumRepository.fetchForumList();
  List<String> updatedlist = [];

  @override
  void initState() {
    super.initState();
    _startRefreshTimer();
    fetchData();
  }

  void _startRefreshTimer()
  {
    _refreshTimer = Timer.periodic(
      Duration(milliseconds: refreshIntervalInMilliseconds),
      (timer) async {
        try {
          List<Forum.Forum> updatedList =
              await _forumRepository.fetchForumList();
          setState(() {
            _forumList = Future.value(updatedList);
          });
        } catch (error) {
          // ignore: avoid_print
          print('Error fetching data: $error');
        }
      },
    );
  }

  void fetchData() {
    _refreshTimer = Timer.periodic(
      Duration(milliseconds: refreshIntervalInMilliseconds),
      (timer) async {
        try {
          updatedlist = await ReplyRepository.retrieveReplies();
        } catch (error) {
          // ignore: avoid_print
          print('Error fetching data: $error');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      body: FutureBuilder<List<Forum.Forum>>(
        future: _forumList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching data'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No forum added"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Forum.Forum forums = snapshot.data![index];
                return Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ForumDiscussion(forum: forums),
                            ),
                          );
                        },
                        child: Container(
                          width: cardWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      radius: 15,
                                      backgroundImage: AssetImage(
                                        'assets/images/defaultProfilePic.jpg',
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('name'),
                                        Text(
                                          forums.subject,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(forums.message),
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const SizedBox(width: 35),
                                    InkWell(
                                      onTap: () async {
                                        if (mounted) {
                                          await _commentRepository
                                              .incrementLikeForum(
                                                  forums.subject);
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(Icons.favorite_border_outlined),
                                          const SizedBox(width: 3),
                                          FutureBuilder<int>(
                                            future: _commentRepository
                                                .getLikesForum(forums.subject),
                                            builder: (context, likesSnapshot) {
                                              if (likesSnapshot.hasError) {
                                                return Text(
                                                    'Error: ${likesSnapshot.error}');
                                              } else {
                                                int likesCount =
                                                    likesSnapshot.data ?? 0;
                                                return Text(
                                                    'Likes $likesCount');
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            40),
                                    InkWell(
                                      onTap: () {},
                                      child: Row(
                                        children: [
                                          const Icon(Icons.comment_outlined),
                                          const SizedBox(width: 5),
                                          Text(
                                            'Discussion ${updatedlist.length}',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
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

