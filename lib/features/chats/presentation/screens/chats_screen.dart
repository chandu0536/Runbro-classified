import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runbroclassified/features/chats/presentation/screens/chat_detail_screen.dart';
import 'package:runbroclassified/features/profile/presentation/screens/profile_screen.dart';
import 'package:runbroclassified/features/listings/presentation/screens/listings_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final List<Map<String, dynamic>> _mockChats = [
    {
      'name': 'Ramesh Kumar',
      'item': 'Maruti Swift VXI 2018',
      'lastMsg': 'Is the price negotiable?',
      'time': '10:30 AM',
      'unread': 2,
      'isOnline': true,
      'imageUrl': 'https://images.unsplash.com/photo-1619767886558-efdc259cde1a?auto=format&fit=crop&q=80&w=200',
      'emoji': '🚗',
    },
    {
      'name': 'Suresh Auto',
      'item': 'KTM Duke 390 2021',
      'lastMsg': 'Can you share more pics?',
      'time': '9:45 AM',
      'unread': 1,
      'isOnline': true,
      'imageUrl': 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&q=80&w=200',
      'emoji': '🏍️',
    },
    {
      'name': 'Priya Furniture',
      'item': '3 Seater Sofa',
      'lastMsg': 'Available?',
      'time': 'Yesterday',
      'unread': 0,
      'isOnline': false,
      'imageUrl': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=200',
      'emoji': '🛋️',
    },
    {
      'name': 'Mahesh Mobiles',
      'item': 'iPhone 14 128GB',
      'lastMsg': 'Final price?',
      'time': '8:20 AM',
      'unread': 5,
      'isOnline': true,
      'imageUrl': 'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?auto=format&fit=crop&q=80&w=200',
      'emoji': '📱',
    },
    {
      'name': 'Anil Cars',
      'item': 'Hyundai i20 Sportz 2020',
      'lastMsg': 'Still available?',
      'time': 'Yesterday',
      'unread': 0,
      'isOnline': false,
      'imageUrl': 'https://images.unsplash.com/photo-1617788138017-80ad40651399?auto=format&fit=crop&q=80&w=200',
      'emoji': '🚗',
    },
    {
      'name': 'Home Comforts',
      'item': 'Premium Chair',
      'lastMsg': 'Thanks!',
      'time': '2 Days ago',
      'unread': 0,
      'isOnline': false,
      'imageUrl': 'https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?auto=format&fit=crop&q=80&w=200',
      'emoji': '🪑',
    },
    {
      'name': 'Book World',
      'item': 'Rich Dad Poor Dad',
      'lastMsg': 'Is it in good condition?',
      'time': '3 Days ago',
      'unread': 0,
      'isOnline': true,
      'imageUrl': 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&q=80&w=200',
      'emoji': '📚',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredChats = _mockChats.where((chat) {
      final name = (chat['name'] as String).toLowerCase();
      final item = (chat['item'] as String).toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || item.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        title: Text(
          'Chats',
          style: GoogleFonts.outfit(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E1E1E),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBox(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              itemCount: filteredChats.length,
              separatorBuilder: (context, index) => const Divider(
                height: 1.0,
                indent: 84.0,
                endIndent: 16.0,
                color: Color(0xFFEEEEEE),
              ),
              itemBuilder: (context, index) {
                final chat = filteredChats[index];
                final unreadCount = chat['unread'] as int;

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatDetailScreen(
                          sellerName: chat['name'] as String,
                          productTitle: chat['item'] as String,
                          productEmoji: chat['emoji'] as String,
                          productImageUrl: chat['imageUrl'] as String,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      children: [
                        // Left Product Image Avatar with online indicator
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 54.0,
                              height: 54.0,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9F9F9),
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFE2E2E2), width: 0.5),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(27.0),
                                child: Image.network(
                                  chat['imageUrl'] as String,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Color(0xFFFF8C00), Color(0xFFFF5F00)],
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          (chat['name'] as String)[0],
                                          style: GoogleFonts.outfit(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            if (chat['isOnline'] as bool)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 14.0,
                                  height: 14.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF22C55E),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2.0),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 14.0),
                        // Middle Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chat['name'] as String,
                                style: GoogleFonts.outfit(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1E1E1E),
                                ),
                              ),
                              const SizedBox(height: 3.0),
                              Text(
                                chat['item'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF555555),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                chat['lastMsg'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  fontSize: 13.0,
                                  fontWeight: unreadCount > 0 ? FontWeight.w600 : FontWeight.w400,
                                  color: unreadCount > 0 ? const Color(0xFF1E1E1E) : const Color(0xFF777777),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        // Right Time & Badge
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              chat['time'] as String,
                              style: GoogleFonts.outfit(
                                fontSize: 11.0,
                                color: const Color(0xFF888888),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            if (unreadCount > 0)
                              Container(
                                width: 20.0,
                                height: 20.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF5F00),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    unreadCount.toString(),
                                    style: GoogleFonts.outfit(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            else
                              const SizedBox(height: 20.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        height: 48.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(color: const Color(0xFFE2E2E2), width: 1.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            const Icon(Icons.search, color: Color(0xFF888888), size: 20),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search conversations',
                  hintStyle: GoogleFonts.outfit(
                    fontSize: 14.0,
                    color: const Color(0xFF888888),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                style: GoogleFonts.outfit(
                  fontSize: 14.0,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 70.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10.0,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            isActive: false,
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          _buildBottomNavItem(
            icon: Icons.assignment_outlined,
            label: 'My Ads',
            isActive: false,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ListingsScreen(category: 'Vehicles')),
              );
            },
          ),
          GestureDetector(
            onTap: () {},
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
            icon: Icons.chat_bubble,
            label: 'Chats',
            isActive: true,
            badgeCount: 2,
            onTap: () {},
          ),
          _buildBottomNavItem(
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: false,
            onTap: () {
              Navigator.pushReplacement(
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