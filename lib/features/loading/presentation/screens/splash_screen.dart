import 'package:flutter/material.dart';
import 'package:runbroclassified/features/loading/presentation/screens/loading_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Transition to LoadingScreen after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _navigateToLoading();
      }
    });
  }

  void _navigateToLoading() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoadingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: Center(
        child: Image.asset(
          'assets/images/app_icon.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
