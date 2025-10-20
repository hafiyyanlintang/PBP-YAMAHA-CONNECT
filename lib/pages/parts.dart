import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_helloworld/widgets/drawer_widget.dart';
import 'package:flutter_helloworld/model/part.dart';
import 'package:intl/intl.dart';

class AppColors {
  static const Color primaryLight = Color(0xFF00264D);
  static const Color accentLight = Color(0xFF0055A4);
  static const Color primaryDark = Color(0xFF0B3A66);
  static const Color accentDark = Color(0xFF4EA0FF);
}

class PartPage extends StatefulWidget {
  final String email;
  final bool darkMode;

  const PartPage({
    super.key,
    required this.email,
    this.darkMode = false,
  });

  @override
  State<PartPage> createState() => _PartPageState();
}

class _PartPageState extends State<PartPage> {
  Timer? _timer;
  Alignment _beginAlignment = Alignment.topLeft;
  Alignment _endAlignment = Alignment.bottomRight;

  final List<String> _filters = ['Semua', 'Original', 'Aksesoris', 'Promo']; 
  String _selectedFilter = 'Semua'; 

  List<Part> _filteredParts = [];

  final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    _applyFilter();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _beginAlignment = [Alignment.topRight, Alignment.bottomLeft, Alignment.topLeft, Alignment.bottomRight][timer.tick % 4];
          _endAlignment = [Alignment.bottomLeft, Alignment.topRight, Alignment.bottomRight, Alignment.topLeft][timer.tick % 4];
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _applyFilter() {
    setState(() {
      if (_selectedFilter == 'Semua') {
        _filteredParts = partsData; 
      } else {
        _filteredParts = partsData.where((part) => part.category == _selectedFilter).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.darkMode ? AppColors.primaryDark : AppColors.primaryLight;
    final accentColor = widget.darkMode ? AppColors.accentDark : AppColors.accentLight;

    return Scaffold(
      drawer: AppDrawer(email: widget.email, darkMode: widget.darkMode),
      body: AnimatedContainer(
        duration: const Duration(seconds: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.darkMode
                ? [const Color(0xFF0F1724), const Color(0xFF08213A)]
                : [accentColor, primaryColor],
            begin: _beginAlignment,
            end: _endAlignment,
          ),
        ),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text("Yamaha Parts"),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
                pinned: true,
                floating: true,
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildFilterChips(),
                  ],
                ),
              ),
            ];
          },
          body: _buildPartsGrid(),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cari Sparepart Motor Kamu 🔧",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text("Pilih kategori atau filter di bawah ini:", style: TextStyle(color: Colors.white.withOpacity(0.8))),
        ],
      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          final accentColor = widget.darkMode ? AppColors.accentDark : Colors.white;
          final chipColor = widget.darkMode ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.7);
          final selectedTextColor = widget.darkMode ? Colors.black : AppColors.primaryLight; 
          final unselectedTextColor = widget.darkMode ? Colors.white : AppColors.primaryLight; 

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = selected ? filter : 'Semua';
                });
                _applyFilter();
              },
              backgroundColor: chipColor,
              selectedColor: accentColor,
              labelStyle: TextStyle(
                color: isSelected ? selectedTextColor : unselectedTextColor,
                fontWeight: FontWeight.bold,
              ),
              shape: StadiumBorder(side: BorderSide(color: widget.darkMode ? Colors.white.withOpacity(0.3) : Colors.transparent)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          );
        }).toList().animate(interval: 100.ms).fadeIn().slideX(begin: 0.5),
      ),
    );
  }

  Widget _buildPartsGrid() {
    if (_filteredParts.isEmpty) {
      return Center(
        child: Text(
          "Sparepart tidak ditemukan...",
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16),
        ).animate().fadeIn(),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: _filteredParts.length,
        itemBuilder: (context, index) {
          final part = _filteredParts[index];
          return _PartCard(part: part)
              .animate()
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.5, delay: Duration(milliseconds: 50 * index), curve: Curves.easeOutCubic);
        },
      ),
    );
  }
}

class _PartCard extends StatelessWidget {
  const _PartCard({required this.part});

  final Part part;

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    part.imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.broken_image, color: Colors.grey, size: 40));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      part.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      currencyFormatter.format(part.price),
                      style: TextStyle(color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}