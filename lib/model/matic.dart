import 'motor.dart';

// Child class
class Matic extends Motor {
  Matic({
    required String name,
    required String image,
    required String desc,
    required int price,
  }) : super(name: name, image: image, desc: desc, price: price);

  // Polymorphism: override method
  @override
  String getCategory() {
    return "Kategori Matic Yamaha: motor praktis dan efisien untuk harian.";
  }
}

// Contoh data
final List<Matic> matics = [
  Matic(
    name: "Mio M3",
    image: "assets/mio.png",
    desc: "Skutik 125cc yang lincah dan irit.",
    price: 17000000,
  ),
  Matic(
    name: "Fino 125",
    image: "assets/fino.png",
    desc: "Skutik bergaya retro dengan mesin 125cc.",
    price: 19000000,
  ),
];
