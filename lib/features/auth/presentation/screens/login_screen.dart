import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runbroclassified/logic/blocs/auth/auth_bloc.dart';
import 'package:runbroclassified/logic/blocs/auth/auth_event.dart';
import 'package:runbroclassified/logic/blocs/auth/auth_state.dart';
import 'package:runbroclassified/features/auth/presentation/screens/otp_screen.dart';
import 'package:runbroclassified/features/auth/presentation/screens/create_account_screen.dart';
import 'package:runbroclassified/ui/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  void _sendOtp() {
    final phone = _phoneController.text.trim();
    context.read<AuthBloc>().add(SendOtpEvent(phone));
  }

  void _navigateToRegister() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CreateAccountScreen(phoneNumber: ''),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is OtpSentState) {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      OtpScreen(phoneNumber: state.phoneNumber),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  transitionDuration: const Duration(milliseconds: 600),
                ),
              );
            } else if (state is AuthFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Language selector aligned top right
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: const Color(0xFFE2E2E2), width: 1.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.language, size: 14.0, color: Color(0xFF555555)),
                          const SizedBox(width: 4.0),
                          Text(
                            'English',
                            style: GoogleFonts.outfit(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF555555),
                            ),
                          ),
                          const SizedBox(width: 2.0),
                          const Icon(Icons.arrow_drop_down, size: 14.0, color: Color(0xFF555555)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),

                  // Login Hero Image from source
                  Image.asset(
                    'assets/images/login_hero.png',
                    height: MediaQuery.of(context).size.height * 0.38,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16.0),

                  // Title & Subtitle
                  Text(
                    'Welcome Back!',
                    style: GoogleFonts.outfit(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    'Login to continue your journey',
                    style: GoogleFonts.outfit(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF777777),
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  // Card containing Mobile Number input field, info text, and Continue button
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.04 * 255).round()),
                          blurRadius: 10.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: const Color(0xFFF2F2F2), width: 1.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mobile Number',
                          style: GoogleFonts.outfit(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9F9F9),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: const Color(0xFFE2E2E2), width: 1.0),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '🇮🇳',
                                style: GoogleFonts.outfit(fontSize: 18.0),
                              ),
                              const SizedBox(width: 4.0),
                              const Icon(Icons.keyboard_arrow_down, size: 16.0, color: Color(0xFF777777)),
                              const SizedBox(width: 8.0),
                              Container(
                                width: 1.0,
                                height: 20.0,
                                color: const Color(0xFFE2E2E2),
                              ),
                              const SizedBox(width: 10.0),
                              Text(
                                '+91',
                                style: GoogleFonts.outfit(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF333333),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: TextField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                  style: GoogleFonts.outfit(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF1E1E1E),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter mobile number',
                                    hintStyle: GoogleFonts.outfit(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFFAAAAAA),
                                    ),
                                    counterText: '',
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          "We'll send you a 4-digit OTP to verify your number",
                          style: GoogleFonts.outfit(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF777777),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        CustomButton(
                          text: 'Continue',
                          icon: Icons.arrow_forward,
                          isLoading: state is AuthLoadingState,
                          onTap: _sendOtp,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  // Bottom info disclaimer row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFF2E6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.shield_outlined, color: Color(0xFFFF7E00), size: 16.0),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          'Your number is safe with us. We never share your details with anyone.',
                          style: GoogleFonts.outfit(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF777777),
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New to RunBro? ',
                        style: GoogleFonts.outfit(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF666666),
                        ),
                      ),
                      GestureDetector(
                        onTap: _navigateToRegister,
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.outfit(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFFF7E00),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}