

class QuizController {
  int currentIndex = 0;
  int score = 0;

  // Progress (foiz)
  double getProgress(int total) {
    return (currentIndex + 1) / total;
  }

  void checkAnswer(int selectedIndex, int correctIndex) {
    if (selectedIndex == correctIndex) {
      score++;
    }
  }

  void next(int totalQuestions) {
    if (currentIndex < totalQuestions - 1) {
      currentIndex++;
    }
  }

  bool isFinished(int totalQuestions) {
    return currentIndex >= totalQuestions - 1;
  }
}
