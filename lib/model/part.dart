class Part {
  final String name;
  final int price; 
  final String imagePath; 
  final String category; 
  Part({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.category,
  });
}


final List<Part> partsData = [
  Part(
    name: 'Kampas Rem Depan',
    price: 85000,
    imagePath: 'assets/kampas_rem.jpg', 
    category: 'Original',
  ),
  Part(
    name: 'Oli Yamalube Sport',
    price: 55000,
    imagePath: 'assets/part_oli.jpg', 
    category: 'Original',
  ),
  Part(
    name: 'Filter Udara NMAX',
    price: 45000,
    imagePath: 'assets/filter_udara.jpg', 
    category: 'Original',
  ),
  Part(
    name: 'Busi NGK CR8E',
    price: 25000,
    imagePath: 'assets/busi.jpg', 
    category: 'Original',
  ),
  Part(
    name: 'Shock Absorber Belakang',
    price: 350000,
    imagePath: 'assets/shock.jpg', 
    category: 'Aksesoris',
  ),
  Part(
    name: 'Rantai & Gear Set',
    price: 150000,
    imagePath: 'assets/rantai.jpg', 
    category: 'Original',
  ),
   Part(
    name: 'Handgrip Racing (Promo)',
    price: 75000,
    imagePath: 'assets/handgrip.png', 
    category: 'Promo',
  ),
  Part(
    name: 'Spion Variasi',
    price: 120000,
    imagePath: 'assets/spion.jpg', 
    category: 'Aksesoris',
  ),
];