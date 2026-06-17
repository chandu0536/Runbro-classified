import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runbroclassified/logic/blocs/location/location_bloc.dart';
import 'package:runbroclassified/logic/blocs/location/location_state.dart';
import 'package:runbroclassified/data/app_data.dart';
import 'package:runbroclassified/features/search/presentation/screens/search_screen.dart';
import 'package:runbroclassified/features/listings/presentation/screens/listings_screen.dart';
import 'package:runbroclassified/features/listings/presentation/screens/listing_detail_screen.dart';
import 'package:runbroclassified/features/chats/presentation/screens/chats_screen.dart';
import 'package:runbroclassified/features/home/presentation/screens/categories_screen.dart';
import 'package:runbroclassified/features/profile/presentation/screens/profile_screen.dart';
import 'package:runbroclassified/features/auth/presentation/screens/location_screen.dart';
import 'package:runbroclassified/ui/widgets/app_logo.dart';
import 'package:runbroclassified/core/routes/app_routes.dart';
import 'package:runbroclassified/features/notifications/presentation/screens/notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _bannerController;
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;

  @override
  void initState() {
    super.initState();
    _bannerController = PageController(initialPage: 0);
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_bannerController.hasClients) {
        final nextPage = (_currentBannerIndex + 1) % 3;
        _bannerController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            _buildPromoBannerCarousel(),
            _buildCategoriesSection(),
            _buildRecommendedSection(),
            _buildNearbyDealsSection(),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            const AppLogo(height: 30.0),
            const Spacer(),
            BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LocationScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Color(0xFF555555), size: 16.0),
                      const SizedBox(width: 4.0),
                      Text(
                        state.selectedLocation.split(',').first,
                        style: GoogleFonts.outfit(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down, color: Color(0xFF555555), size: 16.0),
                    ],
                  ),
                );
              },
            ),
            const Spacer(),
            // Notification bell with badge 3
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF1E1E1E), size: 24.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                    );
                  },
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14.0,
                      minHeight: 14.0,
                    ),
                    child: Text(
                      '3',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 8.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchScreen()),
          );
        },
        child: Container(
          height: 54.0,
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(27.0),
            border: Border.all(color: const Color(0xFFE2E2E2), width: 1.0),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Color(0xFF888888), size: 22.0),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Search for cars, mobiles, bikes and more...',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF888888),
                  ),
                ),
              ),
              Container(
                width: 38.0,
                height: 38.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF7E00),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.search, color: Colors.white, size: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoBannerCarousel() {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth - 32.0;
    // home_banner.png is 1024x408 (wide landscape banner).
    final double cardHeight = cardWidth * (408.0 / 1024.0);
    final double pageViewHeight = cardHeight + 20.0;

    return Column(
      children: [
        SizedBox(
          height: pageViewHeight,
          child: PageView.builder(
            controller: _bannerController,
            onPageChanged: (index) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ListingsScreen(category: 'Vehicles'),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/home_banner.png',
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final isActive = index == _currentBannerIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: isActive ? 18.0 : 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFFFF7E00) : const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(3.0),
              ),
            );
          }),
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }  Widget _buildCategoriesSection() {
    final displayColors = [
      const Color(0xFFFFF4EB), // Vehicles
      const Color(0xFFF3E5F5), // Mobiles
      const Color(0xFFFFEBEE), // Bikes
      const Color(0xFFE3F2FD), // Electronics
      const Color(0xFFFFFDE7), // Furniture
      const Color(0xFFFCE4EC), // Fashion
      const Color(0xFFE8F5E9), // Home & Living
      const Color(0xFFFFF3E5), // Books
      const Color(0xFFE0F7FA), // Jobs
      const Color(0xFFECEFF1), // Services
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Browse Categories',
                style: GoogleFonts.outfit(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CategoriesScreen()),
                  );
                },
                child: Text(
                  'See All',
                  style: GoogleFonts.outfit(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFF7E00),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  final cat = AppData.categories[index];
                  final color = displayColors[index];
                  return Expanded(
                    child: _buildCategoryItem(cat['label'] as String, cat['image'] as String, color, cat['icon'] as String),
                  );
                }),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  final cat = AppData.categories[index + 5];
                  final color = displayColors[index + 5];
                  return Expanded(
                    child: _buildCategoryItem(cat['label'] as String, cat['image'] as String, color, cat['icon'] as String),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String label, String imagePath, Color color, String fallbackIcon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ListingsScreen(category: label),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 54.0,
            height: 54.0,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Text(
                      fallbackIcon,
                      style: const TextStyle(fontSize: 26.0),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.outfit(
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended for You',
                style: GoogleFonts.outfit(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
              Text(
                'See All',
                style: GoogleFonts.outfit(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFF7E00),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: AppData.homeRecommended.length,
            itemBuilder: (context, index) {
              final item = AppData.homeRecommended[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ListingDetailScreen(listing: item)),
                  );
                },
                child: Container(
                  width: 140.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: const Color(0xFFEEEEEE), width: 1.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFF9F9F9),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                                child: Image.network(
                                  item['imageUrl'] as String,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Text(
                                        _getDealEmoji(item['category'] as String),
                                        style: const TextStyle(fontSize: 40.0),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8.0,
                              right: 8.0,
                              child: GestureDetector(
                                onTap: () {
                                  final title = item['title'] as String;
                                  setState(() {
                                    AppData.toggleFavorite(
                                      title,
                                      price: item['price'] as String,
                                      location: item['location'] as String,
                                      image: item['imageUrl'] as String,
                                    );
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha((0.8 * 255).round()),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    AppData.isItemFavorited(item['title'] as String)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 14.0,
                                    color: AppData.isItemFavorited(item['title'] as String)
                                        ? Colors.red
                                        : const Color(0xFF777777),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'] as String,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E1E1E),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              item['price'] as String,
                              style: GoogleFonts.outfit(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFFF7E00),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 10, color: Color(0xFF888888)),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    item['location'] as String,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.outfit(
                                      fontSize: 9.0,
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNearbyDealsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nearby Deals',
                style: GoogleFonts.outfit(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
              Text(
                'See All',
                style: GoogleFonts.outfit(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFF7E00),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: AppData.homeNearbyDeals.length,
            itemBuilder: (context, index) {
              final item = AppData.homeNearbyDeals[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ListingDetailScreen(listing: item)),
                  );
                },
                child: Container(
                  width: 140.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: const Color(0xFFEEEEEE), width: 1.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFF9F9F9),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                                child: Image.network(
                                  item['imageUrl'] as String,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Text(
                                        _getDealEmoji(item['category'] as String),
                                        style: const TextStyle(fontSize: 40.0),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8.0,
                              right: 8.0,
                              child: GestureDetector(
                                onTap: () {
                                  final title = item['title'] as String;
                                  setState(() {
                                    AppData.toggleFavorite(
                                      title,
                                      price: item['price'] as String,
                                      location: item['location'] as String,
                                      image: item['imageUrl'] as String,
                                    );
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha((0.8 * 255).round()),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    AppData.isItemFavorited(item['title'] as String)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 14.0,
                                    color: AppData.isItemFavorited(item['title'] as String)
                                        ? Colors.red
                                        : const Color(0xFF777777),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'] as String,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E1E1E),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              item['price'] as String,
                              style: GoogleFonts.outfit(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFFF7E00),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 10, color: Color(0xFF888888)),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    item['location'] as String,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.outfit(
                                      fontSize: 9.0,
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getDealEmoji(String category) {
    switch (category) {
      case 'Cars':
      case 'Vehicles':
        return '🚗';
      case 'Mobiles':
        return '📱';
      case 'Bikes':
        return '🏍️';
      case 'Furniture':
        return '🛋️';
      case 'Cycles':
        return '🚲';
      case 'Laptops':
        return '💻';
      case 'Electronics':
        return '📺';
      default:
        return '🛍️';
    }
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
            icon: Icons.home,
            label: 'Home',
            isActive: true,
            onTap: () {},
          ),
          _buildBottomNavItem(
            icon: Icons.assignment_outlined,
            label: 'My Ads',
            isActive: false,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.myAds);
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.sell);
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
                        BoxShadow(
                          color: Color(0x4DFF7E00),
                          blurRadius: 8.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 28.0),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -4),
                  child: Text(
                    'Sell Now',
                    style: GoogleFonts.outfit(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF7E00),
                    ),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatsScreen()),
              );
            },
          ),
          _buildBottomNavItem(
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: false,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
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
                Icon(
                  icon,
                  color: isActive ? activeColor : inactiveColor,
                  size: 24.0,
                ),
                if (badgeCount > 0)
                  Positioned(
                    right: -4,
                    top: -4,
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
                        badgeCount.toString(),
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