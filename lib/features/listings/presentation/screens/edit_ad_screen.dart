import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:runbroclassified/features/listings/presentation/screens/ad_preview_screen.dart';
import 'package:runbroclassified/features/listings/presentation/screens/my_ads_screen.dart';
import 'package:runbroclassified/features/sell/presentation/screens/sell_screen.dart';
import 'package:runbroclassified/features/home/presentation/screens/home_screen.dart';
import 'package:runbroclassified/features/chats/presentation/screens/chats_screen.dart';
import 'package:runbroclassified/features/profile/presentation/screens/profile_screen.dart';

class EditAdScreen extends StatefulWidget {
  final Map<String, dynamic> ad;
  const EditAdScreen({super.key, required this.ad});

  @override
  State<EditAdScreen> createState() => _EditAdScreenState();
}

class _EditAdScreenState extends State<EditAdScreen> {
  // Controllers
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;

  // Selectable fields
  late bool _isNegotiable;
  late String _selectedCondition;
  late String _selectedCategory;
  String _selectedSubcategory = 'iPhones';
  String _contactPreference = 'Chat on App'; // 'Chat on App', 'Phone Number'
  late String _status; // 'Active', 'Deactivated'

  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    final ad = widget.ad;
    _titleController = TextEditingController(text: ad['title'] as String? ?? '');
    _priceController = TextEditingController(
      text: (ad['price'] as String? ?? '').replaceAll('₹', '').replaceAll(',', '').trim(),
    );
    _descriptionController = TextEditingController(text: ad['description'] as String? ?? '');
    _locationController = TextEditingController(text: ad['location'] as String? ?? '');
    _isNegotiable = ad['negotiable'] as bool? ?? false;
    _selectedCondition = ad['condition'] as String? ?? 'Like New';
    _selectedCategory = ad['category'] as String? ?? 'Mobiles';
    if (_selectedCategory == 'Mobiles') {
      _selectedCategory = 'Mobiles & Tablets';
    }
    _status = ad['status'] as String? ?? 'Active';
    _images = List<String>.from(ad['images'] as List? ?? []);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    setState(() {
      widget.ad['title'] = _titleController.text.trim();
      widget.ad['price'] = '₹${_priceController.text.trim()}';
      widget.ad['negotiable'] = _isNegotiable;
      widget.ad['description'] = _descriptionController.text.trim();
      widget.ad['location'] = _locationController.text.trim();
      widget.ad['condition'] = _selectedCondition;
      widget.ad['category'] = _selectedCategory == 'Mobiles & Tablets' ? 'Mobiles' : _selectedCategory;
      widget.ad['status'] = _status;
      widget.ad['images'] = _images;
    });

