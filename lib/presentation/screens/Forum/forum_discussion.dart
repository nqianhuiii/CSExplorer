import 'dart:async';
import 'package:csexplorer/data/repositories/reply_repo.dart';
import 'package:flutter/material.dart';
import 'package:csexplorer/data/model/forum.dart' as Forum;

class ForumDiscussion extends StatefulWidget {
  final Forum.Forum forum;

  const ForumDiscussion({Key? key, required this.forum}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForumDiscussionState createState() => _ForumDiscussionState();
}

class _ForumDiscussionState extends State<ForumDiscussion> {
  final ReplyRepository _commentRepository = ReplyRepository();
  // ignore: unused_field
  late Timer _refreshTimer;
  final int refreshIntervalInMilliseconds = 1000;
  late Future<List<String>> _replyList = ReplyRepository.retrieveReplies();
  List<String> updatedList=[];
  List<int> likesCounts = [];

  @override
  void initState() {
    super.initState();
    _startRefreshTimer();
  }

  Future<void> handleLikesUpdate(String comment, int index) async {
    int updatedLikes = await _commentRepository.getLikes(comment);

    setState(() {
      if (index >= likesCounts.length) {
        likesCounts.add(updatedLikes);
      } else {
        likesCounts[index] = updatedLikes;
      }
    });
  }

  void _startRefreshTimer() {
    _refreshTimer = Timer.periodic(
      Duration(milliseconds: refreshIntervalInMilliseconds),
      (timer) async {
        try {
          updatedList = await ReplyRepository.retrieveReplies();
          setState(() {
            _replyList = Future.value(updatedList);
          });
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

    void showReplyBottomSheet() {
      TextEditingController replyController = TextEditingController();

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: replyController,
                      decoration: const InputDecoration(
                        hintText: 'Type your reply here...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      String replyText = replyController.text;

                      await _commentRepository.addReply(replyText);

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Post'),
      ),
      body: FutureBuilder<List<String>>(
          future: _replyList,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        width: cardWidth,
                        padding: const EdgeInsets.all(16),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('name'),
                                    Text(
                                      widget.forum.subject,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(widget.forum.message),
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Discussion ${updatedList.length}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String comment = snapshot.data![index];
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            width: cardWidth,
                            padding: const EdgeInsets.all(16),
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
                                        Text(comment),
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const SizedBox(width: 35),
                                    InkWell(
                                      onTap: () async {
                                        if (mounted) {
                                          await _commentRepository
                                              .incrementLikes(comment);
                                          handleLikesUpdate(comment, index);
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                              Icons.favorite_border_outlined),
                                          const SizedBox(width: 3),
                                          FutureBuilder<int>(
                                            future: _commentRepository
                                                .getLikes(comment),
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          }),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 60,
            right: 10,
            child: FloatingActionButton(
              onPressed: showReplyBottomSheet,
              tooltip: 'Reply',
              child: const Icon(Icons.comment),
            ),
          ),
        ],
      ),
    );
  }
}
