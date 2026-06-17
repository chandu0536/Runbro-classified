import '../models/car_listing.dart';

class AppData {
  static final Set<String> registeredPhones = {
    '9876543210',
    '9999999999',
    '8888888888',
    '1234567890',
  };

  static const List<Map<String, dynamic>> categories = [
    {
      'label': 'Vehicles',
      'count': '25,432',
      'image': 'assets/categories/vehicles.jpeg',
      'icon': '🚗',
    },
    {
      'label': 'Mobiles',
      'count': '18,765',
      'image': 'assets/categories/mobiles.jpeg',
      'icon': '📱',
    },
    {
      'label': 'Bikes',
      'count': '12,543',
      'image': 'assets/categories/bikes.jpeg',
      'icon': '🏍️',
    },
    {
      'label': 'Electronics',
      'count': '22,112',
      'image': 'assets/categories/electronice.jpeg',
      'icon': '💻',
    },
    {
      'label': 'Furniture',
      'count': '9,876',
      'image': 'assets/categories/furniture.jpeg',
      'icon': '🛋️',
    },
    {
      'label': 'Fashion',
      'count': '31,245',
      'image': 'assets/categories/fashion.jpeg',
      'icon': '👗',
    },
    {
      'label': 'Home & Living',
      'count': '14,567',
      'image': 'assets/categories/home & living.jpeg',
      'icon': '🏡',
    },
    {
      'label': 'Books',
      'count': '8,432',
      'image': 'assets/categories/books.jpeg',
      'icon': '📚',
    },
    {
      'label': 'Jobs',
      'count': '3,245',
      'image': 'assets/categories/jobs.jpeg',
      'icon': '🔧',
      'unit': 'jobs',
    },
    {
      'label': 'Services',
      'count': '6,789',
      'image': 'assets/categories/services.jpeg',
      'icon': '⚙️',
    },
    {
      'label': 'Pets',
      'count': '1,987',
      'image': 'assets/categories/pets (1).jpeg',
      'icon': '🐾',
    },
    {
      'label': 'Kids',
      'count': '2,134',
      'image': 'assets/categories/kids.jpeg',
      'icon': '🧸',
    },
  ];


  static const List<CarListing> carListings = [
    CarListing(
      title: 'Maruti Suzuki Swift',
      price: '₹4,25,000',
      year: 'VXI 2018',
      km: 45000,
      fuel: 'Petrol',
      transmission: 'Manual',
      location: 'Hyderabad',
      timeAgo: '2h ago',
      badge: 'FEATURED',
      imagePath: 'assets/images/swift_car_main.png',
    ),
    CarListing(
      title: 'Hyundai Venue',
      price: '₹7,45,000',
      year: 'SX 2021',
      km: 32000,
      fuel: 'Petrol',
      transmission: 'Manual',
      location: 'Hyderabad',
      timeAgo: '3h ago',
      imagePath: 'https://images.unsplash.com/photo-1583121274602-3e2820c69888?auto=format&fit=crop&q=80&w=400',
    ),
    CarListing(
      title: 'Kia Seltos',
      price: '₹8,75,000',
      year: 'HTK Plus 2020',
      km: 38000,
      fuel: 'Diesel',
      transmission: 'Manual',
      location: 'Hyderabad',
      timeAgo: '4h ago',
      imagePath: 'https://images.unsplash.com/photo-1605559424843-9e4c228bf1c2?auto=format&fit=crop&q=80&w=400',
    ),
    CarListing(
      title: 'Honda City',
      price: '₹6,25,000',
      year: 'V 2019',
      km: 50000,
      fuel: 'Petrol',
      transmission: 'Manual',
      location: 'Hyderabad',
      timeAgo: '5h ago',
      imagePath: 'https://images.unsplash.com/photo-1606016159991-dfe4f2746ad5?auto=format&fit=crop&q=80&w=400',
    ),
    CarListing(
      title: 'Tata Nexon',
      price: '₹6,80,000',
      year: 'XZ+ 2021',
      km: 28000,
      fuel: 'Petrol',
      transmission: 'Manual',
      location: 'Hyderabad',
      timeAgo: '6h ago',
      imagePath: 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&q=80&w=400',
    ),
    CarListing(
      title: 'Mahindra XUV500',
      price: '₹5,50,000',
      year: 'W8 2017',
      km: 65000,
      fuel: 'Diesel',
      transmission: 'Manual',
      location: 'Hyderabad',
      timeAgo: '7h ago',
      imagePath: 'https://images.unsplash.com/photo-1617814076367-b759c7d7e738?auto=format&fit=crop&q=80&w=400',
    ),
  ];

