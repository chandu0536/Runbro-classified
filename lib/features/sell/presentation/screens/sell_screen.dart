import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:runbroclassified/data/app_data.dart';
import 'package:runbroclassified/features/listings/presentation/screens/my_ads_screen.dart';
import 'package:runbroclassified/features/premium/presentation/screens/premium_screen.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0; // 0: Category, 1: Details, 2: Photos, 3: Preview, 4: Success

  // Form Field State
  String _selectedCategory = '';
  final _titleController = TextEditingController(text: 'iPhone 15 Pro Max');
  final _descriptionController = TextEditingController(
    text: 'Excellent condition. No scratches or dents. Original bill available. Box and charger included.',
  );
  String _selectedCondition = 'Like New';
  String _selectedBrand = 'Apple';
  final _modelController = TextEditingController(text: 'iPhone 15 Pro Max');
  String _selectedStorage = '256 GB';
  String _selectedColor = 'Natural Titanium';
  final _priceController = TextEditingController(text: '85,000');
  bool _isNegotiable = true;
  final _locationController = TextEditingController(text: 'Hyderabad, Telangana');

  // Vehicles & Bikes specific state
  String _selectedYear = '2021';
  String _selectedFuel = 'Petrol';
  String _selectedTransmission = 'Manual';
  String _selectedOwner = '1st Owner';
  final _kmController = TextEditingController(text: '32,000');
  String _selectedBodyType = 'SUV';
  String _selectedRegBoard = 'TS Board';

  // Jobs specific state
  String _selectedJobType = 'Full-time';
  final _salaryController = TextEditingController(text: '25,000');
  String _selectedExperience = '1-3 Years';

  // Fashion specific state
  String _selectedSize = 'M';
  String _selectedGender = 'Men';

  // Image Upload State
  final List<String> _uploadedImages = [];
  bool _isUploading = false;

  List<String> _getBrandsForCategory() {
    switch (_selectedCategory) {
      case 'Vehicles':
        return ['Suzuki', 'Hyundai', 'Kia', 'Honda', 'Tata', 'Mahindra'];
      case 'Bikes':
        return ['Royal Enfield', 'Honda', 'Yamaha', 'Hero', 'KTM', 'Bajaj'];
      case 'Mobiles':
        return ['Apple', 'Samsung', 'OnePlus', 'Xiaomi', 'Realme'];
      case 'Electronics':
        return ['Apple', 'Dell', 'HP', 'Lenovo', 'Sony', 'LG'];
      case 'Furniture':
        return ['Nilkamal', 'Sleepwell', 'Urban Ladder', 'IKEA', 'Other'];
      case 'Fashion':
        return ['Zara', 'Nike', 'Adidas', 'H&M', 'Other'];
      default:
        return ['Apple', 'Samsung', 'Suzuki', 'Royal Enfield', 'RunBro', 'Other'];
    }
  }

  void _updateBrandForCategory() {
    final brands = _getBrandsForCategory();
    if (!brands.contains(_selectedBrand)) {
      _selectedBrand = brands.first;
    }
  }

  List<Map<String, String>> _getPreviewSpecItems() {
    final list = <Map<String, String>>[];
    list.add({'label': 'Category', 'val': _selectedCategory.isEmpty ? 'Mobiles' : _selectedCategory});
    if (_selectedCategory != 'Jobs') {
      list.add({'label': 'Brand', 'val': _selectedBrand});
    }
    list.add({'label': 'Model', 'val': _modelController.text.trim()});
    list.add({'label': 'Condition', 'val': _selectedCondition});

    if (_selectedCategory == 'Vehicles' || _selectedCategory == 'Bikes') {
      list.add({'label': 'Year', 'val': _selectedYear});
      list.add({'label': 'Owner', 'val': _selectedOwner});
      list.add({'label': 'KM Driven', 'val': '${_kmController.text.trim()} km'});
      list.add({'label': 'Reg Board', 'val': _selectedRegBoard});
    }
    if (_selectedCategory == 'Vehicles') {
      list.add({'label': 'Fuel Type', 'val': _selectedFuel});
      list.add({'label': 'Transmission', 'val': _selectedTransmission});
      list.add({'label': 'Body Type', 'val': _selectedBodyType});
    }
    if (_selectedCategory == 'Mobiles' || _selectedCategory == 'Electronics') {
      list.add({'label': 'Storage', 'val': _selectedStorage});
      list.add({'label': 'Color', 'val': _selectedColor});
    }
    if (_selectedCategory == 'Jobs') {
      list.add({'label': 'Job Type', 'val': _selectedJobType});
      list.add({'label': 'Salary', 'val': '₹${_salaryController.text.trim()}/month'});
      list.add({'label': 'Experience', 'val': _selectedExperience});
    }
    if (_selectedCategory == 'Fashion') {
      list.add({'label': 'Gender', 'val': _selectedGender});
      list.add({'label': 'Size', 'val': _selectedSize});
    }

    return list;
  }

  Widget _buildCategorySpecificFields() {
    if (_selectedCategory == 'Vehicles') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Model
          _buildFieldLabel('Model'),
          _buildTextField(_modelController, hint: 'e.g. Swift, Seltos, i20'),
          const SizedBox(height: 16),

          // Year & Owner side by side
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Year'),
                    _buildDropdownField(
                      val: _selectedYear,
                      items: const ['2024', '2023', '2022', '2021', '2020', '2019', '2018', '2017'],
                      onChanged: (v) => setState(() => _selectedYear = v!),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Owner'),
                    _buildDropdownField(
                      val: _selectedOwner,
                      items: const ['1st Owner', '2nd Owner', '3rd Owner', '3+ Owners'],
                      onChanged: (v) => setState(() => _selectedOwner = v!),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Fuel & Transmission side by side
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Fuel Type'),
                    _buildDropdownField(
                      val: _selectedFuel,
                      items: const ['Petrol', 'Diesel', 'CNG', 'Electric'],
                      onChanged: (v) => setState(() => _selectedFuel = v!),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Transmission'),
                    _buildDropdownField(
                      val: _selectedTransmission,
                      items: const ['Manual', 'Automatic'],
                      onChanged: (v) => setState(() => _selectedTransmission = v!),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // KM Driven & Registration Board side by side
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('KM Driven'),
                    TextField(
                      controller: _kmController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFF1E1E1E)),
                      decoration: InputDecoration(
                        hintText: 'e.g. 45,000',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E2E2))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFFF7E00))),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Reg. Board'),
                    _buildDropdownField(
                      val: _selectedRegBoard,
                      items: const ['TS Board', 'AP Board', 'KA Board', 'MH Board', 'DL Board', 'Other'],
                      onChanged: (v) => setState(() => _selectedRegBoard = v!),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Body Type
          _buildFieldLabel('Body Type'),
          _buildDropdownField(
            val: _selectedBodyType,
            items: const ['SUV', 'Hatchback', 'Sedan', 'MUV', 'Coupe'],
            onChanged: (v) => setState(() => _selectedBodyType = v!),
          ),
        ],
      );
    } else if (_selectedCategory == 'Bikes') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Model
          _buildFieldLabel('Model'),
          _buildTextField(_modelController, hint: 'e.g. Classic 350, Pulsar, Duke 390'),
          const SizedBox(height: 16),

          // Year & Owner side by side
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Year'),
                    _buildDropdownField(
                      val: _selectedYear,
                      items: const ['2024', '2023', '2022', '2021', '2020', '2019', '2018', '2017'],
                      onChanged: (v) => setState(() => _selectedYear = v!),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Owner'),
                    _buildDropdownField(
                      val: _selectedOwner,
                      items: const ['1st Owner', '2nd Owner', '3rd Owner', '3+ Owners'],
                      onChanged: (v) => setState(() => _selectedOwner = v!),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // KM Driven & Reg Board side by side
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('KM Driven'),
                    TextField(
                      controller: _kmController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFF1E1E1E)),
                      decoration: InputDecoration(
                        hintText: 'e.g. 25,000',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E2E2))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFFF7E00))),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Reg. Board'),
                    _buildDropdownField(
                      val: _selectedRegBoard,
                      items: const ['TS Board', 'AP Board', 'KA Board', 'MH Board', 'DL Board', 'Other'],
                      onChanged: (v) => setState(() => _selectedRegBoard = v!),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    } else if (_selectedCategory == 'Jobs') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Designation/Model field
          _buildFieldLabel('Designation / Role'),
          _buildTextField(_modelController, hint: 'e.g. Delivery Executive, Telecaller'),
          const SizedBox(height: 16),

          // Job Type
          _buildFieldLabel('Job Type'),
          _buildDropdownField(
            val: _selectedJobType,
            items: const ['Full-time', 'Part-time', 'Work from home', 'Contract'],
            onChanged: (v) => setState(() => _selectedJobType = v!),
          ),
          const SizedBox(height: 16),

          // Salary & Experience side by side
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Monthly Salary'),
                    TextField(
                      controller: _salaryController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFF1E1E1E)),
                      decoration: InputDecoration(
                        hintText: 'e.g. 20,000',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E2E2))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFFF7E00))),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Experience'),
                    _buildDropdownField(
                      val: _selectedExperience,
                      items: const ['0-1 Year', '1-3 Years', '3-5 Years', '5+ Years'],
                      onChanged: (v) => setState(() => _selectedExperience = v!),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    } else if (_selectedCategory == 'Fashion') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item Model
          _buildFieldLabel('Item Type'),
          _buildTextField(_modelController, hint: 'e.g. Casual T-Shirt, Sneakers'),
          const SizedBox(height: 16),

          // Gender & Size side by side
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Gender'),
                    _buildDropdownField(
                      val: _selectedGender,
                      items: const ['Men', 'Women', 'Unisex', 'Kids'],
                      onChanged: (v) => setState(() => _selectedGender = v!),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Size'),
                    _buildDropdownField(
                      val: _selectedSize,
                      items: const ['S', 'M', 'L', 'XL', 'XXL'],
                      onChanged: (v) => setState(() => _selectedSize = v!),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      // Mobiles, Electronics, Furniture, Home & Living, Books, Services, Pets, Kids (Default/Standard)
      final showStorageColor = _selectedCategory == 'Mobiles' || _selectedCategory == 'Electronics';
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Model
          _buildFieldLabel('Model / Item Name'),
          _buildTextField(_modelController, hint: 'e.g. iPhone 15 Pro Max, Wooden Sofa'),
          const SizedBox(height: 16),

          if (showStorageColor) ...[
            // Storage and Color side-by-side
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel(_selectedCategory == 'Mobiles' ? 'Storage' : 'RAM/Storage'),
                      _buildDropdownField(
                        val: _selectedStorage,
                        items: const ['128 GB', '256 GB', '512 GB', '1 TB'],
                        onChanged: (v) => setState(() => _selectedStorage = v!),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel('Color'),
                      _buildDropdownField(
                        val: _selectedColor,
                        items: const ['Natural Titanium', 'Blue Titanium', 'White Titanium', 'Black Titanium'],
                        onChanged: (v) => setState(() => _selectedColor = v!),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      );
    }
  }

  final List<Map<String, dynamic>> _categoriesList = [
    {
      'label': 'Vehicles',
      'sub': 'Cars, Bikes, Scooters & more',
      'image': 'assets/categories/vehicles.jpeg',
    },
    {
      'label': 'Mobiles',
      'sub': 'Smartphones, Tablets & Accessories',
      'image': 'assets/categories/mobiles.jpeg',
    },
    {
      'label': 'Bikes',
      'sub': 'Motorcycles, Scooters & more',
      'image': 'assets/categories/bikes.jpeg',
    },
    {
      'label': 'Electronics',
      'sub': 'TVs, Laptops, Cameras & more',
      'image': 'assets/categories/electronice.jpeg',
    },
    {
      'label': 'Furniture',
      'sub': 'Sofa, Beds, Tables & more',
      'image': 'assets/categories/furniture.jpeg',
    },
    {
      'label': 'Fashion',
      'sub': 'Men, Women & Kids Fashion',
      'image': 'assets/categories/fashion.jpeg',
    },
    {
      'label': 'Home & Living',
      'sub': 'Home Decor, Kitchen & more',
      'image': 'assets/categories/home & living.jpeg',
    },
    {
      'label': 'Books',
      'sub': 'Academic, Novels, Comics & more',
      'image': 'assets/categories/books.jpeg',
    },
    {
      'label': 'Jobs',
      'sub': 'Full-time, Part-time & more',
      'image': 'assets/categories/jobs.jpeg',
    },
    {
      'label': 'Services',
      'sub': 'Business, Home, Repair & more',
      'image': 'assets/categories/services.jpeg',
    },
    {
      'label': 'Pets',
      'sub': 'Dogs, Cats, Birds & accessories',
      'image': 'assets/categories/pets (1).jpeg',
    },
    {
      'label': 'Kids',
      'sub': 'Toys, Clothing, Baby Gear & more',
      'image': 'assets/categories/kids.jpeg',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _modelController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    _kmController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentStep < 4) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      if (_uploadedImages.length >= 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You can add up to 10 photos only.')),
        );
        return;
      }
      setState(() => _isUploading = true);
      
      if (source == ImageSource.gallery) {
        final List<XFile> images = await _picker.pickMultiImage();
        if (images.isNotEmpty) {
          setState(() {
            bool exceeded = false;
            for (var img in images) {
              if (_uploadedImages.length < 10) {
                _uploadedImages.add(img.path);
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
            _uploadedImages.add(image.path);
          });
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    } finally {
      setState(() => _isUploading = false);
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

  void _publishAd() {
    // Save to AppData static memory
    final newAd = {
      'id': 'RB${10000000 + AppData.myAds.length * 13}',
      'title': _titleController.text.trim(),
      'price': '₹${_priceController.text.trim()}',
      'negotiable': _isNegotiable,
      'location': _locationController.text.trim(),
      'date': 'Just now',
      'views': 0,
      'chats': 0,
      'likes': 0,
      'status': 'Active',
      'category': _selectedCategory.isEmpty ? 'Mobiles' : _selectedCategory,
      'brand': _selectedCategory == 'Jobs' ? 'RunBro' : _selectedBrand,
      'model': _modelController.text.trim(),
      'condition': _selectedCondition,
      'description': _descriptionController.text.trim(),
      'images': _uploadedImages.isNotEmpty
          ? _uploadedImages
          : ['https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=400'],
      
      // Category Specific Attributes
      if (_selectedCategory == 'Vehicles' || _selectedCategory == 'Bikes') ...{
        'year': _selectedYear,
        'owner': _selectedOwner,
        'km': int.tryParse(_kmController.text.replaceAll(',', '').replaceAll('.', '').trim()) ?? 0,
        'regBoard': _selectedRegBoard,
      },
      if (_selectedCategory == 'Vehicles') ...{
        'fuel': _selectedFuel,
        'transmission': _selectedTransmission,
        'bodyType': _selectedBodyType,
      },
      if (_selectedCategory == 'Mobiles' || _selectedCategory == 'Electronics') ...{
        'storage': _selectedStorage,
        'color': _selectedColor,
      },
      if (_selectedCategory == 'Jobs') ...{
        'jobType': _selectedJobType,
        'salary': '₹${_salaryController.text.trim()}/month',
        'experience': _selectedExperience,
      },
      if (_selectedCategory == 'Fashion') ...{
        'gender': _selectedGender,
        'size': _selectedSize,
      },
    };

    AppData.myAds.insert(0, newAd);
    _nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _currentStep == 4
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text(
                'Sell Your Item',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Color(0xFF1E1E1E)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            )
          : AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E)),
                onPressed: () {
                  if (_currentStep == 0) {
                    Navigator.pop(context);
                  } else {
                    _prevPage();
                  }
                },
              ),
              title: Text(
                'Sell Your Item',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
              centerTitle: true,
            ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildCategoryStep(),
                _buildDetailsStep(),
                _buildPhotosStep(),
                _buildPreviewStep(),
                _buildSuccessStep(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Horizontal Step Indicator
  Widget _buildStepIndicator() {
    final steps = ['Category', 'Details', 'Photos', 'Preview'];
    final displayStep = _currentStep == 4 ? 3 : _currentStep;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isOdd) {
            // Connector line
            final stepIndex = index ~/ 2;
            final isCompleted = displayStep > stepIndex;
            return Expanded(
              child: Container(
                height: 2,
                margin: const EdgeInsets.only(top: 15), // Center vertically with 32px height circle (16 - 1)
                color: isCompleted ? const Color(0xFFFF7E00) : const Color(0xFFE2E2E2),
              ),
            );
          } else {
            // Step node (Circle + Label below)
            final stepIndex = index ~/ 2;
            final isCompleted = displayStep > stepIndex;
            final isActive = displayStep == stepIndex;
            
            return SizedBox(
              width: 64, // Equal width for all step columns to ensure perfect spacing
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Circle badge
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isCompleted || isActive
                          ? const Color(0xFFFF7E00).withOpacity(0.15)
                          : const Color(0xFFF0F0F0).withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isCompleted || isActive ? const Color(0xFFFF7E00) : const Color(0xFFF0F0F0),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: isCompleted
                            ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                            : Text(
                                '${stepIndex + 1}',
                                style: GoogleFonts.outfit(
                                  color: isActive ? Colors.white : const Color(0xFF777777),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Text label
                  Text(
                    steps[stepIndex],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      color: isActive || isCompleted ? const Color(0xFFFF7E00) : const Color(0xFF777777),
                      fontSize: 12,
                      fontWeight: isActive || isCompleted ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  // STEP 1: Select Category
  Widget _buildCategoryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select a Category',
                style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1E1E1E)),
              ),
              const SizedBox(height: 4),
              Text(
                'Choose the category that best describes your item',
                style: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFF777777)),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _categoriesList.length,
            separatorBuilder: (context, index) => const Divider(color: Color(0xFFF5F5F5), height: 1),
            itemBuilder: (context, index) {
              final cat = _categoriesList[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFEEEEEE)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.asset(
                      cat['image'] as String,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  cat['label'] as String,
                  style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF1E1E1E)),
                ),
                subtitle: Text(
                  cat['sub'] as String,
                  style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF888888)),
                ),
                trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF888888)),
                onTap: () {
                  setState(() {
                    _selectedCategory = cat['label'] as String;
                    // Reset defaults based on category
                    if (_selectedCategory == 'Vehicles') {
                      _selectedBrand = 'Suzuki';
                      _modelController.text = 'Swift';
                      _titleController.text = 'Maruti Suzuki Swift VXI 2021';
                    } else if (_selectedCategory == 'Bikes') {
                      _selectedBrand = 'Royal Enfield';
                      _modelController.text = 'Classic 350';
                      _titleController.text = 'Royal Enfield Classic 350 2021';
                    } else if (_selectedCategory == 'Mobiles') {
                      _selectedBrand = 'Apple';
                      _modelController.text = 'iPhone 15 Pro Max';
                      _titleController.text = 'iPhone 15 Pro Max 256GB';
                    } else if (_selectedCategory == 'Jobs') {
                      _selectedBrand = 'RunBro';
                      _modelController.text = 'Delivery Executive';
                      _titleController.text = 'Urgent requirement for Delivery Executive';
                    } else {
                      _selectedBrand = 'Other';
                      _modelController.text = '';
                      _titleController.text = '';
                    }
                    _updateBrandForCategory();
                  });
                  _nextPage();
                },
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: const Color(0xFFFFF6F2),
          child: Row(
            children: [
              const Icon(Icons.verified_user_rounded, color: Color(0xFF4CAF50)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '100% Safe & Secure',
                      style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF2E7D32)),
                    ),
                    Text(
                      'Your details are protected with us',
                      style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF558B2F)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // STEP 2: Details Form
  Widget _buildDetailsStep() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Details',
                  style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1E1E1E)),
                ),
                const SizedBox(height: 4),
                Text(
                  'Enter the correct details to attract more buyers',
                  style: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFF777777)),
                ),
                const SizedBox(height: 20),

                // Title field
                _buildFieldLabel('Title'),
                _buildTextField(_titleController, hint: 'e.g. iPhone 15 Pro Max', maxLen: 60),
                const SizedBox(height: 16),

                // Description field
                _buildFieldLabel('Description'),
                _buildTextField(_descriptionController, hint: 'Describe your item in detail...', maxLen: 500, lines: 4),
                const SizedBox(height: 16),

                // Condition Selection Cards
                _buildFieldLabel('Condition'),
                _buildConditionRow(),
                const SizedBox(height: 16),

                // Brand (only show if not Jobs)
                if (_selectedCategory != 'Jobs') ...[
                  _buildFieldLabel('Brand'),
                  _buildDropdownField(
                    val: _selectedBrand,
                    items: _getBrandsForCategory(),
                    onChanged: (v) => setState(() => _selectedBrand = v!),
                  ),
                  const SizedBox(height: 16),
                ],

                // Category Specific Custom Fields
                _buildCategorySpecificFields(),
                const SizedBox(height: 16),

                // Price and Negotiable Row
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('Price'),
                          TextField(
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF1E1E1E)),
                            decoration: InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                child: Text('₹', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E2E2))),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFFF7E00))),
                              isDense: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Negotiable',
                                style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E1E1E)),
                              ),
                              const SizedBox(width: 2),
                              const Icon(Icons.info_outline_rounded, size: 12, color: Colors.grey),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Switch(
                            value: _isNegotiable,
                            activeColor: const Color(0xFFFF7E00),
                            onChanged: (v) => setState(() => _isNegotiable = v),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Location field
                _buildFieldLabel('Location'),
                TextField(
                  controller: _locationController,
                  style: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFF1E1E1E)),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_on_outlined, color: Colors.grey),
                    suffixIcon: const Icon(Icons.gps_fixed_rounded, color: Color(0xFFFF7E00)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E2E2))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFFF7E00))),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        _buildBottomButtons(
          onNext: _nextPage,
        ),
      ],
    );
  }

  // STEP 3: Upload Photos
  Widget _buildPhotosStep() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload Photos',
                  style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1E1E1E)),
                ),
                const SizedBox(height: 4),
                Text(
                  'Add clear photos of your item to get more interest',
                  style: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFF777777)),
                ),
                const SizedBox(height: 16),

                // Upload info pill
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF9EE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, color: Color(0xFF4CAF50), size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'You can upload 1 to 10 images',
                        style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF2E7D32)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Grid of picked Photo slots & Add Photo card
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: _uploadedImages.length < 10 ? _uploadedImages.length + 1 : 10,
                  itemBuilder: (context, index) {
                    if (index == _uploadedImages.length && _uploadedImages.length < 10) {
                      return GestureDetector(
                        onTap: () => _showPhotoSourceBottomSheet(context),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF6F2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFFFEADF), width: 1.5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.camera_alt_outlined, color: Color(0xFFFF7E00), size: 24),
                              const SizedBox(height: 4),
                              Text(
                                'Add Photo',
                                style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.w700, color: const Color(0xFFFF7E00)),
                              ),
                              Text(
                                'Tap to upload',
                                style: GoogleFonts.outfit(fontSize: 7, color: const Color(0xFFFF7E00)),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final path = _uploadedImages[index];
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFE2E2E2), width: 1.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: path.startsWith('http')
                                ? Image.network(path, fit: BoxFit.cover)
                                : Image.file(File(path), fit: BoxFit.cover),
                          ),
                        ),
                        if (index == 0)
                          Positioned(
                            bottom: 4,
                            left: 4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Cover',
                                style: GoogleFonts.outfit(fontSize: 7, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _uploadedImages.removeAt(index);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),

                if (_isUploading)
                  const Center(child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator(color: Color(0xFFFF7E00))))
                else
                  Row(
                    children: [
                      Expanded(
                        child: _buildUploadSourceCard(
                          icon: Icons.camera_alt_rounded,
                          title: 'Camera',
                          sub: 'Take a new photo',
                          onTap: () => _pickImage(ImageSource.camera),
                          color: const Color(0xFFFF7E00),
                          bg: const Color(0xFFFFF6F2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildUploadSourceCard(
                          icon: Icons.image_rounded,
                          title: 'Gallery',
                          sub: 'Choose from gallery',
                          onTap: () => _pickImage(ImageSource.gallery),
                          color: Colors.purple,
                          bg: const Color(0xFFF9F0FF),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 24),

                // Photo Tips
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBFBFB),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFF0F0F0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Photo Tips',
                              style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF1E1E1E)),
                            ),
                            const SizedBox(height: 8),
                            _buildTipItem('Add clear, well-lit photos'),
                            _buildTipItem('Show different angles'),
                            _buildTipItem('Highlight important features'),
                            _buildTipItem('Avoid blurred images'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text('📷', style: TextStyle(fontSize: 48)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        _buildBottomButtons(
          onNext: () {
            if (_uploadedImages.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please add at least 1 photo of the product.')),
              );
              _showPhotoSourceBottomSheet(context);
            } else {
              _nextPage();
            }
          },
        ),
      ],
    );
  }

  // STEP 4: Preview Ad
  Widget _buildPreviewStep() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Preview Your Ad',
                            style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1E1E1E)),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Review how your ad will look to other buyers',
                            style: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFF777777)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: _prevPage,
                      icon: const Icon(Icons.edit_outlined, size: 14, color: Color(0xFFFF7E00)),
                      label: Text(
                        'Edit Details',
                        style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFFFF7E00)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Card preview layout
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFECEBEB)),
                    boxShadow: const [BoxShadow(color: Color(0x05000000), blurRadius: 10, offset: Offset(0, 4))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image block
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                            child: _uploadedImages.isNotEmpty
                                ? (_uploadedImages[0].startsWith('http')
                                    ? Image.network(_uploadedImages[0], height: 200, width: double.infinity, fit: BoxFit.cover)
                                    : Image.file(File(_uploadedImages[0]), height: 200, width: double.infinity, fit: BoxFit.cover))
                                : Image.network(
                                    'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=400',
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                          ),
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
                                'Preview',
                                style: GoogleFonts.outfit(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '1 / ${_uploadedImages.isNotEmpty ? _uploadedImages.length : 1}',
                                style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Thumbnail Strip
                      if (_uploadedImages.isNotEmpty)
                        Container(
                          height: 50,
                          margin: const EdgeInsets.only(top: 8, left: 12, right: 12),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _uploadedImages.length,
                            itemBuilder: (context, i) {
                              return Container(
                                margin: const EdgeInsets.only(right: 6),
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: i == 0 ? const Color(0xFFFF7E00) : const Color(0xFFE2E2E2), width: i == 0 ? 2 : 1),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: _uploadedImages[i].startsWith('http')
                                      ? Image.network(_uploadedImages[i], fit: BoxFit.cover)
                                      : Image.file(File(_uploadedImages[i]), fit: BoxFit.cover),
                                ),
                              );
                            },
                          ),
                        ),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _titleController.text.trim(),
                              style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1E1E1E)),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  '₹${_priceController.text.trim()}',
                                  style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xFFFF7E00)),
                                ),
                                if (_isNegotiable) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(color: const Color(0xFFEEF9EE), borderRadius: BorderRadius.circular(4)),
                                    child: Text(
                                      'Negotiable',
                                      style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.w700, color: const Color(0xFF2E7D32)),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined, size: 12, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      _locationController.text.trim(),
                                      style: GoogleFonts.outfit(fontSize: 11, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Just now',
                                  style: GoogleFonts.outfit(fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                            const Divider(height: 24, color: Color(0xFFEEEEEE)),
                            Text(
                              'Description',
                              style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF1E1E1E)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _descriptionController.text.trim(),
                              style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF555555), height: 1.4),
                            ),
                            const Divider(height: 24, color: Color(0xFFEEEEEE)),

                            // Specifications Grid
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3.5,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: _getPreviewSpecItems().length,
                              itemBuilder: (context, idx) {
                                final item = _getPreviewSpecItems()[idx];
                                return _buildSpecItem(
                                  Icons.info_outline,
                                  item['label']!,
                                  item['val']!,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Tips Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFFFFF6F2), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      const Text('💡', style: TextStyle(fontSize: 32)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tips for better response',
                              style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFFFF7E00)),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Add more photos from different angles & be responsive to buyer messages.',
                              style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFFB06020)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        _buildBottomButtons(
          nextText: 'Publish Ad',
          nextIcon: Icons.send_rounded,
          onNext: _publishAd,
        ),
      ],
    );
  }

  // STEP 5: Success Ad Published
  Widget _buildSuccessStep() {
    final adId = AppData.myAds.isNotEmpty ? AppData.myAds[0]['id'] : 'RB12345678';
    
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        children: [
          const SizedBox(height: 12),
          
          // Success badge with static confetti dots
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 140,
                height: 140,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Positioned(top: 25, left: 25, child: _buildConfettiDot(const Color(0xFF2196F3), 6)),
                    Positioned(top: 20, right: 30, child: _buildConfettiDot(const Color(0xFFFF9800), 8)),
                    Positioned(bottom: 35, left: 35, child: _buildConfettiDot(const Color(0xFFE91E63), 7)),
                    Positioned(bottom: 30, right: 30, child: _buildConfettiDot(const Color(0xFF4CAF50), 6)),
                    Positioned(top: 65, left: 15, child: _buildConfettiDot(const Color(0xFF9C27B0), 7)),
                    Positioned(top: 75, right: 18, child: _buildConfettiDot(const Color(0xFFFFEB3B), 8)),
                    Positioned(top: 15, left: 70, child: _buildConfettiDot(const Color(0xFF00BCD4), 5)),
                    Positioned(bottom: 15, left: 75, child: _buildConfettiDot(const Color(0xFFFF7E00), 6)),
                  ],
                ),
              ),
              if (_currentStep == 4) const ConfettiBlastWidget(),
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Color(0x2E4CAF50), blurRadius: 16, offset: Offset(0, 4)),
                  ],
                ),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 48),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          Text(
            'Your Ad is Live!',
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Congratulations! Your item has been published successfully.',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF777777),
            ),
          ),
          const SizedBox(height: 24),

          // Ad Summary Section title & Card
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
              child: Text(
                'Ad Summary',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFECEBEB)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _uploadedImages.isNotEmpty
                      ? (_uploadedImages[0].startsWith('http')
                          ? Image.network(_uploadedImages[0], width: 72, height: 72, fit: BoxFit.cover)
                          : Image.file(File(_uploadedImages[0]), width: 72, height: 72, fit: BoxFit.cover))
                      : Image.network(
                          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=400',
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _titleController.text.trim(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '₹${_priceController.text.trim()}',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFFF7E00),
                            ),
                          ),
                          if (_isNegotiable) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF9EE),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Negotiable',
                                style: GoogleFonts.outfit(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2E7D32),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 12, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              _locationController.text.trim(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Ad ID: ',
                              style: GoogleFonts.outfit(fontSize: 11, color: Colors.grey),
                            ),
                            TextSpan(
                              text: adId,
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E1E1E),
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
          const SizedBox(height: 20),

          // Share Box (Increase your chances of selling!)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF1FAF2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFD3F2D6), width: 1),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xFFE0F2E9),
                      child: Icon(Icons.campaign_outlined, color: Color(0xFF2E7D32), size: 16),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Increase your chances of selling!',
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2E7D32),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Share your ad with more people to get quick responses.',
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              color: const Color(0xFF555555),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildShareButtonWidget(
                      'WhatsApp',
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Color(0xFF25D366),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.chat_bubble_rounded, color: Colors.white, size: 20),
                      ),
                    ),
                    _buildShareButtonWidget(
                      'Facebook',
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1877F2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.facebook, color: Colors.white, size: 24),
                      ),
                    ),
                    _buildShareButtonWidget(
                      'Instagram',
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Color(0xFFFFDD55),
                              Color(0xFFFF543F),
                              Color(0xFFC837AB),
                              Color(0xFF3772FF),
                            ],
                            center: Alignment.bottomLeft,
                            radius: 1.0,
                          ),
                        ),
                        child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 20),
                      ),
                    ),
                    _buildShareButtonWidget(
                      'More',
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.share_rounded, color: Color(0xFF555555), size: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // RunBro Premium fully integrated product box
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const PremiumScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7F4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFFE3D5), width: 1),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 16,
                              backgroundColor: Color(0xFFFFECE2),
                              child: Icon(Icons.workspace_premium, color: Color(0xFFFF7E00), size: 18),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Unlock More. Sell Faster!',
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFFF7E00),
                                    ),
                                  ),
                                  Text(
                                    'Upgrade to RunBro Premium and get exclusive benefits.',
                                    style: GoogleFonts.outfit(
                                      fontSize: 10,
                                      color: const Color(0xFFB06020),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // 4 columns benefits grid
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildPremiumMiniFeature(
                              icon: Icons.campaign_rounded,
                              title: 'Boosted Visibility',
                              desc: 'Your ad reaches more interested buyers',
                            ),
                            _buildPremiumMiniFeature(
                              icon: Icons.push_pin_rounded,
                              title: 'Top Placement',
                              desc: 'Show your ad on top of listings',
                            ),
                            _buildPremiumMiniFeature(
                              icon: Icons.wb_sunny_rounded,
                              title: 'Highlight Ad',
                              desc: 'Make your ad stand out from others',
                            ),
                            _buildPremiumMiniFeature(
                              icon: Icons.mark_chat_unread_rounded,
                              title: 'More Responses',
                              desc: 'Get more calls & messages faster',
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
  
                        // 3 package cards selector row
                        Row(
                          children: [
                            _buildPremiumPackageCard(
                              duration: '1 Month',
                              price: '₹129',
                              period: '/month',
                            ),
                            const SizedBox(width: 8),
                            _buildPremiumPackageCard(
                              duration: '3 Months',
                              price: '₹99',
                              period: '/month',
                              badge: 'POPULAR',
                              savings: 'Save 23%',
                            ),
                            const SizedBox(width: 8),
                            _buildPremiumPackageCard(
                              duration: '12 Months',
                              price: '₹69',
                              period: '/month',
                              badge: 'BEST VALUE',
                              savings: 'Save 46%',
                              isSelected: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        // Secure payment footer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.verified_user_rounded, color: Color(0xFF4CAF50), size: 14),
                            const SizedBox(width: 6),
                            Text(
                              'Secure Payment • Cancel Anytime',
                              style: GoogleFonts.outfit(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF555555),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Best value starburst / badge in top-right
                  Positioned(
                    top: -12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF7E00),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(color: Color(0x33FF7E00), blurRadius: 4, offset: Offset(0, 2)),
                        ],
                      ),
                      child: Text(
                        'BEST VALUE',
                        style: GoogleFonts.outfit(
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Primary Actions
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MyAdsScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7E00),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                'View My Ads',
                style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFFF7E00), width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                'Continue Exploring',
                style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFFFF7E00)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfettiDot(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildShareButtonWidget(String label, Widget iconWidget) {
    return Column(
      children: [
        iconWidget,
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF555555),
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumMiniFeature({required IconData icon, required String title, required String desc}) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFFF7E00), size: 16),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(fontSize: 8, fontWeight: FontWeight.w700, color: const Color(0xFF1E1E1E)),
          ),
          const SizedBox(height: 2),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(fontSize: 6, color: Colors.grey, height: 1.2),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumPackageCard({
    required String duration,
    required String price,
    required String period,
    String? badge,
    String? savings,
    bool isSelected = false,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF0E8) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFFE2E2E2),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (badge != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7E00),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.outfit(fontSize: 6, fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ),
              const SizedBox(height: 4),
            ] else ...[
              const SizedBox(height: 12),
            ],
            Text(
              duration,
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: price,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                  TextSpan(
                    text: period,
                    style: GoogleFonts.outfit(
                      fontSize: 8,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            if (savings != null) ...[
              const SizedBox(height: 4),
              Text(
                savings,
                style: GoogleFonts.outfit(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Common UI Helpers
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
    return TextField(
      controller: controller,
      maxLines: lines,
      maxLength: maxLen == 100 ? null : maxLen,
      style: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFF1E1E1E)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.outfit(fontSize: 12, color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E2E2))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFFF7E00))),
        isDense: true,
        counterStyle: GoogleFonts.outfit(fontSize: 9),
      ),
    );
  }

  Widget _buildDropdownField({required String val, required List<String> items, required ValueChanged<String?> onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E2E2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: val,
          isExpanded: true,
          style: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFF1E1E1E)),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildConditionRow() {
    final conditions = ['New', 'Like New', 'Good', 'Fair', 'Used'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: conditions.map((cond) {
        final isSelected = _selectedCondition == cond;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedCondition = cond),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFF6F2) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isSelected ? const Color(0xFFFF7E00) : const Color(0xFFE2E2E2), width: isSelected ? 1.5 : 1),
              ),
              child: Center(
                child: Text(
                  cond,
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
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
          border: Border.all(color: color.withOpacity(0.15)),
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

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Color(0xFFFF7E00), size: 12),
          const SizedBox(width: 6),
          Text(text, style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF555555))),
        ],
      ),
    );
  }

  Widget _buildSpecItem(IconData icon, String label, String val) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF777777), size: 14),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: GoogleFonts.outfit(fontSize: 8, color: Colors.grey)),
              Text(val, maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w700, color: const Color(0xFF1E1E1E))),
            ],
          ),
        ),
      ],
    );
  }



  Widget _buildBottomButtons({VoidCallback? onNext, String nextText = 'Next', IconData? nextIcon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 44,
              child: OutlinedButton(
                onPressed: _prevPage,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFFF7E00)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  'Back',
                  style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFFFF7E00)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7E00),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nextText,
                      style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    if (nextIcon != null) ...[
                      const SizedBox(width: 6),
                      Icon(nextIcon, color: Colors.white, size: 14),
                    ] else ...[
                      const SizedBox(width: 6),
                      const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfettiBlastWidget extends StatefulWidget {
  const ConfettiBlastWidget({super.key});

  @override
  State<ConfettiBlastWidget> createState() => _ConfettiBlastWidgetState();
}

class _ConfettiBlastWidgetState extends State<ConfettiBlastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_ConfettiParticle> _particles = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    final colors = [
      const Color(0xFF2196F3), // Blue
      const Color(0xFFFF9800), // Orange
      const Color(0xFFE91E63), // Pink
      const Color(0xFF4CAF50), // Green
      const Color(0xFF9C27B0), // Purple
      const Color(0xFFFFEB3B), // Yellow
      const Color(0xFF00BCD4), // Cyan
      const Color(0xFFFF7E00), // Red-Orange
    ];

    for (int i = 0; i < 45; i++) {
      final angle = _random.nextDouble() * 2 * math.pi;
      final speed = 50.0 + _random.nextDouble() * 120.0;
      final color = colors[_random.nextInt(colors.length)];
      final size = 4.0 + _random.nextDouble() * 7.0;
      final shape = _random.nextInt(3); // 0: circle, 1: square, 2: strip
      final rotationSpeed = (_random.nextDouble() - 0.5) * 4 * math.pi;

      _particles.add(_ConfettiParticle(
        angle: angle,
        speed: speed,
        color: color,
        size: size,
        shape: shape,
        rotationSpeed: rotationSpeed,
      ));
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = _controller.value;
        final distanceCurve = Curves.easeOutBack.transform(progress);
        final opacityCurve = progress < 0.6 
            ? 1.0 
            : (1.0 - (progress - 0.6) / 0.4).clamp(0.0, 1.0);
        final scaleCurve = (1.0 - progress).clamp(0.0, 1.0);

        return Stack(
          alignment: Alignment.center,
          children: _particles.map((p) {
            final x = math.cos(p.angle) * p.speed * distanceCurve;
            final y = math.sin(p.angle) * p.speed * distanceCurve;
            final rotation = p.rotationSpeed * progress;

            return Transform.translate(
              offset: Offset(x, y),
              child: Transform.rotate(
                angle: rotation,
                child: Opacity(
                  opacity: opacityCurve,
                  child: Transform.scale(
                    scale: scaleCurve,
                    child: _buildParticleShape(p),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildParticleShape(_ConfettiParticle p) {
    if (p.shape == 0) {
      return Container(
        width: p.size,
        height: p.size,
        decoration: BoxDecoration(
          color: p.color,
          shape: BoxShape.circle,
        ),
      );
    } else if (p.shape == 1) {
      return Container(
        width: p.size,
        height: p.size,
        color: p.color,
      );
    } else {
      return Container(
        width: p.size * 1.5,
        height: p.size * 0.6,
        decoration: BoxDecoration(
          color: p.color,
          borderRadius: BorderRadius.circular(1),
        ),
      );
    }
  }
}

class _ConfettiParticle {
  final double angle;
  final double speed;
  final Color color;
  final double size;
  final int shape;
  final double rotationSpeed;

  _ConfettiParticle({
    required this.angle,
    required this.speed,
    required this.color,
    required this.size,
    required this.shape,
    required this.rotationSpeed,
  });
}
