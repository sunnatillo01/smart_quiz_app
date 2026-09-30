// english_levels.dart
import 'package:smart_quiz_app/models.dart/level.dart';

// ================== 1-SINF ==================
final List<Level> englishLevels1 = [
  for (int i = 1; i <= 10; i++)
    Level(
      classLevel: 1,
      title: "Level $i",
      questions: [
        Question(
            question: "What is the color of the sky?",
            options: ["Red", "Blue", "Green"],
            answer: "Blue"),
        Question(
            question: "What is 1 + 1 in English?",
            options: ["One", "Two", "Three"],
            answer: "Two"),
        Question(
            question: "Select the correct word: 'C__t'?",
            options: ["Cat", "Cot", "Cut"],
            answer: "Cat"),
        Question(
            question: "Which word is an animal?",
            options: ["Apple", "Dog", "Chair"],
            answer: "Dog"),
        Question(
            question: "How do you say '1' in English?",
            options: ["One", "Two", "Three"],
            answer: "One"),
      ],
    ),
];

// ================== 2-SINF ==================
final List<Level> englishLevels2 = [
  for (int i = 1; i <= 10; i++)
    Level(
      classLevel: 2,
      title: "Level $i",
      questions: [
        Question(
            question: "Which is a fruit?",
            options: ["Banana", "Car", "Table"],
            answer: "Banana"),
        Question(
            question: "Choose the correct word: 'B__ok'?",
            options: ["Book", "Back", "Buck"],
            answer: "Book"),
        Question(
            question: "How do you say '5' in English?",
            options: ["Five", "Four", "Six"],
            answer: "Five"),
        Question(
            question: "Select the plural of 'cat'",
            options: ["Cats", "Cates", "Cati"],
            answer: "Cats"),
        Question(
            question: "Which one is a vehicle?",
            options: ["Bike", "Apple", "Dog"],
            answer: "Bike"),
      ],
    ),
];

// ================== 3-SINF ==================
final List<Level> englishLevels3 = [
  for (int i = 1; i <= 10; i++)
    Level(
      classLevel: 3,
      title: "Level $i",
      questions: [
        Question(
            question: "What is the opposite of 'Hot'?",
            options: ["Cold", "Warm", "Tall"],
            answer: "Cold"),
        Question(
            question: "Choose the correct word: 'T__ble'?",
            options: ["Table", "Tuble", "Tible"],
            answer: "Table"),
        Question(
            question: "How do you say '10' in English?",
            options: ["Ten", "Twelve", "Nine"],
            answer: "Ten"),
        Question(
            question: "Select the correct sentence",
            options: ["I is happy", "I am happy", "I be happy"],
            answer: "I am happy"),
        Question(
            question: "Which one is a living thing?",
            options: ["Chair", "Cat", "Book"],
            answer: "Cat"),
      ],
    ),
];
