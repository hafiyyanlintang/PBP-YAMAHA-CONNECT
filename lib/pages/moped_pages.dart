import 'package:flutter/material.dart';
import 'package:flutter_helloworld/model/moped.dart';
import 'package:flutter_helloworld/pages/moped_detail.dart';

class MopedPage extends StatelessWidget {
  const MopedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kategori MOPED")),
      body: ListView.builder(
        itemCount: mopeds.length,
        itemBuilder: (context, index) {
          final moped = mopeds[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Hero(
                tag: moped.name,
                child: Image.asset(moped.image, width: 50),
              ),
              title: Text(
                moped.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Rp ${moped.price}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MopedDetailPage(moped: moped),
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
