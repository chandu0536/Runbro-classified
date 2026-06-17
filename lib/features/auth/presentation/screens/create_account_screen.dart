import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runbroclassified/logic/blocs/auth/auth_bloc.dart';
import 'package:runbroclassified/logic/blocs/auth/auth_event.dart';
import 'package:runbroclassified/logic/blocs/auth/auth_state.dart';
import 'package:runbroclassified/ui/widgets/app_logo.dart';
import 'package:runbroclassified/ui/widgets/custom_button.dart';
import 'package:runbroclassified/features/auth/presentation/screens/location_screen.dart';
import 'package:runbroclassified/features/auth/presentation/screens/login_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  final String phoneNumber;
  const CreateAccountScreen({super.key, required this.phoneNumber});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  late TextEditingController _phoneController;
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  
  String _selectedGender = 'Male';

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.phoneNumber);
  }

  void _navigateToLocation() {
    final String name = _nameController.text.trim();
    final String phone = _phoneController.text.trim().replaceAll(RegExp(r'\D'), '');
    
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your full name',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    
    if (phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a valid 10-digit mobile number',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    context.read<AuthBloc>().add(
      RegisterUserEvent(
        name: name,
        email: '',
        phoneNumber: phone,
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.of(context).pushAndRemoveUntil(
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
      (route) => false,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccessState) {
                final phoneVal = _phoneController.text.trim().replaceAll(RegExp(r'\D'), '');
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        LocationScreen(phoneNumber: phoneVal),
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
                    // Top Bar with back button and logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E), size: 24.0),
                        ),
                        
                        // Reusable App Logo
                        const AppLogo(height: 56.0),
                        const SizedBox(width: 48.0), // Spacer balancing the back button
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    
                    // Title, Subtitle & Waving Mascot badge side-by-side
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create Your Account',
                                style: GoogleFonts.outfit(
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1E1E1E),
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Text(
                                'Join RunBro and start buying & selling amazing things around you.',
                                style: GoogleFonts.outfit(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF777777),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        
                        // Mascot graphic (not a profile picture upload placeholder)
                        Image.asset(
                          'assets/images/mascot_waving.png',
                          width: 80.0,
                          height: 80.0,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    const SizedBox(height: 28.0),
                    
                    // Form Fields
                    CreateAccountTextField(
                      label: 'Full Name',
                      hintText: 'Enter your full name',
                      prefixIcon: Icons.person_outline,
                      controller: _nameController,
                    ),
                    const SizedBox(height: 16.0),
                    
                    // Mobile Number display field (locked dial-code prefix)
                    Column(
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
                            color: widget.phoneNumber.isEmpty ? Colors.white : const Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: const Color(0xFFE2E2E2), width: 1.0),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.phone_outlined, color: Color(0xFF777777), size: 20.0),
                              const SizedBox(width: 10.0),
                              Text(
                                '+91 ',
                                style: GoogleFonts.outfit(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF555555),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _phoneController,
                                  enabled: widget.phoneNumber.isEmpty,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                  style: GoogleFonts.outfit(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    color: widget.phoneNumber.isEmpty ? const Color(0xFF1E1E1E) : const Color(0xFF555555),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: widget.phoneNumber.isEmpty ? 'Enter mobile number' : '',
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
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    
                    // Gender Segment Selector
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gender',
                          style: GoogleFonts.outfit(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        GenderSelector(
                          selectedGender: _selectedGender,
                          onChanged: (gender) {
                            setState(() {
                              _selectedGender = gender;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    
                    // Age picker/selector field
                    CreateAccountTextField(
                      label: 'Age',
                      hintText: 'Enter your age',
                      prefixIcon: Icons.calendar_month_outlined,
                      controller: _ageController,
                      isNumeric: true,
                      suffixIcon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF777777)),
                    ),
                    const SizedBox(height: 16.0),
                    
                    // Address textarea field
                    CreateAccountTextField(
                      label: 'Address',
                      hintText: 'Enter your address',
                      prefixIcon: Icons.location_on_outlined,
                      controller: _addressController,
                      isMultiline: true,
                    ),
                    const SizedBox(height: 32.0),
                    
                    // Reusable CustomButton (incorporates auth bloc loading state)
                    CustomButton(
                      text: 'Create Account',
                      icon: Icons.arrow_forward,
                      isLoading: state is AuthLoadingState,
                      onTap: _navigateToLocation,
                    ),
                    const SizedBox(height: 16.0),
                    
                    // T&C caption
                    Text(
                      'By creating an account, you agree to our\nTerms of Service and Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF888888),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    
                    // Already have an account login redirect
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: GoogleFonts.outfit(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF666666),
                          ),
                        ),
                        GestureDetector(
                          onTap: _navigateToLogin,
                          child: Text(
                            'Login',
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

class CreateAccountTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool isNumeric;
  final bool isMultiline;
  final Widget? suffixIcon;

  const CreateAccountTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.isNumeric = false,
    this.isMultiline = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFFE2E2E2), width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: isMultiline ? 14.0 : 0.0),
                child: Icon(prefixIcon, color: const Color(0xFF777777), size: 20.0),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: isNumeric ? TextInputType.number : (isMultiline ? TextInputType.multiline : TextInputType.text),
                  maxLines: isMultiline ? 3 : 1,
                  style: GoogleFonts.outfit(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E1E1E),
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: GoogleFonts.outfit(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFAAAAAA),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: isMultiline ? 12.0 : 16.0),
                  ),
                ),
              ),
              ?suffixIcon,
            ],
          ),
        ),
      ],
    );
  }
}

class GenderSelector extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String> onChanged;

  const GenderSelector({super.key, required this.selectedGender, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildGenderButton('Male', Icons.male, const Color(0xFF29B6F6))),
        const SizedBox(width: 12.0),
        Expanded(child: _buildGenderButton('Female', Icons.female, const Color(0xFFEC407A))),
        const SizedBox(width: 12.0),
        Expanded(child: _buildGenderButton('Other', Icons.transgender, const Color(0xFFAB47BC))),
      ],
    );
  }

  Widget _buildGenderButton(String gender, IconData icon, Color color) {
    final isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () => onChanged(gender),
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: isSelected ? color.withAlpha((0.1 * 255).round()) : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected ? color : const Color(0xFFE2E2E2),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? color : const Color(0xFF777777), size: 18.0),
            const SizedBox(width: 6.0),
            Text(
              gender,
              style: GoogleFonts.outfit(
                fontSize: 14.0,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? color : const Color(0xFF555555),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
