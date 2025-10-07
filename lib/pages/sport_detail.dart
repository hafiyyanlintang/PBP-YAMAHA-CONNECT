import 'package:flutter/material.dart';
import 'package:flutter_helloworld/model/sport.dart';

class SportDetailPage extends StatelessWidget {
  final Sport sport;

  const SportDetailPage({super.key, required this.sport});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sport.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: sport.name,
                child: Image.asset(sport.image, width: 200),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              sport.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              sport.getCategory(),
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Text(sport.desc),
            const SizedBox(height: 12),
            Text(
              "Harga: Rp ${sport.price}",
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
