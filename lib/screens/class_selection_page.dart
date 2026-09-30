import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class ClassSelectionPage extends StatelessWidget {
  const ClassSelectionPage({super.key});

  Future<void> _selectClass(BuildContext context, int classLevel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('classLevel', classLevel);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(selectedClass: classLevel), // required param qo'shildi
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1C2D),
      appBar: AppBar(
        title: const Text("Sinfni tanlang"),
        backgroundColor: const Color(0xFF0B1C2D),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 30),
            _classCard(context, 1, Colors.orange),
            _classCard(context, 2, Colors.green),
            _classCard(context, 3, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _classCard(BuildContext context, int classLevel, Color color) {
    return GestureDetector(
      onTap: () => _selectClass(context, classLevel),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Center(
          child: Text(
            "$classLevel - SINF",
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
