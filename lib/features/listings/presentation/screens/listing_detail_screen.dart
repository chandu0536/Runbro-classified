import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runbroclassified/features/chats/presentation/screens/chat_detail_screen.dart';
import 'package:runbroclassified/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:runbroclassified/data/app_data.dart';

class ListingDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? listing;
  const ListingDetailScreen({super.key, this.listing});

  @override
  State<ListingDetailScreen> createState() => _ListingDetailScreenState();
}

class _ListingDetailScreenState extends State<ListingDetailScreen> {
  bool _isWishlisted = false;
  int _selectedImageIndex = 0;

  late final String _title;
  late final String _price;
  late final String _location;
  late final String _category;
  late final List<String> _images;
  late final String _description;
  late final String _subtitle;
  late final bool _isVehicle;

  @override
  void initState() {
    super.initState();
    final listing = widget.listing;
    if (listing != null) {
      _title = listing['title'] as String? ?? 'Maruti Suzuki Swift VXI 2018';
      _price = listing['price'] as String? ?? '₹4,25,000';
      _location = listing['location'] as String? ?? 'Hyderabad, Telangana';
      _category = listing['category'] as String? ?? 'Cars';
      _isVehicle = _category.toLowerCase().contains('car') || 
                   _category.toLowerCase().contains('vehicle') || 
                   _category.toLowerCase().contains('bike');
      
      final singleImg = listing['imageUrl'] as String? ?? listing['image'] as String? ?? 'assets/images/swift_car_main.png';
      _images = [singleImg];
      
      _description = 'High quality $_title in excellent condition. Location: $_location. Price is negotiable.';
      _subtitle = _isVehicle ? '45,000 km • Petrol • Manual' : 'Gently Used • Certified';
    } else {
      _title = 'Maruti Suzuki Swift VXI 2018';
      _price = '₹4,25,000';
      _location = 'Hyderabad, Telangana';
      _category = 'Cars';
      _isVehicle = true;
      _images = _carImages;
      _description = 'Well maintained Maruti Suzuki Swift VXI 2018 for sale.\nSingle owner, excellent condition, all documents are clear.';
      _subtitle = '45,000 km • Petrol • Manual';
    }

    _isWishlisted = AppData.isItemFavorited(_title);
  }

  final List<String> _carImages = [
    'assets/images/swift_car_main.png', // main grey Swift
    'assets/images/swift_detail_1.jpg',  // interior / dash
    'assets/images/swift_detail_2.jpg',  // side view
    'assets/images/swift_main.png',      // rear/main view
    'assets/images/swift_detail_1.jpg',  // repeat dashboard
    'assets/images/swift_detail_2.jpg',  // repeat side
  ];

