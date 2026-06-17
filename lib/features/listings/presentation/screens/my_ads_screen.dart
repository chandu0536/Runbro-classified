import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runbroclassified/data/app_data.dart';
import 'package:runbroclassified/features/listings/presentation/screens/my_ad_details_screen.dart';
import 'package:runbroclassified/features/listings/presentation/screens/edit_ad_screen.dart';
import 'package:runbroclassified/features/sell/presentation/screens/sell_screen.dart';
import 'package:runbroclassified/features/home/presentation/screens/home_screen.dart';
import 'package:runbroclassified/features/chats/presentation/screens/chats_screen.dart';
import 'package:runbroclassified/features/profile/presentation/screens/profile_screen.dart';
import 'package:runbroclassified/features/premium/presentation/screens/premium_screen.dart';
import 'package:runbroclassified/features/notifications/presentation/screens/notifications_screen.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  String _selectedSort = 'Newest First';
  bool _isSearching = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showManageSheet(BuildContext context, Map<String, dynamic> ad) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Manage Ad - ${ad['title']}',
                  style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
                ),
              ),
              const Divider(height: 1, color: Color(0xFFF0F0F0)),
              ListTile(
                leading: const Icon(Icons.edit_outlined, color: Color(0xFFFF7E00)),
                title: Text('Edit Ad Details', style: GoogleFonts.outfit(fontSize: 13)),
                onTap: () {
                  Navigator.pop(bc);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditAdScreen(ad: ad)),
                  ).then((_) => setState(() {}));
                },
              ),
              ListTile(
                leading: const Icon(Icons.check_circle_outline, color: Colors.green),
                title: Text('Mark as Sold', style: GoogleFonts.outfit(fontSize: 13)),
                onTap: () {
                  Navigator.pop(bc);
                  setState(() {
                    ad['status'] = 'Sold';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('"${ad['title']}" marked as sold successfully.')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: Text('Delete Ad', style: GoogleFonts.outfit(fontSize: 13, color: Colors.red)),
                onTap: () {
                  Navigator.pop(bc);
                  setState(() {
                    AppData.myAds.removeWhere((element) => element['id'] == ad['id']);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ad deleted successfully.')),
                  );
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter and Sort the ads list
    final List<Map<String, dynamic>> adsList = List.from(AppData.myAds);
    
    // Filter by search query
    final filteredAds = adsList.where((ad) {
      if (_searchQuery.isEmpty) return true;
      final title = (ad['title'] as String? ?? '').toLowerCase();
      final category = (ad['category'] as String? ?? '').toLowerCase();
      final description = (ad['description'] as String? ?? '').toLowerCase();
      final query = _searchQuery.toLowerCase();
      return title.contains(query) || category.contains(query) || description.contains(query);
    }).toList();

    // Sort the list
    if (_selectedSort == 'Newest First') {
      filteredAds.sort((a, b) => (b['id'] as String).compareTo(a['id'] as String));
    } else if (_selectedSort == 'Oldest First') {
      filteredAds.sort((a, b) => (a['id'] as String).compareTo(b['id'] as String));
    } else if (_selectedSort == 'Price: Low to High') {
      filteredAds.sort((a, b) {
        final double priceA = double.tryParse((a['price'] as String? ?? '').replaceAll(RegExp(r'[^0-9]'), '')) ?? 0.0;
        final double priceB = double.tryParse((b['price'] as String? ?? '').replaceAll(RegExp(r'[^0-9]'), '')) ?? 0.0;
        return priceA.compareTo(priceB);
      });
    } else if (_selectedSort == 'Price: High to Low') {
      filteredAds.sort((a, b) {
        final double priceA = double.tryParse((a['price'] as String? ?? '').replaceAll(RegExp(r'[^0-9]'), '')) ?? 0.0;
        final double priceB = double.tryParse((b['price'] as String? ?? '').replaceAll(RegExp(r'[^0-9]'), '')) ?? 0.0;
        return priceB.compareTo(priceA);
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E)),
          onPressed: () {
            if (_isSearching) {
              setState(() {
                _isSearching = false;
                _searchQuery = '';
                _searchController.clear();
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search my ads...',
                  hintStyle: GoogleFonts.outfit(
                    fontSize: 16,
                    color: const Color(0xFF888888),
                  ),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  color: const Color(0xFF1E1E1E),
                ),
              )
            : Text(
                'My Ads',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search, color: const Color(0xFF1E1E1E), size: 22),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchQuery = '';
                  _searchController.clear();
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF1E1E1E), size: 22),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                  );
                },
              ),
              Positioned(
                right: 14,
                top: 14,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF7E00),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Boost Your Ads Banner
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF6F2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFE3D5)),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFFFE3D5), width: 1),
                  ),
                  child: const Center(
                    child: Icon(Icons.rocket_launch_rounded, color: Color(0xFFFF7E00), size: 20),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Boost Your Ads',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Get more views and sell faster with RunBro Premium.',
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          color: const Color(0xFF757575),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PremiumScreen()));
                  },
                  icon: const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 12),
                  label: Text(
                    'Upgrade Now',
                    style: GoogleFonts.outfit(fontSize: 9.5, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7E00),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    minimumSize: Size.zero,
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ),

          // Filters Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PopupMenuButton<String>(
                  initialValue: _selectedSort,
                  onSelected: (val) => setState(() => _selectedSort = val),
                  itemBuilder: (context) => [
                    'Newest First',
                    'Oldest First',
                    'Price: Low to High',
                    'Price: High to Low',
                  ].map((e) => PopupMenuItem(value: e, child: Text(e, style: GoogleFonts.outfit(fontSize: 12)))).toList(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFECEBEB)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Sort by: $_selectedSort',
                          style: GoogleFonts.outfit(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E1E1E)),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.keyboard_arrow_down_rounded, size: 14, color: Color(0xFF1E1E1E)),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFECEBEB)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.tune_rounded, size: 14, color: Color(0xFF1E1E1E)),
                      const SizedBox(width: 6),
                      Text(
                        'Filter',
                        style: GoogleFonts.outfit(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E1E1E)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Ads List
          Expanded(
            child: filteredAds.isEmpty
                ? Center(
                    child: Text(
                      _searchQuery.isEmpty 
                          ? 'No ads posted yet.\nTap "Sell Now" to list an item.'
                          : 'No matching ads found.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(fontSize: 14, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredAds.length,
                    itemBuilder: (context, index) {
                      final ad = filteredAds[index];
                      final isSold = ad['status'] == 'Sold';
                      final imagePath = ad['images'] != null && (ad['images'] as List).isNotEmpty
                          ? ad['images'][0] as String
                          : 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=400';

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MyAdDetailsScreen(ad: ad)),
                          ).then((_) => setState(() {}));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(10),
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
                                    borderRadius: BorderRadius.circular(8),
                                    child: imagePath.startsWith('http')
                                        ? Image.network(imagePath, width: 130, height: 125, fit: BoxFit.cover)
                                        : (imagePath.startsWith('assets/')
                                            ? Image.asset(imagePath, width: 130, height: 125, fit: BoxFit.cover)
                                            : Image.file(File(imagePath), width: 130, height: 125, fit: BoxFit.cover)),
                                  ),
                                  Positioned(
                                    top: 6,
                                    left: 6,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: isSold ? const Color(0xFFEEEEEE) : const Color(0xFFEEF9EE),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        ad['status'] as String,
                                        style: GoogleFonts.outfit(
                                          fontSize: 8.5,
                                          fontWeight: FontWeight.bold,
                                          color: isSold ? const Color(0xFF757575) : const Color(0xFF2E7D32),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 6,
                                    right: 6,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 9),
                                          const SizedBox(width: 3),
                                          Text(
                                            '${(ad['images'] as List?)?.length ?? 1}',
                                            style: GoogleFonts.outfit(
                                              fontSize: 8.5,
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
                              const SizedBox(width: 12),

                              // Right: Title, Price, Stats, Location, Date & Action Buttons
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            ad['title'] as String,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.outfit(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF1E1E1E),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => _showManageSheet(context, ad),
                                          child: const Icon(Icons.more_vert_rounded, color: Color(0xFF757575), size: 18),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        Text(
                                          ad['price'] as String,
                                          style: GoogleFonts.outfit(
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.w900,
                                            color: const Color(0xFFFF7E00),
                                          ),
                                        ),
                                        if (ad['negotiable'] == true) ...[
                                          const SizedBox(width: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFEEF9EE),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              'Negotiable',
                                              style: GoogleFonts.outfit(
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF2E7D32),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    // Stats row
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 4,
                                      children: [
                                        _buildStat(Icons.visibility_outlined, '${ad['views']} Views'),
                                        _buildStat(Icons.chat_bubble_outline_rounded, '${ad['chats']} Chats'),
                                        _buildStat(Icons.favorite_border_rounded, '${ad['likes']}'),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    // Location row
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_outlined, size: 11, color: Color(0xFF757575)),
                                        const SizedBox(width: 3),
                                        Expanded(
                                          child: Text(
                                            ad['location'] as String,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.outfit(
                                              fontSize: 10,
                                              color: const Color(0xFF757575),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    // Date text
                                    Text(
                                      isSold ? 'Sold on ${ad['date']}' : 'Posted on ${ad['date']}',
                                      style: GoogleFonts.outfit(
                                        fontSize: 9.5,
                                        color: const Color(0xFF9E9E9E),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    // Row of action buttons
                                    isSold
                                        ? Align(
                                            alignment: Alignment.centerRight,
                                            child: SizedBox(
                                              width: 100,
                                              height: 30,
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (_) => MyAdDetailsScreen(ad: ad)),
                                                  ).then((_) => setState(() {}));
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  side: const BorderSide(color: Color(0xFFECEBEB)),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                                  padding: EdgeInsets.zero,
                                                ),
                                                child: Text(
                                                  'View Details',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 10.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(0xFF555555),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Row(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  height: 30,
                                                  child: OutlinedButton.icon(
                                                    onPressed: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (_) => const PremiumScreen()));
                                                    },
                                                    icon: const Icon(Icons.rocket_launch_rounded, color: Color(0xFFFF7E00), size: 11),
                                                    label: Text(
                                                      'Boost Ad',
                                                      style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFFFF7E00)),
                                                    ),
                                                    style: OutlinedButton.styleFrom(
                                                      side: const BorderSide(color: Color(0xFFFF7E00)),
                                                      backgroundColor: Colors.white,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                                      padding: EdgeInsets.zero,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: SizedBox(
                                                  height: 30,
                                                  child: ElevatedButton.icon(
                                                    onPressed: () => _showManageSheet(context, ad),
                                                    icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 11),
                                                    label: Text(
                                                      'Manage Ad',
                                                      style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: const Color(0xFFFF7E00),
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
                      );
                    },
                  ),
          ),

          // Sell Another Item Button with custom dashed border
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SellScreen())).then((_) => setState(() {}));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CustomPaint(
                painter: _MyAdsDashedBorderPainter(color: const Color(0xFFFFDCD0), radius: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF7E00),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(Icons.add, color: Colors.white, size: 18),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sell Another Item',
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF1E1E1E),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'List more items and earn more',
                              style: GoogleFonts.outfit(
                                fontSize: 9.5,
                                color: const Color(0xFF757575),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded, color: Color(0xFF757575), size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom Nav bar tabs
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 12, color: const Color(0xFF757575)),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF757575), fontWeight: FontWeight.w500),
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
            isActive: true,
            onTap: () {},
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SellScreen())).then((_) => setState(() {}));
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
            icon: Icons.chat_bubble_outline_rounded,
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

// Custom Painter for drawing the dashed border of "Sell Another Item" box
class _MyAdsDashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashLength;
  final double radius;

  _MyAdsDashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 4.0,
    this.dashLength = 6.0,
    this.radius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));

    final dashedPath = Path();
    double distance = 0.0;
    for (final metric in path.computeMetrics()) {
      while (distance < metric.length) {
        dashedPath.addPath(
          metric.extractPath(distance, distance + dashLength),
          Offset.zero,
        );
        distance += dashLength + gap;
      }
    }
    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
