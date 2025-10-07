import 'motor.dart';

// Child class
class Classy extends Motor {
  Classy({
    required String name,
    required String image,
    required String desc,
    required int price,
  }) : super(name: name, image: image, desc: desc, price: price);

  @override
  String getCategory() {
    return "Kategori CLASSY Yamaha: motor matic dengan gaya elegan dan retro modern.";
  }
}

// Contoh data
final List<Classy> classies = [
  Classy(
    name: "Grand Filano",
    image: "assets/grandfilano.png",
    desc: "Motor matic stylish dengan mesin Blue Core Hybrid.",
    price: 27000000,
  ),
  Classy(
    name: "Fazzio",
    image: "assets/fazzio.png",
    desc: "Motor matic dengan desain unik dan teknologi Connected.",
    price: 25000000,
  ),
];
