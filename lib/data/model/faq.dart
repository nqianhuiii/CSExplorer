import 'dart:math';

class Faq {
  late String id; // Change to String
  late String question;
  late String answer;

  Faq({
    required this.question,
    required this.answer,
  }) : id = _generateRandomId();

  static String _generateRandomId() {
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    final int random = Random().nextInt(100000);
    return '$timestamp$random';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }
}
