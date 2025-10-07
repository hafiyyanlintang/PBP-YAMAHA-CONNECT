import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter_helloworld/model/product.dart';

class HomePage extends StatelessWidget {
  final String email;
  const HomePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 4,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF003366), Color(0xFF0055A4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          children: [
            Image.asset("assets/logoyamaha.png", height: 40),
            const SizedBox(width: 10),
            const Text(
              "Yamaha Dealer",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Welcome text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Selamat Datang, $email 👋",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Image Carousel
              cs.CarouselSlider(
                options: cs.CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.25,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.95,
                  aspectRatio: 16 / 9,
                ),
                items:
                    [
                      "assets/slider1.jpg",
                      "assets/slider2.jpg",
                      "assets/slider3.jpg",
                    ].map((path) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          path,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    }).toList(),
              ),

              const SizedBox(height: 20),

              // Product Category
              const Center(
                child: Text(
                  "PRODUCT CATEGORY",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Color(0xFF003366),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 Product List
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _AnimatedProductCard(
                      title: product.title,
                      imagePath: product.imagePath,
                      description: product.description,
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

          // 🔹 Side Menu (4 tombol aktif)
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 75,
              decoration: BoxDecoration(
                color: Colors.blue[900]!.withOpacity(0.85),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSideMenu(
                    context,
                    Icons.motorcycle,
                    "Products",
                    "/products",
                  ),
                  _buildSideMenu(context, Icons.store, "Dealers", "/dealers"),
                  _buildSideMenu(context, Icons.build, "Services", "/services"),
                  _buildSideMenu(context, Icons.settings, "Parts", "/parts"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Side Menu Item dengan Navigasi
  Widget _buildSideMenu(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedProductCard extends StatefulWidget {
  final String title;
  final String imagePath;
  final String description;
  final VoidCallback? onTap;

  const _AnimatedProductCard({
    required this.title,
    required this.imagePath,
    required this.description,
    this.onTap,
  });

  @override
  State<_AnimatedProductCard> createState() => _AnimatedProductCardState();
}

class _AnimatedProductCardState extends State<_AnimatedProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.identity()
            ..scale(_isHovered ? 1.07 : 1.0)
            ..translate(0, _isHovered ? -8 : 0),
          width: 200,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? Colors.black.withOpacity(0.25)
                    : Colors.black.withOpacity(0.1),
                blurRadius: _isHovered ? 12 : 6,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Hero(
                  tag: widget.title,
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                    height: 130,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF003366),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.description,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
