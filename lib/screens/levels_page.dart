import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_quiz_app/models.dart/level.dart';
import 'quiz_page.dart';

import '../data/math_levels.dart';
import '../data/english_levels.dart';

class LevelPage extends StatefulWidget {
  final String subject;
  final int selectedClass; // 1, 2, 3
  const LevelPage({Key? key, required this.subject, required this.selectedClass}) : super(key: key);

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  late List<Level> levels;
  Map<int, int> levelProgress = {};
  Map<int, int> levelStars = {};
  String firstName = '';
  String lastName = '';

  @override
  void initState() {
    super.initState();
    _loadLevels();
    _loadProgress();
    _loadUserName();
  }

  void _loadLevels() {
    // Sinf va fanga qarab levelsni tanlash
    if (widget.subject == "math") {
      if (widget.selectedClass == 1) levels = mathLevels1;
      else if (widget.selectedClass == 2) levels = mathLevels2;
      else levels = mathLevels3;
    } else {
      if (widget.selectedClass == 1) levels = englishLevels1;
      else if (widget.selectedClass == 2) levels = englishLevels2;
      else levels = englishLevels3;
    }
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    Map<int, int> loadedProgress = {};
    Map<int, int> loadedStars = {};

    for (int i = 0; i < levels.length; i++) {
      loadedProgress[i] =
          prefs.getInt('${widget.subject}_${widget.selectedClass}_level_${i}_progress') ?? 0;
      loadedStars[i] =
          prefs.getInt('${widget.subject}_${widget.selectedClass}_level_${i}_stars') ?? 0;
    }

    setState(() {
      levelProgress = loadedProgress;
      levelStars = loadedStars;
    });
  }

  Future<void> _saveProgress(int index, int progress, int stars) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${widget.subject}_${widget.selectedClass}_level_${index}_progress', progress);
    await prefs.setInt('${widget.subject}_${widget.selectedClass}_level_${index}_stars', stars);

    setState(() {
      levelProgress[index] = progress;
      levelStars[index] = stars;
    });
  }

  bool _isLevelLocked(int index) {
    if (index == 0) return false;
    int prevStars = levelStars[index - 1] ?? 0;
    return prevStars < 2;
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final fName = prefs.getString('firstName') ?? '';
    final lName = prefs.getString('lastName') ?? '';
    setState(() {
      firstName = fName;
      lastName = lName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // Clouds
            Positioned(top: 40, left: 30, child: Icon(Icons.cloud, size: 80, color: Colors.white24)),
            Positioned(top: 150, right: 30, child: Icon(Icons.cloud, size: 60, color: Colors.white30)),
            Positioned(bottom: 100, left: 20, child: Icon(Icons.cloud, size: 100, color: Colors.white10)),

            // User Name Container
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  (firstName.isNotEmpty && lastName.isNotEmpty)
                      ? "$firstName $lastName!"
                      : "Hello, Guest!",
                  style: const TextStyle(
                      color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Home/Back icon
            Positioned(
              top: 16,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),

            // Levels Grid
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 16, right: 16, bottom: 16),
              child: GridView.builder(
                itemCount: levels.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final progress = levelProgress[index] ?? 0;
                  final stars = levelStars[index] ?? 0;
                  final isLocked = _isLevelLocked(index);

                  return Stack(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: isLocked
                            ? null
                            : () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => QuizPage(
                                      level: levels[index],
                                      levelNumber: index + 1,
                                    ),
                                  ),
                                );

                                if (result != null && result is Map<String, int>) {
                                  _saveProgress(index, result['progress'] ?? 0,
                                      result['stars'] ?? 0);
                                }
                              },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF7B61FF), Color(0xFF9C7BFF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Level number container
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "Level ${index + 1}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              const SizedBox(height: 12),
                              if (progress > 0)
                                Container(
                                  width: 100,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: progress / 100,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.yellowAccent,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 10),
                              if (stars > 0)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(3, (i) {
                                    return Icon(
                                      i < stars ? Icons.star : Icons.star_border,
                                      color: Colors.yellowAccent,
                                      size: 24,
                                    );
                                  }),
                                ),
                            ],
                          ),
                        ),
                      ),
                      // Lock overlay
                      if (isLocked)
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.55),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Icon(Icons.lock, color: Colors.white, size: 40),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
