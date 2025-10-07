import 'package:flutter/material.dart';

class PartsPage extends StatelessWidget {
  const PartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parts"),
        backgroundColor: const Color(0xFF003366),
      ),
      body: const Center(
        child: Text(
          "Halaman Suku Cadang Yamaha",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
