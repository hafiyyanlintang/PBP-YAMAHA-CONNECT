import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_helloworld/widgets/drawer_widget.dart';

class AppColors {
  static const Color primaryLight = Color(0xFF00264D);
  static const Color accentLight = Color(0xFF0055A4);
  static const Color primaryDark = Color(0xFF0B3A66);
  static const Color accentDark = Color(0xFF4EA0FF);
}

class Dealer {
  final String name;
  final String address;
  final LatLng location;

  Dealer({required this.name, required this.address, required this.location});
}

class DealerPage extends StatefulWidget {
  final String email;
  final bool darkMode;

  const DealerPage({
    super.key,
    required this.email,
    this.darkMode = false,
  });

  @override
  _DealerPageState createState() => _DealerPageState();
}

class _DealerPageState extends State<DealerPage> {
  // MapController 
  final MapController _mapController = MapController();
  int? _selectedDealerIndex;

  final List<Dealer> dealers = [
    Dealer(name: "Yamaha Sentral Jakarta", address: "Jl. Pahlawan No. 1, Jakarta Pusat", location: LatLng(-6.2088, 106.8456)),
    Dealer(name: "Yamaha Bandung Motor", address: "Jl. Sudirman No. 123, Bandung", location: LatLng(-6.9175, 107.6191)),
    Dealer(name: "Yamaha Surabaya Center", address: "Jl. Diponegoro No. 45, Surabaya", location: LatLng(-7.2575, 112.7521)),
    Dealer(name: "Yamaha Yogyakarta Flagship", address: "Jl. Malioboro No. 5, Yogyakarta", location: LatLng(-7.7927, 110.3659)),
    Dealer(name: "Yamaha Medan Utama", address: "Jl. Gatot Subroto No. 67, Medan", location: LatLng(3.587, 98.6784)),
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.darkMode ? AppColors.primaryDark : AppColors.primaryLight;
    final accentColor = widget.darkMode ? AppColors.accentDark : AppColors.accentLight;

    return Scaffold(
      drawer: AppDrawer(email: widget.email, darkMode: widget.darkMode),
      backgroundColor: widget.darkMode ? const Color(0xFF0F1724) : const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text("Dealer Yamaha Terdekat"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, accentColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Map Section
          Expanded(
            flex: 3, 
            child: _buildMapSection(),
          ),
          // Dealer List Section
          Expanded(
            flex: 2, 
            child: _buildDealerListSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    final markers = dealers.asMap().entries.map((entry) {
      int index = entry.key;
      Dealer dealer = entry.value;
      bool isSelected = _selectedDealerIndex == index;

      return Marker(
        width: isSelected ? 120 : 100,
        height: isSelected ? 80 : 70,
        point: dealer.location,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedDealerIndex = index;
            });
            _mapController.move(dealer.location, 13.0);
            _showDealerInfo(context, dealer);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? (widget.darkMode ? AppColors.accentDark : AppColors.accentLight) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 2))],
                  ),
                  child: Text(
                    dealer.name.split(" ").first,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: isSelected ? Colors.white : (widget.darkMode ? Colors.white : AppColors.primaryLight),
                    ),
                  ),
                ),
                Icon(
                  Icons.location_pin,
                  color: isSelected ? Colors.amber : Colors.redAccent,
                  size: isSelected ? 40 : 35,
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: dealers[1].location,
        initialZoom: 6.0,
      ),
      children: [
        TileLayer(
          urlTemplate: widget.darkMode
              ? "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png" 
              : "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(markers: markers),
      ],
    );
  }

  Widget _buildDealerListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: const Text(
            "Pilih Dealer",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ).animate().fadeIn(),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            scrollDirection: Axis.horizontal,
            itemCount: dealers.length,
            itemBuilder: (context, index) {
              final dealer = dealers[index];
              bool isSelected = _selectedDealerIndex == index;
              return _DealerCard(
                dealer: dealer,
                isSelected: isSelected,
                darkMode: widget.darkMode,
                onTap: () {
                  setState(() {
                    _selectedDealerIndex = index;
                  });
                  _mapController.move(dealer.location, 13.0);
                },
              )
              .animate()
              .fadeIn(delay: Duration(milliseconds: 200 + (index * 100)))
              .slideX(begin: 0.5, curve: Curves.easeOut);
            },
          ),
        ),
      ],
    );
  }

  void _showDealerInfo(BuildContext context, Dealer dealer) {
  }
}

class _DealerCard extends StatelessWidget {
  final Dealer dealer;
  final bool isSelected;
  final bool darkMode;
  final VoidCallback onTap;

  const _DealerCard({
    required this.dealer,
    required this.isSelected,
    required this.darkMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = darkMode ? AppColors.primaryDark : Colors.white;
    final textColor = darkMode ? Colors.white : AppColors.primaryLight;
    final accentColor = darkMode ? AppColors.accentDark : AppColors.accentLight;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 280,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: accentColor, width: 2.5) : null,
          boxShadow: [
            BoxShadow(
              color: (darkMode ? Colors.black : Colors.grey).withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dealer.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? accentColor : textColor,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.redAccent, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      dealer.address,
                      style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.7)),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_forward_ios_rounded, color: textColor.withOpacity(0.5)),
              )
            ],
          ),
        ),
      ),
    );
  }
}