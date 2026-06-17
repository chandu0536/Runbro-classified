import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runbroclassified/data/app_data.dart';
import 'package:runbroclassified/features/listings/presentation/screens/edit_ad_screen.dart';
import 'package:runbroclassified/features/listings/presentation/screens/my_ads_screen.dart';
import 'package:runbroclassified/features/sell/presentation/screens/sell_screen.dart';
import 'package:runbroclassified/features/home/presentation/screens/home_screen.dart';
import 'package:runbroclassified/features/chats/presentation/screens/chats_screen.dart';
import 'package:runbroclassified/features/profile/presentation/screens/profile_screen.dart';
import 'package:runbroclassified/features/premium/presentation/screens/premium_screen.dart';

class MyAdDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> ad;
  const MyAdDetailsScreen({super.key, required this.ad});

  @override
  State<MyAdDetailsScreen> createState() => _MyAdDetailsScreenState();
}

class _MyAdDetailsScreenState extends State<MyAdDetailsScreen> {
  bool _isDescriptionExpanded = false;

  void _markAsSold() {
    setState(() {
      widget.ad['status'] = 'Sold';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${widget.ad['title']}" marked as sold.')),
    );
  }

  void _deleteAd() {
    setState(() {
      AppData.myAds.removeWhere((element) => element['id'] == widget.ad['id']);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ad deleted successfully.')),
    );
    Navigator.pop(context); // Go back
  }

  void _updatePriceDialog() {
    final priceController = TextEditingController(text: widget.ad['price'].toString().replaceAll('₹', '').replaceAll(',', '').trim());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Price', style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.bold)),
          content: TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixText: '₹ ',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: GoogleFonts.outfit(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.ad['price'] = '₹${priceController.text.trim()}';
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Price updated successfully.')),
                );
              },
              child: Text('Update', style: GoogleFonts.outfit(color: const Color(0xFFFF7E00), fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ad = widget.ad;
    final isSold = ad['status'] == 'Sold';
    final images = ad['images'] as List? ?? [];
    final imagePath = images.isNotEmpty
        ? images[0] as String
        : 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=400';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Ad Details',
          style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined, color: Color(0xFF1E1E1E), size: 22), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert_rounded, color: Color(0xFF1E1E1E), size: 22), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main product image card
                  // Consolidated High-Fidelity Ad Card
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFECEBEB)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left: Image with Status Badge and Image Count overlay
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: imagePath.startsWith('http')
                                  ? Image.network(imagePath, width: 140, height: 155, fit: BoxFit.cover)
                                  : (imagePath.startsWith('assets/')
                                      ? Image.asset(imagePath, width: 140, height: 155, fit: BoxFit.cover)
                                      : Image.file(File(imagePath), width: 140, height: 155, fit: BoxFit.cover)),
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isSold ? const Color(0xFFEEEEEE) : const Color(0xFFDCF5E3),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  ad['status'] as String,
                                  style: GoogleFonts.outfit(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: isSold ? const Color(0xFF757575) : const Color(0xFF1E5C27),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 12),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${images.length}',
                                      style: GoogleFonts.outfit(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 14),

                        // Right: Title, Price, Stats, Location, Date & Action Buttons
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ad['title'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1E1E1E),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    ad['price'] as String,
                                    style: GoogleFonts.outfit(
                                      fontSize: 18.5,
                                      fontWeight: FontWeight.w900,
                                      color: const Color(0xFFFF7E00),
                                    ),
                                  ),
                                  if (ad['negotiable'] == true) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFDCF5E3),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        'Negotiable',
                                        style: GoogleFonts.outfit(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF1E5C27),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 6),
                              // Stats Row
                              Wrap(
                                spacing: 8,
                                runSpacing: 4,
                                children: [
                                  _buildMetricIcon(Icons.visibility_outlined, '${ad['views']} Views'),
                                  _buildMetricIcon(Icons.chat_bubble_outline_rounded, '${ad['chats']} Chats'),
                                  _buildMetricIcon(Icons.favorite_border_rounded, '${ad['likes']}'),
                                ],
                              ),
                              const SizedBox(height: 6),
                              // Location Row
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF455A64)),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      ad['location'] as String,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        color: const Color(0xFF455A64),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              // Date & Ad ID Row
                              Row(
                                children: [
                                  Text(
                                    isSold ? 'Sold on ${ad['date']}' : 'Posted on ${ad['date']}',
                                    style: GoogleFonts.outfit(
                                      fontSize: 11,
                                      color: const Color(0xFF546E7A),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '•',
                                    style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF546E7A)),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      'Ad ID: #${ad['id']}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.outfit(
                                        fontSize: 11,
                                        color: const Color(0xFF546E7A),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Buttons row inside the details column
                              if (!isSold)
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 38,
                                        child: OutlinedButton.icon(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (_) => const PremiumScreen()));
                                          },
                                          icon: const Icon(Icons.rocket_launch_rounded, color: Color(0xFFFF7E00), size: 14),
                                          label: Text(
                                            'Boost Ad',
                                            style: GoogleFonts.outfit(fontSize: 12.5, fontWeight: FontWeight.bold, color: const Color(0xFFFF7E00)),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(color: Color(0xFFFF7E00)),
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            padding: EdgeInsets.zero,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: SizedBox(
                                        height: 38,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (_) => EditAdScreen(ad: ad)),
                                            ).then((_) => setState(() {}));
                                          },
                                          icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 14),
                                          label: Text(
                                            'Edit Ad',
                                            style: GoogleFonts.outfit(fontSize: 12.5, fontWeight: FontWeight.bold, color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFFFF7E00),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            elevation: 0,
                                            padding: EdgeInsets.zero,
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
                  const Divider(height: 32, color: Color(0xFFEEEEEE)),

                  // Description
                  Text(
                    'Description',
                    style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    ad['description'] as String,
                    maxLines: _isDescriptionExpanded ? null : 2,
                    overflow: _isDescriptionExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF555555), height: 1.4),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () => setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _isDescriptionExpanded ? 'See less' : 'See more',
                          style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFFFF7E00)),
                        ),
                        Icon(_isDescriptionExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 14, color: const Color(0xFFFF7E00)),
                      ],
                    ),
                  ),
                  const Divider(height: 32, color: Color(0xFFEEEEEE)),

                  // Ad Details Grid
                  Text(
                    'Ad Details',
                    style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailsGrid(ad),
                  const Divider(height: 32, color: Color(0xFFEEEEEE)),

                  // Images Strip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Images (${images.length})',
                        style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
                      ),
                      Text(
                        'View All',
                        style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFFFF7E00)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (context, i) {
                        final path = images[i] as String;
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E2E2)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: path.startsWith('http')
                                ? Image.network(path, fit: BoxFit.cover)
                                : (path.startsWith('assets/')
                                    ? Image.asset(path, fit: BoxFit.cover)
                                    : Image.file(File(path), fit: BoxFit.cover)),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(height: 32, color: Color(0xFFEEEEEE)),

                  // Manage Your Ad Options
                  Text(
                    'Manage Your Ad',
                    style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildManageOptionButton(Icons.currency_rupee_rounded, 'Update Price', _updatePriceDialog),
                      const SizedBox(width: 8),
                      _buildManageOptionButton(Icons.check_circle_outline_rounded, 'Mark as Sold', _markAsSold, disabled: isSold),
                      const SizedBox(width: 8),
                      _buildManageOptionButton(Icons.delete_outline_rounded, 'Delete Ad', _deleteAd, isDanger: true),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Bottom nav bar tabs
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildMetricIcon(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF455A64)),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF455A64), fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildDetailsGrid(Map<String, dynamic> ad) {
    final specItems = [
      {'label': 'Category', 'val': ad['category'] ?? 'Mobiles'},
      if (ad['brand'] != null) {'label': 'Brand', 'val': ad['brand']},
      {'label': 'Model', 'val': ad['model'] ?? 'N/A'},
      if (ad['storage'] != null) {'label': 'Storage', 'val': ad['storage']},
      if (ad['color'] != null) {'label': 'Color', 'val': ad['color']},
      if (ad['year'] != null) {'label': 'Year', 'val': ad['year']},
      if (ad['fuel'] != null) {'label': 'Fuel', 'val': ad['fuel']},
      if (ad['transmission'] != null) {'label': 'Transmission', 'val': ad['transmission']},
      if (ad['owner'] != null) {'label': 'Owner', 'val': ad['owner']},
      if (ad['km'] != null) {'label': 'KM Driven', 'val': '${ad['km']} km'},
      if (ad['regBoard'] != null) {'label': 'Reg Board', 'val': ad['regBoard']},
      if (ad['bodyType'] != null) {'label': 'Body Type', 'val': ad['bodyType']},
      if (ad['jobType'] != null) {'label': 'Job Type', 'val': ad['jobType']},
      if (ad['salary'] != null) {'label': 'Salary', 'val': ad['salary']},
      if (ad['experience'] != null) {'label': 'Experience', 'val': ad['experience']},
      if (ad['gender'] != null) {'label': 'Gender', 'val': ad['gender']},
      if (ad['size'] != null) {'label': 'Size', 'val': ad['size']},
      {'label': 'Condition', 'val': ad['condition'] ?? 'Good'},
      {'label': 'Posted On', 'val': ad['date'] ?? 'Just now'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
      ),
      itemCount: specItems.length,
      itemBuilder: (context, index) {
        final spec = specItems[index];
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(spec['label'] as String, style: GoogleFonts.outfit(fontSize: 8, color: Colors.grey)),
                  Text(
                    spec['val'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildManageOptionButton(IconData icon, String label, VoidCallback onTap, {bool isDanger = false, bool disabled = false}) {
    final Color contentColor = disabled
        ? Colors.grey
        : (isDanger ? Colors.red : const Color(0xFF555555));
    final Color borderColor = disabled ? const Color(0xFFE2E2E2) : (isDanger ? Colors.red.withOpacity(0.5) : const Color(0xFFE2E2E2));

    return Expanded(
      child: GestureDetector(
        onTap: disabled ? null : onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: contentColor, size: 16),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.bold, color: contentColor),
              ),
            ],
          ),
        ),
      ),
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
          _buildBottomNavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            isActive: false,
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
            },
          ),
          _buildBottomNavItem(
            icon: Icons.assignment_outlined,
            label: 'My Ads',
            isActive: false, // Inactive detail overlay tab
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MyAdsScreen()));
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SellScreen()));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.translate(
                  offset: const Offset(0, -8),
                  child: Container(
                    width: 46.0,
                    height: 46.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF7E00),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Color(0x4DFF7E00), blurRadius: 8.0, offset: Offset(0, 4)),
                      ],
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 28.0),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -4),
                  child: Text(
                    'Sell Now',
                    style: GoogleFonts.outfit(fontSize: 10.0, fontWeight: FontWeight.w600, color: const Color(0xFFFF7E00)),
                  ),
                ),
              ],
            ),
          ),
          _buildBottomNavItem(
            icon: Icons.chat_bubble_outline,
            label: 'Chats',
            isActive: false,
            badgeCount: 2,
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ChatsScreen()));
            },
          ),
          _buildBottomNavItem(
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: false,
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
            },
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
    final activeColor = const Color(0xFFFF7E00);
    final inactiveColor = const Color(0xFF888888);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: isActive ? activeColor : inactiveColor, size: 24.0),
                if (badgeCount > 0)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      constraints: const BoxConstraints(minWidth: 12.0, minHeight: 12.0),
                      child: Text(
                        badgeCount.toString(),
                        style: GoogleFonts.outfit(color: Colors.white, fontSize: 7.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3.0),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 10.0,
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
