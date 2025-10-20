import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_helloworld/main.dart';
import 'package:flutter_helloworld/model/product.dart';
import 'package:flutter_helloworld/widgets/drawer_widget.dart';
import 'package:flutter_helloworld/pages/product.dart';
import 'package:flutter_helloworld/pages/maxi_pages.dart';
import 'package:flutter_helloworld/pages/matic_pages.dart';
import 'package:flutter_helloworld/pages/sport_pages.dart';
import 'package:flutter_helloworld/pages/classy_pages.dart';
import 'package:flutter_helloworld/pages/moped_pages.dart';


class AppColors {
  static const Color primaryLight = Color(0xFF00264D);
  static const Color accentLight = Color(0xFF0055A4);
  static const Color backgroundLight = Color(0xFFF6F7FB);
  static const Color cardLight = Colors.white;
  static const Color textLight = Colors.black87;
  static const Color primaryDark = Color(0xFF0B3A66);
  static const Color accentDark = Color(0xFF4EA0FF);
  static const Color backgroundDark = Color(0xFF0F1724);
  static const Color cardDark = Color(0xFF1E293B);
  static const Color textDark = Colors.white;
}

class Testimonial {
  final String name;
  final String text;
  Testimonial({required this.name, required this.text});
}

class HomePage extends StatefulWidget {
  final String email;
  const HomePage({super.key, required this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // UI
  bool _darkMode = false;
  int _carouselIndex = 0;
  final TextEditingController _chatController = TextEditingController();

  // animasi background
  Timer? _timer;
  Alignment _beginAlignment = Alignment.topLeft;
  Alignment _endAlignment = Alignment.bottomRight;

  // simulasi loading
  bool _isLoading = true;

  final List<String> banners = [
    "assets/slider1.jpg", "assets/slider2.jpg", "assets/slider3.jpg",
    "assets/slider4.jpg", "assets/slider5.jpg", "assets/slider6.jpg",
    "assets/slider7.jpg", "assets/slider8.jpg", "assets/slider9.jpg",
    "assets/slider10.jpg", "assets/slider11.jpg",
  ];

  final List<Testimonial> testimonials = [
    Testimonial(name: "Andi", text: "Pelayanan cepat & ramah banget! Sangat direkomendasikan."),
    Testimonial(name: "Dewi", text: "Motor impian akhirnya dapet promo! Prosesnya juga mudah."),
    Testimonial(name: "Rafi", text: "Booking service online lewat aplikasi ini gampang banget."),
  ];

  final List<Map<String, dynamic>> _messages = [
    {"fromUser": false, "text": "Halo! Ada yang bisa saya bantu?"},
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _beginAlignment = [Alignment.topRight, Alignment.bottomLeft, Alignment.topLeft, Alignment.bottomRight][timer.tick % 4];
          _endAlignment = [Alignment.bottomLeft, Alignment.topRight, Alignment.bottomRight, Alignment.topLeft][timer.tick % 4];
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() { _isLoading = false; });
      }
    });
  }

  @override
  void dispose() {
    _chatController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Color get primaryColor => _darkMode ? AppColors.primaryDark : AppColors.primaryLight;
  Color get accentColor => _darkMode ? AppColors.accentDark : AppColors.accentLight;
  Color get pageBg => _darkMode ? AppColors.backgroundDark : AppColors.backgroundLight;
  Color get cardBg => _darkMode ? AppColors.cardDark : AppColors.cardLight;
  Color get textColor => _darkMode ? AppColors.textDark : AppColors.textLight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(email: widget.email, darkMode: _darkMode),
      body: AnimatedContainer(
        duration: const Duration(seconds: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _darkMode
                ? [AppColors.backgroundDark, const Color(0xFF08213A)]
                : [AppColors.accentLight, AppColors.primaryLight],
            begin: _beginAlignment,
            end: _endAlignment,
          ),
        ),
        child: Stack(
          children: [
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildAppBar(),
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 24),
                    _buildGreeting(),
                    const SizedBox(height: 24),
                    _buildCarouselSection(),
                    const SizedBox(height: 32),
                    _buildQuickActions(),
                    const SizedBox(height: 32),
                    _buildCategorySection(),
                    const SizedBox(height: 32),
                    _buildPromoSection(),
                    const SizedBox(height: 32),
                    _buildTestimonialSection(),
                    const SizedBox(height: 100),
                  ]),
                ),
              ],
            ),
            _buildFloatingChatButton(),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      floating: true, pinned: true, snap: false, elevation: 2,
      backgroundColor: primaryColor.withOpacity(0.8),
      foregroundColor: Colors.white,
      title: Row(children: [
        Image.asset("assets/logoyamaha.png", height: 38),
        const SizedBox(width: 10),
        const Text("Yamaha Dealer", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ]),
      actions: [
        IconButton(
          tooltip: _darkMode ? 'Light mode' : 'Dark mode',
          icon: Icon(_darkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
          onPressed: () => setState(() => _darkMode = !_darkMode),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Halo, ${widget.email.split('@').first} 👋", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 6),
          const Text("Selamat datang di Dealer Digital Yamaha!", style: TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 500)).slideY(begin: 0.2, curve: Curves.easeOut);
  }

  Widget _buildCarouselSection() {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        cs.CarouselSlider.builder(
          itemCount: banners.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(image: AssetImage(banners[index]), fit: BoxFit.cover),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 12, offset: const Offset(0, 4))]),
            );
          },
          options: cs.CarouselOptions(
            height: screenHeight * 0.99,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) => setState(() => _carouselIndex = index),
          ),
        ).animate().fadeIn(duration: const Duration(milliseconds: 600)).scale(begin: const Offset(0.9, 0.9)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: banners.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _carouselIndex == entry.key ? 24.0 : 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: _carouselIndex == entry.key ? Colors.white : Colors.white.withOpacity(0.3)),
              curve: Curves.easeOut,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _QuickActionButton(
              icon: Icons.motorcycle,
              label: 'Produk',
              hasNotification: true,
              onTap: () => Navigator.pushNamed(context, '/products', arguments: PageArguments(email: widget.email, darkMode: _darkMode))),
          _QuickActionButton(
              icon: Icons.build,
              label: 'Servis',
              onTap: () => Navigator.pushNamed(context, '/services', arguments: PageArguments(email: widget.email, darkMode: _darkMode))),
          _QuickActionButton(
              icon: Icons.location_on,
              label: 'Dealer',
              onTap: () => Navigator.pushNamed(context, '/dealers', arguments: PageArguments(email: widget.email, darkMode: _darkMode))),
          _QuickActionButton(
              icon: Icons.settings,
              label: 'Parts',
              onTap: () => Navigator.pushNamed(context, '/parts', arguments: PageArguments(email: widget.email, darkMode: _darkMode))),
        ].animate(interval: 100.ms).fadeIn(delay: 600.ms).slideY(begin: 0.5, curve: Curves.easeOut),
      ),
    );
  }