  static const List<CarListing> mobileListings = [
    CarListing(
      title: 'iPhone 15 Pro Max',
      price: '₹1,24,900',
      year: '256 GB',
      km: 100,
      fuel: 'iOS',
      transmission: '1 Year Warranty',
      location: 'Hyderabad',
      timeAgo: '1h ago',
      badge: 'FEATURED',
      imagePath: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400&auto=format&fit=crop',
    ),
    CarListing(
      title: 'Samsung Galaxy S24 Ultra',
      price: '₹1,09,999',
      year: '512 GB',
      km: 98,
      fuel: 'Android',
      transmission: '9 Months Warranty',
      location: 'Hyderabad',
      timeAgo: '3h ago',
      badge: 'TRUSTED',
      imagePath: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400&auto=format&fit=crop',
    ),
    CarListing(
      title: 'OnePlus 12',
      price: '₹54,999',
      year: '256 GB',
      km: 99,
      fuel: 'Android',
      transmission: '11 Months Warranty',
      location: 'Secunderabad',
      timeAgo: '4h ago',
      imagePath: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400&auto=format&fit=crop',
    ),
    CarListing(
      title: 'Google Pixel 8 Pro',
      price: '₹79,900',
      year: '128 GB',
      km: 100,
      fuel: 'Android',
      transmission: 'Local Warranty',
      location: 'Hyderabad',
      timeAgo: '5h ago',
      badge: 'NEW',
      imagePath: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400&auto=format&fit=crop',
    ),
    CarListing(
      title: 'iPhone 14',
      price: '₹52,999',
      year: '128 GB',
      km: 92,
      fuel: 'iOS',
      transmission: 'Out of Warranty',
      location: 'Hyderabad',
      timeAgo: '6h ago',
      imagePath: 'https://images.unsplash.com/photo-1616348436168-de43ad0db179?w=400&auto=format&fit=crop',
    ),
    CarListing(
      title: 'Redmi Note 13 Pro+',
      price: '₹28,999',
      year: '256 GB',
      km: 95,
      fuel: 'Android',
      transmission: '6 Months Warranty',
      location: 'Hyderabad',
      timeAgo: '1d ago',
      imagePath: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400&auto=format&fit=crop',
    ),
    CarListing(
      title: 'Vivo V29 Pro',
      price: '₹35,999',
      year: '256 GB',
      km: 97,
      fuel: 'Android',
      transmission: '8 Months Warranty',
      location: 'Hyderabad',
      timeAgo: '2d ago',
      imagePath: 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=400&auto=format&fit=crop',
    ),
    CarListing(
      title: 'Realme GT 5 Pro',
      price: '₹42,999',
      year: '512 GB',
      km: 98,
      fuel: 'Android',
      transmission: '10 Months Warranty',
      location: 'Secunderabad',
      timeAgo: '3d ago',
      imagePath: 'https://images.unsplash.com/photo-1574944985070-8f3ebc6b79d2?w=400&auto=format&fit=crop',
    ),
  ];

  // ── Generic category listings ──────────────────────────────────────────────

