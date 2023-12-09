import 'package:flutter/material.dart';

class FAQ {
  String question;
  String answer;

  FAQ(this.question, this.answer);
}

class ManageFAQ extends StatefulWidget {
  const ManageFAQ({Key? key}) : super(key: key);

  @override
  State<ManageFAQ> createState() => _ManageFAQState();
}

class _ManageFAQState extends State<ManageFAQ> {
  List<FAQ> faqList = [];
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  TextEditingController editQuestionController = TextEditingController();
  TextEditingController editAnswerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage FAQ List'),
         
        ),
        backgroundColor: const Color(0xFFF8FBFF),
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
                            onPressed: () {
                              _editFAQ(context, index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteFAQ(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addFAQ(context);
          },
          backgroundColor: const Color(0xFF15B3B6),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _addFAQ(BuildContext context) {
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
              onPressed: () {
                _saveChanges();
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _saveChanges() {
    String question = questionController.text;
    String answer = answerController.text;

    if (question.isNotEmpty && answer.isNotEmpty) {
      FAQ newFAQ = FAQ(question, answer);

      setState(() {
        faqList.add(newFAQ);
      });

      questionController.clear();
      answerController.clear();
    }
  }

  void _editFAQ(BuildContext context, int index) {
    FAQ selectedFAQ = faqList[index];

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
              onPressed: () {
                _updateFAQ(index);
                Navigator.pop(context);
              },
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  void _updateFAQ(int index) {
    String editedQuestion = editQuestionController.text;
    String editedAnswer = editAnswerController.text;

    if (editedQuestion.isNotEmpty && editedAnswer.isNotEmpty) {
      FAQ editedFAQ = FAQ(editedQuestion, editedAnswer);

      setState(() {
        faqList[index] = editedFAQ;
      });

      editQuestionController.clear();
      editAnswerController.clear();
    }
  }

  void _deleteFAQ(int index) {
    setState(() {
      faqList.removeAt(index);
    });
  }
}
