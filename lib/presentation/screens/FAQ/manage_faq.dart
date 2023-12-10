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
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
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
        _loadFaqs(); // Reload FAQs after adding
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
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
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
              
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
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
        _loadFaqs(); // Reload FAQs after editing
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
                    Navigator.of(context).pop(); // Dismiss the dialog
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
      _loadFaqs(); // Reload FAQs after deleting
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: dialogContext, // Use the stored context here
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
          title: const Text('Manage FAQ List'),
        ),
        backgroundColor: Colors.grey[100],
        body: Padding(
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
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Q ${faqList[index].question}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'A ${faqList[index].answer}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color:Colors.indigo[700],
                            onPressed: () {
                              _editFAQ(context, index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color:Colors.indigo[700],
                            onPressed: () {
                              _deleteFAQ(index);
                            },
                          ),
                        ],
                      ),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addFAQ(context);
          },
           child: Icon(
            Icons.add,
            color: Colors.indigo[700], 
          ),
      ),
    );
  }
}
