class CarListing {
  final String title;
  final String price;
  final String year;
  final int km;
  final String fuel;
  final String transmission;
  final String location;
  final String timeAgo;
  final String badge; // e.g. 'FEATURED', 'TRUSTED', ''
  final String imagePath; // placeholder
  final bool isWishlisted;

  const CarListing({
    required this.title,
    required this.price,
    required this.year,
    required this.km,
    required this.fuel,
    required this.transmission,
    required this.location,
    required this.timeAgo,
    this.badge = '',
    this.imagePath = '',
    this.isWishlisted = false,
  });
}
