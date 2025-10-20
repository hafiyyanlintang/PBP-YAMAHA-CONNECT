import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_helloworld/main.dart'; 

class AppColors {
  static const Color primaryDark = Color(0xFF0B3A66);
  static const Color accentDark = Color(0xFF4EA0FF);
}

class AppDrawer extends StatelessWidget {
  final String email;
  final bool darkMode;

  const AppDrawer({
    super.key,
    required this.email,
    required this.darkMode,
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFF08213A), AppColors.primaryDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            _buildDrawerHeader(context),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _drawerItem(
                    context: context,
                    icon: Icons.home_filled,
                    title: "Home",
                    routeName: '/home',
                    currentRoute: currentRoute,
                    onTap: () {
                      if (currentRoute != '/home') {
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  _drawerItem(
                    context: context,
                    icon: Icons.motorcycle,
                    title: "Products",
                    routeName: '/products',
                    currentRoute: currentRoute,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      Navigator.pushNamed(context, '/products', arguments: PageArguments(email: email, darkMode: darkMode));
                    },
                  ),
                  _drawerItem(
                    context: context,
                    icon: Icons.build_circle,
                    title: "Service",
                    routeName: '/services',
                    currentRoute: currentRoute,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      Navigator.pushNamed(context, '/services', arguments: PageArguments(email: email, darkMode: darkMode));
                    },
                  ),
                  _drawerItem(
                    context: context,
                    icon: Icons.location_on,
                    title: "Dealer",
                    routeName: '/dealers',
                    currentRoute: currentRoute,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      Navigator.pushNamed(context, '/dealers', arguments: PageArguments(email: email, darkMode: darkMode));
                    },
                  ),
                  _drawerItem(
                    context: context,
                    icon: Icons.settings,
                    title: "Parts",
                    routeName: '/parts',
                    currentRoute: currentRoute,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      Navigator.pushNamed(context, '/parts', arguments: PageArguments(email: email, darkMode: darkMode));
                    },
                  ),
                  const Divider(color: Colors.white24, thickness: 0.5, indent: 16, endIndent: 16),
                  _drawerItem(
                    context: context,
                    icon: Icons.logout,
                    title: "Logout",
                    routeName: '/',
                    currentRoute: currentRoute,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                    },
                  ),
                ]
                .animate(interval: 80.ms)
                .fadeIn(duration: 200.ms)
                .slideX(begin: -0.2, curve: Curves.easeOut),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return SizedBox(
      height: 220,
      child: DrawerHeader(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.accentDark.withOpacity(0.3), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logoyamaha.png", height: 60),
            const SizedBox(height: 12),
            const Text('YAMAHA CONNECT', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            const SizedBox(height: 6),
            Text(email, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String routeName,
    String? currentRoute,
    required VoidCallback onTap,
  }) {
    final bool isSelected = currentRoute == routeName;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.accentDark.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.white : Colors.white70),
        title: Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}