import 'package:flutter/material.dart';
import 'package:flutter_helloworld/model/moped.dart';

class MopedDetailPage extends StatelessWidget {
  final Moped moped;

  const MopedDetailPage({super.key, required this.moped});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(moped.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: moped.name,
                child: Image.asset(moped.image, width: 200),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              moped.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              moped.getCategory(),
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Text(moped.desc),
            const SizedBox(height: 12),
            Text(
              "Harga: Rp ${moped.price}",
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