  static const List<Map<String, dynamic>> bikeListings = [
    {'title': 'Royal Enfield Classic 350', 'price': '₹1,65,000', 'sub': '2021 • 12,000 km', 'tag': 'Cruiser', 'location': 'Hyderabad', 'time': '1h ago', 'badge': 'FEATURED', 'image': 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=400&auto=format&fit=crop'},
    {'title': 'KTM Duke 390', 'price': '₹2,25,000', 'sub': '2022 • 8,500 km', 'tag': 'Sports', 'location': 'Hyderabad', 'time': '2h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?w=400&auto=format&fit=crop'},
    {'title': 'Bajaj Pulsar NS200', 'price': '₹95,000', 'sub': '2020 • 22,000 km', 'tag': 'Sports', 'location': 'Secunderabad', 'time': '3h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1609630875171-b1321377ee65?w=400&auto=format&fit=crop'},
    {'title': 'Honda CB Shine', 'price': '₹55,000', 'sub': '2019 • 35,000 km', 'tag': 'Commuter', 'location': 'Hyderabad', 'time': '4h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1449426468159-d96dbf08f19f?w=400&auto=format&fit=crop'},
    {'title': 'Yamaha R15 V4', 'price': '₹1,45,000', 'sub': '2022 • 9,000 km', 'tag': 'Sports', 'location': 'Hyderabad', 'time': '5h ago', 'badge': 'TRUSTED', 'image': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&auto=format&fit=crop'},
    {'title': 'Hero Splendor Plus', 'price': '₹42,000', 'sub': '2018 • 48,000 km', 'tag': 'Commuter', 'location': 'Hyderabad', 'time': '6h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1571068316344-75bc76f77890?w=400&auto=format&fit=crop'},
    {'title': 'TVS Apache RTR 200', 'price': '₹85,000', 'sub': '2021 • 18,000 km', 'tag': 'Sports', 'location': 'Hyderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1591637333184-19aa84b3e01f?w=400&auto=format&fit=crop'},
    {'title': 'Suzuki Gixxer 250', 'price': '₹1,20,000', 'sub': '2020 • 14,000 km', 'tag': 'Sports', 'location': 'Secunderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1601758174493-45d0a4d3e407?w=400&auto=format&fit=crop'},
    {'title': 'Jawa 42 Bobber', 'price': '₹1,80,000', 'sub': '2023 • 4,500 km', 'tag': 'Cruiser', 'location': 'Hyderabad', 'time': '2d ago', 'badge': 'NEW', 'image': 'https://images.unsplash.com/photo-1580310614729-ccd69652491d?w=400&auto=format&fit=crop'},
  ];

  static const List<Map<String, dynamic>> electronicsListings = [
    {'title': 'MacBook Air M2', 'price': '₹72,000', 'sub': '8GB RAM • 256GB SSD', 'tag': 'Laptop', 'location': 'Hyderabad', 'time': '1h ago', 'badge': 'FEATURED', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400&auto=format&fit=crop'},
    {'title': 'Sony Bravia 55" 4K TV', 'price': '₹38,000', 'sub': 'Smart TV • 2022', 'tag': 'TV', 'location': 'Hyderabad', 'time': '2h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1593305841991-05c297ba4575?w=400&auto=format&fit=crop'},
    {'title': 'Apple Watch Series 9', 'price': '₹28,000', 'sub': '45mm • GPS', 'tag': 'Wearable', 'location': 'Hyderabad', 'time': '3h ago', 'badge': 'TRUSTED', 'image': 'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=400&auto=format&fit=crop'},
    {'title': 'Dell Inspiron 15 3520', 'price': '₹32,000', 'sub': 'i5 12th Gen • 8GB', 'tag': 'Laptop', 'location': 'Secunderabad', 'time': '4h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1496181130204-7552cc14bc4b?w=400&auto=format&fit=crop'},
    {'title': 'Sony WH-1000XM5', 'price': '₹18,500', 'sub': 'Noise Cancelling', 'tag': 'Audio', 'location': 'Hyderabad', 'time': '5h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&auto=format&fit=crop'},
    {'title': 'Canon EOS 200D II', 'price': '₹42,000', 'sub': '24.1MP • With Kit Lens', 'tag': 'Camera', 'location': 'Hyderabad', 'time': '6h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400&auto=format&fit=crop'},
    {'title': 'iPad Air 5th Gen', 'price': '₹55,000', 'sub': '64GB • Wi-Fi', 'tag': 'Tablet', 'location': 'Hyderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400&auto=format&fit=crop'},
    {'title': 'Samsung 32" Curved Monitor', 'price': '₹14,500', 'sub': '75Hz • Full HD', 'tag': 'Monitor', 'location': 'Hyderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1527443224154-c4a573d18712?w=400&auto=format&fit=crop'},
    {'title': 'PlayStation 5 Disc Edition', 'price': '₹38,000', 'sub': 'With 2 Controllers', 'tag': 'Gaming', 'location': 'Secunderabad', 'time': '2d ago', 'badge': 'NEW', 'image': 'https://images.unsplash.com/photo-1607853202273-797f1c22a38e?w=400&auto=format&fit=crop'},
  ];

  static const List<Map<String, dynamic>> fashionListings = [
    {'title': 'Levi\'s 511 Slim Jeans', 'price': '₹1,800', 'sub': 'Size 32 • Like New', 'tag': 'Jeans', 'location': 'Hyderabad', 'time': '1h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=400&auto=format&fit=crop'},
    {'title': 'Nike Air Max 270', 'price': '₹4,500', 'sub': 'UK 9 • Worn Twice', 'tag': 'Footwear', 'location': 'Hyderabad', 'time': '2h ago', 'badge': 'FEATURED', 'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&auto=format&fit=crop'},
    {'title': 'Zara Floral Dress', 'price': '₹1,200', 'sub': 'Size M • Good Condition', 'tag': 'Dress', 'location': 'Hyderabad', 'time': '3h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=400&auto=format&fit=crop'},
    {'title': 'Allen Solly Formal Shirt', 'price': '₹800', 'sub': 'Size L • Barely Used', 'tag': 'Shirts', 'location': 'Secunderabad', 'time': '4h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=400&auto=format&fit=crop'},
    {'title': 'Michael Kors Handbag', 'price': '₹6,500', 'sub': 'Brown • Genuine Leather', 'tag': 'Bags', 'location': 'Hyderabad', 'time': '5h ago', 'badge': 'TRUSTED', 'image': 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=400&auto=format&fit=crop'},
    {'title': 'Ray-Ban Wayfarer', 'price': '₹3,200', 'sub': 'Black Frame • With Case', 'tag': 'Accessories', 'location': 'Hyderabad', 'time': '6h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400&auto=format&fit=crop'},
    {'title': 'H&M Jogger Pants', 'price': '₹600', 'sub': 'Size L • Good Condition', 'tag': 'Trousers', 'location': 'Hyderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1473966968600-fa801b869a1a?w=400&auto=format&fit=crop'},
    {'title': 'Adidas Ultraboost 22', 'price': '₹5,500', 'sub': 'UK 8 • Used 3 Times', 'tag': 'Footwear', 'location': 'Hyderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=400&auto=format&fit=crop'},
    {'title': 'Fossil Gen 6 Smartwatch', 'price': '₹8,500', 'sub': 'Gold • Unisex', 'tag': 'Accessories', 'location': 'Secunderabad', 'time': '2d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&auto=format&fit=crop'},
  ];

  static const List<Map<String, dynamic>> homeLivingListings = [
    {'title': '3 Seater L-Shape Sofa', 'price': '₹18,000', 'sub': 'Grey Fabric • 2 Years Old', 'tag': 'Sofa', 'location': 'Hyderabad', 'time': '1h ago', 'badge': 'FEATURED', 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&auto=format&fit=crop'},
    {'title': 'Usha Tower Fan', 'price': '₹2,800', 'sub': '3 Speed • Remote Control', 'tag': 'Appliances', 'location': 'Hyderabad', 'time': '2h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&auto=format&fit=crop'},
    {'title': 'Godrej Refrigerator 350L', 'price': '₹14,000', 'sub': 'Double Door • 4 Years Old', 'tag': 'Appliances', 'location': 'Secunderabad', 'time': '3h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1571175443880-49e1d25b2bc5?w=400&auto=format&fit=crop'},
    {'title': 'Wooden Dining Table (6 Seater)', 'price': '₹22,000', 'sub': 'Teak Wood • Like New', 'tag': 'Furniture', 'location': 'Hyderabad', 'time': '4h ago', 'badge': 'TRUSTED', 'image': 'https://images.unsplash.com/photo-1549187774-b4e9b0445b41?w=400&auto=format&fit=crop'},
    {'title': 'LG Washing Machine 7kg', 'price': '₹12,500', 'sub': 'Fully Automatic • 2020', 'tag': 'Appliances', 'location': 'Hyderabad', 'time': '5h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1626806787461-102c1bfaaea1?w=400&auto=format&fit=crop'},
    {'title': 'Curtains Set (3 Panels)', 'price': '₹1,500', 'sub': 'Brown • 7ft Length', 'tag': 'Decor', 'location': 'Hyderabad', 'time': '6h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1615529328331-f8917597711f?w=400&auto=format&fit=crop'},
    {'title': 'Steel Wardrobe 4 Door', 'price': '₹8,500', 'sub': 'Mirror • Good Condition', 'tag': 'Furniture', 'location': 'Hyderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1558997519-83ea9252edf8?w=400&auto=format&fit=crop'},
    {'title': 'Prestige Induction Cooktop', 'price': '₹1,800', 'sub': '2000W • 1 Year Old', 'tag': 'Kitchen', 'location': 'Secunderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400&auto=format&fit=crop'},
    {'title': 'Wall Clock Set', 'price': '₹950', 'sub': 'Wooden Frame • Set of 3', 'tag': 'Decor', 'location': 'Hyderabad', 'time': '2d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1574610758825-3a4e83e29044?w=400&auto=format&fit=crop'},
  ];

  static const List<Map<String, dynamic>> booksListings = [
    {'title': 'Atomic Habits – James Clear', 'price': '₹220', 'sub': 'Self-Help • Good Condition', 'tag': 'Self-Help', 'location': 'Hyderabad', 'time': '1h ago', 'badge': 'FEATURED', 'image': 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&auto=format&fit=crop'},
    {'title': 'NCERT Class 12 Physics Set', 'price': '₹180', 'sub': 'Set of 2 • Slightly Used', 'tag': 'Academic', 'location': 'Hyderabad', 'time': '2h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=400&auto=format&fit=crop'},
    {'title': 'Rich Dad Poor Dad', 'price': '₹150', 'sub': 'Finance • Good Condition', 'tag': 'Finance', 'location': 'Secunderabad', 'time': '3h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400&auto=format&fit=crop'},
    {'title': 'The Alchemist – Paulo Coelho', 'price': '₹120', 'sub': 'Novel • Like New', 'tag': 'Novel', 'location': 'Hyderabad', 'time': '4h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&auto=format&fit=crop'},
    {'title': 'JEE Advanced Previous Papers', 'price': '₹350', 'sub': '10 Years • Set of 3', 'tag': 'Academic', 'location': 'Hyderabad', 'time': '5h ago', 'badge': 'TRUSTED', 'image': 'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=400&auto=format&fit=crop'},
    {'title': 'Harry Potter Box Set (7 Books)', 'price': '₹2,200', 'sub': 'Fantasy • Good Condition', 'tag': 'Novel', 'location': 'Hyderabad', 'time': '6h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1463320726281-696a485928c7?w=400&auto=format&fit=crop'},
    {'title': 'Python for Beginners', 'price': '₹280', 'sub': 'Programming • Barely Used', 'tag': 'Technical', 'location': 'Hyderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1515879218367-8466d910aaa4?w=400&auto=format&fit=crop'},
    {'title': 'Think and Grow Rich', 'price': '₹130', 'sub': 'Self-Help • Good Condition', 'tag': 'Self-Help', 'location': 'Secunderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=400&auto=format&fit=crop'},
    {'title': 'The Psychology of Money', 'price': '₹200', 'sub': 'Finance • Like New', 'tag': 'Finance', 'location': 'Hyderabad', 'time': '2d ago', 'badge': 'NEW', 'image': 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=400&auto=format&fit=crop'},
  ];

  static const List<Map<String, dynamic>> jobsListings = [
    {'title': 'Flutter Developer (2–4 yrs)', 'price': '₹8–14 LPA', 'sub': 'Full-time • Remote', 'tag': 'IT', 'location': 'Hyderabad', 'time': '1h ago', 'badge': 'FEATURED', 'image': 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=400&auto=format&fit=crop'},
    {'title': 'Sales Executive', 'price': '₹3–5 LPA', 'sub': 'Full-time • On-site', 'tag': 'Sales', 'location': 'Hyderabad', 'time': '2h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1521737711867-e3b97375f902?w=400&auto=format&fit=crop'},
    {'title': 'Graphic Designer', 'price': '₹4–7 LPA', 'sub': 'Full-time • Hybrid', 'tag': 'Design', 'location': 'Hyderabad', 'time': '3h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1611532736597-de2d4265fba3?w=400&auto=format&fit=crop'},
    {'title': 'Data Analyst (Fresher OK)', 'price': '₹4–6 LPA', 'sub': 'Full-time • On-site', 'tag': 'IT', 'location': 'Secunderabad', 'time': '4h ago', 'badge': 'TRUSTED', 'image': 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=400&auto=format&fit=crop'},
    {'title': 'Delivery Boy (Part-time)', 'price': '₹15,000/mo', 'sub': 'Part-time • Bike Required', 'tag': 'Delivery', 'location': 'Hyderabad', 'time': '5h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1616763355548-1b606f439f86?w=400&auto=format&fit=crop'},
    {'title': 'Teacher – Math (CBSE)', 'price': '₹3–5 LPA', 'sub': 'Full-time • On-site', 'tag': 'Teaching', 'location': 'Hyderabad', 'time': '6h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1509062522246-3755977927d7?w=400&auto=format&fit=crop'},
    {'title': 'Receptionist (Female)', 'price': '₹2.5–3.5 LPA', 'sub': 'Full-time • On-site', 'tag': 'Admin', 'location': 'Hyderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1586473219010-2ffc57b0d282?w=400&auto=format&fit=crop'},
    {'title': 'Chef – Continental', 'price': '₹4–6 LPA', 'sub': 'Full-time • Hotel', 'tag': 'Hospitality', 'location': 'Hyderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400&auto=format&fit=crop'},
    {'title': 'UI/UX Designer (3+ yrs)', 'price': '₹10–16 LPA', 'sub': 'Full-time • Remote', 'tag': 'Design', 'location': 'Secunderabad', 'time': '2d ago', 'badge': 'NEW', 'image': 'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=400&auto=format&fit=crop'},
  ];

  static const List<Map<String, dynamic>> servicesListings = [
    {'title': 'AC Repair & Service', 'price': '₹499', 'sub': 'All Brands • Same Day', 'tag': 'AC Service', 'location': 'Hyderabad', 'time': '1h ago', 'badge': 'FEATURED', 'image': 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=400&auto=format&fit=crop'},
    {'title': 'House Deep Cleaning', 'price': '₹1,999', 'sub': '3BHK • Professional Team', 'tag': 'Cleaning', 'location': 'Hyderabad', 'time': '2h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&auto=format&fit=crop'},
    {'title': 'Plumber – Urgent Available', 'price': '₹299 visit', 'sub': 'Leakage & Fitting', 'tag': 'Plumbing', 'location': 'Hyderabad', 'time': '3h ago', 'badge': 'TRUSTED', 'image': 'https://images.unsplash.com/photo-1607400201889-565b1ee75f8e?w=400&auto=format&fit=crop'},
    {'title': 'Electrician Services', 'price': '₹249 visit', 'sub': 'Wiring, Switches & Fans', 'tag': 'Electrical', 'location': 'Secunderabad', 'time': '4h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=400&auto=format&fit=crop'},
    {'title': 'Packers & Movers', 'price': '₹3,500+', 'sub': 'Local Shifting • Insured', 'tag': 'Moving', 'location': 'Hyderabad', 'time': '5h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1600880292203-757bb62b4baf?w=400&auto=format&fit=crop'},
    {'title': 'Yoga & Fitness Trainer', 'price': '₹2,000/mo', 'sub': 'Home Visit • Certified', 'tag': 'Fitness', 'location': 'Hyderabad', 'time': '6h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1575052814086-f385e2e2ad1b?w=400&auto=format&fit=crop'},
    {'title': 'Car Washing at Home', 'price': '₹199/wash', 'sub': 'Interior + Exterior', 'tag': 'Car Care', 'location': 'Hyderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=400&auto=format&fit=crop'},
    {'title': 'Laptop Repair – Home Visit', 'price': '₹399+', 'sub': 'All Brands • Same Day', 'tag': 'Tech Repair', 'location': 'Hyderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1588702547923-7093a6c3ba33?w=400&auto=format&fit=crop'},
    {'title': 'Photography (Events)', 'price': '₹5,000/day', 'sub': 'DSLR • Edited Delivery', 'tag': 'Photography', 'location': 'Secunderabad', 'time': '2d ago', 'badge': 'NEW', 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400&auto=format&fit=crop'},
  ];

  static const List<Map<String, dynamic>> petsListings = [
    {'title': 'Golden Retriever Puppy', 'price': '₹18,000', 'sub': '2 Months • Vaccinated', 'tag': 'Dogs', 'location': 'Hyderabad', 'time': '1h ago', 'badge': 'FEATURED', 'image': 'https://images.unsplash.com/photo-1552053831-71594a27632d?w=400&auto=format&fit=crop'},
    {'title': 'Persian Cat (Female)', 'price': '₹12,000', 'sub': '4 Months • Healthy', 'tag': 'Cats', 'location': 'Hyderabad', 'time': '2h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1548802673-380ab8ebc7b7?w=400&auto=format&fit=crop'},
    {'title': 'Labrador Male Puppy', 'price': '₹14,000', 'sub': '45 Days • KCI Registered', 'tag': 'Dogs', 'location': 'Secunderabad', 'time': '3h ago', 'badge': 'TRUSTED', 'image': 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=400&auto=format&fit=crop'},
    {'title': 'Budgerigar Pair (Budgie)', 'price': '₹1,200', 'sub': '6 Months • With Cage', 'tag': 'Birds', 'location': 'Hyderabad', 'time': '4h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1552728089-57bdde30beb3?w=400&auto=format&fit=crop'},
    {'title': 'Aquarium Setup (3 Feet)', 'price': '₹4,500', 'sub': 'With Fish & Equipment', 'tag': 'Fish', 'location': 'Hyderabad', 'time': '5h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1535591273668-578e31182c4f?w=400&auto=format&fit=crop'},
    {'title': 'Shih Tzu Puppy', 'price': '₹22,000', 'sub': '60 Days • Vaccinated', 'tag': 'Dogs', 'location': 'Hyderabad', 'time': '6h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1612195583950-b8fd34c87093?w=400&auto=format&fit=crop'},
    {'title': 'Maine Coon Kitten', 'price': '₹25,000', 'sub': '3 Months • Pedigree', 'tag': 'Cats', 'location': 'Hyderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?w=400&auto=format&fit=crop'},
    {'title': 'Cockatiel Pair', 'price': '₹3,000', 'sub': '8 Months • Tame', 'tag': 'Birds', 'location': 'Secunderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1552728089-57bdde30beb3?w=400&auto=format&fit=crop'},
    {'title': 'Pet Carrier Bag (Large)', 'price': '₹1,200', 'sub': 'Airline Approved • Good', 'tag': 'Accessories', 'location': 'Hyderabad', 'time': '2d ago', 'badge': 'NEW', 'image': 'https://images.unsplash.com/photo-1601758174493-45d0a4d3e407?w=400&auto=format&fit=crop'},
  ];

  static const List<Map<String, dynamic>> kidsListings = [
    {'title': 'Baby Pram (Mee Mee)', 'price': '₹3,500', 'sub': '0–3 Yrs • Good Condition', 'tag': 'Baby Gear', 'location': 'Hyderabad', 'time': '1h ago', 'badge': 'FEATURED', 'image': 'https://images.unsplash.com/photo-1584464491033-06628f3a6b7b?w=400&auto=format&fit=crop'},
    {'title': 'LEGO Creator Set (500 pcs)', 'price': '₹2,200', 'sub': '6+ Yrs • Complete', 'tag': 'Toys', 'location': 'Hyderabad', 'time': '2h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1587654780291-39c9404d746b?w=400&auto=format&fit=crop'},
    {'title': 'Kids Bicycle 16" (5–8 yrs)', 'price': '₹2,800', 'sub': 'With Training Wheels', 'tag': 'Outdoor', 'location': 'Secunderabad', 'time': '3h ago', 'badge': 'TRUSTED', 'image': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&auto=format&fit=crop'},
    {'title': 'School Bag Set (Class 1–5)', 'price': '₹550', 'sub': 'Disney Theme • Good', 'tag': 'School', 'location': 'Hyderabad', 'time': '4h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&auto=format&fit=crop'},
    {'title': 'Baby Cot Wooden (0–2 yrs)', 'price': '₹4,500', 'sub': 'With Mattress • Good', 'tag': 'Baby Gear', 'location': 'Hyderabad', 'time': '5h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1586015555751-63bb77f4322a?w=400&auto=format&fit=crop'},
    {'title': 'Board Games Collection', 'price': '₹1,800', 'sub': '8+ Yrs • Set of 5', 'tag': 'Games', 'location': 'Hyderabad', 'time': '6h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1610890716171-6b1bb98ffd09?w=400&auto=format&fit=crop'},
    {'title': 'Kids Wooden Study Table', 'price': '₹3,200', 'sub': '5+ Yrs • Good Condition', 'tag': 'Furniture', 'location': 'Hyderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1567016432779-094069958ea5?w=400&auto=format&fit=crop'},
    {'title': 'Baby Walker (Chicco)', 'price': '₹1,500', 'sub': '6–18 Months • Good', 'tag': 'Baby Gear', 'location': 'Secunderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1519689680058-324335c77eba?w=400&auto=format&fit=crop'},
    {'title': 'RC Car Set (Remote Controlled)', 'price': '₹1,800', 'sub': '6+ Yrs • Working', 'tag': 'Toys', 'location': 'Hyderabad', 'time': '2d ago', 'badge': 'NEW', 'image': 'https://images.unsplash.com/photo-1566576912321-d58ddd7a6088?w=400&auto=format&fit=crop'},
  ];

  // ── Furniture listings ────────────────────────────────────────────────────

  static const List<Map<String, dynamic>> furnitureListings = [
    {'title': '3 Seater Fabric Sofa', 'price': '₹18,500', 'sub': 'Grey • 2 Years Old', 'tag': 'Sofa', 'location': 'Hyderabad', 'time': '1h ago', 'badge': 'FEATURED', 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&auto=format&fit=crop'},
    {'title': 'Teak Wood Dining Table (6 Seater)', 'price': '₹22,000', 'sub': 'With Chairs • Like New', 'tag': 'Dining', 'location': 'Hyderabad', 'time': '2h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1549187774-b4e9b0445b41?w=400&auto=format&fit=crop'},
    {'title': '4-Door Steel Wardrobe', 'price': '₹8,500', 'sub': 'With Mirror • Good Condition', 'tag': 'Wardrobe', 'location': 'Secunderabad', 'time': '3h ago', 'badge': 'TRUSTED', 'image': 'https://images.unsplash.com/photo-1558997519-83ea9252edf8?w=400&auto=format&fit=crop'},
    {'title': 'Queen Size Wooden Bed', 'price': '₹15,000', 'sub': 'With Storage • 3 Years', 'tag': 'Bed', 'location': 'Hyderabad', 'time': '4h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400&auto=format&fit=crop'},
    {'title': '5-Shelf Wooden Bookcase', 'price': '₹4,200', 'sub': 'Dark Walnut • Like New', 'tag': 'Bookshelf', 'location': 'Hyderabad', 'time': '5h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&auto=format&fit=crop'},
    {'title': 'Ergonomic Office Chair', 'price': '₹6,800', 'sub': 'Lumbar Support • Good', 'tag': 'Chair', 'location': 'Hyderabad', 'time': '6h ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=400&auto=format&fit=crop'},
    {'title': 'Wooden TV Unit (55" Fit)', 'price': '₹9,000', 'sub': 'With Cabinets • 2 Years', 'tag': 'TV Unit', 'location': 'Hyderabad', 'time': '1d ago', 'badge': '', 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&auto=format&fit=crop'},
    {'title': 'Shoe Rack (3 Tier)', 'price': '₹1,200', 'sub': 'Iron Frame • Good Condition', 'tag': 'Storage', 'location': 'Secunderabad', 'time': '2d ago', 'badge': 'NEW', 'image': 'https://images.unsplash.com/photo-1567016432779-094069958ea5?w=400&auto=format&fit=crop'},
  ];

  // ── Subcategory tabs per category ─────────────────────────────────────────

  static const Map<String, List<String>> categorySubcategories = {
    'Furniture': ['All', 'Sofa', 'Dining', 'Wardrobe', 'Bed', 'Bookshelf', 'Chair', 'TV Unit', 'Storage'],
    'Bikes': ['All', 'Cruiser', 'Sports', 'Commuter', 'Scooter'],
    'Electronics': ['All', 'Laptop', 'TV', 'Audio', 'Camera', 'Tablet', 'Gaming', 'Wearable'],
    'Fashion': ['All', 'Jeans', 'Dress', 'Shirts', 'Footwear', 'Bags', 'Accessories', 'Trousers'],
    'Home & Living': ['All', 'Sofa', 'Furniture', 'Appliances', 'Kitchen', 'Decor'],
    'Books': ['All', 'Academic', 'Novel', 'Self-Help', 'Finance', 'Technical'],
    'Jobs': ['All', 'IT', 'Sales', 'Design', 'Teaching', 'Admin', 'Hospitality', 'Delivery'],
    'Services': ['All', 'AC Service', 'Cleaning', 'Plumbing', 'Electrical', 'Moving', 'Fitness', 'Tech Repair'],
    'Pets': ['All', 'Dogs', 'Cats', 'Birds', 'Fish', 'Accessories'],
    'Kids': ['All', 'Toys', 'Baby Gear', 'Outdoor', 'School', 'Games', 'Furniture'],
  };

  // Returns the generic listing map for any category
  static List<Map<String, dynamic>> getCategoryListings(String category) {
    switch (category.toLowerCase()) {
      case 'furniture': return furnitureListings;
      case 'bikes': return bikeListings;
      case 'electronics': return electronicsListings;
      case 'fashion': return fashionListings;
      case 'home & living': return homeLivingListings;
      case 'books': return booksListings;
      case 'jobs': return jobsListings;
      case 'services': return servicesListings;
      case 'pets': return petsListings;
      case 'kids': return kidsListings;
      default: return [];
    }
  }



  static const List<Map<String, dynamic>> popularSearches = [
    {'label': 'iPhone 13', 'icon': '🔥'},
    {'label': 'Royal Enfield', 'icon': '🔥'},
    {'label': 'Sofa', 'icon': '🔥'},
    {'label': 'MacBook', 'icon': '🔥'},
    {'label': 'Hyundai i20', 'icon': '🔥'},
  ];

  static const List<String> recentSearches = [
    'iPhone 13 128GB',
    'Maruti Suzuki Swift',
    'KTM Duke 390',
    '3 Seater Sofa',
    'MacBook Air M1',
  ];

  static const List<Map<String, dynamic>> homeRecommended = [
    {
      'title': 'Maruti Suzuki Swift VXI 2018',
      'price': '₹4,25,000',
      'location': 'Hyderabad',
      'category': 'Cars',
      'imageUrl': 'https://images.unsplash.com/photo-1619767886558-efdc259cde1a?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'iPhone 13 128GB',
      'price': '₹38,999',
      'location': 'Hyderabad',
      'category': 'Mobiles',
      'imageUrl': 'https://images.unsplash.com/photo-1616348436168-de43ad0db179?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'KTM Duke 390 2021',
      'price': '₹2,25,000',
      'location': 'Hyderabad',
      'category': 'Bikes',
      'imageUrl': 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': '3 Seater Sofa (Good Condition)',
      'price': '₹8,500',
      'location': 'Hyderabad',
      'category': 'Furniture',
      'imageUrl': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=400',
    },
  ];

  static const List<Map<String, dynamic>> homeNearbyDeals = [
    {
      'title': 'Samsung Galaxy S21 FE',
      'price': '₹24,999',
      'location': '1.2 km away',
      'category': 'Mobiles',
      'imageUrl': 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'Hero Sprint Cycle',
      'price': '₹3,200',
      'location': '1.5 km away',
      'category': 'Cycles',
      'imageUrl': 'https://images.unsplash.com/photo-1485965120184-e220f721d03e?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'Dell Inspiron 15',
      'price': '₹28,000',
      'location': '2 km away',
      'category': 'Laptops',
      'imageUrl': 'https://images.unsplash.com/photo-1496181130204-7552cc14bc4b?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'Sony Bravia 43" Smart TV',
      'price': '₹26,500',
      'location': '2.8 km away',
      'category': 'Electronics',
      'imageUrl': 'https://images.unsplash.com/photo-1593305841991-05c297ba4575?auto=format&fit=crop&q=80&w=400',
    },
  ];

  static const List<Map<String, dynamic>> searchSuggestions = [
    {
      'title': 'Hyundai i20 2020',
      'price': '₹6,20,000',
      'location': 'Hyderabad',
      'imageUrl': 'https://images.unsplash.com/photo-1619767886558-efdc259cde1a?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'iPhone 14 128GB',
      'price': '₹45,999',
      'location': 'Hyderabad',
      'imageUrl': 'https://images.unsplash.com/photo-1616348436168-de43ad0db179?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'Royal Enfield Classic 350 2021',
      'price': '₹1,65,000',
      'location': 'Hyderabad',
      'imageUrl': 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&q=80&w=400',
    },
    {
      'title': 'MacBook Air M1',
      'price': '₹59,999',
      'location': 'Hyderabad',
      'imageUrl': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=400',
    },
  ];

  static List<Map<String, dynamic>> myAds = [
    {
      'id': 'RB12345678',
      'title': 'iPhone 15 Pro Max',
      'price': '₹85,000',
      'negotiable': true,
      'location': 'Hyderabad, Telangana',
      'date': '18 May 2024',
      'views': 156,
      'chats': 12,
      'likes': 8,
      'status': 'Active',
      'category': 'Mobiles',
      'brand': 'Apple',
      'model': 'iPhone 15 Pro Max',
      'storage': '256 GB',
      'color': 'Natural Titanium',
      'description': 'Excellent condition. No scratches or dents. Original bill available. Box and charger included. Well maintained and barely used.',
      'images': [
        'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=400',
        'https://images.unsplash.com/photo-1598327105666-5b89351aff97?auto=format&fit=crop&q=80&w=400',
      ],
    },
    {
      'id': 'RB12345679',
      'title': 'Hyundai i20 Asta 2020',
      'price': '₹6,25,000',
      'negotiable': true,
      'location': 'Hyderabad, Telangana',
      'date': '10 May 2024',
      'views': 243,
      'chats': 21,
      'likes': 15,
      'status': 'Active',
      'category': 'Vehicles',
      'brand': 'Hyundai',
      'model': 'i20 Asta',
      'year': '2020',
      'fuel': 'Petrol',
      'transmission': 'Manual',
      'description': 'Top model Hyundai i20 Asta. Excellent driving dynamics, single owner, comprehensive insurance valid.',
      'images': [
        'https://images.unsplash.com/photo-1619767886558-efdc259cde1a?auto=format&fit=crop&q=80&w=400',
      ],
    },
    {
      'id': 'RB12345680',
      'title': '3 Seater Sofa',
      'price': '₹8,500',
      'negotiable': true,
      'location': 'Hyderabad, Telangana',
      'date': '05 May 2024',
      'views': 89,
      'chats': 7,
      'likes': 3,
      'status': 'Active',
      'category': 'Furniture',
      'description': 'Comfortable 3 seater sofa in grey fabric. No tears or stains, foam is intact.',
      'images': [
        'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=400',
      ],
    },
    {
      'id': 'RB12345681',
      'title': 'Apple Watch Series 8',
      'price': '₹22,000',
      'negotiable': false,
      'location': 'Hyderabad, Telangana',
      'date': '12 May 2024',
      'views': 312,
      'chats': 18,
      'likes': 11,
      'status': 'Sold',
      'category': 'Electronics',
      'description': 'Apple Watch Series 8 GPS 45mm. Aluminum case with Midnight sport band. Battery health 92%.',
      'images': [
        'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?auto=format&fit=crop&q=80&w=400',
      ],
    },
  ];

  static List<Map<String, dynamic>> wishlistItems = [
    {
      'id': '1',
      'title': 'iPhone 15 Pro Max',
      'price': '₹85,000',
      'location': 'Hyderabad',
      'time': 'Added 2 days ago',
      'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400&auto=format&fit=crop',
      'isFavorited': true,
    },
    {
      'id': '2',
      'title': 'Hyundai i20 2020',
      'price': '₹6,25,000',
      'location': 'Hyderabad',
      'time': 'Added 5 days ago',
      'image': 'https://images.unsplash.com/photo-1617788138017-80ad40651399?w=400&auto=format&fit=crop',
      'isFavorited': true,
    },
    {
      'id': '3',
      'title': 'MacBook Air M2',
      'price': '₹72,000',
      'priceDrop': '₹3,000',
      'tag': 'Price Dropped',
      'location': 'Visakhapatnam',
      'time': 'Added 5 days ago',
      'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400&auto=format&fit=crop',
      'isFavorited': true,
    },
    {
      'id': '4',
      'title': 'Sony Alpha A7 III',
      'price': '₹95,000',
      'location': 'Vijayawada',
      'time': 'Added 1 week ago',
      'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400&auto=format&fit=crop',
      'isFavorited': true,
    },
    {
      'id': '5',
      'title': '3 Seater Sofa',
      'price': '₹15,000',
      'location': 'Rajahmundry',
      'time': 'Added 1 week ago',
      'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&auto=format&fit=crop',
      'isFavorited': true,
    },
    {
      'id': '6',
      'title': 'Samsung Galaxy S24',
      'price': '₹54,999',
      'location': 'Hyderabad',
      'time': 'Added 2 weeks ago',
      'image': 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400&auto=format&fit=crop',
      'isFavorited': true,
    },
  ];

  static bool isItemFavorited(String title) {
    final normalized = _normalizeTitle(title);
    return wishlistItems.any((w) => _normalizeTitle(w['title'] as String? ?? '') == normalized && w['isFavorited'] == true);
  }

  static void toggleFavorite(String title, {String? price, String? location, String? image}) {
    final normalized = _normalizeTitle(title);
    final currentlyFavorited = isItemFavorited(title);
    final newStatus = !currentlyFavorited;

    // Search for all existing items that match this normalized title and update them
    bool found = false;
    for (int i = 0; i < wishlistItems.length; i++) {
      if (_normalizeTitle(wishlistItems[i]['title'] as String? ?? '') == normalized) {
        wishlistItems[i]['isFavorited'] = newStatus;
        found = true;
      }
    }

    // If not found and we want to favorite it, add it
    if (!found && newStatus) {
      wishlistItems.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'title': title,
        'price': price ?? '₹0',
        'location': location ?? 'Unknown',
        'time': 'Added just now',
        'image': image ?? '',
        'isFavorited': true,
      });
      // Also add the normalized alternative to wishlistItems if it's the Swift, to ensure perfect syncing
      if (normalized == 'maruti suzuki swift') {
        final alternativeTitle = title == 'Maruti Suzuki Swift' ? 'Maruti Suzuki Swift VXI 2018' : 'Maruti Suzuki Swift';
        wishlistItems.add({
          'id': (DateTime.now().millisecondsSinceEpoch + 1).toString(),
          'title': alternativeTitle,
          'price': price ?? '₹4,25,000',
          'location': location ?? 'Hyderabad',
          'time': 'Added just now',
          'image': image ?? 'assets/images/swift_car_main.png',
          'isFavorited': true,
        });
      }
    }
  }

  static String _normalizeTitle(String title) {
    String t = title.toLowerCase().trim();
    if (t.contains('maruti suzuki swift') || t.contains('swift vxi')) {
      return 'maruti suzuki swift';
    }
    return t;
  }
}

