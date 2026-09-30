import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/splash_page.dart';
import 'screens/registration_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Foydalanuvchi ma'lumotlarini tekshirish
  final prefs = await SharedPreferences.getInstance();
  final firstName = prefs.getString('firstName');

  runApp(MyApp(showRegistration: firstName == null));
}

class MyApp extends StatelessWidget {
  final bool showRegistration;
  const MyApp({super.key, required this.showRegistration});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: showRegistration ? const RegistrationPage() : const SplashPage(),
    );
  }
}
