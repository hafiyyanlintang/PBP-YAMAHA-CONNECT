import 'package:flutter/material.dart';
import 'package:flutter_helloworld/model/matic.dart';

class MaticDetailPage extends StatelessWidget {
  final Matic matic;

  const MaticDetailPage({super.key, required this.matic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(matic.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: matic.name,
                child: Image.asset(matic.image, width: 200),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              matic.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // 🔑 bukti polymorphism
            Text(
              matic.getCategory(),
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 12),
            Text(matic.desc),
            const SizedBox(height: 12),
            Text(
              "Harga: Rp ${matic.price}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
