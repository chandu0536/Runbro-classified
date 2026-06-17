import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:runbroclassified/features/home/presentation/screens/home_screen.dart';
import 'package:runbroclassified/features/chats/presentation/screens/chats_screen.dart';
import 'package:runbroclassified/features/sell/presentation/screens/sell_screen.dart';
import 'package:runbroclassified/features/listings/presentation/screens/my_ads_screen.dart';
import 'package:runbroclassified/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:runbroclassified/features/premium/presentation/screens/premium_screen.dart';
import 'package:runbroclassified/features/profile/presentation/screens/wishlist_screen.dart';
import 'package:runbroclassified/features/profile/presentation/screens/help_support_screen.dart';
import 'package:runbroclassified/features/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:runbroclassified/features/profile/presentation/screens/terms_conditions_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _profileImagePath = 'assets/images/karthik_profile.png';
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() {
          _profileImagePath = pickedFile.path;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e')),
        );
      }
    }
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: Text(
                    'Change Profile Photo',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                ),
              ),
              const Divider(height: 1, color: Color(0xFFF2F2F2)),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined, color: Color(0xFFFF7E00)),
                title: Text('Take Photo', style: GoogleFonts.outfit(fontSize: 14)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined, color: Color(0xFFFF7E00)),
                title: Text('Choose from Gallery', style: GoogleFonts.outfit(fontSize: 14)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close, color: Colors.grey),
                title: Text('Cancel', style: GoogleFonts.outfit(fontSize: 14, color: Colors.grey)),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E1E1E),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              children: [
                // 1. User Header Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar with edit option
                    GestureDetector(
                      onTap: _showImageSourceActionSheet,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFF2F2F2), width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: _profileImagePath.startsWith('assets/')
                                  ? Image.asset(
                                      _profileImagePath,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.person, size: 50, color: Colors.grey);
                                      },
                                    )
                                  : Image.file(
                                      File(_profileImagePath),
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.person, size: 50, color: Colors.grey);
                                      },
                                    ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF7E00),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 18),
                    // Name & Contact details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Karthik Kumar',
                            style: GoogleFonts.outfit(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1E1E1E),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.phone_outlined, size: 14, color: Color(0xFF757575)),
                              const SizedBox(width: 6),
                              Text(
                                '+91 9876543210',
                                style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  color: const Color(0xFF757575),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.email_outlined, size: 14, color: Color(0xFF757575)),
                              const SizedBox(width: 6),
                              Text(
                                'karthik@gmail.com',
                                style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  color: const Color(0xFF757575),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 2. RunBro Premium Banner
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5F2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFFE0D6), width: 0.8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.rocket_launch_rounded,
                            color: Color(0xFFFF7E00),
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'RunBro Premium',
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E1E1E),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Boost your ads, get more visibility and sell faster.',
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                color: const Color(0xFF757575),
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const PremiumScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFFF7E00), width: 1.0),
                          ),
                          child: Text(
                            'Upgrade Now',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFF7E00),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 3. Menu items Card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: const Color(0xFFF2F2F2), width: 1),
                  ),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        icon: Icons.assignment_outlined,
                        iconColor: const Color(0xFF2E7D32),
                        iconBgColor: const Color(0xFFE8F5E9),
                        title: 'My Ads',
                        subtitle: 'View and manage your ads',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const MyAdsScreen()),
                          );
                        },
                      ),
                      const Divider(height: 1, color: Color(0xFFF2F2F2)),
                      _buildMenuItem(
                        icon: Icons.favorite,
                        iconColor: const Color(0xFFE91E63),
                        iconBgColor: const Color(0xFFFCE4EC),
                        title: 'Wishlist',
                        subtitle: 'Saved products',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const WishlistScreen()),
                          );
                        },
                      ),
                      const Divider(height: 1, color: Color(0xFFF2F2F2)),
                      _buildMenuItem(
                        icon: Icons.notifications_rounded,
                        iconColor: const Color(0xFFFF9100),
                        iconBgColor: const Color(0xFFFFF3E0),
                        title: 'Notifications',
                        subtitle: 'Messages and alerts',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                          );
                        },
                      ),
                      const Divider(height: 1, color: Color(0xFFF2F2F2)),
                      _buildMenuItem(
                        icon: Icons.help_outline_rounded,
                        iconColor: const Color(0xFF1976D2),
                        iconBgColor: const Color(0xFFE3F2FD),
                        title: 'Help & Support',
                        subtitle: 'Get help and contact support',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
                          );
                        },
                      ),
                      const Divider(height: 1, color: Color(0xFFF2F2F2)),
                      _buildMenuItem(
                        icon: Icons.shield_outlined,
                        iconColor: const Color(0xFF7B1FA2),
                        iconBgColor: const Color(0xFFF3E5F5),
                        title: 'Privacy Policy',
                        subtitle: 'Read our privacy policy',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
                          );
                        },
                      ),
                      const Divider(height: 1, color: Color(0xFFF2F2F2)),
                      _buildMenuItem(
                        icon: Icons.description_outlined,
                        iconColor: const Color(0xFFE64A19),
                        iconBgColor: const Color(0xFFFBE9E7),
                        title: 'Terms & Conditions',
                        subtitle: 'Read our terms and conditions',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const TermsConditionsScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 4. Logout Card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: const Color(0xFFF2F2F2), width: 1),
                  ),
                  child: _buildMenuItem(
                    icon: Icons.logout_rounded,
                    iconColor: const Color(0xFFFF7E00),
                    iconBgColor: const Color(0xFFFBE9E7),
                    title: 'Logout',
                    titleColor: const Color(0xFFFF7E00),
                    subtitle: '',
                    onTap: () {
                      _showLogoutDialog();
                    },
                  ),
                ),
              ],
            ),
          ),
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  // ── Menu Item Row Builder ──────────────────────────────────────────────────

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color titleColor = const Color(0xFF1E1E1E),
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: iconBgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: titleColor,
        ),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(
              subtitle,
              style: GoogleFonts.outfit(
                fontSize: 11,
                color: const Color(0xFF757575),
              ),
            )
          : null,
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: Color(0xFF9E9E9E),
        size: 22,
      ),
    );
  }

  // ── Logout Dialog ─────────────────────────────────────────────────────────

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          'Logout',
          style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: GoogleFonts.outfit(fontSize: 13, color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF757575),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
            },
            child: Text(
              'Logout',
              style: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFF7E00),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom Navigation Bar ─────────────────────────────────────────────────

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 68.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).round()),
            blurRadius: 10.0,
            offset: const Offset(0, -3),
          ),
        ],
        border: const Border(
          top: BorderSide(color: Color(0xFFF2F2F2), width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            isActive: false,
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            ),
          ),
          _buildBottomNavItem(
            icon: Icons.assignment_outlined,
            label: 'My Ads',
            isActive: false,
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MyAdsScreen()),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SellScreen()),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.translate(
                  offset: const Offset(0, -8),
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF7E00),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x4DFF7E00),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 28),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -4),
                  child: Text(
                    'Sell Now',
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF7E00),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildBottomNavItem(
            icon: Icons.chat_bubble_outline_rounded,
            label: 'Chats',
            isActive: false,
            badgeCount: 2,
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ChatsScreen()),
            ),
          ),
          _buildBottomNavItem(
            icon: Icons.person,
            label: 'Profile',
            isActive: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    int badgeCount = 0,
  }) {
    const activeColor = Color(0xFFFF7E00);
    const inactiveColor = Color(0xFF888888);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon,
                    color: isActive ? activeColor : inactiveColor, size: 24),
                if (badgeCount > 0)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        badgeCount.toString(),
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