Widget _buildCategorySection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        title: "Kategori Motor",
        onViewAll: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ProductPage(email: widget.email, darkMode: _darkMode)));
        },
      ),
      const SizedBox(height: 16),
      SizedBox(
        height: 240,
        child: _isLoading
            ? _buildCategoryShimmer()
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _ProductCard(
                    product: product,
                    onTap: () {
                      Widget destinationPage;
                      switch (product.title) {
                        case 'MAXI':
                          destinationPage = MaxiPage(email: widget.email, darkMode: _darkMode);
                          break;
                        case 'Matic':
                          destinationPage = MaticPage(email: widget.email, darkMode: _darkMode);
                          break;
                        case 'Sport':
                          destinationPage = SportPage(email: widget.email, darkMode: _darkMode);
                          break;
                        case 'Classy':
                          destinationPage = ClassyPage(email: widget.email, darkMode: _darkMode);
                          break;
                        case 'Moped':
                          destinationPage = MopedPage(email: widget.email, darkMode: _darkMode);
                          break;
                        default:
                          destinationPage = ProductPage(email: widget.email, darkMode: _darkMode);
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => destinationPage),
                      );
                    },
                  );
                },
              ),
      ),
    ],
  );
}
  Widget _buildPromoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Stack(
        children: [
          Container(height: 150, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), image: const DecorationImage(image: AssetImage("assets/slider6.jpg"), fit: BoxFit.cover), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5))])),
          Container(height: 150, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: LinearGradient(colors: [Colors.black.withOpacity(0.8), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter))),
          Positioned(bottom: 20, left: 20, right: 20, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Servis Hemat 20%", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(height: 4), Text("Diskon untuk servis rutin bulan ini.", style: TextStyle(color: Colors.white70, fontSize: 14)),
            ])),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: accentColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                onPressed: () => Navigator.pushNamed(context, '/services', arguments: PageArguments(email: widget.email, darkMode: _darkMode)),
                child: const Text("Klaim"))
          ]))
        ],
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 600)).slideY(begin: 0.3, curve: Curves.easeOut);
  }

  Widget _buildTestimonialSection() {
    return Column(
      children: [
        _buildSectionHeader(title: "Testimoni Pelanggan"),
        const SizedBox(height: 16),
        _isLoading
            ? _buildTestimonialShimmer()
            : Column(
                children: testimonials.map((testi) {
                  int index = testimonials.indexOf(testi);
                  return _TestimonialCard(
                    testimonial: testi,
                    cardColor: cardBg,
                    textColor: textColor,
                    accentColor: accentColor,
                  ).animate().fadeIn(duration: const Duration(milliseconds: 500), delay: Duration(milliseconds: 150 * index)).slideX(begin: -0.2, curve: Curves.easeOut);
                }).toList(),
              ),
      ],
    );
  }

  Widget _buildFloatingChatButton() {
    return Positioned(
      right: 20,
      bottom: 20,
      child: FloatingActionButton(
        backgroundColor: accentColor,
        onPressed: () => _openChat(context),
        tooltip: 'Live Chat',
        child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
      ),
    ).animate(delay: const Duration(seconds: 1)).slide(begin: const Offset(0, 2), end: Offset.zero, duration: const Duration(milliseconds: 500), curve: Curves.easeOutBack).scale(duration: const Duration(milliseconds: 500), curve: Curves.easeOutBack);
  }