    // Navigate to Ad Preview screen after saving
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => AdPreviewScreen(ad: widget.ad)),
    );
  }

  void _goToPreview() {
    // Save first, then show preview
    widget.ad['title'] = _titleController.text.trim();
    widget.ad['price'] = '₹${_priceController.text.trim()}';
    widget.ad['negotiable'] = _isNegotiable;
    widget.ad['description'] = _descriptionController.text.trim();
    widget.ad['location'] = _locationController.text.trim();
    widget.ad['condition'] = _selectedCondition;
    widget.ad['category'] = _selectedCategory == 'Mobiles & Tablets' ? 'Mobiles' : _selectedCategory;
    widget.ad['status'] = _status;
    widget.ad['images'] = _images;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AdPreviewScreen(ad: widget.ad)),
    );
  }

  void _toggleStatus() {
    setState(() {
      if (_status == 'Active') {
        _status = 'Deactivated';
      } else {
        _status = 'Active';
      }
    });
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      if (_images.length >= 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You can add up to 10 photos only.')),
        );
        return;
      }
      
      if (source == ImageSource.gallery) {
        final List<XFile> images = await _picker.pickMultiImage();
        if (images.isNotEmpty) {
          setState(() {
            bool exceeded = false;
            for (var img in images) {
              if (_images.length < 10) {
                _images.add(img.path);
              } else {
                exceeded = true;
                break;
              }
            }
            if (exceeded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Limit reached: Only up to 10 photos can be added.')),
              );
            }
          });
        }
      } else {
        final XFile? image = await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          setState(() {
            _images.add(image.path);
          });
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  void _showPhotoSourceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Photo Source',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E1E1E),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildUploadSourceCard(
                        icon: Icons.camera_alt_rounded,
                        title: 'Camera',
                        sub: 'Take a new photo',
                        onTap: () {
                          Navigator.pop(context);
                          _pickImage(ImageSource.camera);
                        },
                        color: const Color(0xFFFF7E00),
                        bg: const Color(0xFFFFF6F2),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildUploadSourceCard(
                        icon: Icons.image_rounded,
                        title: 'Gallery (Files)',
                        sub: 'Choose from files',
                        onTap: () {
                          Navigator.pop(context);
                          _pickImage(ImageSource.gallery);
                        },
                        color: Colors.purple,
                        bg: const Color(0xFFF9F0FF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUploadSourceCard({
    required IconData icon,
    required String title,
    required String sub,
    required VoidCallback onTap,
    required Color color,
    required Color bg,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: Colors.white, radius: 16, child: Icon(icon, color: color, size: 16)),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E))),
                  Text(sub, style: GoogleFonts.outfit(fontSize: 8, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
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
        title: Text(
          'Edit Ad',
          style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _goToPreview,
            child: Text(
              'Preview',
              style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFFFF7E00)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photos Row
                  _buildSectionLabel('Photos'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _images.length < 10 ? _images.length + 1 : 10,
                      itemBuilder: (context, i) {
                        if (i == _images.length && _images.length < 10) {
                          return GestureDetector(
                            onTap: () => _showPhotoSourceBottomSheet(context),
                            child: CustomPaint(
                              painter: _EditAdDashedBorderPainter(color: const Color(0xFFECEBEB), radius: 8, strokeWidth: 1),
                              child: Container(
                                width: 80,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFBFBFB),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 20),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Add Photo',
                                      style: GoogleFonts.outfit(fontSize: 8, color: Colors.grey, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }

                        final path = _images[i];
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: Stack(
                            children: [
                              Container(
                                width: 80,
                                height: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFFECEBEB)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: path.startsWith('http')
                                      ? Image.network(path, fit: BoxFit.cover)
                                      : (path.startsWith('assets/')
                                          ? Image.asset(path, fit: BoxFit.cover)
                                          : Image.file(File(path), fit: BoxFit.cover)),
                                ),
                              ),
                              if (i == 0)
                                Positioned(
                                  bottom: 6,
                                  left: 6,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.6),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Cover',
                                      style: GoogleFonts.outfit(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _images.removeAt(i);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.close, color: Colors.white, size: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Drag to reorder photos',
                    style: GoogleFonts.outfit(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                  const Divider(height: 24, color: Color(0xFFEEEEEE)),

                  // Title Field
                  _buildFieldLabel('Title'),
                  _buildTextField(_titleController, hint: 'iPhone 15 Pro Max', maxLen: 50),
                  const SizedBox(height: 16),

                  // Price Field
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Price'),
                            TextField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFF1E1E1E), fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                prefixText: '₹ ',
                                prefixStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E2E2))),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFFF7E00))),
                                isDense: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: GestureDetector(
                          onTap: () => setState(() => _isNegotiable = !_isNegotiable),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: _isNegotiable,
                                  activeColor: const Color(0xFFFF7E00),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  onChanged: (v) => setState(() => _isNegotiable = v!),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Negotiable',
                                style: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFF1E1E1E), fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Category
                  _buildFieldLabel('Category'),
                  _buildDropdownField(
                    val: _selectedCategory,
                    items: ['Mobiles & Tablets', 'Vehicles', 'Bikes', 'Electronics', 'Furniture', 'Fashion'],
                    onChanged: (v) => setState(() => _selectedCategory = v!),
                  ),
                  const SizedBox(height: 16),

                  // Subcategory
                  _buildFieldLabel('Subcategory'),
                  _buildDropdownField(
                    val: _selectedSubcategory,
                    items: ['iPhones', 'Android Phones', 'Tablets', 'Accessories'],
                    onChanged: (v) => setState(() => _selectedSubcategory = v!),
                  ),
                  const SizedBox(height: 16),

                  // Condition selection chips
                  _buildFieldLabel('Condition'),
                  _buildConditionChips(),
                  const SizedBox(height: 16),

                  // Description
                  _buildFieldLabel('Description'),
                  _buildTextField(_descriptionController, hint: 'Describe the item...', maxLen: 500, lines: 4),
                  const SizedBox(height: 16),

                  // Location
                  _buildFieldLabel('Location'),
                  _buildLocationField(),
                  const SizedBox(height: 20),

                  // Contact Preference
                  _buildFieldLabel('Contact Preference'),
                  const SizedBox(height: 4),
                  _buildContactPreferenceRow(),
                  const Divider(height: 32, color: Color(0xFFEEEEEE)),

                  // Ad Status section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Ad Status',
                            style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _status == 'Active' ? const Color(0xFFDCF5E3) : Colors.grey[200],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _status,
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: _status == 'Active' ? const Color(0xFF1E5C27) : const Color(0xFF555555),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: _toggleStatus,
                        child: Text(
                          _status == 'Active' ? 'Deactivate Ad' : 'Activate Ad',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFF7E00),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Bottom Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7E00),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  'Save Changes',
                  style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),

          // Bottom nav bar tabs
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E1E1E)),
            ),
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, {required String hint, int maxLen = 100, int lines = 1}) {
    return Stack(
      children: [
        TextField(
          controller: controller,
          maxLines: lines,
          onChanged: (v) {
            setState(() {}); // trigger rebuild to update counter
          },
          style: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFF1E1E1E), fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.outfit(fontSize: 12, color: Colors.grey),
            contentPadding: EdgeInsets.only(
              left: 16,
              right: maxLen != 100 ? 55 : 16,
              top: 12,
              bottom: lines > 1 ? 28 : 12,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E2E2))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFFF7E00))),
            isDense: true,
            counterText: "", // hide default counter
          ),
        ),
        if (maxLen != 100)
          Positioned(
            right: 12,
            bottom: lines > 1 ? 8 : 12,
            child: Text(
              '${controller.text.length}/$maxLen',
              style: GoogleFonts.outfit(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ),
      ],
    );
  }

  Widget _buildDropdownField({required String val, required List<String> items, required ValueChanged<String?> onChanged}) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (bc) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Text(
                        'Select Option',
                        style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
                      ),
                    ),
                    const Divider(color: Color(0xFFECEBEB)),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, idx) {
                          final item = items[idx];
                          final isSelected = item == val;
                          return ListTile(
                            title: Text(
                              item,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFF1E1E1E),
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              ),
                            ),
                            trailing: isSelected ? const Icon(Icons.check_rounded, color: Color(0xFFFF7E00)) : null,
                            onTap: () {
                              onChanged(item);
                              Navigator.pop(bc);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E2E2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              val,
              style: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFF1E1E1E), fontWeight: FontWeight.w500),
            ),
            const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationField() {
    return GestureDetector(
      onTap: () {
        final controller = TextEditingController(text: _locationController.text);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Edit Location', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold)),
              content: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Enter city, state',
                  border: OutlineInputBorder(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel', style: GoogleFonts.outfit(color: Colors.grey)),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _locationController.text = controller.text.trim();
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Save', style: GoogleFonts.outfit(color: const Color(0xFFFF7E00), fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E2E2)),
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on_outlined, color: Colors.grey, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _locationController.text.isEmpty ? 'Select Location' : _locationController.text,
                style: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFF1E1E1E), fontWeight: FontWeight.w500),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionChips() {
    final conditions = ['Like New', 'Good', 'Fair', 'Used'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: conditions.map((cond) {
        final isSelected = _selectedCondition == cond;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedCondition = cond),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFF6F2) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFFE2E2E2),
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: Center(
                child: Text(
                  cond,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFF555555),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContactPreferenceRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _contactPreference = 'Chat on App'),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<String>(
                value: 'Chat on App',
                groupValue: _contactPreference,
                activeColor: const Color(0xFFFF7E00),
                onChanged: (v) => setState(() => _contactPreference = v!),
              ),
              Text(
                'Chat on App',
                style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w500, color: const Color(0xFF1E1E1E)),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => setState(() => _contactPreference = 'Phone Number'),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: 'Phone Number',
                      groupValue: _contactPreference,
                      activeColor: const Color(0xFFFF7E00),
                      onChanged: (v) => setState(() => _contactPreference = v!),
                    ),
                    Text(
                      'Phone Number',
                      style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w500, color: const Color(0xFF1E1E1E)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: Text(
                  'Buyers will see your phone number',
                  style: GoogleFonts.outfit(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
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
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MyAdsScreen()));
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SellScreen()));
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

class _EditAdDashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashLength;
  final double radius;

  _EditAdDashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 4.0,
    this.dashLength = 6.0,
    this.radius = 8.0,
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
