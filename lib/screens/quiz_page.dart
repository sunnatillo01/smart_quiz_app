import 'package:flutter/material.dart';
import 'package:smart_quiz_app/models.dart/level.dart';

class QuizPage extends StatefulWidget {
  final Level level;
  final int levelNumber;
  QuizPage({Key? key, required this.level, required this.levelNumber}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with SingleTickerProviderStateMixin {
  int currentQuestion = 0;
  int score = 0;
  bool answered = false;
  int selectedIndex = -1;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void nextQuestion() {
    setState(() {
      answered = false;
      selectedIndex = -1;
      currentQuestion += 1;
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.level.questions;

    return Scaffold(
      body: Stack(
        children: [
          // 🌌 Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade900, Colors.indigo.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // ☁️ Clouds
          Positioned(top: 30, left: 30, child: Icon(Icons.cloud, size: 80, color: Colors.white24)),
          Positioned(top: 150, right: 30, child: Icon(Icons.cloud, size: 60, color: Colors.white30)),
          Positioned(bottom: 100, left: 20, child: Icon(Icons.cloud, size: 100, color: Colors.white10)),

          // 📝 Quiz container
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: currentQuestion < questions.length
                ? FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurple.shade700.withOpacity(0.95),
                              Colors.indigo.shade600.withOpacity(0.95),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 12,
                              offset: const Offset(4, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 🔝 Header: Back icon + Level
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.purple.shade300,
                                    Colors.deepPurple.shade400,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: const Icon(Icons.arrow_back_ios_rounded,
                                        color: Colors.white, size: 28),
                                  ),
                                  Text(
                                    "Level ${widget.levelNumber}: ${widget.level.title}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 3,
                                          color: Colors.black45,
                                          offset: Offset(1, 1),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 28),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Progress bar
                            LinearProgressIndicator(
                              value: (currentQuestion + 1) / questions.length,
                              backgroundColor: Colors.white24,
                              color: Colors.yellowAccent.shade400,
                              minHeight: 10,
                            ),
                            const SizedBox(height: 20),

                            // Question text
                            Text(
                              questions[currentQuestion].question,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                shadows: [
                                  Shadow(
                                    blurRadius: 2,
                                    color: Colors.black38,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Options
                            Column(
                              children: questions[currentQuestion].options
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int idx = entry.key;
                                String option = entry.value;

                                Color btnColor = Colors.deepPurple.shade400;
                                if (answered) {
                                  if (idx == selectedIndex) {
                                    btnColor = option == questions[currentQuestion].answer
                                        ? Colors.greenAccent.shade400
                                        : Colors.redAccent.shade400;
                                  } else if (option == questions[currentQuestion].answer) {
                                    btnColor = Colors.greenAccent.shade400;
                                  }
                                }

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: btnColor,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: 5,
                                    ),
                                    onPressed: answered
                                        ? null
                                        : () {
                                            setState(() {
                                              answered = true;
                                              selectedIndex = idx;
                                              if (option == questions[currentQuestion].answer)
                                                score += 1;
                                            });

                                            Future.delayed(const Duration(seconds: 1), () {
                                              if (currentQuestion + 1 < questions.length) {
                                                nextQuestion();
                                              } else {
                                                int progress =
                                                    ((score / questions.length) * 100)
                                                        .toInt();
                                                int stars = 0;
                                                if (progress >= 80)
                                                  stars = 3;
                                                else if (progress >= 50)
                                                  stars = 2;
                                                else if (progress >= 20)
                                                  stars = 1;

                                                Navigator.pop(context,
                                                    {'progress': progress, 'stars': stars});
                                              }
                                            });
                                          },
                                    child: Text(
                                      option,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                              blurRadius: 2,
                                              color: Colors.black38,
                                              offset: Offset(1, 1))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: Text("No questions found",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
          ),
        ],
      ),
    );
  }
}
