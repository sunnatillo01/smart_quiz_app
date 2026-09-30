class Level {
  final int classLevel; // 1,2,3...
  final String title;
  final List<Question> questions;

  Level({
    required this.classLevel,
    required this.title,
    required this.questions,
  });
}

class Question {
  final String question;
  final List<String> options;
  final String answer;

  Question({
    required this.question,
    required this.options,
    required this.answer,
  });
}
