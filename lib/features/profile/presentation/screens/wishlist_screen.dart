import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:runbroclassified/data/app_data.dart';
import 'package:runbroclassified/features/home/presentation/screens/home_screen.dart';
import 'package:runbroclassified/features/chats/presentation/screens/chats_screen.dart';
import 'package:runbroclassified/features/sell/presentation/screens/sell_screen.dart';
import 'package:runbroclassified/features/listings/presentation/screens/my_ads_screen.dart';
import 'package:runbroclassified/features/profile/presentation/screens/profile_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<Map<String, dynamic>> get _savedItems => AppData.wishlistItems;

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter items based on search query
    final filteredItems = _savedItems.where((item) {
      return item['title'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    // Count favorited items
    final favoritedCount = _savedItems.where((item) => item['isFavorited'] == true).length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saved Products',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E1E1E),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.favorite, color: Color(0xFFFF7E00), size: 12),
                const SizedBox(width: 4),
                Text(
                  '$favoritedCount Items Saved',
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: const Color(0xFF757575),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFF1E1E1E), size: 22),
            onPressed: _showClearAllDialog,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF1E1E1E), size: 22),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search saved products',
                  hintStyle: GoogleFonts.outfit(
                    color: const Color(0xFF888888),
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF888888), size: 20),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
          ),

          // Saved Products List
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Text(
                      'No saved products found',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: const Color(0xFF888888),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return _buildSavedProductCard(item);
                    },
                  ),
          ),
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  // ── Product Card Builder ───────────────────────────────────────────────────

  Widget _buildSavedProductCard(Map<String, dynamic> item) {
    final bool isFavorited = item['isFavorited'] as bool;
    final bool hasPriceDrop = item['priceDrop'] != null;
    final bool hasTag = item['tag'] != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFF2F2F2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Image Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item['image'] as String,
                width: 120,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 110,
                    color: const Color(0xFFF5F5F5),
                    child: const Icon(Icons.image, color: Colors.grey, size: 30),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),

            // Right Info Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Favorite Icon Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item['title'] as String,
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E1E1E),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            item['isFavorited'] = !isFavorited;
                            if (!(item['isFavorited'] as bool)) {
                              AppData.wishlistItems.removeWhere((w) => w['title'] == item['title']);
                            }
                          });
                        },
                        child: Icon(
                          isFavorited ? Icons.favorite : Icons.favorite_border,
                          color: isFavorited ? const Color(0xFFFF7E00) : const Color(0xFF888888),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Price + Price Drop Row
                  Row(
                    children: [
                      Text(
                        item['price'] as String,
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFFF7E00),
                        ),
                      ),
                      if (hasPriceDrop) ...[
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_downward, color: Color(0xFF2E7D32), size: 12),
                        Text(
                          item['priceDrop'] as String,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Location Row
                  Row(
                    children: [
                      const Icon(Icons.place_outlined, size: 13, color: Color(0xFF757575)),
                      const SizedBox(width: 4),
                      Text(
                        item['location'] as String,
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          color: const Color(0xFF757575),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Tag or Date Row
                  if (hasTag)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.local_offer, color: Color(0xFF2E7D32), size: 10),
                          const SizedBox(width: 4),
                          Text(
                            item['tag'] as String,
                            style: GoogleFonts.outfit(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Text(
                      item['time'] as String,
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                  const SizedBox(height: 10),

                  // Buttons Row
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Chatting with seller of ${item['title']}')),
                            );
                          },
                          child: Container(
                            height: 28,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.chat_bubble_outline_rounded, size: 12, color: Color(0xFF555555)),
                                const SizedBox(width: 4),
                                Text(
                                  'Chat Seller',
                                  style: GoogleFonts.outfit(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF555555),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Viewing details of ${item['title']}')),
                            );
                          },
                          child: Container(
                            height: 28,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFFF7E00), width: 1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                'View Details',
                                style: GoogleFonts.outfit(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFFF7E00),
                                ),
                              ),
                            ),
                          ),
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

  // ── Clear All Dialog ───────────────────────────────────────────────────────

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          'Clear saved products?',
          style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'This will remove all items from your wishlist.',
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
              setState(() {
                _savedItems.clear();
              });
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
            isActive: true,
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
