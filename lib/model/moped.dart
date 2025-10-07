import 'motor.dart';

// Child class
class Moped extends Motor {
  Moped({
    required String name,
    required String image,
    required String desc,
    required int price,
  }) : super(name: name, image: image, desc: desc, price: price);

  @override
  String getCategory() {
    return "Kategori MOPED Yamaha: motor bebek tangguh dan irit bahan bakar.";
  }
}

// Contoh data
final List<Moped> mopeds = [
  Moped(
    name: "MX King 150",
    image: "assets/mxking150.png",
    desc: "Motor bebek sporty dengan mesin 150cc berperforma tinggi.",
    price: 26000000,
  ),
  Moped(
    name: "Jupiter Z1",
    image: "assets/jupiterz1.png",
    desc: "Motor bebek legendaris dengan mesin 115cc yang efisien.",
    price: 21000000,
  ),
  Moped(
    name: "Vega Force",
    image: "assets/vegaforce.png",
    desc: "Motor bebek tangguh untuk aktivitas harian.",
    price: 18000000,
  ),
];
