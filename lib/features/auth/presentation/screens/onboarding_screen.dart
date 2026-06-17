import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runbroclassified/ui/widgets/app_logo.dart';
import 'package:runbroclassified/ui/widgets/custom_button.dart';
import 'package:runbroclassified/features/auth/presentation/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
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
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // PageView and Bottom Buttons
            Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      _buildPage1(),
                      _buildPage2(),
                      _buildPage3(),
                    ],
                  ),
                ),
                // Bottom Section
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 16.0,
                        offset: const Offset(0, -6),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(
                    24.0,
                    24.0,
                    24.0,
                    MediaQuery.of(context).padding.bottom > 0
                        ? MediaQuery.of(context).padding.bottom + 8.0
                        : 24.0,
                  ),
                  child: _buildNavigationButtons(),
                ),
              ],
            ),
            
            // Fixed Overlaid Top Bar (Logo and Skip Button)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    const AppLogo(height: 56.0),
                    
                    // Skip button
                    OutlinedButton(
                      onPressed: _navigateToLogin,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF555555),
                        side: const BorderSide(color: Color(0xFFE2E2E2), width: 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                        backgroundColor: Colors.white.withAlpha((0.6 * 255).round()),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Skip',
                            style: GoogleFonts.outfit(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          const Icon(
                            Icons.chevron_right,
                            size: 16.0,
                            color: Color(0xFF555555),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper builder for Page dots inline
  Widget _buildPageDots(int pageIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = index == pageIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: isActive ? 10.0 : 8.0,
          height: isActive ? 10.0 : 8.0,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFFF7E00) : const Color(0xFFE0E0E0),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  // --- Page 1 Contents ---
  Widget _buildPage1() {
    return Column(
      children: [
        // Main Visual: 3D illustration of the classified app
        Expanded(
          flex: 12,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 70.0),
            child: Image.asset(
              'assets/images/for screen after .png',
              fit: BoxFit.contain,
            ),
          ),
        ),

        // Inline Page Dots
        const SizedBox(height: 16.0),
        _buildPageDots(0),
        const SizedBox(height: 24.0),

        // Page 1 Texts
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.outfit(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E1E1E),
                    height: 1.25,
                  ),
                  children: [
                    const TextSpan(text: 'Buy & Sell Anything\n'),
                    TextSpan(
                      text: 'Nearby',
                      style: GoogleFonts.outfit(
                        color: const Color(0xFFFF7E00),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                'Find great deals around you. Buy and sell mobiles, cars, bikes, properties and more with ease.',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF777777),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  // --- Page 2 Contents ---
  Widget _buildPage2() {
    return Column(
      children: [
        // Spacer for the overlaid top bar (logo/skip)
        const SizedBox(height: 70.0),

        // Main Visual: background image with text overlaid on top of it
        Expanded(
          child: Stack(
            children: [
              // The image widget
              Positioned.fill(
                child: Image.asset(
                  'assets/images/onboarding_page_2.jpg',
                  fit: BoxFit.cover,
                ),
              ),

              // Page 2 Texts directly on the image background
              Positioned(
                top: 0,
                left: 24.0,
                right: 24.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.outfit(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E1E1E),
                          height: 1.25,
                        ),
                        children: [
                          const TextSpan(text: 'Find Deals\n'),
                          TextSpan(
                            text: 'Near You',
                            style: GoogleFonts.outfit(
                              color: const Color(0xFFFF7E00),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Discover amazing deals from trusted sellers in your neighborhood. Save time, save money!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF777777),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Inline Page Dots (outside the image Stack)
        const SizedBox(height: 16.0),
        _buildPageDots(1),
        const SizedBox(height: 16.0),
      ],
    );
  }

  // --- Page 3 Contents ---
  Widget _buildPage3() {
    return Column(
      children: [
        // Spacer for the overlaid top bar (logo/skip)
        const SizedBox(height: 70.0),

        // Main Visual: background image with text overlaid on top of it
        Expanded(
          child: Stack(
            children: [
              // The image widget
              Positioned.fill(
                child: Image.asset(
                  'assets/images/onboarding_page_3.jpg',
                  fit: BoxFit.cover,
                ),
              ),

              // Page 3 Texts directly on the image background
              Positioned(
                top: 0,
                left: 24.0,
                right: 24.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.outfit(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E1E1E),
                          height: 1.25,
                        ),
                        children: [
                          const TextSpan(text: 'Chat Directly\n'),
                          TextSpan(
                            text: 'With Sellers',
                            style: GoogleFonts.outfit(
                              color: const Color(0xFFFF7E00),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Have questions? Chat in real-time, negotiate and close the deal with confidence.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF777777),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Page 3 Features Row (outside the image Stack)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFeatureItem(
                Icons.chat_bubble,
                const Color(0xFFAB47BC), // Purple
                'Real-time Chat',
                'Instant messaging\nwith sellers',
              ),
              Container(
                width: 1.0,
                height: 50.0,
                color: const Color(0xFFE2E2E2),
                margin: const EdgeInsets.only(top: 10.0),
              ),
              _buildFeatureItem(
                Icons.verified_user,
                const Color(0xFFFFB300), // Yellow/Orange
                'Safe & Secure',
                'Your privacy is\nour priority',
              ),
              Container(
                width: 1.0,
                height: 50.0,
                color: const Color(0xFFE2E2E2),
                margin: const EdgeInsets.only(top: 10.0),
              ),
              _buildFeatureItem(
                Icons.handshake,
                const Color(0xFF29B6F6), // Light Blue
                'Better Deals',
                'Negotiate and get\nthe best price',
              ),
            ],
          ),
        ),

        // Inline Page Dots (outside the image Stack)
        const SizedBox(height: 12.0),
        _buildPageDots(2),
        const SizedBox(height: 16.0),
      ],
    );
  }

  // Helper builder for Page 3 Feature items
  Widget _buildFeatureItem(IconData icon, Color color, String title, String subtitle) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color.withAlpha((0.1 * 255).round()),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22.0),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 10.0,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF777777),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  // --- Bottom Navigation Row ---
  Widget _buildNavigationButtons() {
    if (_currentPage == 0) {
      // Reusable CustomButton
      return CustomButton(
        text: 'Next',
        icon: Icons.arrow_forward,
        onTap: () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
      );
    } else {
      final isLastPage = _currentPage == 2;
      return Row(
        children: [
          // Circular Outlined Back Button
          OutlinedButton(
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            style: OutlinedButton.styleFrom(
              shape: const CircleBorder(),
              side: const BorderSide(color: Color(0xFFE2E2E2), width: 1.0),
              padding: const EdgeInsets.all(14.0),
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFF555555),
              size: 22.0,
            ),
          ),
          const SizedBox(width: 16.0),
          
          // Reusable CustomButton
          Expanded(
            child: CustomButton(
              text: isLastPage ? 'Get Started' : 'Next',
              icon: Icons.arrow_forward,
              onTap: () {
                if (isLastPage) {
                  _navigateToLogin();
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
        ],
      );
    }
  }
}
