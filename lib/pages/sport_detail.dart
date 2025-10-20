import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_helloworld/model/sport.dart';
import 'package:flutter_helloworld/pages/order_form_page.dart';

class AppColors {
  static const Color primaryLight = Color(0xFF00264D);
  static const Color accentLight = Color(0xFF0055A4);
  static const Color primaryDark = Color(0xFF0B3A66);
  static const Color accentDark = Color(0xFF4EA0FF);
}

class SportDetailPage extends StatefulWidget {
  final Sport sport;
  final String email;
  final bool darkMode;

  const SportDetailPage({
    super.key,
    required this.sport,
    required this.email,
    required this.darkMode,
  });

  @override
  State<SportDetailPage> createState() => _SportDetailPageState();
}

class _SportDetailPageState extends State<SportDetailPage> {
  int _selectedColorIndex = 0;
  final List<Color> _availableColors = [
    const Color(0xFF0D47A1), // Biru
    const Color(0xFF212121), // Hitam
    const Color(0xFFBDBDBD), // Silver
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final primaryColor = widget.darkMode
        ? AppColors.primaryDark
        : AppColors.primaryLight;
    final accentColor = widget.darkMode
        ? AppColors.accentDark
        : AppColors.accentLight;
    final pageBgColor = widget.darkMode
        ? const Color(0xFF0F1724)
        : const Color(0xFFF4F6FA);
    final textColor = widget.darkMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: pageBgColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: screenHeight * 0.5,
                pinned: true,
                stretch: true,
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    widget.sport.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                  background: Hero(
                    tag: widget.sport.name,
                    child: Image.asset(widget.sport.image, fit: BoxFit.contain),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(textColor),
                              const SizedBox(height: 24),
                              _buildColorSelector(),
                              const SizedBox(height: 24),
                              Text(
                                "Deskripsi",
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.sport.desc,
                                style: TextStyle(
                                  color: textColor.withOpacity(0.7),
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                "Spesifikasi Kunci",
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildKeySpecs(textColor),
                              const SizedBox(height: 100),
                            ],
                          ),
                        ),
                      ]
                      .animate(interval: 100.ms)
                      .fadeIn(duration: 300.ms)
                      .slideY(begin: 0.2),
                ),
              ),
            ],
          ),
          _buildCtaButton(accentColor),
        ],
      ).animate().fadeIn(duration: 300.ms),
    );
  }

  Widget _buildHeader(Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Chip(
          label: const Text("Sport Series"),
          backgroundColor: Colors.red.withOpacity(0.1),
          labelStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: List.generate(
            5,
            (index) => Icon(Icons.star_rounded, color: Colors.amber, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pilihan Warna",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: _availableColors.asMap().entries.map((entry) {
            int index = entry.key;
            Color color = entry.value;
            bool isSelected = _selectedColorIndex == index;

            return GestureDetector(
              onTap: () => setState(() => _selectedColorIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 12),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: Colors.blue, width: 3)
                      : Border.all(color: Colors.grey.shade300, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildKeySpecs(Color textColor) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 2.5,
      children: widget.sport.specs.entries.map((entry) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (widget.darkMode ? Colors.white : Colors.black).withOpacity(
              0.05,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                entry.key,
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                entry.value,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }


  Widget _buildCtaButton(Color accentColor) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              (widget.darkMode
                      ? const Color(0xFF0F1724)
                      : const Color(0xFFF4F6FA))
                  .withOpacity(0.0),
              widget.darkMode
                  ? const Color(0xFF0F1724)
                  : const Color(0xFFF4F6FA),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Harga",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  "Rp ${widget.sport.price}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderFormPage(
                      motor: widget.sport,
                      darkMode: widget.darkMode,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 8,
                shadowColor: accentColor.withOpacity(0.5),
              ),
              child: const Text(
                "Pesan Sekarang",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
