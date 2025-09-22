import 'motor.dart';

// Child class
class Maxi extends Motor {
  Maxi({
    required String name,
    required String image,
    required String desc,
    required int price,
  }) : super(name: name, image: image, desc: desc, price: price);

  // Polymorphism: override method
  @override
  String getCategory() {
    return "Kategori MAXI Yamaha: motor matic premium dengan desain elegan.";
  }
}

// Contoh data
final List<Maxi> maxis = [
  Maxi(
    name: "NMAX 155",
    image: "assets/nmax.png",
    desc: "Skutik premium dengan mesin 155cc VVA.",
    price: 32000000,
  ),
  Maxi(
    name: "XMAX 250",
    image: "assets/xmax.png",
    desc: "Skutik besar 250cc nyaman untuk touring.",
    price: 66000000,
  ),
];
