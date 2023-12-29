import 'package:flutter/material.dart';
import 'package:csexplorer/data/model/faq.dart';
import 'package:csexplorer/data/repositories/faq_repo.dart';

class ManageFAQ extends StatefulWidget {
  const ManageFAQ({Key? key}) : super(key: key);

  @override
  State<ManageFAQ> createState() => _ManageFAQState();
}

class _ManageFAQState extends State<ManageFAQ> {
  final FaqRepository _faqRepository = FaqRepository();
  List<Faq> faqList = [];
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  TextEditingController editQuestionController = TextEditingController();
  TextEditingController editAnswerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFaqs();
  }

  Future<void> _loadFaqs() async {
    List<Faq> faqs = await _faqRepository.getFaqs();
    setState(() {
      faqList = faqs;
    });
  }

  Future<void> _addFAQ(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add FAQ'),
          content: SizedBox(
            height: 200.0,
            child: Column(
              children: [
                TextField(
                  controller: questionController,
                  decoration: const InputDecoration(labelText: 'Question'),
                ),
                TextField(
                  controller: answerController,
                  decoration: const InputDecoration(labelText: 'Answer'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[700], // Set the background color
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
                await _saveChanges();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveChanges() async {
    String question = questionController.text;
    String answer = answerController.text;

    if (question.isNotEmpty && answer.isNotEmpty) {
      Faq newFAQ = Faq(
        question: question,
        answer: answer,
      );

      String? faqId = await _faqRepository.addFaq(newFAQ);

      if (faqId != null) {
        _loadFaqs(); 
        questionController.clear();
        answerController.clear();
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Cannot Add the FAQ'),
              actions: [
                TextButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[700], 
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); 
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _editFAQ(BuildContext context, int index) async {
    Faq selectedFAQ = faqList[index];

    editQuestionController.text = selectedFAQ.question;
    editAnswerController.text = selectedFAQ.answer;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit FAQ'),
          content: SizedBox(
            height: 200.0,
            child: Column(
              children: [
                TextField(
                  controller: editQuestionController,
                  decoration: const InputDecoration(labelText: 'Question'),
                ),
                TextField(
                  controller: editAnswerController,
                  decoration: const InputDecoration(labelText: 'Answer'),
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
                await _updateFAQ(index);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateFAQ(int index) async {
    String editedQuestion = editQuestionController.text;
    String editedAnswer = editAnswerController.text;

    if (editedQuestion.isNotEmpty && editedAnswer.isNotEmpty) {
      Faq editedFAQ = Faq(
        question: editedQuestion,
        answer: editedAnswer,
      );

      bool success = await _faqRepository.editFaq(faqList[index].id, editedFAQ);
      if (success) {
        _loadFaqs(); 
        editQuestionController.clear();
        editAnswerController.clear();
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Cannot Edit the FAQ'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); 
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _deleteFAQ(int index) async {
    BuildContext dialogContext = context;
    bool success = await _faqRepository.deleteFaq(faqList[index].id);
    if (success) {
      _loadFaqs(); 
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: dialogContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Cannot Delete the FAQ'),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 20.0,top:20), // Adjust the right padding as needed
            child: Text(
              "Manage FAQ",
              style: TextStyle(
                 color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20.0),
                if (faqList.isNotEmpty) ...[
                  for (int index = 0; index < faqList.length; index++)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      faqList[index].question,
                                      style: TextStyle(
                                        color: Colors.indigo[700],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    color:Color.fromARGB(255, 87, 87, 87),
                                    onPressed: () {
                                      _editFAQ(context, index);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    color:Color.fromARGB(255, 251, 117, 117),
                                    onPressed: () {
                                      _deleteFAQ(index);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            faqList[index].answer,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                ] else
                  const Text(
                    'FAQ is empty',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addFAQ(context);
          },
          backgroundColor: Colors.indigo[700],
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
