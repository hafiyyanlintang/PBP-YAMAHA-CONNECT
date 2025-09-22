import 'package:flutter/material.dart';
import 'package:flutter_helloworld/model/product.dart';

class HomePage extends StatelessWidget {
  final String email; // dari login

  const HomePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("assets/logoyamaha.png", height: 40),
            const SizedBox(width: 10),
            const Text(
              "Yamaha Dealer",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: const [
          _AppBarMenuItem("Products"),
          _AppBarMenuItem("Dealers"),
          _AppBarMenuItem("Services"),
          _AppBarMenuItem("Parts"),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Selamat Datang, $email",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "PRODUCT CATEGORY",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // daftar produk
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(16),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _buildProductCard(
                      context,
                      product.title,
                      product.imagePath,
                      product.description,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => product.page),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          // side menu
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 80,
              color: Colors.blue[900],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSideMenu(Icons.motorcycle, "Product"),
                  _buildSideMenu(Icons.store, "Dealer"),
                  _buildSideMenu(Icons.credit_card, "Credit"),
                  _buildSideMenu(Icons.headset_mic, "Konsultasi"),
                  _buildSideMenu(Icons.build, "Service"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // card produk
  Widget _buildProductCard(
    BuildContext context,
    String title,
    String imagePath,
    String description, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: title,
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSideMenu(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _AppBarMenuItem extends StatelessWidget {
  final String text;
  const _AppBarMenuItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Center(child: Text(text, style: const TextStyle(fontSize: 14))),
    );
  }
}
