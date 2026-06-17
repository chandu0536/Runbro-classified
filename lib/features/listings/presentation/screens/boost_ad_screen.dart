import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:runbroclassified/features/listings/presentation/screens/boost_success_screen.dart';

class BoostAdScreen extends StatefulWidget {
  final Map<String, dynamic> ad;
  const BoostAdScreen({super.key, required this.ad});

  @override
  State<BoostAdScreen> createState() => _BoostAdScreenState();
}

class _BoostAdScreenState extends State<BoostAdScreen> {
  String _selectedPlan = 'Premium';
  String _selectedPayment = 'UPI';

  static const Map<String, Map<String, dynamic>> _plans = {
    'Premium': {
      'price': 499,
      'days': 7,
      'description': 'Maximum visibility in your local area',
      'recommended': true,
      'tag': 'Best Results',
    },
    'Standard': {
      'price': 299,
      'days': 3,
      'description': 'Increased visibility in your local area',
      'recommended': false,
      'tag': null,
    },
    'Basic': {
      'price': 149,
      'days': 1,
      'description': 'Good visibility in your local area',
      'recommended': false,
      'tag': null,
    },
  };

  double get _planPrice =>
      (_plans[_selectedPlan]!['price'] as int).toDouble();
  double get _gst => _planPrice * 0.18;
  double get _total => _planPrice + _gst;

