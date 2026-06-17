import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatDetailScreen extends StatefulWidget {
  final String sellerName;
  final String productTitle;
  final String productEmoji;
  final String productImageUrl;

  const ChatDetailScreen({
    super.key,
    this.sellerName = 'Ramesh Kumar',
    this.productTitle = 'Maruti Suzuki Swift VXI 2018',
    this.productEmoji = '🚗',
    this.productImageUrl = '',
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_Message> _messages = [
    _Message(text: 'Hello! 👋', isMe: false, time: '10:28 AM'),
    _Message(text: 'Thank you for showing interest\nin my car.', isMe: false, time: '10:28 AM'),
    _Message(text: 'Hi, is the car still available?', isMe: true, time: '10:29 AM', isRead: true),
    _Message(text: "Yes, it's still available.", isMe: false, time: '10:30 AM'),
    _Message(text: 'Can you share the final price?', isMe: true, time: '10:30 AM', isRead: true),
    _Message(text: 'The final price is ₹4,10,000.', isMe: false, time: '10:31 AM'),
    _Message(text: 'Can I come and inspect the car today?', isMe: true, time: '10:32 AM', isRead: true),
    _Message(text: "Sure, you can come.\nI'm available after 4 PM.", isMe: false, time: '10:33 AM'),
    _Message(text: "Great! I'll be there around 4:30 PM.", isMe: true, time: '10:33 AM', isRead: true),
    _Message(text: 'Okay, see you then.', isMe: false, time: '10:34 AM'),
  ];

  void _sendMessage() {
    final text = _msgController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Message(text: text, isMe: true, time: _currentTime(), isRead: false));
      _msgController.clear();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  String _currentTime() {
    final now = DateTime.now();
    final h = now.hour > 12 ? now.hour - 12 : now.hour;
    final m = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $period';
  }

  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          // Product card at top
          _buildProductCard(),

          // Date divider
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text('Today', style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF888888))),
                ),
                const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
              ],
            ),
          ),

          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildBubble(_messages[index]),
            ),
          ),

          // Quick action bar
          _buildActionBar(context),

          // Input bar
          _buildInputBar(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E)),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFFF8C00), Color(0xFFFF5F00)]),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    widget.sellerName.isNotEmpty ? widget.sellerName[0] : 'S',
                    style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                bottom: 1, right: 1,
                child: Container(
                  width: 10, height: 10,
                  decoration: BoxDecoration(color: const Color(0xFF22C55E), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.sellerName, style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF1E1E1E))),
              Text('Online', style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF22C55E), fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(icon: const Icon(Icons.phone, color: Color(0xFF333333)), onPressed: () {}),
        IconButton(icon: const Icon(Icons.more_vert, color: Color(0xFF333333)), onPressed: () {}),
      ],
    );
  }

  Widget _buildProductCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 6)],
      ),
      child: Row(
        children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0), 
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: widget.productImageUrl.isNotEmpty
                  ? Image.network(
                      widget.productImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Text(
                            widget.productEmoji,
                            style: const TextStyle(fontSize: 26),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        widget.productEmoji,
                        style: const TextStyle(fontSize: 26),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.productTitle,
                  style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF1E1E1E))),
                const SizedBox(height: 2),
                Text('₹4,25,000', style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, color: const Color(0xFFFF7E00))),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 11, color: Color(0xFF888888)),
                    const SizedBox(width: 2),
                    Text('Hyderabad, Telangana', style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF888888))),
                  ],
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFFF7E00),
              side: const BorderSide(color: Color(0xFFFF7E00)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              minimumSize: Size.zero,
            ),
            child: Text('View Product', style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(_Message msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: msg.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!msg.isMe) ...[
            Container(
              width: 30, height: 30,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFF8C00), Color(0xFFFF5F00)]),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(widget.sellerName.isNotEmpty ? widget.sellerName[0] : 'S',
                  style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white)),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
              decoration: BoxDecoration(
                color: msg.isMe ? const Color(0xFFDCF8C6) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(msg.isMe ? 16 : 4),
                  bottomRight: Radius.circular(msg.isMe ? 4 : 16),
                ),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 4)],
              ),
              child: Column(
                crossAxisAlignment: msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(msg.text, style: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFF1E1E1E), height: 1.35)),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(msg.time, style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF888888))),
                      if (msg.isMe) ...[
                        const SizedBox(width: 4),
                        Icon(
                          Icons.done_all,
                          size: 14,
                          color: msg.isRead ? const Color(0xFF4FC3F7) : const Color(0xFFAAAAAA),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (msg.isMe) const SizedBox(width: 4),
        ],
      ),
    );
  }

  Widget _buildActionBar(BuildContext context) {
    final actions = [
      {'icon': Icons.phone, 'label': 'Call', 'color': const Color(0xFF22C55E)},
      {'icon': Icons.storefront_outlined, 'label': 'View Product', 'color': const Color(0xFFFF7E00)},
      {'icon': Icons.location_on_outlined, 'label': 'Share Location', 'color': const Color(0xFF2196F3)},
      {'icon': Icons.flag_outlined, 'label': 'Report User', 'color': const Color(0xFFEF4444)},
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: actions.map((action) {
          final color = action['color'] as Color;
          return GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withAlpha(20),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(action['icon'] as IconData, color: color, size: 20),
                ),
                const SizedBox(height: 4),
                Text(action['label'] as String,
                  style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w600, color: const Color(0xFF555555))),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInputBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        left: 12, right: 12, top: 8,
        bottom: 8,
      ),
      child: SafeArea(
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.add, color: Color(0xFF888888), size: 24),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _msgController,
                        style: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFF1E1E1E)),
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFFAAAAAA)),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.sentiment_satisfied_alt_outlined, color: Color(0xFFAAAAAA), size: 22),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFFFA000), Color(0xFFFF6F00)]),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Message {
  final String text;
  final bool isMe;
  final String time;
  final bool isRead;

  const _Message({required this.text, required this.isMe, required this.time, this.isRead = false});
}
