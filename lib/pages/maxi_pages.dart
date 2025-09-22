import 'package:flutter/material.dart';
import 'package:flutter_helloworld/model/maxi.dart';
import 'package:flutter_helloworld/pages/maxi_detail.dart';

class MaxiPage extends StatelessWidget {
  const MaxiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kategori MAXI")),
      body: ListView.builder(
        itemCount: maxis.length,
        itemBuilder: (context, index) {
          final maxi = maxis[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Hero(
                tag: maxi.name,
                child: Image.asset(maxi.image, width: 50),
              ),
              title: Text(
                maxi.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Rp ${maxi.price}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MaxiDetailPage(maxi: maxi)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
