import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runbroclassified/data/app_data.dart';
import 'package:runbroclassified/models/car_listing.dart';
import 'package:runbroclassified/features/listings/presentation/screens/listing_detail_screen.dart';
import 'package:runbroclassified/features/profile/presentation/screens/wishlist_screen.dart';
import 'package:runbroclassified/features/search/presentation/screens/search_screen.dart';

class ListingsScreen extends StatefulWidget {
  final String category;
  const ListingsScreen({super.key, required this.category});

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  String _selectedSubcategory = 'All';

  @override
  Widget build(BuildContext context) {
    final cat = widget.category.toLowerCase();
    final isVehicles = cat.contains('vehicle') || cat.contains('car');
    final isMobiles = cat.contains('mobil');
    final isBikes = cat.contains('bike');

    // Generic categories that use the new Map-based data
    final genericCategories = [
      'furniture', 'bikes', 'electronics', 'fashion', 'home & living',
      'books', 'jobs', 'services', 'pets', 'kids',
    ];
    final isGeneric = genericCategories.any((g) => cat.contains(g.split(' ')[0]) || cat == g);

    // --- Determine listings ---
    List<CarListing> carListings = [];
    List<Map<String, dynamic>> genericListings = [];

    if (isMobiles) {
      carListings = AppData.mobileListings;
      if (_selectedSubcategory != 'All') {
        carListings = carListings
            .where((item) => item.title.toLowerCase().contains(_selectedSubcategory.toLowerCase()))
            .toList();
      }
    } else if (isVehicles && !isBikes) {
      carListings = AppData.carListings;
      if (_selectedSubcategory != 'All' && _selectedSubcategory != 'Electric' && _selectedSubcategory != 'Diesel') {
        carListings = carListings
            .where((item) => item.year.toLowerCase().contains(_selectedSubcategory.toLowerCase()) ||
                             item.title.toLowerCase().contains(_selectedSubcategory.toLowerCase()))
            .toList();
      } else if (_selectedSubcategory == 'Electric' || _selectedSubcategory == 'Diesel') {
        carListings = carListings
            .where((item) => item.fuel.toLowerCase().contains(_selectedSubcategory.toLowerCase()))
            .toList();
      }
    } else if (isGeneric) {
      genericListings = AppData.getCategoryListings(widget.category);
      if (_selectedSubcategory != 'All') {
        genericListings = genericListings
            .where((item) => (item['tag'] as String).toLowerCase() == _selectedSubcategory.toLowerCase())
            .toList();
      }
    }

    final cleanCategory = isMobiles
        ? 'Mobiles'
        : (isVehicles && !isBikes ? 'Cars' : widget.category);

    final totalCount = isGeneric ? genericListings.length : carListings.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              cleanCategory,
              style: GoogleFonts.outfit(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E1E1E),
              ),
            ),
            Text(
              '$totalCount Results',
              style: GoogleFonts.outfit(
                fontSize: 11.0,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF888888),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF1E1E1E), size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Color(0xFF1E1E1E), size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WishlistScreen()),
              ).then((_) => setState(() {}));
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          _buildFilterRow(),
          const SizedBox(height: 8),
          _buildSubcategoryTabs(),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                children: [
                  if (isGeneric && genericListings.isNotEmpty)
                    _buildGenericGrid(genericListings)
                  else if (!isGeneric && carListings.isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: List.generate((carListings.length + 1) ~/ 2, (colIndex) {
                              final index = colIndex * 2;
                              return _buildCard(context, carListings[index], index, isVehicles && !isBikes);
                            }),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: List.generate(carListings.length ~/ 2, (colIndex) {
                              final index = colIndex * 2 + 1;
                              return _buildCard(context, carListings[index], index, isVehicles && !isBikes);
                            }),
                          ),
                        ),
                      ],
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60.0),
                      child: Center(
                        child: Text(
                          'No results found',
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            color: const Color(0xFF999999),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  _buildPaginationFooter(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          _buildFilterPill('Sort', Icons.swap_vert_rounded),
          const SizedBox(width: 8),
          _buildFilterPill('Filter', Icons.filter_alt_outlined),
          const SizedBox(width: 8),
          _buildFilterPill('Location', Icons.location_on_outlined),
          const SizedBox(width: 8),
          _buildFilterPill('Price', Icons.currency_rupee_rounded),
        ],
      ),
    );
  }

  Widget _buildFilterPill(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E2E2), width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF555555)),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF555555),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down_rounded, size: 14, color: Color(0xFF555555)),
        ],
      ),
    );
  }

  Widget _buildSubcategoryTabs() {
    final cat = widget.category.toLowerCase();
    final isMobiles = cat.contains('mobil');
    final isVehicles = cat.contains('vehicle') || cat.contains('car');
    final isBikes = cat.contains('bike');

    List<String> tabs;
    if (isMobiles) {
      tabs = ['All', 'iPhone', 'Samsung', 'OnePlus', 'Google', 'Xiaomi'];
    } else if (isVehicles && !isBikes) {
      tabs = ['All', 'Hatchback', 'Sedan', 'SUV', 'Luxury', 'Electric', 'Diesel'];
    } else {
      // Use AppData map for all new categories
      tabs = AppData.categorySubcategories[widget.category] ?? ['All'];
    }

    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = tab == _selectedSubcategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSubcategory = tab;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFFF7F2) : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFFE2E2E2),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  tab,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFF777777),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Generic grid for new Map-based categories ──────────────────────────────

  Widget _buildGenericGrid(List<Map<String, dynamic>> items) {
    // Split into two columns
    final leftItems = <Map<String, dynamic>>[];
    final rightItems = <Map<String, dynamic>>[];
    for (int i = 0; i < items.length; i++) {
      if (i % 2 == 0) {
        leftItems.add(items[i]);
      } else {
        rightItems.add(items[i]);
      }
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: leftItems.map((item) => _buildGenericCard(item)).toList(),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: rightItems.map((item) => _buildGenericCard(item)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildGenericCard(Map<String, dynamic> item) {
    final title = item['title'] as String;
    final price = item['price'] as String;
    final sub = item['sub'] as String;
    final tag = item['tag'] as String;
    final location = item['location'] as String;
    final time = item['time'] as String;
    final badge = item['badge'] as String;
    final image = item['image'] as String;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ListingDetailScreen(
                listing: {
                  'title': title,
                  'price': price,
                  'location': location,
                  'category': widget.category,
                  'imageUrl': image,
                },
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFEBEBEB), width: 1.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0x05000000),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with badge + favorite
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                    child: Image.network(
                      image,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 120,
                          color: const Color(0xFFF5F5F5),
                          child: const Center(
                            child: Icon(Icons.image_not_supported_outlined, color: Color(0xFFCCCCCC)),
                          ),
                        );
                      },
                    ),
                  ),
                  if (badge.isNotEmpty)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: badge == 'NEW'
                              ? const Color(0xFF2196F3)
                              : badge == 'TRUSTED'
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFFFF7E00),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          badge,
                          style: GoogleFonts.outfit(
                            fontSize: 8.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          AppData.toggleFavorite(
                            title,
                            price: price,
                            location: location,
                            image: image,
                          );
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0x4D000000),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          AppData.isItemFavorited(title)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: AppData.isItemFavorited(title)
                              ? Colors.red
                              : Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Details
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E1E1E),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      sub,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF999999),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Tag chip
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        tag,
                        style: GoogleFonts.outfit(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFE65100),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      price,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFFFF7E00),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.location_on_outlined, size: 10, color: Color(0xFF888888)),
                              const SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  location,
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
                        ),
                        const SizedBox(width: 4),
                        Text(
                          time,
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            color: const Color(0xFFBBBBBB),
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
      ),
    );
  }

  Widget _buildPaginationFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing 1 – 20 of 25,432 results',
            style: GoogleFonts.outfit(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF888888),
            ),
          ),
          Row(
            children: [
              _buildPageNumber('1', true),
              const SizedBox(width: 4),
              _buildPageNumber('2', false),
              const SizedBox(width: 4),
              _buildPageNumber('3', false),
              const SizedBox(width: 4),
              Text(
                '...',
                style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF888888)),
              ),
              const SizedBox(width: 4),
              _buildPageNumber('127', false),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFF888888)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageNumber(String number, bool isActive) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFF7E00) : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? const Color(0xFFFF7E00) : const Color(0xFFE2E2E2),
          width: isActive ? 0 : 1,
        ),
      ),
      child: Center(
        child: Text(
          number,
          style: GoogleFonts.outfit(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: isActive ? Colors.white : const Color(0xFF888888),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, CarListing item, int index, bool isVehiclesCategory) {
    final isMobiles = widget.category.toLowerCase().contains('mobil');
    final title = isVehiclesCategory || isMobiles ? item.title : '${widget.category} Model ${index + 1}';
    final price = isVehiclesCategory || isMobiles ? item.price : '₹${((index + 1) * 12000)}';
    final image = (isVehiclesCategory || isMobiles) && item.imagePath.isNotEmpty
        ? item.imagePath
        : 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&q=80&w=400';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ListingDetailScreen(
                listing: {
                  'title': title,
                  'price': price,
                  'location': item.location,
                  'category': isMobiles ? 'Mobiles' : (isVehiclesCategory ? 'Cars' : widget.category),
                  'imageUrl': image,
                },
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFEBEBEB), width: 1.0),
            boxShadow: [
              BoxShadow(
                color: const Color(0x05000000),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                    child: image.startsWith('http')
                        ? Image.network(
                            image,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 120,
                                color: const Color(0xFFF5F5F5),
                                child: const Center(
                                  child: Icon(Icons.image_not_supported_outlined, color: Color(0xFFCCCCCC)),
                                ),
                              );
                            },
                          )
                        : Image.asset(
                            image,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 120,
                                color: const Color(0xFFF5F5F5),
                                child: const Center(
                                  child: Icon(Icons.image_not_supported_outlined, color: Color(0xFFCCCCCC)),
                                ),
                              );
                            },
                          ),
                  ),
                  if (item.badge.isNotEmpty)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.badge,
                          style: GoogleFonts.outfit(
                            fontSize: 8.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          AppData.toggleFavorite(
                            title,
                            price: price,
                            location: item.location,
                            image: image,
                          );
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0x4D000000),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          AppData.isItemFavorited(title)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: AppData.isItemFavorited(title)
                              ? Colors.red
                              : Colors.white,
                          size: 14,
                        ),
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
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                    Text(
                      item.year,
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF777777),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(isMobiles ? Icons.smartphone_rounded : Icons.local_gas_station_rounded, size: 12, color: const Color(0xFF777777)),
                        const SizedBox(width: 2),
                        Text(
                          item.fuel,
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF777777),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(isMobiles ? Icons.battery_charging_full_rounded : Icons.speed_rounded, size: 12, color: const Color(0xFF777777)),
                        const SizedBox(width: 2),
                        Text(
                          isMobiles ? 'Battery: ${item.km}%' : '${item.km ~/ 1000},000 km',
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF777777),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      price,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFFFF7E00),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.location_on_outlined, size: 10, color: Color(0xFF888888)),
                              const SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  item.location,
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
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.timeAgo,
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            color: const Color(0xFFBBBBBB),
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
      ),
    );
  }
}