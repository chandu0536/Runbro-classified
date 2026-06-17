import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runbroclassified/logic/blocs/location/location_bloc.dart';
import 'package:runbroclassified/logic/blocs/location/location_event.dart';
import 'package:runbroclassified/logic/blocs/location/location_state.dart';
import 'package:runbroclassified/logic/blocs/auth/auth_bloc.dart';
import 'package:runbroclassified/logic/blocs/auth/auth_event.dart';
import 'package:runbroclassified/ui/widgets/app_logo.dart';
import 'package:runbroclassified/features/auth/presentation/screens/otp_screen.dart';

class LocationScreen extends StatefulWidget {
  final String phoneNumber;
  const LocationScreen({super.key, this.phoneNumber = ''});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  String _selectedPopularArea = 'Madhapur';

  final List<Map<String, String>> _popularAreas = [
    {'name': 'Madhapur', 'city': 'Hyderabad'},
    {'name': 'Kukatpally', 'city': 'Hyderabad'},
    {'name': 'Ameerpet', 'city': 'Hyderabad'},
    {'name': 'Hitech City', 'city': 'Hyderabad'},
  ];

  final List<Map<String, String>> _recentLocations = [
    {'title': 'Madhapur, Hyderabad', 'subtitle': 'Telangana, India'},
    {'title': 'Kukatpally, Hyderabad', 'subtitle': 'Telangana, India'},
    {'title': 'Ameerpet, Hyderabad', 'subtitle': 'Telangana, India'},
  ];



  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with back button and centered logo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E), size: 24.0),
                  ),
                  const Expanded(
                    child: Center(
                      child: AppLogo(height: 44.0),
                    ),
                  ),
                  const SizedBox(width: 48.0), // Balancing spacer
                ],
              ),
            ),
            
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Location Headers + 3D Mascot Map Graphic
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Where are you?',
                                style: GoogleFonts.outfit(
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1E1E1E),
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Text(
                                'Select your location to discover great deals near you',
                                style: GoogleFonts.outfit(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF777777),
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Image.asset(
                          'assets/images/location_header_3d.png',
                          width: 110.0,
                          height: 110.0,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    
                    // Search bar and GPS button (capsule shape)
                    Container(
                      height: 54.0,
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28.0),
                        border: Border.all(color: const Color(0xFFE2E2E2), width: 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((0.03 * 255).round()),
                            blurRadius: 8.0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Color(0xFFFF7E00), size: 22.0),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: GoogleFonts.outfit(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1E1E1E),
                              ),
                              decoration: InputDecoration(
                                hintText: 'Search location',
                                hintStyle: GoogleFonts.outfit(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFFAAAAAA),
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          
                          // Use My Location button
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPopularArea = 'Madhapur';
                                _searchController.text = 'Madhapur, Hyderabad';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF2E6),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.my_location, size: 16.0, color: Color(0xFFFF7E00)),
                                  const SizedBox(width: 6.0),
                                  Text(
                                    'Use My Location',
                                    style: GoogleFonts.outfit(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFFF7E00),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    
                    // Map Preview
                    Container(
                      height: 180.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFE2E2E2), width: 1.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          'assets/images/location_map_preview.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    
                    // Popular Areas Header
                    Text(
                      'Popular Areas',
                      style: GoogleFonts.outfit(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    
                    // Horizontal scroll location chips
                    BlocBuilder<LocationBloc, LocationState>(
                      builder: (context, state) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _popularAreas.map((area) {
                              final name = area['name']!;
                              final isSelected = _selectedPopularArea == name;
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: LocationChip(
                                  title: name,
                                  subtitle: area['city'] ?? 'Hyderabad',
                                  isSelected: isSelected,
                                  onTap: () {
                                    setState(() {
                                      _selectedPopularArea = name;
                                      _searchController.text = '$name, ${area['city']}';
                                    });
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 28.0),
                    
                    // Recent Locations list Header
                    Text(
                      'Recent Locations',
                      style: GoogleFonts.outfit(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    
                    // Enclosing Card Container for Recent Locations
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFF2F2F2), width: 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((0.02 * 255).round()),
                            blurRadius: 10.0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: List.generate(_recentLocations.length, (index) {
                          final loc = _recentLocations[index];
                          final isLast = index == _recentLocations.length - 1;
                          return Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                                leading: const Icon(
                                  Icons.location_on_outlined,
                                  color: Color(0xFFFF7E00),
                                  size: 24.0,
                                ),
                                title: Text(
                                  loc['title']!,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1E1E1E),
                                  ),
                                ),
                                subtitle: Text(
                                  loc['subtitle']!,
                                  style: GoogleFonts.outfit(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF777777),
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right,
                                  color: Color(0xFFBBBBBB),
                                  size: 20.0,
                                ),
                                onTap: () {
                                  setState(() {
                                    _selectedPopularArea = loc['title']!.split(',').first.trim();
                                    _searchController.text = loc['title']!;
                                  });
                                },
                              ),
                              if (!isLast)
                                const Divider(
                                  height: 1.0,
                                  thickness: 1.0,
                                  color: Color(0xFFF2F2F2),
                                  indent: 16.0,
                                  endIndent: 16.0,
                                ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Bottom Action Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      final selectedLoc = '$_selectedPopularArea, Hyderabad';
                      context.read<LocationBloc>().add(SelectLocationEvent(selectedLoc));
                      
                      final phone = widget.phoneNumber.isEmpty ? '9876543210' : widget.phoneNumber;
                      context.read<AuthBloc>().add(SendOtpEvent(phone));
                      
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              OtpScreen(phoneNumber: phone),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(opacity: animation, child: child);
                          },
                          transitionDuration: const Duration(milliseconds: 600),
                        ),
                      );
                    },
                    child: Container(
                      height: 54.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFFA000),
                            Color(0xFFFF6F00),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(27.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x40FF6F00),
                            blurRadius: 10.0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            'Confirm Location',
                            style: GoogleFonts.outfit(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const Positioned(
                            right: 20.0,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.lock_outline,
                        size: 14.0,
                        color: Color(0xFF888888),
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        'Your location is only used to show nearby listings.',
                        style: GoogleFonts.outfit(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF888888),
                        ),
                      ),
                    ],
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

class LocationChip extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const LocationChip({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF2E6) : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFFE2E2E2),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on,
              color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFF888888),
              size: 20.0,
            ),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E1E1E),
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: GoogleFonts.outfit(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
