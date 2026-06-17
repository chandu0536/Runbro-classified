import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:runbroclassified/features/listings/presentation/screens/boost_ad_screen.dart';
import 'package:runbroclassified/features/listings/presentation/screens/my_ads_screen.dart';

class BoostSuccessScreen extends StatefulWidget {
  final Map<String, dynamic> ad;
  final String planName;
  final int planDays;
  final double totalAmount;
  final String paymentMethod;

  const BoostSuccessScreen({
    super.key,
    required this.ad,
    required this.planName,
    required this.planDays,
    required this.totalAmount,
    required this.paymentMethod,
  });

  @override
  State<BoostSuccessScreen> createState() => _BoostSuccessScreenState();
}

class _BoostSuccessScreenState extends State<BoostSuccessScreen>
    with TickerProviderStateMixin {
  late AnimationController _checkController;
  late AnimationController _blastController;
  late Animation<double> _checkScale;
  late Animation<double> _blastExpand;
  late Animation<double> _blastFade;

  final String _transactionId = 'UPI${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 12)}';

  @override
  void initState() {
    super.initState();

    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _blastController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _checkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkController, curve: Curves.elasticOut),
    );
    _blastExpand = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _blastController, curve: Curves.easeOut),
    );
    _blastFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _blastController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      _checkController.forward();
      _blastController.forward();
    });
  }

  @override
  void dispose() {
    _checkController.dispose();
    _blastController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ad = widget.ad;
    final images = (ad['images'] as List?)?.cast<String>() ?? [];
    final imagePath = images.isNotEmpty ? images[0] : null;
    final now = DateTime.now();
    final boostedOnStr =
        '${now.day} ${_monthName(now.month)} ${now.year}, ${_formatTime(now)}';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Payment Successful',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E1E1E),
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Done',
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFF7E00),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // ── Animated Check with blast ──────────────────────
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Blast particles
                        AnimatedBuilder(
                          animation: _blastController,
                          builder: (context, child) {
                            return CustomPaint(
                              size: const Size(130, 130),
                              painter: _BlastPainter(
                                progress: _blastExpand.value,
                                opacity: _blastFade.value,
                              ),
                            );
                          },
                        ),
                        // Green circle + check
                        ScaleTransition(
                          scale: _checkScale,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF43E97B), Color(0xFF38D969)],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF43E97B).withAlpha(80),
                                  blurRadius: 22,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 44,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  Text(
                    'Your ad is now boosted!',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Great! Your ad is now live with more visibility.\nYou\'ll see better results soon.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: const Color(0xFF757575),
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Divider(color: Color(0xFFEEEEEE), height: 1, indent: 16, endIndent: 16),
                  const SizedBox(height: 20),

                  // ── Boost Summary ──────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Boost Summary',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E1E1E),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Product info row — larger image in grey box
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Product image inside a light grey rounded container
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: imagePath != null
                                    ? _buildImage(imagePath, 90, 90)
                                    : const Center(
                                        child: Icon(Icons.image_outlined,
                                            color: Colors.grey, size: 36),
                                      ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ad['title'] as String? ?? '',
                                    style: GoogleFonts.outfit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1E1E1E),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        ad['price'] as String? ?? '',
                                        style: GoogleFonts.outfit(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900,
                                          color: const Color(0xFFFF7E00),
                                        ),
                                      ),
                                      if (ad['negotiable'] == true) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFDCF5E3),
                                            borderRadius: BorderRadius.circular(5),
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
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        // Detail rows with dot bullets
                        _summaryRow(
                          Icons.rocket_launch_rounded,
                          '${widget.planName} Boost',
                          '${widget.planDays} Days',
                        ),
                        const SizedBox(height: 12),
                        _summaryRow(
                          Icons.calendar_today_outlined,
                          'Boosted On',
                          boostedOnStr,
                        ),
                        const SizedBox(height: 12),
                        _summaryRow(
                          Icons.link_rounded,
                          'Ad ID',
                          '#${ad['id'] as String? ?? 'RBD12345'}',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Divider(color: Color(0xFFEEEEEE), height: 1, indent: 16, endIndent: 16),
                  const SizedBox(height: 20),

                  // ── Payment Details ────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Details',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E1E1E),
                          ),
                        ),
                        const SizedBox(height: 14),
                        _paymentDetailRow('Payment Method', widget.paymentMethod),
                        const SizedBox(height: 10),
                        _paymentDetailRow('Transaction ID', _transactionId),
                        const SizedBox(height: 10),
                        _paymentDetailRow(
                          'Amount Paid',
                          '₹${widget.totalAmount.toStringAsFixed(2)}',
                          isBold: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── What happens next? info banner ──────────────────
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F4FD),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFB3D9F5)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline_rounded,
                            size: 16, color: Color(0xFF1A73E8)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'What happens next?',
                                style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1A73E8),
                                ),
                              ),
                              const SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.outfit(
                                    fontSize: 12,
                                    color: const Color(0xFF1A73E8),
                                    height: 1.45,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text:
                                          'Your ad will be shown to more relevant buyers in your area.\nYou can track your ad performance in ',
                                    ),
                                    TextSpan(
                                      text: 'My Ads.',
                                      style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF1A73E8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Boost Again banner ─────────────────────────────
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF6F2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFFDDD5)),
                    ),
                    child: Row(
                      children: [
                        // Target / bullseye icon
                        Container(
                          width: 42,
                          height: 42,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFE0D6),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(Icons.track_changes_rounded,
                                color: Color(0xFFFF7E00), size: 22),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Want even better results?',
                                style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1E1E1E),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Try increasing your boost duration\nfor maximum visibility.',
                                style: GoogleFonts.outfit(
                                  fontSize: 11,
                                  color: const Color(0xFF757575),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BoostAdScreen(ad: widget.ad),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFFF7E00), width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          ),
                          child: Text(
                            'Boost Again',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFF7E00),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // ── Bottom CTA ─────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const MyAdsScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7E00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Go to My Ads',
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  Widget _summaryRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 15, color: const Color(0xFF546E7A)),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 13,
            color: const Color(0xFF546E7A),
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E1E1E),
          ),
        ),
      ],
    );
  }

  Widget _paymentDetailRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 13,
            color: const Color(0xFF546E7A),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: isBold ? 14 : 13,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: const Color(0xFF1E1E1E),
          ),
        ),
      ],
    );
  }

  Widget _buildImage(String path, double w, double h) {
    if (path.startsWith('http')) {
      return Image.network(path, width: w, height: h, fit: BoxFit.cover);
    } else if (path.startsWith('assets/')) {
      return Image.asset(path, width: w, height: h, fit: BoxFit.cover);
    } else {
      return Image.file(File(path), width: w, height: h, fit: BoxFit.cover);
    }
  }

  String _monthName(int m) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[m];
  }

  String _formatTime(DateTime d) {
    final h = d.hour > 12 ? d.hour - 12 : (d.hour == 0 ? 12 : d.hour);
    final m = d.minute.toString().padLeft(2, '0');
    final ampm = d.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $ampm';
  }
}

