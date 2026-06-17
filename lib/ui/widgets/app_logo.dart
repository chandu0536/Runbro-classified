import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double height;
  final BoxFit fit;

  const AppLogo({
    super.key,
    this.height = 56.0,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo_old.png',
      height: height,
      fit: fit,
    );
  }
}
