import 'motor.dart';

class Moped extends Motor {
  final Map<String, String> specs;

  Moped({
    required String name,
    required String image,
    required String desc,
    required int price,
    required this.specs,
  }) : super(name: name, image: image, desc: desc, price: price);

  @override
  String getCategory() {
    return "Kategori Moped: Tangguh, irit, dan serbaguna untuk segala medan.";
  }
}

final List<Moped> mopeds = [
  Moped(
    name: "Jupiter Z1",
    image: "assets/jupiterz1.png",
    desc: "Motor bebek sporty dengan teknologi injeksi yang responsif dan bertenaga.",
    price: 19000000,
    specs: {
      'Mesin': '113.7cc',
      'Power': '7.4 kW / 7750 rpm',
      'Torsi': '9.8 Nm / 6750 rpm',
      'Tipe': 'Air Cooled 4-Stroke, SOHC',
      'Transmisi': '4-speed',
    },
  ),
  Moped(
    name: "Vega Force",
    image: "assets/vegaforce.png",
    desc: "Motor bebek yang bandel dan irit, pilihan tepat untuk kebutuhan sehari-hari.",
    price: 17000000,
    specs: {
      'Mesin': '114cc',
      'Power': '6.41 kW / 7000 rpm',
      'Torsi': '9.53 Nm / 5500 rpm',
      'Tipe': 'Air Cooled 4-Stroke, SOHC',
      'Transmisi': '4-speed',
    },
  ),
  Moped(
    name: "MX King 150",
    image: "assets/mxking150.png",
    desc:
        "The King of Street! Motor bebek sport 150cc dengan desain agresif, performa tinggi, dan handling mantap untuk pengendara sejati.",
    price: 27725000,
    specs: {
      'Mesin': '150cc, Liquid Cooled 4-Stroke, SOHC',
      'Power': '11.3 kW / 8500 rpm',
      'Torsi': '13.8 Nm / 7000 rpm',
      'Transmisi': '5-speed',
      'Kapasitas Tangki': '4.2 L',
    },
  ),
];