// ── Blast particle painter ──────────────────────────────────────────────────

class _BlastPainter extends CustomPainter {
  final double progress;
  final double opacity;

  _BlastPainter({required this.progress, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rng = Random(42); // fixed seed for consistent pattern
    final maxRadius = size.width / 2;

    // Tiny star bursts
    for (int i = 0; i < 14; i++) {
      final angle = rng.nextDouble() * 2 * pi;
      final dist = maxRadius * (0.4 + 0.6 * progress) * (0.6 + 0.4 * rng.nextDouble());
      final pos = center + Offset(cos(angle) * dist, sin(angle) * dist);
      final dotSize = 2.0 + rng.nextDouble() * 3.0;

      // Alternate colours — green, orange, yellow-gold
      final colors = [
        const Color(0xFF43E97B),
        const Color(0xFFFF7E00),
        const Color(0xFFFFB300),
        const Color(0xFF1DE9B6),
        const Color(0xFFFF6D00),
      ];
      final color = colors[i % colors.length].withAlpha((opacity * 220).round());

      // Draw small cross / star shapes instead of plain dots for richer blast
      if (i % 3 == 0) {
        // Small "+" shape
        final paint = Paint()
          ..color = color
          ..strokeWidth = 1.8
          ..strokeCap = StrokeCap.round;
        final arm = dotSize;
        canvas.drawLine(
          pos + Offset(-arm, 0),
          pos + Offset(arm, 0),
          paint,
        );
        canvas.drawLine(
          pos + Offset(0, -arm),
          pos + Offset(0, arm),
          paint,
        );
      } else if (i % 3 == 1) {
        // Small diamond
        final paint = Paint()..color = color;
        final path = Path()
          ..moveTo(pos.dx, pos.dy - dotSize)
          ..lineTo(pos.dx + dotSize * 0.6, pos.dy)
          ..lineTo(pos.dx, pos.dy + dotSize)
          ..lineTo(pos.dx - dotSize * 0.6, pos.dy)
          ..close();
        canvas.drawPath(path, paint);
      } else {
        // Circular dot
        canvas.drawCircle(
          pos,
          dotSize * 0.6,
          Paint()..color = color,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_BlastPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.opacity != opacity;
}
