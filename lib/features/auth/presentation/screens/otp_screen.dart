import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runbroclassified/logic/blocs/auth/auth_bloc.dart';
import 'package:runbroclassified/logic/blocs/auth/auth_event.dart';
import 'package:runbroclassified/logic/blocs/auth/auth_state.dart';
import 'package:runbroclassified/ui/widgets/app_logo.dart';
import 'package:runbroclassified/features/home/presentation/screens/home_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, this.phoneNumber = '9876543210'});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  
  Timer? _timer;
  int _secondsRemaining = 45;
  bool _canResend = false;
  bool _isDialogOpen = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 45;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          _canResend = true;
          _timer?.cancel();
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1) {
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // Last digit entered, unfocus and verify
        _focusNodes[index].unfocus();
        FocusScope.of(context).unfocus(); // Force keyboard down
        _verifyOtp();
      }
    } else if (value.isEmpty) {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  void _verifyOtp() {
    String otp = _controllers.map((c) => c.text).join();
    if (otp.length == 4) {
      context.read<AuthBloc>().add(VerifyOtpEvent(otp));
    }
  }

  void _dismissDialog() {
    if (_isDialogOpen && mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      _isDialogOpen = false;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoadingState) {
              _isDialogOpen = true;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF7E00)),
                  ),
                ),
              );
            } else if (state is AuthOtpVerifiedState) {
              _dismissDialog();
              Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const HomeScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  transitionDuration: const Duration(milliseconds: 600),
                ),
                (route) => false,
              );
            } else if (state is AuthFailureState) {
              _dismissDialog();
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Bar with back arrow
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E), size: 24.0),
                  ),
                ),
                
                // Reusable App Logo
                const AppLogo(height: 56.0),
                const SizedBox(height: 16.0),
                
                // OTP page illustration
                Image.asset(
                  'assets/images/otp_hero.png',
                  height: MediaQuery.of(context).size.height * 0.28,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 24.0),
                
                // Verify Title
                Text(
                  'Verify Your Number',
                  style: GoogleFonts.outfit(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E1E1E),
                  ),
                ),
                const SizedBox(height: 8.0),
                
                // Verification subtext
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter the 4-digit code sent to ',
                      style: GoogleFonts.outfit(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF777777),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '+91 ${widget.phoneNumber} ',
                      style: GoogleFonts.outfit(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        'Edit ✏️',
                        style: GoogleFonts.outfit(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFFF7E00),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                
                // 4 OTP Box fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 60.0,
                      height: 60.0,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        onChanged: (value) => _onOtpChanged(value, index),
                        style: GoogleFonts.outfit(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E1E1E),
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(color: Color(0xFFE2E2E2), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(color: Color(0xFFFF7E00), width: 2.0),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 32.0),
                
                // Resend text timer
                Text(
                  "Didn't receive the code?",
                  style: GoogleFonts.outfit(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF777777),
                  ),
                ),
                const SizedBox(height: 6.0),
                _canResend
                    ? GestureDetector(
                        onTap: _startTimer,
                        child: Text(
                          'Resend OTP',
                          style: GoogleFonts.outfit(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFF7E00),
                          ),
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          style: GoogleFonts.outfit(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF777777),
                          ),
                          children: [
                            const TextSpan(text: 'Resend OTP in '),
                            TextSpan(
                              text: '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                              style: GoogleFonts.outfit(
                                color: const Color(0xFFFF7E00),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(height: 48.0),
                
                // Bottom security disclaimer card
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9F5), // Light warm tint
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: const Color(0xFFFFE0CC), width: 1.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.security, color: Color(0xFFFF7E00), size: 20.0),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your security is our priority',
                              style: GoogleFonts.outfit(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFFF7E00),
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              'We never share your number with anyone.',
                              style: GoogleFonts.outfit(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF666666),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
