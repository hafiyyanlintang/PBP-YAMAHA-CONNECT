import 'motor.dart';

// Child class
class Sport extends Motor {
  Sport({
    required String name,
    required String image,
    required String desc,
    required int price,
  }) : super(name: name, image: image, desc: desc, price: price);

  // Polymorphism: override method
  @override
  String getCategory() {
    return "Kategori SPORT Yamaha: performa tinggi dan tampilan agresif.";
  }
}

// Contoh data
final List<Sport> sports = [
  Sport(
    name: "XSR 155",
    image: "assets/xsr155.png",
    desc: "Motor sport retro modern dengan teknologi VVA 155cc.",
    price: 38000000,
  ),
  Sport(
    name: "R15",
    image: "assets/r15.png",
    desc: "Motor sport fairing 155cc dengan tampilan aerodinamis.",
    price: 42500000,
  ),
  Sport(
    name: "R25",
    image: "assets/r25.png",
    desc: "Motor sport 250cc DOHC bertenaga dan stabil di kecepatan tinggi.",
    price: 65000000,
  ),
  Sport(
    name: "MT 15",
    image: "assets/mt15.png",
    desc: "Streetfighter 155cc dengan gaya naked agresif.",
    price: 38000000,
  ),
  Sport(
    name: "MT 25",
    image: "assets/mt25.png",
    desc: "Motor naked 250cc dengan performa responsif dan handling ringan.",
    price: 64000000,
  ),
  Sport(
    name: "Vixion 155",
    image: "assets/vixion155.png",
    desc: "Motor sport legendaris dengan desain ramping dan efisien.",
    price: 31000000,
  ),
];
