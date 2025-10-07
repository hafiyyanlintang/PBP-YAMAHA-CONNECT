import 'package:flutter/material.dart';
import 'package:flutter_helloworld/model/classy.dart';

class ClassyDetailPage extends StatelessWidget {
  final Classy classy;

  const ClassyDetailPage({super.key, required this.classy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(classy.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: classy.name,
                child: Image.asset(classy.image, width: 200),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              classy.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              classy.getCategory(),
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Text(classy.desc),
            const SizedBox(height: 12),
            Text(
              "Harga: Rp ${classy.price}",
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
