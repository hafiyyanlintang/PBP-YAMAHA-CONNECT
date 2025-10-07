import 'package:flutter/material.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Services"),
        backgroundColor: const Color(0xFF003366),
      ),
      body: const Center(
        child: Text(
          "Halaman Layanan Servis Yamaha",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
