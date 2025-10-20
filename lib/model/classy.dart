import 'motor.dart';

class Classy extends Motor {
  final Map<String, String> specs;

  Classy({
    required String name,
    required String image,
    required String desc,
    required int price,
    required this.specs,
  }) : super(name: name, image: image, desc: desc, price: price);

  @override
  String getCategory() {
    return "Kategori Classy: Desain unik dan stylish untuk gaya hidup modern.";
  }
}

final List<Classy> classies = [
  Classy(
    name: "Fazzio",
    image: "assets/fazzio.png",
    desc: "Skutik hybrid dengan desain stylish dan modern yang cocok untuk anak muda.",
    price: 22000000,
    specs: {
      'Mesin': '125cc',
      'Power': '6.2 kW',
      'Torsi': '10.6 Nm',
      'Tipe': 'Air Cooled 4-Stroke, SOHC',
    },
  ),
  Classy(
    name: "Grand Filano",
    image: "assets/grandfilano.png",
    desc: "The Next Level of Fashion. Skutik premium dengan desain mewah dan elegan.",
    price: 27000000,
    specs: {
      'Mesin': '125cc',
      'Power': '6.1 kW',
      'Torsi': '10.4 Nm',
      'Tipe': 'Air Cooled 4-Stroke, SOHC',
    },
  ),
];