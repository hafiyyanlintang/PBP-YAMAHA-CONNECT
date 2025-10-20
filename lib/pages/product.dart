import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_helloworld/model/motor.dart';
import 'package:flutter_helloworld/model/maxi.dart';
import 'package:flutter_helloworld/model/classy.dart';
import 'package:flutter_helloworld/model/matic.dart';
import 'package:flutter_helloworld/model/sport.dart';
import 'package:flutter_helloworld/model/moped.dart';
import 'package:flutter_helloworld/pages/maxi_detail.dart';
import 'package:flutter_helloworld/pages/classy_detail.dart';
import 'package:flutter_helloworld/pages/matic_detail.dart';
import 'package:flutter_helloworld/pages/sport_detail.dart';
import 'package:flutter_helloworld/pages/moped_detail.dart';
import 'package:flutter_helloworld/widgets/drawer_widget.dart'; 

class AppColors {
  static const Color primaryLight = Color(0xFF00264D);
  static const Color accentLight = Color(0xFF0055A4);
  static const Color primaryDark = Color(0xFF0B3A66);
  static const Color accentDark = Color(0xFF4EA0FF);
}

class ProductPage extends StatefulWidget {
  final bool darkMode;
  final String email;

  const ProductPage({
    super.key,
    this.darkMode = false,
    required this.email
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String selectedCategory = 'MAXI';
  List<Motor> displayedMotors = maxis;

  Timer? _timer;
  Alignment _beginAlignment = Alignment.topLeft;
  Alignment _endAlignment = Alignment.bottomRight;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if(mounted) {
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

  void changeCategory(String category) {
    setState(() {
      selectedCategory = category;
      switch (category) {
        case 'MAXI': displayedMotors = maxis; break;
        case 'Classy': displayedMotors = classies; break;
        case 'Matic': displayedMotors = matics; break;
        case 'Sport': displayedMotors = sports; break;
        case 'Moped': displayedMotors = mopeds; break;
        default: displayedMotors = [];
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
                title: const Text("Produk Yamaha"),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
                pinned: true,
                floating: true,
              ),
              SliverToBoxAdapter(
                child: _buildCategoryBar(),
              ),
            ];
          },
          body: _buildProductGrid(),
        ),
      ),
    );
  }

  Widget _buildCategoryBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      color: Colors.black.withOpacity(0.1),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _categoryChip('MAXI'),
            _categoryChip('Classy'),
            _categoryChip('Matic'),
            _categoryChip('Sport'),
            _categoryChip('Moped'),
          ],
        ),
      ),
    );
  }

  Widget _categoryChip(String title) {
    bool isSelected = selectedCategory == title;
    final accentColor = widget.darkMode ? AppColors.accentDark : AppColors.accentLight;

    return GestureDetector(
      onTap: () => changeCategory(title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? accentColor : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? accentColor : Colors.white.withOpacity(0.3),
            width: 1.5
          )
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? (widget.darkMode ? Colors.black : Colors.white) : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: GridView.builder(
        key: ValueKey<String>(selectedCategory),
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75, 
        ),
        itemCount: displayedMotors.length,
        itemBuilder: (context, index) {
          final motor = displayedMotors[index];
          return _ProductCard( 
            motor: motor,
            email: widget.email,
            darkMode: widget.darkMode,
          )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 400))
              .slideY(
                begin: 0.3,
                delay: Duration(milliseconds: 100 * (index % 2)),
                curve: Curves.easeOut,
              );
        },
      ),
    );
  }
}


class _ProductCard extends StatefulWidget {
  const _ProductCard({
    required this.motor,
    required this.email,
    required this.darkMode,
  });

  final Motor motor;
  final String email;
  final bool darkMode;

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _isFavorited = false;

  void _navigateToDetail() {
     Widget detailPage;
      if (widget.motor is Maxi) {
        detailPage = MaxiDetailPage(maxi: widget.motor as Maxi, email: widget.email, darkMode: widget.darkMode);
      } else if (widget.motor is Classy) {
        detailPage = ClassyDetailPage(classy: widget.motor as Classy, email: widget.email, darkMode: widget.darkMode);
      } else if (widget.motor is Matic) {
        detailPage = MaticDetailPage(matic: widget.motor as Matic, email: widget.email, darkMode: widget.darkMode);
      } else if (widget.motor is Sport) {
        detailPage = SportDetailPage(sport: widget.motor as Sport, email: widget.email, darkMode: widget.darkMode);
      } else if (widget.motor is Moped) {
        detailPage = MopedDetailPage(moped: widget.motor as Moped, email: widget.email, darkMode: widget.darkMode);
      } else {
        return;
      }
      Navigator.push(context, MaterialPageRoute(builder: (_) => detailPage));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToDetail,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
            
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.0), Colors.black.withOpacity(0.5)],
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                    )
                  ),
                ),
              ),

              Positioned(
                top: 4, 
                right: 4, 
                child: IconButton(
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                    child: Icon(
                      _isFavorited ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey<bool>(_isFavorited),
                      color: _isFavorited ? Colors.redAccent : Colors.white.withOpacity(0.7),
                      size: 24, 
                    ),
                  ),
                  tooltip: _isFavorited ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
                  onPressed: () {
                    setState(() {
                      _isFavorited = !_isFavorited;
                    });
                     ScaffoldMessenger.of(context).hideCurrentSnackBar(); 
                     ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_isFavorited ? '${widget.motor.name} ditambahkan ke favorit!' : '${widget.motor.name} dihapus dari favorit.'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                  },
                ),
              ),

              // Konten Utama
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 30.0, 12.0, 12.0),
                      child: Hero(
                        tag: widget.motor.name,
                        child: Image.asset(widget.motor.image, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.motor.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Rp ${widget.motor.price.toStringAsFixed(0)}",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}