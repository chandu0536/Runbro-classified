import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:runbroclassified/features/home/presentation/screens/home_screen.dart';
import 'package:runbroclassified/features/chats/presentation/screens/chats_screen.dart';
import 'package:runbroclassified/features/sell/presentation/screens/sell_screen.dart';
import 'package:runbroclassified/features/listings/presentation/screens/my_ads_screen.dart';
import 'package:runbroclassified/features/profile/presentation/screens/profile_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    // Today
    {
      'type': 'message',
      'title': 'New Message',
      'body': 'Ramesh Kumar sent a message about your iPhone 15 Pro Max.',
      'time': '2 min ago',
      'section': 'Today',
      'unread': true,
    },
    {
      'type': 'wishlist',
      'title': 'Wishlist Alert',
      'body': 'Your Hyundai i20 has been added to 5 wishlists.',
      'time': '10 min ago',
      'section': 'Today',
      'unread': true,
    },
    {
      'type': 'price_drop',
      'title': 'Price Drop Alert',
      'body': 'iPhone 14 price dropped from ₹48,000 to ₹43,000.',
      'time': '30 min ago',
      'section': 'Today',
      'unread': true,
    },
    // Yesterday
    {
      'type': 'approved',
      'title': 'Ad Approved',
      'body': 'Your ad "MacBook Air M2" has been approved.',
      'time': 'Yesterday',
      'section': 'Yesterday',
      'unread': true,
    },
    {
      'type': 'expired',
      'title': 'Ad Expired',
      'body': 'Your ad "3 Seater Sofa" has expired.',
      'action': 'Renew now',
      'time': 'Yesterday',
      'section': 'Yesterday',
      'unread': true,
    },
    {
      'type': 'boost',
      'title': 'Ad Boost Active',
      'body': 'Your Premium Boost is now active for 7 days.',
      'time': 'Yesterday',
      'section': 'Yesterday',
      'unread': false,
    },
    {
      'type': 'views',
      'title': 'New View Milestone',
      'body': 'Your ad reached 500+ views.',
      'time': 'Yesterday',
      'section': 'Yesterday',
      'unread': false,
    },
    {
      'type': 'sold',
      'title': 'Item Sold',
      'body': 'Congratulations! 🎉\nApple Watch Series 8 sold.',
      'time': '2 days ago',
      'section': 'Yesterday',
      'unread': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Group by section
    final todayItems =
        _notifications.where((n) => n['section'] == 'Today').toList();
    final yesterdayItems =
        _notifications.where((n) => n['section'] == 'Yesterday').toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E1E1E),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Color(0xFF1E1E1E), size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFF1E1E1E), size: 22),
            onPressed: _showClearAllDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                if (todayItems.isNotEmpty) ...[
                  _buildSectionHeader('Today'),
                  ...todayItems.map((n) => _buildNotificationTile(n)),
                ],
                if (yesterdayItems.isNotEmpty) ...[
                  _buildSectionHeader('Yesterday'),
                  ...yesterdayItems.map((n) => _buildNotificationTile(n)),
                ],
              ],
            ),
          ),
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  // ── Section header ────────────────────────────────────────────────────────

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      color: const Color(0xFFF9F9F9),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF757575),
        ),
      ),
    );
  }

  // ── Notification tile ─────────────────────────────────────────────────────

  Widget _buildNotificationTile(Map<String, dynamic> n) {
    final iconData = _iconForType(n['type'] as String);
    final iconBg = _bgColorForType(n['type'] as String);
    final iconColor = _iconColorForType(n['type'] as String);
    final badgeCount = n['type'] == 'message' ? 2 : 0;
    final hasAction = n['action'] != null;
    final isUnread = n['unread'] as bool;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF2F2F2), width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon circle with optional badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: iconColor, size: 22),
              ),
              if (badgeCount > 0)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        badgeCount.toString(),
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  n['title'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E1E1E),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  n['body'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: const Color(0xFF757575),
                    height: 1.4,
                  ),
                ),
                if (hasAction) ...[
                  const SizedBox(height: 3),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      n['action'] as String,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFF7E00),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Time + unread dot
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                n['time'] as String,
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
              if (isUnread) ...[
                const SizedBox(height: 6),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF7E00),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // ── Icon helpers ──────────────────────────────────────────────────────────

  IconData _iconForType(String type) {
    switch (type) {
      case 'message':
        return Icons.chat_bubble_rounded;
      case 'wishlist':
        return Icons.favorite_rounded;
      case 'price_drop':
        return Icons.local_offer_rounded;
      case 'approved':
        return Icons.check_circle_rounded;
      case 'expired':
        return Icons.error_rounded;
      case 'boost':
        return Icons.rocket_launch_rounded;
      case 'views':
        return Icons.visibility_rounded;
      case 'sold':
        return Icons.celebration_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  Color _bgColorForType(String type) {
    switch (type) {
      case 'message':
        return const Color(0xFFE3F2FD);
      case 'wishlist':
        return const Color(0xFFFCE4EC);
      case 'price_drop':
        return const Color(0xFFFFF3E0);
      case 'approved':
        return const Color(0xFFE8F5E9);
      case 'expired':
        return const Color(0xFFFBE9E7);
      case 'boost':
        return const Color(0xFFF3E5F5);
      case 'views':
        return const Color(0xFFE8EAF6);
      case 'sold':
        return const Color(0xFFE8F5E9);
      default:
        return const Color(0xFFF5F5F5);
    }
  }

  Color _iconColorForType(String type) {
    switch (type) {
      case 'message':
        return const Color(0xFF1565C0);
      case 'wishlist':
        return const Color(0xFFE91E63);
      case 'price_drop':
        return const Color(0xFFFF6D00);
      case 'approved':
        return const Color(0xFF2E7D32);
      case 'expired':
        return const Color(0xFFFF7E00);
      case 'boost':
        return const Color(0xFF7B1FA2);
      case 'views':
        return const Color(0xFF283593);
      case 'sold':
        return const Color(0xFF2E7D32);
      default:
        return const Color(0xFF757575);
    }
  }

  // ── Dialogs ───────────────────────────────────────────────────────────────

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          'Clear all notifications?',
          style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'This action cannot be undone.',
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
              setState(() => _notifications.clear());
              Navigator.pop(ctx);
            },
            child: Text(
              'Clear All',
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
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: false,
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
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
