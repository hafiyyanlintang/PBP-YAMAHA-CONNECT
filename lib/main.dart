import 'package:flutter/material.dart';
import 'package:flutter_helloworld/pages/splash.dart';
import 'package:flutter_helloworld/pages/home.dart';
import 'package:flutter_helloworld/pages/product.dart';
import 'package:flutter_helloworld/pages/dealer.dart';
import 'package:flutter_helloworld/pages/service.dart';
import 'package:flutter_helloworld/pages/parts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YAMAHA CONNECT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 140, 255),
        ),
      ),

      // 🔹 Daftar semua route di sini
      routes: {
        '/home': (context) => const HomePage(
          email: "user@email.com",
        ), // nanti bisa diganti dari login
        '/products': (context) => const ProductPage(),
        '/dealers': (context) => const DealerPage(),
        '/services': (context) => const ServicePage(),
        '/parts': (context) => const PartsPage(),
      },

      // 🔹 Tetap mulai dari Splash
      home: const SplashPage(),
    );
  }
}

// by hafiyyan lintang arizaki 24111814048