  Widget _buildImage(String path, {double? width, double? height, BoxFit fit = BoxFit.cover}) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: const Color(0xFFF5F5F5),
            child: const Center(
              child: Icon(Icons.image_not_supported_outlined, color: Color(0xFFCCCCCC), size: 48),
            ),
          );
        },
      );
    } else {
      return Image.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: const Color(0xFFF5F5F5),
            child: const Center(
              child: Icon(Icons.image_not_supported_outlined, color: Color(0xFFCCCCCC), size: 48),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E), size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: _isWishlisted ? Colors.red : const Color(0xFF1E1E1E),
              size: 22,
            ),
            onPressed: () {
              setState(() {
                _isWishlisted = !_isWishlisted;
                AppData.toggleFavorite(
                  _title,
                  price: _price,
                  location: _location,
                  image: _images[0],
                );
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.ios_share, color: Color(0xFF1E1E1E), size: 22),
            onPressed: () {},
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
                right: 6,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12.0,
                    minHeight: 12.0,
                  ),
                  child: Text(
                    '3',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 7.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            
            // Main Product Image with rounded corners and overlays
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: [
                  Container(
                    height: 220.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.04 * 255).round()),
                          blurRadius: 10.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: _buildImage(
                        _images[_selectedImageIndex],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  // Featured Badge Overlay
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'FEATURED',
                        style: GoogleFonts.outfit(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  
                  // Pagination Badge Overlay
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0x80000000),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_selectedImageIndex + 1} / ${_images.length}',
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            _buildBody(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),

        // Gallery Thumbnail strip
        if (_images.length > 1) ...[
          _buildThumbnailStrip(),
          const SizedBox(height: 12),
        ],

        // Product text/price specs
        _buildProductDetails(),
        const SizedBox(height: 12),

        // Key Highlights card
        if (_isVehicle) ...[
          _buildKeyHighlights(),
          const SizedBox(height: 12),
        ],

        // Seller Information card
        _buildSellerInformation(),
        const SizedBox(height: 12),

        // Description text
        _buildDescription(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildThumbnailStrip() {
    return SizedBox(
      height: 58,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _images.length,
        itemBuilder: (context, i) {
          final isSelected = _selectedImageIndex == i;
          final isLast = i == _images.length - 1;
          return GestureDetector(
            onTap: () => setState(() => _selectedImageIndex = i),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFFE2E2E2),
                  width: isSelected ? 2.0 : 1.0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildImage(
                      _images[i],
                      fit: BoxFit.cover,
                    ),
                    if (isLast && _images.length > 5)
                      Container(
                        color: const Color(0x99000000),
                        child: Center(
                          child: Text(
                            '+10',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductDetails() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _title,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _subtitle,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF777777),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Certified pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF81C784), width: 0.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF4CAF50),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'RunBro Certified',
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Price
          Text(
            _price,
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFFF7E00),
            ),
          ),
          const SizedBox(height: 2),
          GestureDetector(
            onTap: () {},
            child: Text(
              'View Finance Options',
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2196F3),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFEEEEEE), height: 1),
          const SizedBox(height: 12),

          // Location and posted timestamp row
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 12,
            runSpacing: 6,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF888888)),
                  const SizedBox(width: 4),
                  Text(
                     '$_location  •  Posted 2 hours ago',
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF888888),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.visibility_outlined, size: 14, color: Color(0xFF888888)),
                  const SizedBox(width: 4),
                  Text(
                    '256 Views',
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyHighlights() {
    final List<IconData> highlightIcons = [
      Icons.speed_outlined,
      Icons.local_gas_station_outlined,
      Icons.lan_outlined,
      Icons.person_outline_rounded,
      Icons.shield_outlined,
    ];
    final List<String> labels = ['45,000 km', 'Petrol', 'Manual', '1st Owner', 'Valid'];
    final List<String> subLabels = ['Driven', 'Fuel Type', 'Transmission', 'Ownership', 'Insurance'];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0F0F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0x05000000),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Highlights',
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              return Expanded(
                child: Column(
                  children: [
                    Icon(
                      highlightIcons[index],
                      color: const Color(0xFF555555),
                      size: 24,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      labels[index],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subLabels[index],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSellerInformation() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0F0F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0x05000000),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seller Information',
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFECE2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'RA',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFFF7E00),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ramesh A',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Color(0xFFFFB300), size: 14),
                        const SizedBox(width: 3),
                        Text(
                          '4.5 (32 Reviews)',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Member since Jan 2021',
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFFF7E00)),
                  foregroundColor: const Color(0xFFFF7E00),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                ),
                child: Text(
                  'View Profile',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _description,
            style: GoogleFonts.outfit(
              fontSize: 13,
              color: const Color(0xFF555555),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Read More',
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFF7E00),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 16,
                  color: Color(0xFFFF7E00),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ChatDetailScreen()),
                      ),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFD2D2D2), width: 1.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF555555), size: 18),
                            const SizedBox(width: 6),
                            Text(
                              'Chat with Seller',
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1E1E1E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF7E00),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.phone_outlined, color: Colors.white, size: 18),
                            const SizedBox(width: 6),
                            Text(
                              'Call Seller',
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: const Color(0xFFEEF9EE),
              child: Row(
                children: [
                  const Icon(Icons.gpp_good_rounded, color: Color(0xFF4CAF50), size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Be safe! Meet in public places and inspect the product before buying.',
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
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

