import 'package:flutter/material.dart';
import 'package:flutter_helloworld/pages/splash.dart';
import 'package:flutter_helloworld/pages/home.dart';
import 'package:flutter_helloworld/pages/product.dart';
import 'package:flutter_helloworld/pages/dealer.dart';
import 'package:flutter_helloworld/pages/service.dart';
import 'package:flutter_helloworld/pages/parts.dart';

void main() {
  runApp(const MyApp());
}

class PageArguments {
  final String email;
  final bool darkMode;

  PageArguments({required this.email, required this.darkMode});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YAMAHA CONNECT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 140, 255),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashPage());

          case '/home':
            return MaterialPageRoute(
              builder: (_) => const HomePage(email: "user@email.com"),
            );

          case '/products':
            if (settings.arguments is PageArguments) {
              final args = settings.arguments as PageArguments;
              return MaterialPageRoute(
                builder: (_) =>
                    ProductPage(email: args.email, darkMode: args.darkMode),
              );
            }
            return _errorRoute(settings.name);

          case '/dealers':
            if (settings.arguments is PageArguments) {
              final args = settings.arguments as PageArguments;
              return MaterialPageRoute(
                builder: (_) =>
                    DealerPage(email: args.email, darkMode: args.darkMode),
              );
            }
            return _errorRoute(settings.name);

          case '/services':
            if (settings.arguments is PageArguments) {
              final args = settings.arguments as PageArguments;
              return MaterialPageRoute(
                builder: (_) =>
                    ServicePage(email: args.email, darkMode: args.darkMode),
              );
            }
            return _errorRoute(settings.name);

          case '/parts':
            if (settings.arguments is PageArguments) {
              final args = settings.arguments as PageArguments;
              return MaterialPageRoute(
                builder: (_) =>
                    PartPage(email: args.email, darkMode: args.darkMode),
              );
            }
            return _errorRoute(settings.name);

          default:
            return _errorRoute(settings.name);
        }
      },
    );
  }

  static Route<dynamic> _errorRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text(
            'Rute tidak ditemukan atau argumen salah untuk: $routeName',
          ),
        ),
      ),
    );
  }
}
