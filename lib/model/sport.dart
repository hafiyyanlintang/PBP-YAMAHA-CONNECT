import 'motor.dart';

// Child class
class Sport extends Motor {
  final Map<String, String> specs;

  Sport({
    required String name,
    required String image,
    required String desc,
    required int price,
    required this.specs, 
  }) : super(name: name, image: image, desc: desc, price: price);

  @override
  String getCategory() {
    return "Kategori SPORT Yamaha: performa tinggi dan tampilan agresif.";
  }
}

final List<Sport> sports = [
  Sport(
    name: "XSR 155",
    image: "assets/xsr155.png",
    desc: "Motor sport retro modern dengan teknologi VVA 155cc.",
    price: 38000000,
    specs: {
      'Mesin': '155cc',
      'Power': '14.2 kW',
      'Torsi': '14.7 Nm',
      'Tipe': 'Liquid Cooled 4-Stroke, SOHC',
    },
  ),
  Sport(
    name: "R15",
    image: "assets/r15.png",
    desc: "Motor sport fairing 155cc dengan tampilan aerodinamis.",
    price: 42500000,
    specs: {
      'Mesin': '155cc',
      'Power': '14.2 kW',
      'Torsi': '14.7 Nm',
      'Tipe': 'Liquid Cooled 4-Stroke, SOHC',
    },
  ),
  Sport(
    name: "R25",
    image: "assets/r25.png",
    desc: "Motor sport 250cc DOHC bertenaga dan stabil di kecepatan tinggi.",
    price: 65000000,
    specs: {
      'Mesin': '250cc',
      'Power': '26.5 kW',
      'Torsi': '22.9 Nm',
      'Tipe': 'Liquid Cooled 4-Stroke, DOHC',
    },
  ),
  Sport(
    name: "MT 15",
    image: "assets/mt15.png",
    desc: "Streetfighter 155cc dengan gaya naked agresif.",
    price: 38000000,
    specs: {
      'Mesin': '155cc',
      'Power': '14.2 kW',
      'Torsi': '14.7 Nm',
      'Tipe': 'Liquid Cooled 4-Stroke, SOHC',
    },
  ),
  Sport(
    name: "MT 25",
    image: "assets/mt25.png",
    desc: "Motor naked 250cc dengan performa responsif dan handling ringan.",
    price: 64000000,
    specs: {
      'Mesin': '250cc',
      'Power': '26.5 kW',
      'Torsi': '22.9 Nm',
      'Tipe': 'Liquid Cooled 4-Stroke, DOHC',
    },
  ),
  Sport(
    name: "Vixion 155",
    image: "assets/vixion155.png",
    desc: "Motor sport legendaris dengan desain ramping dan efisien.",
    price: 31000000,
    specs: {
      'Mesin': '155cc',
      'Power': '14.2 kW',
      'Torsi': '14.7 Nm',
      'Tipe': 'Liquid Cooled 4-Stroke, SOHC',
    },
  ),
];