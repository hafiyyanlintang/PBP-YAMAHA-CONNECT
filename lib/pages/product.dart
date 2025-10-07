import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: const Color(0xFF003366),
      ),
      body: const Center(
        child: Text("Halaman Produk Yamaha", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
