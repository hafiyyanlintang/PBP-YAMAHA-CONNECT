import 'motor.dart';

class Matic extends Motor {
  final Map<String, String> specs;

  Matic({
    required String name,
    required String image,
    required String desc,
    required int price,
    required this.specs,
  }) : super(name: name, image: image, desc: desc, price: price);

  @override
  String getCategory() {
    return "Kategori Matic: lincah, irit, dan praktis untuk mobilitas harian.";
  }
}
final List<Matic> matics = [
  Matic(
    name: "Mio M3 125",
    image: "assets/mio.png",
    desc:
        "Motor matic serbaguna yang irit dan andal untuk aktivitas sehari-hari di perkotaan.",
    price: 18305000,
    specs: {
      'Mesin': '125cc',
      'Power': '7.0 kW / 8000 rpm',
      'Torsi': '9.6 Nm / 5500 rpm',
      'Tipe': 'Air Cooled 4-Stroke, SOHC',
    },
  ),
  Matic(
    name: "Gear 125",
    image: "assets/gear125.png",
    desc:
        "Matic multiguna dengan desain tangguh, pijakan kaki untuk anak, dan aksesoris lengkap.",
    price: 19045000,
    specs: {
      'Mesin': '125cc Blue Core',
      'Power': '7.0 kW / 8000 rpm',
      'Torsi': '9.5 Nm / 5500 rpm',
      'Tipe': 'Air Cooled 4-Stroke, SOHC',
    },
  ),
  Matic(
    name: "Gear Ultima",
    image: "assets/gear_ultima.png",
    desc:
        "Versi premium dari Gear Series dengan tampilan sporty dan teknologi lebih modern.",
    price: 19990000,
    specs: {
      'Mesin': '125cc Blue Core',
      'Power': '7.0 kW / 8000 rpm',
      'Torsi': '9.5 Nm / 5500 rpm',
      'Tipe': 'Air Cooled 4-Stroke, SOHC',
    },
  ),
  Matic(
    name: "FreeGo 125",
    image: "assets/freego125.png",
    desc:
        "Motor matic stylish dengan bagasi besar dan tangki bensin depan yang praktis.",
    price: 22315000,
    specs: {
      'Mesin': '125cc Blue Core',
      'Power': '7.0 kW / 8000 rpm',
      'Torsi': '9.5 Nm / 5500 rpm',
      'Tipe': 'Air Cooled 4-Stroke, SOHC',
    },
  ),
  Matic(
    name: "X-Ride 125",
    image: "assets/xride125.png",
    desc:
        "Motor matic bergaya adventure untuk kamu yang aktif dan suka tantangan.",
    price: 20785000,
    specs: {
      'Mesin': '125cc Blue Core',
      'Power': '7.0 kW / 8000 rpm',
      'Torsi': '9.6 Nm / 5500 rpm',
      'Tipe': 'Air Cooled 4-Stroke, SOHC',
    },
  ),
  Matic(
    name: "Fino 125",
    image: "assets/fino.png",
    desc:
        "Motor matic dengan desain klasik dan elegan, cocok untuk tampil stylish setiap hari.",
    price: 20400000,
    specs: {
      'Mesin': '125cc Blue Core',
      'Power': '7.0 kW / 8000 rpm',
      'Torsi': '9.6 Nm / 5500 rpm',
      'Tipe': 'Air Cooled 4-Stroke, SOHC',
    },
  ),
];
