import 'package:flutter/material.dart';
import 'package:flutter_helloworld/model/classy.dart';
import 'package:flutter_helloworld/pages/classy_detail.dart';

class ClassyPage extends StatelessWidget {
  const ClassyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kategori CLASSY")),
      body: ListView.builder(
        itemCount: classies.length,
        itemBuilder: (context, index) {
          final classy = classies[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Hero(
                tag: classy.name,
                child: Image.asset(classy.image, width: 50),
              ),
              title: Text(
                classy.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Rp ${classy.price}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ClassyDetailPage(classy: classy),
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
