import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_helloworld/pages/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const LoginPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 1000),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF00264D);
    const Color accentColor = Color(0xFF0055A4);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, accentColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/logoyamaha.png", height: 120)
                  .animate()
                  .fadeIn(duration: 900.ms, curve: Curves.easeOut)
                  .scale(delay: 200.ms, duration: 700.ms, curve: Curves.elasticOut)
                  .then(delay: 500.ms) 
                  .shimmer(duration: 1200.ms, color: Colors.white.withOpacity(0.5)) 
                  .then() 
                  .shake(duration: 800.ms, hz: 3, curve: Curves.easeInOut),
              const SizedBox(height: 20),
              const Text(
                "YAMAHA CONNECT",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ).animate().fadeIn(delay: 800.ms, duration: 800.ms).slideY(begin: 0.5),

              const SizedBox(height: 10),

              const Text(
                "By Hafiyyan Lintang Arizaki",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ).animate().fadeIn(delay: 1000.ms, duration: 800.ms),
            ],
          ),
        ),
      ),
    );
  }
}