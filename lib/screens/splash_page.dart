import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_quiz_app/screens/registration_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    // 4 soniya keyin RegistrationPage ga o'tish
    Timer(const Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RegistrationPage()),
      );
    });

    // Animatsiya controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _bounceAnimation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );

    // Animatsiyani repeat bilan ishga tushirish
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _animatedText(String text, double fontSize, Gradient gradient, {double bounce = 0}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, bounce - _bounceAnimation.value),
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = gradient.createShader(Rect.fromLTWH(0, 0, 300, 0)),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient fon
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Bulut va yulduzlar
          Positioned(top: 50, left: 30, child: Icon(Icons.star, size: 50, color: Colors.white24)),
          Positioned(bottom: 100, right: 50, child: Icon(Icons.star, size: 80, color: Colors.white10)),
          Positioned(top: 150, right: 60, child: Icon(Icons.cloud, size: 100, color: Colors.white30)),

          // Markazdagi animatsiya
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _animatedText(
                  "Quiz App",
                  64,
                  LinearGradient(colors: [Colors.yellowAccent, Colors.orangeAccent]),
                  bounce: 15,
                ),
                const SizedBox(height: 40),
                _animatedText(
                  "Smart Start Maktabi",
                  32,
                  LinearGradient(colors: [Colors.pinkAccent, Colors.orangeAccent, Colors.yellowAccent]),
                  bounce: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
