import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_quiz_app/screens/class_selection_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  // Foydalanuvchi ma’lumotlarini saqlash
  Future<void> _saveUserData() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('firstName', _firstNameController.text.trim());
      await prefs.setString('lastName', _lastNameController.text.trim());

      // ClassSelectionPage ga o‘tish
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ClassSelectionPage()),
      );
    }
  }

  // Faqat harflar tekshirish
  String? _validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName maydonini to‘ldiring";
    }
    final regex = RegExp(r'^[a-zA-Z]+$');
    if (!regex.hasMatch(value.trim())) {
      return "$fieldName faqat harflardan iborat bo‘lishi kerak";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fon gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Bulutlar
          Positioned(top: 50, left: 20, child: Icon(Icons.cloud, size: 80, color: Colors.white24)),
          Positioned(top: 120, right: 40, child: Icon(Icons.cloud, size: 60, color: Colors.white30)),
          Positioned(bottom: 150, left: 50, child: Icon(Icons.cloud, size: 100, color: Colors.white10)),

          // Tepadagi yozuvlar
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Column(
              children: [
                // Smart Start gradient yozuvi
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.yellowAccent, Colors.orangeAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: const Text(
                    "Smart Start Maktabi",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // gradient orqali ko‘rinadi
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '"Ilm ahloq bilan olinsagina, foyda beradi"',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Form container
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 180),
              child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ✨ Xush kelibsiz
                      Text(
                        "Xush Kelibsiz",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellowAccent.shade400,
                          shadows: const [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.black38,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      // ✨ Ro'yxatdan o'ting
                      const Text(
                        "Ro‘yxatdan o‘ting",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      // 🔹 Ism
                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: "Ism",
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white24,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) => _validateName(value, "Ism"),
                      ),
                      const SizedBox(height: 16),
                      // 🔹 Familiya
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText: "Familiya",
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white24,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) => _validateName(value, "Familiya"),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _saveUserData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellowAccent.shade400,
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          "Davom etish",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
