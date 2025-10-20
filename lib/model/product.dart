class Product {
  String title;
  String imagePath;
  String description;

  Product(this.title, this.imagePath, this.description);
}

List<Product> products = [
  Product(
    "MAXI",
    "assets/maxi.png",
    "Kategori motor MAXI Yamaha",
  ),
  Product(
    "Matic",
    "assets/matic.png",
    "Kategori motor Matic Yamaha",
  ),
  Product(
    "Sport",
    "assets/sport.png",
    "Kategori motor Sport Yamaha",
  ),
  Product(
    "Classy",
    "assets/classy.png",
    "Kategori motor Classy Yamaha",
  ),
  Product(
    "Moped",
    "assets/moped.png",
    "Kategori motor Moped Yamaha",
  ),
];