  @override
  Widget build(BuildContext context) {
    final ad = widget.ad;
    final images = (ad['images'] as List?)?.cast<String>() ?? [];
    final imagePath = images.isNotEmpty ? images[0] : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Boost Ad',
          style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E1E1E)),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _showHowItWorks,
            child: Text(
              'How it works',
              style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFF7E00)),
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
                  // ── Ad Summary Card ──────────────────────────────────
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: imagePath != null
                                ? _buildImage(imagePath, 80, 80)
                                : Container(
                                    color: const Color(0xFFF5F5F5),
                                    child: const Icon(Icons.image_outlined,
                                        color: Colors.grey, size: 36),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ad['title'] as String? ?? '',
                                style: GoogleFonts.outfit(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1E1E1E)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    ad['price'] as String? ?? '',
                                    style: GoogleFonts.outfit(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                        color: const Color(0xFFFF7E00)),
                                  ),
                                  if (ad['negotiable'] == true) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFDCF5E3),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        'Negotiable',
                                        style: GoogleFonts.outfit(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF1E5C27)),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 6),
                              // Stats row
                              Wrap(
                                spacing: 10,
                                children: [
                                  _statChip(Icons.visibility_outlined,
                                      '${ad['views'] ?? 0} Views'),
                                  _statChip(
                                      Icons.chat_bubble_outline_rounded,
                                      '${ad['chats'] ?? 0} Chats'),
                                  _statChip(Icons.favorite_border_rounded,
                                      '${ad['likes'] ?? 0} Favorites'),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined,
                                      size: 12,
                                      color: Color(0xFF546E7A)),
                                  const SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      ad['location'] as String? ?? '',
                                      style: GoogleFonts.outfit(
                                          fontSize: 11,
                                          color: const Color(0xFF546E7A),
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Posted on ${ad['date'] as String? ?? ''} • Ad ID: #${ad['id'] as String? ?? ''}',
                                style: GoogleFonts.outfit(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ── Choose a Boost Plan ──────────────────────────────
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Choose a boost plan',
                          style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1E1E1E)),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'More visibility, more chances to sell.',
                          style: GoogleFonts.outfit(
                              fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),

                        // Plan cards
                        ..._plans.entries.map(
                          (e) => _buildPlanCard(e.key, e.value),
                        ),

                        const SizedBox(height: 10),

                        // Blue info banner
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F4FD),
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: const Color(0xFFB3D9F5)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.info_outline_rounded,
                                  color: Color(0xFF1A73E8), size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Your ad will be shown to more relevant buyers in your area.',
                                  style: GoogleFonts.outfit(
                                      fontSize: 12,
                                      color: const Color(0xFF1A73E8),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ── Payment Method ───────────────────────────────────
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment method',
                          style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1E1E1E)),
                        ),
                        const SizedBox(height: 4),
                        _buildPaymentOption(
                          value: 'UPI',
                          iconWidget: _upiIcon(),
                          title: 'UPI',
                          subtitle: 'Pay using any UPI app',
                        ),
                        const Divider(height: 1, color: Color(0xFFF2F2F2)),
                        _buildPaymentOption(
                          value: 'Card',
                          iconWidget: _paymentIconBox(
                              Icons.credit_card_rounded,
                              const Color(0xFF1565C0)),
                          title: 'Credit / Debit Card',
                          subtitle: 'Visa, Mastercard, RuPay',
                        ),
                        const Divider(height: 1, color: Color(0xFFF2F2F2)),
                        _buildPaymentOption(
                          value: 'NetBanking',
                          iconWidget: _paymentIconBox(
                              Icons.account_balance_outlined,
                              const Color(0xFF37474F)),
                          title: 'Net Banking',
                          subtitle: 'All major banks supported',
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ── Price Details ────────────────────────────────────
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price Details',
                          style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1E1E1E)),
                        ),
                        const SizedBox(height: 14),
                        _priceRow(
                          'Plan Amount ($_selectedPlan - ${_plans[_selectedPlan]!['days']} days)',
                          '₹${_planPrice.toStringAsFixed(0)}',
                          bold: false,
                        ),
                        const SizedBox(height: 10),
                        _priceRow(
                          'GST (18%)',
                          '₹${_gst.toStringAsFixed(2)}',
                          bold: false,
                        ),
                        const SizedBox(height: 14),
                        const Divider(height: 1, color: Color(0xFFEEEEEE)),
                        const SizedBox(height: 14),
                        _priceRow(
                          'Total Amount',
                          '₹${_total.toStringAsFixed(2)}',
                          bold: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Secure footer
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.lock_outline_rounded,
                            size: 13, color: Colors.grey),
                        const SizedBox(width: 5),
                        Text(
                          'Secure payments. Your data is safe with us.',
                          style: GoogleFonts.outfit(
                              fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // ── Bottom CTA ───────────────────────────────────────────────
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
                onPressed: _handleProceedToPay,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7E00),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                child: Text(
                  'Proceed to Pay  ₹${_total.toStringAsFixed(2)}',
                  style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Builders ─────────────────────────────────────────────────────────────

  Widget _buildPlanCard(String planName, Map<String, dynamic> plan) {
    final isSelected = _selectedPlan == planName;
    final isRecommended = plan['recommended'] as bool;
    final price = plan['price'] as int;
    final days = plan['days'] as int;
    final description = plan['description'] as String;
    final tag = plan['tag'] as String?;

    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = planName),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF5F2) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFF7E00)
                : const Color(0xFFDEDEDE),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Radio indicator
                _radioCircle(isSelected),
                const SizedBox(width: 10),
                // Labels
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            planName,
                            style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E1E1E)),
                          ),
                          if (isRecommended) ...[
                            const SizedBox(width: 7),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF7E00),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Recommended',
                                style: GoogleFonts.outfit(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: GoogleFonts.outfit(
                            fontSize: 11, color: const Color(0xFF757575)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Price block
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹$price',
                      style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E1E1E)),
                    ),
                    Text(
                      'for $days ${days == 1 ? "day" : "days"}',
                      style: GoogleFonts.outfit(
                          fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            // "Best Results" badge — bottom right
            if (tag != null)
              Positioned(
                bottom: -14,
                right: -14,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF7E00),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomRight: Radius.circular(9),
                    ),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.outfit(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String value,
    required Widget iconWidget,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedPayment == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = value),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            iconWidget,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E1E1E)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                        fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
            // Arrow for first option (UPI), radio for others
            value == 'UPI' && !isSelected
                ? const Icon(Icons.chevron_right,
                    color: Color(0xFFBDBDBD), size: 20)
                : _radioCircle(isSelected),
          ],
        ),
      ),
    );
  }

  Widget _radioCircle(bool selected) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected
              ? const Color(0xFFFF7E00)
              : const Color(0xFFBDBDBD),
          width: 2,
        ),
      ),
      child: selected
          ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF7E00),
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }

  Widget _upiIcon() {
    return Container(
      width: 42,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'bhi',
                style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A237E)),
              ),
              TextSpan(
                text: 'm',
                style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF7E00)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paymentIconBox(IconData icon, Color iconColor) {
    return Container(
      width: 42,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 20, color: iconColor),
    );
  }

  Widget _priceRow(String label, String value, {required bool bold}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: bold ? 14 : 13,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: bold
                ? const Color(0xFF1E1E1E)
                : const Color(0xFF444444),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: bold ? 15 : 13,
            fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            color: const Color(0xFF1E1E1E),
          ),
        ),
      ],
    );
  }

  Widget _statChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: const Color(0xFF555555)),
        const SizedBox(width: 3),
        Text(label,
            style: GoogleFonts.outfit(
                fontSize: 10, color: const Color(0xFF555555))),
      ],
    );
  }

  Widget _buildImage(String path, double w, double h) {
    if (path.startsWith('http')) {
      return Image.network(path,
          width: w, height: h, fit: BoxFit.cover);
    } else if (path.startsWith('assets/')) {
      return Image.asset(path, width: w, height: h, fit: BoxFit.cover);
    } else {
      return Image.file(File(path),
          width: w, height: h, fit: BoxFit.cover);
    }
  }

  // ── Actions ───────────────────────────────────────────────────────────────

  void _showHowItWorks() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'How Boost Works',
              style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E1E1E)),
            ),
            const SizedBox(height: 16),
            _howItWorksStep('🚀', 'Your ad appears at the top',
                'Boosted ads are shown above regular listings.'),
            _howItWorksStep('👁️', 'More people see your ad',
                'Reach up to 10× more potential buyers.'),
            _howItWorksStep('💬', 'Get more inquiries',
                'More visibility means more chats and faster sales.'),
            _howItWorksStep('📅', 'Choose your duration',
                'Plans range from 1 day to 7 days.'),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _howItWorksStep(String emoji, String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E1E1E))),
                const SizedBox(height: 2),
                Text(body,
                    style: GoogleFonts.outfit(
                        fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleProceedToPay() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        Future.delayed(const Duration(milliseconds: 1200), () {
          if (mounted) {
            Navigator.pop(context); // close loading dialog
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BoostSuccessScreen(
                  ad: widget.ad,
                  planName: _selectedPlan,
                  planDays: _plans[_selectedPlan]!['days'] as int,
                  totalAmount: _total,
                  paymentMethod: _selectedPayment == 'UPI'
                      ? 'UPI'
                      : _selectedPayment == 'Card'
                          ? 'Credit / Debit Card'
                          : 'Net Banking',
                ),
              ),
            );
          }
        });
        return const Center(
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Color(0xFFFF7E00)),
          ),
        );
      },
    );
  }
}