void _openChat(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: cardBg,
    isScrollControlled: true,
    builder: (_) => StatefulBuilder(builder: (context, setModalState) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16))),
              child: const Row(children: [
                Icon(Icons.chat, color: Colors.white),
                SizedBox(width: 10),
                Text("Live Chat Yamaha", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))
              ]),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final fromUser = msg["fromUser"] as bool;
                  return Align(
                    alignment: fromUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: fromUser
                            ? accentColor
                            : (_darkMode ? Colors.blueGrey[700] : Colors.grey[300]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        msg["text"],
                        style: TextStyle(color: fromUser ? Colors.white : textColor),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    decoration: InputDecoration(
                        hintText: "Ketik pesan...",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: accentColor),
                  onPressed: () {
                    final text = _chatController.text.trim();
                    if (text.isEmpty) return;
                    setModalState(() {
                      _messages.add({"fromUser": true, "text": text});
                      _chatController.clear();
                      Future.delayed(const Duration(milliseconds: 600), () {
                        setModalState(() {
                          _messages.add({"fromUser": false, "text": "Terima kasih, kami akan bantu secepatnya!"});
                        });
                      });
                    });
                  },
                ),
              ]),
            ),
          ]),
        ),
      );
    }),
  );
}

  Widget _buildSectionHeader({required String title, VoidCallback? onViewAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          if (onViewAll != null) TextButton(onPressed: onViewAll, child: const Text("Lihat Semua", style: TextStyle(color: Colors.white70))),
        ],
      ),
    );
  }

  Widget _buildCategoryShimmer() {
    return Shimmer.fromColors(
      baseColor: _darkMode ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: _darkMode ? Colors.grey[700]! : Colors.grey[100]!,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16),
          child: Container(width: 200, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16))),
        ),
      ),
    );
  }

  Widget _buildTestimonialShimmer() {
    return Shimmer.fromColors(
      baseColor: _darkMode ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: _darkMode ? Colors.grey[700]! : Colors.grey[100]!,
      child: Column(
        children: List.generate(3, (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Container(height: 80, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14))),
        )),
      ),
    );
  }
}


class _QuickActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool hasNotification;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    this.hasNotification = false,
    required this.onTap,
  });

  @override
  State<_QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<_QuickActionButton> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) => setState(() => _isPressed = true);
  void _onPointerUp(PointerUpEvent event) {
    HapticFeedback.lightImpact();
    setState(() => _isPressed = false);
    widget.onTap();
  }
  void _onPointerCancel(PointerCancelEvent event) => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isPressed ? 1.1 : 1.0,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      child: Listener(
        onPointerDown: _onPointerDown,
        onPointerUp: _onPointerUp,
        onPointerCancel: _onPointerCancel,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isPressed = true),
          onExit: (_) => setState(() => _isPressed = false),
          cursor: SystemMouseCursors.click,
          child: SizedBox(
            width: 70,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(widget.icon, color: Colors.white, size: 28),
                          const SizedBox(height: 4),
                          Text(widget.label, style: const TextStyle(color: Colors.white70, fontSize: 10), overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ),
                ),
                if (widget.hasNotification)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 12, height: 12,
                      decoration: BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5)),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final bool darkMode;
  final VoidCallback? onTap;
  const _ProductCard({required this.product, this.darkMode = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
            color: (darkMode ? AppColors.cardDark : AppColors.cardLight),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(darkMode ? 0.2 : 0.08), blurRadius: 10, offset: const Offset(0, 4))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Hero(
                tag: product.title,
                child: Image.asset(
                  product.imagePath,
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: (darkMode ? AppColors.textDark : AppColors.primaryLight)), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Text(product.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: (darkMode ? Colors.white70 : Colors.black54), fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final Testimonial testimonial;
  final Color cardColor;
  final Color textColor;
  final Color accentColor;
  const _TestimonialCard({required this.testimonial, required this.cardColor, required this.textColor, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2))]),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.format_quote, color: accentColor.withOpacity(0.7), size: 28),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(testimonial.text, style: TextStyle(color: textColor, fontStyle: FontStyle.italic)),
            const SizedBox(height: 8),
            Text("- ${testimonial.name}", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
          ])),
        ]),
      ),
    );
  }
}