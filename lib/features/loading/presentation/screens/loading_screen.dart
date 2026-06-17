import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runbroclassified/features/auth/presentation/screens/onboarding_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _stripeController;
  late AnimationController _pulseController;
  
  late Animation<double> _progressAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Controller for the overall progress (0% to 100% in 3.5 seconds)
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOutCubic),
    )..addListener(() {
        setState(() {});
      });

    // Controller for the diagonal stripe animation (continuous looping)
    _stripeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    // Controller for the "Loading..." text pulse animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start progress
    _progressController.forward().then((_) {
      _navigateToOnboarding();
    });
  }

  void _navigateToOnboarding() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const OnboardingScreen(),
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
  void dispose() {
    _progressController.dispose();
    _stripeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: SafeArea(
        child: Column(
          children: [
            // Top mascot image and branding cropped dynamically
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/app_icon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            // Bottom premium loading indicator and captions
            Container(
              padding: const EdgeInsets.only(bottom: 32.0, left: 32.0, right: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pulse animated "Loading..." text
                  FadeTransition(
                    opacity: _pulseAnimation,
                    child: Text(
                       'Loading...',
                      style: GoogleFonts.outfit(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF333333),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  
                  // Custom striped animated progress bar
                  AnimatedBuilder(
                    animation: _stripeController,
                    builder: (context, child) {
                      return SizedBox(
                        width: screenWidth * 0.8,
                        height: 16.0,
                        child: CustomPaint(
                          painter: StripedProgressBarPainter(
                            progress: _progressAnimation.value,
                            stripeAnimationValue: _stripeController.value,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  
                  // Friendly caption text
                  Text(
                    'Just a moment, great deals are coming your way!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF777777),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StripedProgressBarPainter extends CustomPainter {
  final double progress;
  final double stripeAnimationValue;

  StripedProgressBarPainter({
    required this.progress,
    required this.stripeAnimationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw track background
    final Paint trackPaint = Paint()
      ..color = const Color(0xFFF2F2F2)
      ..style = PaintingStyle.fill;
    
    final RRect outerRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(size.height / 2),
    );
    canvas.drawRRect(outerRRect, trackPaint);

    // Draw track border
    final Paint borderPaint = Paint()
      ..color = const Color(0xFFE5E5E5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRRect(outerRRect, borderPaint);

    if (progress <= 0) return;

    // 2. Draw filled progress with rounded clip
    final double filledWidth = size.width * progress;
    final RRect filledRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, filledWidth, size.height),
      Radius.circular(size.height / 2),
    );

    canvas.save();
    canvas.clipRRect(filledRRect);

    // Draw the gradient background of the filled area
    final Paint progressPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFFFA000), // Pure Orange / Yellow-orange
          Color(0xFFFF6F00), // Darker vibrant orange
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, filledWidth, size.height));
    
    canvas.drawRect(Rect.fromLTWH(0, 0, filledWidth, size.height), progressPaint);

    // 3. Draw the animated diagonal stripes
    final Paint stripePaint = Paint()
      ..color = const Color(0x2EFFFFFF) // Semi-transparent white
      ..style = PaintingStyle.fill;

    const double stripeWidth = 14.0;
    const double stripeSpacing = 16.0;
    // We offset the stripes by the animation value to make them slide
    final double offset = stripeAnimationValue * (stripeWidth + stripeSpacing);

    // Draw stripes along the width
    double startX = -stripeWidth * 2 + offset;
    while (startX < filledWidth + stripeWidth * 2) {
      final Path path = Path();
      // Draw a tilted parallelogram (diagonal stripe)
      path.moveTo(startX, 0);
      path.lineTo(startX + stripeWidth, 0);
      path.lineTo(startX + stripeWidth - (size.height * 0.5), size.height);
      path.lineTo(startX - (size.height * 0.5), size.height);
      path.close();

      canvas.drawPath(path, stripePaint);
      startX += stripeWidth + stripeSpacing;
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant StripedProgressBarPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.stripeAnimationValue != stripeAnimationValue;
  }
}
