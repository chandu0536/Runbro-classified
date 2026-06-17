import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:runbroclassified/features/listings/presentation/screens/edit_ad_screen.dart';
import 'package:runbroclassified/features/listings/presentation/screens/my_ads_screen.dart';
import 'package:runbroclassified/features/sell/presentation/screens/sell_screen.dart';
import 'package:runbroclassified/features/home/presentation/screens/home_screen.dart';
import 'package:runbroclassified/features/chats/presentation/screens/chats_screen.dart';
import 'package:runbroclassified/features/profile/presentation/screens/profile_screen.dart';
import 'package:runbroclassified/features/listings/presentation/screens/boost_ad_screen.dart';

class AdPreviewScreen extends StatefulWidget {
  final Map<String, dynamic> ad;
  const AdPreviewScreen({super.key, required this.ad});

  @override
  State<AdPreviewScreen> createState() => _AdPreviewScreenState();
}

class _AdPreviewScreenState extends State<AdPreviewScreen> {
  int _selectedImageIndex = 0;
  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final ad = widget.ad;
    final images = (ad['images'] as List?)?.cast<String>() ?? [];
    final isSold = ad['status'] == 'Sold';
    final isActive = ad['status'] == 'Active';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Ad Preview',
          style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => EditAdScreen(ad: ad)),
              );
            },
            child: Text(
              'Edit',
              style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFFFF7E00)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Blue info banner
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F4FD),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFB3D9F5)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded, color: Color(0xFF1A73E8), size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'This is how your ad will appear to other users.',
                            style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF1A73E8), fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main large image
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 280,
                        child: images.isNotEmpty
                            ? _buildImage(images[_selectedImageIndex], width: double.infinity, height: 280)
                            : Container(
                                color: const Color(0xFFF5F5F5),
                                child: const Center(
                                  child: Icon(Icons.image_outlined, size: 60, color: Colors.grey),
                                ),
                              ),
                      ),
                      // Status badge top left
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xFFDCF5E3)
                                : isSold
                                    ? const Color(0xFFEEEEEE)
                                    : const Color(0xFFFFE5E5),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            ad['status'] as String? ?? 'Active',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isActive
                                  ? const Color(0xFF1E5C27)
                                  : isSold
                                      ? const Color(0xFF757575)
                                      : Colors.red,
                            ),
                          ),
                        ),
                      ),
                      // Image count badge top right
                      if (images.length > 1)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.55),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${_selectedImageIndex + 1}/${images.length}',
                              style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Thumbnail strip
                  if (images.isNotEmpty)
                    Container(
                      height: 72,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: images.length,
                        itemBuilder: (context, i) {
                          final isSelected = i == _selectedImageIndex;
                          // Show +1 on last if more than 5 thumbnails visible
                          final showOverlay = i == 4 && images.length > 5;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedImageIndex = i),
                            child: Container(
                              width: 60,
                              height: 68,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFFE0E0E0),
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: _buildImage(images[i], width: 60, height: 68),
                                  ),
                                  if (showOverlay)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: Container(
                                        color: Colors.black.withValues(alpha: 0.5),
                                        child: Center(
                                          child: Text(
                                            '+${images.length - 4}',
                                            style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          ad['title'] as String? ?? '',
                          style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
                        ),
                        const SizedBox(height: 6),

                        // Price + Negotiable badge
                        Row(
                          children: [
                            Text(
                              ad['price'] as String? ?? '',
                              style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w900, color: const Color(0xFFFF7E00)),
                            ),
                            if (ad['negotiable'] == true) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCF5E3),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Negotiable',
                                  style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF1E5C27)),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Stats row — Views, Chats, Favorites
                        Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          children: [
                            _buildStatChip(Icons.visibility_outlined, '${ad['views'] ?? 0} Views'),
                            _buildStatChip(Icons.chat_bubble_outline_rounded, '${ad['chats'] ?? 0} Chats'),
                            _buildStatChip(Icons.favorite_border_rounded, '${ad['likes'] ?? 0} Favorites'),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Location row
                        _buildInfoRow(Icons.location_on_outlined, ad['location'] as String? ?? ''),
                        const SizedBox(height: 8),
                        // Posted on row
                        _buildInfoRow(Icons.calendar_today_outlined, 'Posted on ${ad['date'] as String? ?? ''}'),
                        const SizedBox(height: 8),
                        // Ad ID row
                        _buildInfoRow(Icons.qr_code_2_rounded, 'Ad ID: #${ad['id'] as String? ?? ''}'),

                        const SizedBox(height: 20),
                        const Divider(color: Color(0xFFEEEEEE), height: 1),
                        const SizedBox(height: 16),

                        // Description section
                        Text(
                          'Description',
                          style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          ad['description'] as String? ?? '',
                          maxLines: _isDescriptionExpanded ? null : 3,
                          overflow: _isDescriptionExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFF444444), height: 1.5),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () => setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _isDescriptionExpanded ? 'See less' : 'See more',
                                style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFFFF7E00)),
                              ),
                              Icon(
                                _isDescriptionExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                size: 16,
                                color: const Color(0xFFFF7E00),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),
                        const Divider(color: Color(0xFFEEEEEE), height: 1),
                        const SizedBox(height: 16),

                        // Ad Details grid
                        _buildDetailsGrid(ad),

                        const SizedBox(height: 20),
                        const Divider(color: Color(0xFFEEEEEE), height: 1),
                        const SizedBox(height: 16),

                        // Boost Banner
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF6F2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFFFDDD5)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF7E00),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 18),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Boost your ad',
                                      style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
                                    ),
                                    Text(
                                      'Get more visibility and sell faster.',
                                      style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF757575)),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => BoostAdScreen(ad: ad)));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF7E00),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Boost Now',
                                  style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Post Ad / bottom CTA button
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ad posted successfully!')),
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const MyAdsScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7E00),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                child: Text(
                  'Post Ad',
                  style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),

          // Bottom Navigation Bar
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildImage(String path, {double? width, double? height}) {
    if (path.startsWith('http')) {
      return Image.network(path, width: width, height: height, fit: BoxFit.cover);
    } else if (path.startsWith('assets/')) {
      return Image.asset(path, width: width, height: height, fit: BoxFit.cover);
    } else {
      return Image.file(File(path), width: width, height: height, fit: BoxFit.cover);
    }
  }

  Widget _buildStatChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: const Color(0xFF555555)),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF555555), fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: const Color(0xFF546E7A)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.outfit(fontSize: 12.5, color: const Color(0xFF546E7A), fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsGrid(Map<String, dynamic> ad) {
    final categoryDisplay = ad['category'] == 'Mobiles'
        ? 'Mobiles & Tablets'
        : ad['category'] as String? ?? '';

    final List<Map<String, String>> details = [
      {'icon': '📦', 'label': 'Category', 'val': categoryDisplay},
      if (ad['storage'] != null) {'icon': '💾', 'label': 'Storage', 'val': ad['storage'] as String},
      if (ad['brand'] != null) {'icon': '🏷️', 'label': 'Brand', 'val': ad['brand'] as String},
      {'icon': '✅', 'label': 'Condition', 'val': ad['condition'] as String? ?? 'Like New'},
      if (ad['model'] != null) {'icon': '📱', 'label': 'Model', 'val': ad['model'] as String},
      if (ad['year'] != null) {'icon': '📅', 'label': 'Year', 'val': ad['year'] as String},
      if (ad['fuel'] != null) {'icon': '⛽', 'label': 'Fuel', 'val': ad['fuel'] as String},
      if (ad['transmission'] != null) {'icon': '⚙️', 'label': 'Transmission', 'val': ad['transmission'] as String},
      if (ad['owner'] != null) {'icon': '👤', 'label': 'Owner', 'val': ad['owner'] as String},
      if (ad['km'] != null) {'icon': '🛣️', 'label': 'KM Driven', 'val': '${ad['km']} km'},
      if (ad['color'] != null) {'icon': '🎨', 'label': 'Color', 'val': ad['color'] as String},
      if (ad['regBoard'] != null) {'icon': '🔲', 'label': 'Reg Board', 'val': ad['regBoard'] as String},
      if (ad['bodyType'] != null) {'icon': '🚘', 'label': 'Body Type', 'val': ad['bodyType'] as String},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group items in pairs for a 2-column grid
        ...List.generate(
          (details.length / 2).ceil(),
          (rowIdx) {
            final left = details[rowIdx * 2];
            final rightIdx = rowIdx * 2 + 1;
            final right = rightIdx < details.length ? details[rightIdx] : null;
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  Expanded(child: _buildDetailCell(left['icon']!, left['label']!, left['val']!)),
                  if (right != null)
                    Expanded(child: _buildDetailCell(right['icon']!, right['label']!, right['val']!))
                  else
                    const Expanded(child: SizedBox()),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDetailCell(String emoji, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: GoogleFonts.outfit(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(value, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E))),
            ],
          ),
        ),
      ],
    );
  }

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
        border: const Border(top: BorderSide(color: Color(0xFFF2F2F2), width: 1.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(icon: Icons.home_outlined, label: 'Home', isActive: false, onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          }),
          _buildBottomNavItem(icon: Icons.assignment_outlined, label: 'My Ads', isActive: true, onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MyAdsScreen()));
          }),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellScreen())),
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
                      boxShadow: [BoxShadow(color: Color(0x4DFF7E00), blurRadius: 8, offset: Offset(0, 4))],
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 28),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -4),
                  child: Text('Sell Now', style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w600, color: const Color(0xFFFF7E00))),
                ),
              ],
            ),
          ),
          _buildBottomNavItem(icon: Icons.chat_bubble_outline_rounded, label: 'Chats', isActive: false, badgeCount: 2, onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ChatsScreen()));
          }),
          _buildBottomNavItem(icon: Icons.person_outline, label: 'Profile', isActive: false, onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }),
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
    final activeColor = const Color(0xFFFF7E00);
    final inactiveColor = const Color(0xFF888888);
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
                Icon(icon, color: isActive ? activeColor : inactiveColor, size: 24),
                if (badgeCount > 0)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                      child: Text(
                        badgeCount.toString(),
                        style: GoogleFonts.outfit(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold),
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
