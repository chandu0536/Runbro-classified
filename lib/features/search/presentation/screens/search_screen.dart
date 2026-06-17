import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runbroclassified/features/listings/presentation/screens/listings_screen.dart';
import 'package:runbroclassified/features/home/presentation/screens/categories_screen.dart';
import 'package:runbroclassified/data/app_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  final List<Map<String, dynamic>> _searchCategories = [
    {
      'label': 'Vehicles',
      'image': 'assets/categories/vehicles.jpeg',
      'color': const Color(0xFFFFF4EB),
      'fallbackIcon': Icons.directions_car,
    },
    {
      'label': 'Mobiles',
      'image': 'assets/categories/mobiles.jpeg',
      'color': const Color(0xFFF3E5F5),
      'fallbackIcon': Icons.phone_android,
    },
    {
      'label': 'Bikes',
      'image': 'assets/categories/bikes.jpeg',
      'color': const Color(0xFFFFEBEE),
      'fallbackIcon': Icons.motorcycle,
    },
    {
      'label': 'Electronics',
      'image': 'assets/categories/electronice.jpeg',
      'color': const Color(0xFFE3F2FD),
      'fallbackIcon': Icons.tv,
    },
    {
      'label': 'Furniture',
      'image': 'assets/categories/furniture.jpeg',
      'color': const Color(0xFFFFFDE7),
      'fallbackIcon': Icons.chair,
    },
    {
      'label': 'Fashion',
      'image': 'assets/categories/fashion.jpeg',
      'color': const Color(0xFFFCE4EC),
      'fallbackIcon': Icons.checkroom,
    },
    {
      'label': 'Home & Living',
      'image': 'assets/categories/home & living.jpeg',
      'color': const Color(0xFFE8F5E9),
      'fallbackIcon': Icons.weekend,
    },
    {
      'label': 'Books',
      'image': 'assets/categories/books.jpeg',
      'color': const Color(0xFFFFF3E5),
      'fallbackIcon': Icons.menu_book,
    },
    {
      'label': 'Jobs',
      'image': 'assets/categories/jobs.jpeg',
      'color': const Color(0xFFE0F7FA),
      'fallbackIcon': Icons.work,
    },
    {
      'label': 'Services',
      'image': 'assets/categories/services.jpeg',
      'color': const Color(0xFFECEFF1),
      'fallbackIcon': Icons.build,
    },
    {
      'label': 'More',
      'image': '',
      'color': const Color(0xFFFFEFEB),
      'fallbackIcon': Icons.apps_rounded,
    },
  ];


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Row: Back button and Centered Search Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E), size: 24),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Text(
                    'Search',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar Input Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E2E2), width: 1.0),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 14),
                          const Icon(Icons.search, color: Color(0xFFAAAAAA), size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              autofocus: false, // Don't show keyboard on first tap
                              onChanged: (v) => setState(() => _isSearching = v.isNotEmpty),
                              onSubmitted: (v) {
                                if (v.isNotEmpty) {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => ListingsScreen(category: v)));
                                }
                              },
                              style: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFF1E1E1E)),
                              decoration: InputDecoration(
                                hintText: 'Search for cars, mobiles, bikes and more...',
                                hintStyle: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFFAAAAAA)),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          if (_isSearching)
                            GestureDetector(
                              onTap: () {
                                _controller.clear();
                                setState(() => _isSearching = false);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(Icons.close, color: Color(0xFF888888), size: 18),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFF7E00),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Popular Searches Section
                    Text(
                      'Popular Searches',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 38,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: AppData.popularSearches.length,
                        itemBuilder: (context, index) {
                          final item = AppData.popularSearches[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => ListingsScreen(category: item['label'] as String)),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF7F2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: const Color(0xFFFFEADF), width: 1),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.trending_up_rounded,
                                      color: Color(0xFFFF7E00),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      item['label'] as String,
                                      style: GoogleFonts.outfit(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF333333),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Browse Categories Section (5 columns grid)
                    Text(
                      'Browse Categories',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 0.70,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _searchCategories.length,
                      itemBuilder: (context, index) {
                        final cat = _searchCategories[index];
                        return GestureDetector(
                          onTap: () {
                            if (cat['label'] == 'More') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const CategoriesScreen()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => ListingsScreen(category: cat['label'] as String)),
                              );
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                  color: cat['color'] as Color,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: cat['image'].toString().isNotEmpty
                                      ? ClipOval(
                                          child: Image.asset(
                                            cat['image'] as String,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Icon(
                                                cat['fallbackIcon'] as IconData,
                                                color: const Color(0xFFFF7E00),
                                                size: 26,
                                              );
                                            },
                                          ),
                                        )
                                      : Icon(
                                          cat['fallbackIcon'] as IconData,
                                          color: const Color(0xFFFF7E00),
                                          size: 26,
                                        ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                cat['label'] as String,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF444444),
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Recent Searches Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Searches',
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E1E1E),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // In mock application, just printing or we could set state if needed.
                          },
                          child: Text(
                            'Clear All',
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFFF7E00),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: AppData.recentSearches.length,
                      itemBuilder: (context, index) {
                        final search = AppData.recentSearches[index];
                        return Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFFF0F0F0),
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            leading: const Icon(
                              Icons.access_time_rounded,
                              color: Color(0xFFAAAAAA),
                              size: 18,
                            ),
                            title: Text(
                              search,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF333333),
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                // Close item handler
                              },
                              child: const Icon(
                                Icons.close,
                                color: Color(0xFF888888),
                                size: 16,
                              ),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => ListingsScreen(category: search)),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 28),

                    // Suggestions For You Section
                    Text(
                      'Suggestions For You',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 210,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: AppData.searchSuggestions.length,
                        itemBuilder: (context, index) {
                          final item = AppData.searchSuggestions[index];
                          return Container(
                            width: 150,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFEBEBEB), width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                      child: Image.network(
                                        item['imageUrl'] as String,
                                        height: 100,
                                        width: 150,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            height: 100,
                                            width: 150,
                                            color: const Color(0xFFF5F5F5),
                                            child: const Icon(
                                              Icons.image_not_supported_outlined,
                                              color: Color(0xFFCCCCCC),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: const Color(0x4D000000),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title'] as String,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.outfit(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF333333),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item['price'] as String,
                                        style: GoogleFonts.outfit(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFFFF7E00),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            color: Color(0xFF888888),
                                            size: 12,
                                          ),
                                          const SizedBox(width: 2),
                                          Expanded(
                                            child: Text(
                                              item['location'] as String,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.outfit(
                                                fontSize: 10,
                                                color: const Color(0xFF888888),
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
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

