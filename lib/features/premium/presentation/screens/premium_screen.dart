import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  int _selectedPlanIndex = 0; // 0: 12 months, 1: 3 months, 2: 1 month
  String _selectedPaymentMethod = 'UPI'; // 'UPI', 'PhonePe', 'GooglePay', 'Paytm', 'Cards'

  final List<Map<String, dynamic>> _plans = [
    {
      'months': '12 Months',
      'price': '69',
      'billed': '₹828',
      'original': '₹1,380',
      'savings': 'Save 46%',
      'tag': 'BEST VALUE',
      'bestChoice': true,
    },
    {
      'months': '3 Months',
      'price': '99',
      'billed': '₹297',
      'original': '₹390',
      'savings': 'Save 23%',
      'tag': 'POPULAR',
      'bestChoice': false,
    },
    {
      'months': '1 Month',
      'price': '129',
      'billed': '₹129',
      'original': '',
      'savings': '',
      'tag': '',
      'bestChoice': false,
    },
  ];

  void _processPayment() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              const CircleAvatar(
                radius: 28,
                backgroundColor: Color(0xFFEEF9EE),
                child: Icon(Icons.check_circle_rounded, color: Color(0xFF4CAF50), size: 40),
              ),
              const SizedBox(height: 16),
              Text(
                'Payment Successful!',
                style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
              ),
              const SizedBox(height: 8),
              Text(
                'Congratulations! You are now a RunBro Premium member. Your ads will get boosted visibility immediately.',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF666666)),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Go back
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7E00),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'Done',
                    style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              'RunBro Premium',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Upgrade your experience and sell faster!',
              style: GoogleFonts.outfit(
                fontSize: 11,
                color: const Color(0xFF757575),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Crown Header promo card enclosing title, 3D image, and feature list
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFF2EB), Color(0xFFFFF9F5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFFDCD0), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'More Visibility. More Buyers.',
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFF1E1E1E),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Sell Faster with RunBro Premium!',
                                    style: GoogleFonts.outfit(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFFFF7E00),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              'assets/images/premium_crown.png',
                              width: 80,
                              height: 80,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback icon in case asset is not immediately resolved by the bundle
                                return const Icon(
                                  Icons.workspace_premium_rounded,
                                  color: Color(0xFFFFB300),
                                  size: 70,
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Features row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFeaturePill(
                              Icons.rocket_launch_rounded,
                              'Boosted\nVisibility',
                              'Your ad reaches\nmore buyers',
                            ),
                            _buildFeaturePill(
                              Icons.workspace_premium_rounded,
                              'Top\nPlacement',
                              'Show your ad on\ntop of listings',
                            ),
                            _buildFeaturePill(
                              Icons.stars_rounded,
                              'Highlight\nAd',
                              'Make your ad\nstand out',
                            ),
                            _buildFeaturePill(
                              Icons.chat_bubble_rounded,
                              'More\nResponses',
                              'Get more calls &\nmessages faster',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Plans Title & Cancel Anytime Subtitle
                  Text(
                    'Choose Your Plan',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.check_circle_rounded, color: Color(0xFF0F8F46), size: 14),
                      const SizedBox(width: 4),
                      Text(
                        'Secure Payment',
                        style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF5F6368)),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '•',
                        style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Cancel Anytime',
                        style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF5F6368)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Plan Selectors List
                  Column(
                    children: List.generate(_plans.length, (index) {
                      final plan = _plans[index];
                      final isSelected = _selectedPlanIndex == index;
                      return _buildPlanCard(plan, index, isSelected);
                    }),
                  ),
                  const SizedBox(height: 24),

                  // Comparison Table
                  Text(
                    'Compare Features',
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildComparisonTable(),
                  const SizedBox(height: 24),

                  // Payment options
                  Text(
                    'Select Payment Method',
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentRow(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Bottom Continue to payment button + security badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _processPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7E00),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue to Payment',
                          style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle_rounded, color: Color(0xFF0F8F46), size: 13),
                    const SizedBox(width: 4),
                    Text(
                      '100% Secure Payments',
                      style: GoogleFonts.outfit(fontSize: 10.5, fontWeight: FontWeight.w600, color: const Color(0xFF757575)),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '•',
                      style: TextStyle(fontSize: 10.5, color: Colors.grey.shade400),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Easy Refunds',
                      style: GoogleFonts.outfit(fontSize: 10.5, fontWeight: FontWeight.w600, color: const Color(0xFF757575)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturePill(IconData icon, String title, String desc) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: const Color(0xFFFF7E00), size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E1E1E),
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 7.5,
              color: const Color(0xFF757575),
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan, int index, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _selectedPlanIndex = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF6F2) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFFECEBEB),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Radio button icon
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: Icon(
                      isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                      color: isSelected ? const Color(0xFFFF7E00) : Colors.grey.shade400,
                      size: 20,
                    ),
                  ),
                  // Plan description details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              plan['months'] as String,
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF1E1E1E),
                              ),
                            ),
                            if ((plan['tag'] as String).isNotEmpty) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: plan['tag'] == 'BEST VALUE' ? const Color(0xFFFFEAE0) : const Color(0xFFE8F0FE),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  plan['tag'] as String,
                                  style: GoogleFonts.outfit(
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.w800,
                                    color: plan['tag'] == 'BEST VALUE' ? const Color(0xFFFF7E00) : const Color(0xFF1A73E8),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '₹${plan['price']}',
                              style: GoogleFonts.outfit(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFFFF7E00),
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              ' /month',
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF757575),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              'Billed as ${plan['billed']}',
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                color: const Color(0xFF757575),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if ((plan['original'] as String).isNotEmpty) ...[
                              const SizedBox(width: 6),
                              Text(
                                plan['original'] as String,
                                style: GoogleFonts.outfit(
                                  fontSize: 11,
                                  color: const Color(0xFFB0B0B0),
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                            if ((plan['savings'] as String).isNotEmpty) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE6F4EA),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  plan['savings'] as String,
                                  style: GoogleFonts.outfit(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF137333),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Total Box on the right
                  Container(
                    width: 80,
                    height: 52,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? Colors.transparent : const Color(0xFFECEBEB),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total',
                          style: GoogleFonts.outfit(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white70 : const Color(0xFF757575),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          plan['billed'] as String,
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: isSelected ? Colors.white : const Color(0xFF1E1E1E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (plan['bestChoice'] as bool)
              Positioned(
                top: -8,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Best Choice',
                    style: GoogleFonts.outfit(
                      fontSize: 8.5,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonTable() {
    final rows = [
      {'feature': 'Ad Visibility', 'icon': Icons.visibility_outlined, 'free': 'Standard', 'premium': 'Boosted'},
      {'feature': 'Top Placement', 'icon': Icons.workspace_premium_outlined, 'free': false, 'premium': true},
      {'feature': 'Highlight Ad', 'icon': Icons.stars_outlined, 'free': false, 'premium': true},
      {'feature': 'More Responses', 'icon': Icons.chat_bubble_outline_rounded, 'free': false, 'premium': true},
      {'feature': 'Ad Insights', 'icon': Icons.bar_chart_rounded, 'free': false, 'premium': true},
      {'feature': 'Edit Ad', 'icon': Icons.edit_outlined, 'free': 'Limited', 'premium': 'Unlimited'},
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFECEBEB)),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2.2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
        },
        border: TableBorder.symmetric(inside: const BorderSide(color: Color(0xFFF5F5F5))),
        children: [
          // Header
          TableRow(
            decoration: const BoxDecoration(
              color: Color(0xFFFBFBFB),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(
                  'Features',
                  style: GoogleFonts.outfit(fontSize: 11.5, fontWeight: FontWeight.bold, color: const Color(0xFF757575)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(
                  'Free',
                  style: GoogleFonts.outfit(fontSize: 11.5, fontWeight: FontWeight.bold, color: const Color(0xFF757575)),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(
                  'Premium',
                  style: GoogleFonts.outfit(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF7E00),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          // Rows
          ...rows.map((r) {
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Icon(r['icon'] as IconData, color: const Color(0xFFFF7E00), size: 14),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          r['feature'] as String,
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E1E1E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Center(
                    child: r['free'] is bool
                        ? (r['free'] as bool
                            ? const Icon(Icons.check, color: Colors.green, size: 14)
                            : const Icon(Icons.close, color: Colors.grey, size: 14))
                        : Text(
                            r['free'] as String,
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF757575),
                            ),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Center(
                    child: r['premium'] is bool
                        ? (r['premium'] as bool
                            ? Container(
                                width: 14,
                                height: 14,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF7E00),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check, color: Colors.white, size: 10),
                              )
                            : const Icon(Icons.close, color: Colors.grey, size: 14))
                        : Text(
                            r['premium'] as String,
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFF7E00),
                            ),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPaymentRow() {
    final paymentMethods = [
      {'id': 'UPI', 'label': 'UPI'},
      {'id': 'PhonePe', 'label': 'PhonePe'},
      {'id': 'GooglePay', 'label': 'Google Pay'},
      {'id': 'Paytm', 'label': 'Paytm'},
      {'id': 'Cards', 'label': 'Cards'},
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: paymentMethods.map((pm) {
        final isSelected = _selectedPaymentMethod == pm['id'];
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedPaymentMethod = pm['id'] as String),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 64,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFFFF6F2) : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFFECEBEB),
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 24,
                        child: Center(
                          child: _getPaymentMethodLogo(pm['id'] as String, isSelected),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        pm['label'] as String,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 9.5,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Positioned(
                    top: -4,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF7E00),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 9,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _getPaymentMethodLogo(String methodId, bool isSelected) {
    switch (methodId) {
      case 'UPI':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('U', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, color: const Color(0xFF0F8F46))),
            Text('P', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, color: const Color(0xFF007DC5))),
            Text('I', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, color: const Color(0xFFE31E24))),
          ],
        );
      case 'PhonePe':
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF5F259F),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 18),
        );
      case 'GooglePay':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: Color(0xFF4285F4),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('G', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 4),
            Text('Pay', style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF5F6368))),
          ],
        );
      case 'Paytm':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('pay', style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w900, color: const Color(0xFF00B9F5))),
            Text('tm', style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w900, color: const Color(0xFF002E6E))),
          ],
        );
      case 'Cards':
        return Icon(
          Icons.credit_card_rounded,
          color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFF5F6368),
          size: 22,
        );
      default:
        return const SizedBox();
    }
  }
}
