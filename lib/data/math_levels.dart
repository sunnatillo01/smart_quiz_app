// math_levels.dart
import 'package:smart_quiz_app/models.dart/level.dart';

// ================== 1-SINF ==================
final List<Level> mathLevels1 = [
  for (int i = 1; i <= 10; i++)
    Level(
      classLevel: 1,
      title: "Level $i",
      questions: [
        Question(question: "$i + 1 = ?", options: ["$i", "${i+1}", "${i+2}"], answer: "${i+1}"),
        Question(question: "$i + 2 = ?", options: ["${i+1}", "${i+2}", "${i+3}"], answer: "${i+2}"),
        Question(question: "$i + 3 = ?", options: ["${i+2}", "${i+3}", "${i+4}"], answer: "${i+3}"),
        Question(question: "$i + 4 = ?", options: ["${i+3}", "${i+4}", "${i+5}"], answer: "${i+4}"),
        Question(question: "$i + 5 = ?", options: ["${i+4}", "${i+5}", "${i+6}"], answer: "${i+5}"),
      ],
    ),
];

// ================== 2-SINF ==================
final List<Level> mathLevels2 = [
  for (int i = 1; i <= 10; i++)
    Level(
      classLevel: 2,
      title: "Level $i",
      questions: [
        Question(question: "$i × 2 = ?", options: ["${i*1}", "${i*2}", "${i*3}"], answer: "${i*2}"),
        Question(question: "$i × 3 = ?", options: ["${i*2}", "${i*3}", "${i*4}"], answer: "${i*3}"),
        Question(question: "$i + ${i+2} = ?", options: ["${i+2}", "${i+3}", "${i*2}"], answer: "${i+2+i}"),
        Question(question: "${i*3} - $i = ?", options: ["${i*2}", "${i*3}", "${i*4}"], answer: "${i*2}"),
        Question(question: "$i × 4 = ?", options: ["${i*3}", "${i*4}", "${i*5}"], answer: "${i*4}"),
      ],
    ),
];

// ================== 3-SINF ==================
final List<Level> mathLevels3 = [
  for (int i = 1; i <= 10; i++)
    Level(
      classLevel: 3,
      title: "Level $i",
      questions: [
        Question(question: "$i × 5 = ?", options: ["${i*4}", "${i*5}", "${i*6}"], answer: "${i*5}"),
        Question(question: "$i × 6 = ?", options: ["${i*5}", "${i*6}", "${i*7}"], answer: "${i*6}"),
        Question(question: "$i × 7 = ?", options: ["${i*6}", "${i*7}", "${i*8}"], answer: "${i*7}"),
        Question(question: "${i*10} ÷ $i = ?", options: ["9", "10", "11"], answer: "10"),
        Question(question: "${i*12} ÷ $i = ?", options: ["11", "12", "13"], answer: "12"),
      ],
    ),
];
