import 'package:flutter/material.dart';
import 'package:flutter_helloworld/model/maxi.dart';

class MaxiDetailPage extends StatelessWidget {
  final Maxi maxi;

  const MaxiDetailPage({super.key, required this.maxi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(maxi.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: maxi.name,
                child: Image.asset(maxi.image, width: 200),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              maxi.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            //  bukti polymorphism
            Text(
              maxi.getCategory(),
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 12),
            Text(maxi.desc),
            const SizedBox(height: 12),
            Text(
              "Harga: Rp ${maxi.price}",
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
