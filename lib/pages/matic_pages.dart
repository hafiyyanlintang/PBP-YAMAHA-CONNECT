import 'package:flutter/material.dart';
import 'package:flutter_helloworld/model/matic.dart';
import 'package:flutter_helloworld/pages/matic_detail.dart';

class MaticPage extends StatelessWidget {
  const MaticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kategori Matic")),
      body: ListView.builder(
        itemCount: matics.length,
        itemBuilder: (context, index) {
          final matic = matics[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Hero(
                tag: matic.name,
                child: Image.asset(matic.image, width: 50),
              ),
              title: Text(
                matic.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Rp ${matic.price}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MaticDetailPage(matic: matic),
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
