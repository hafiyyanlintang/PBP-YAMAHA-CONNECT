import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_helloworld/model/moped.dart';
import 'package:flutter_helloworld/pages/moped_detail.dart';
import 'package:flutter_helloworld/widgets/drawer_widget.dart';

class AppColors {
  static const Color primaryLight = Color(0xFF00264D);
  static const Color accentLight = Color(0xFF0055A4);
  static const Color primaryDark = Color(0xFF0B3A66);
  static const Color accentDark = Color(0xFF4EA0FF);
}

class MopedPage extends StatefulWidget {
  final String email;
  final bool darkMode;

  const MopedPage({
    super.key,
    required this.email,
    required this.darkMode,
  });

  @override
  State<MopedPage> createState() => _MopedPageState();
}

class _MopedPageState extends State<MopedPage> {
  Timer? _timer;
  Alignment _beginAlignment = Alignment.topLeft;
  Alignment _endAlignment = Alignment.bottomRight;

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
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: const Text("Moped Series"),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              elevation: 0,
              pinned: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final moped = mopeds[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: _MopedListItem(
                        moped: moped,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MopedDetailPage(
                                moped: moped,
                                email: widget.email,
                                darkMode: widget.darkMode,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 500.ms, delay: (100 * index).ms)
                    .slideX(begin: -0.2, curve: Curves.easeOutCubic);
                  },
                  childCount: mopeds.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MopedListItem extends StatelessWidget {
  final Moped moped;
  final VoidCallback onTap;

  const _MopedListItem({required this.moped, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 120,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Hero(
                  tag: moped.name,
                  child: Image.asset(moped.image, width: 100),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        moped.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Rp ${moped.price}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white.withOpacity(0.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}