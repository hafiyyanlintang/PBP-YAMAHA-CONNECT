import 'package:flutter/material.dart';
import 'package:flutter_helloworld/model/sport.dart';
import 'package:flutter_helloworld/pages/sport_detail.dart';

class SportPage extends StatelessWidget {
  const SportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kategori SPORT")),
      body: ListView.builder(
        itemCount: sports.length,
        itemBuilder: (context, index) {
          final sport = sports[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Hero(
                tag: sport.name,
                child: Image.asset(sport.image, width: 50),
              ),
              title: Text(
                sport.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Rp ${sport.price}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SportDetailPage(sport: sport),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
