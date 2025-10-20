import 'motor.dart';

class Maxi extends Motor {
  final Map<String, String> specs;

  Maxi({
    required String name,
    required String image,
    required String desc,
    required int price,
    required this.specs, 
  }) : super(name: name, image: image, desc: desc, price: price);

  @override
  String getCategory() {
    return "Kategori MAXI Yamaha: motor matic premium dengan desain elegan.";
  }
}

final List<Maxi> maxis = [
  Maxi(
    name: "XMAX 250",
    image: "assets/xmax.png",
    desc:
        "The Ultimate MAXI. Performa mesin Blue Core 250cc yang bertenaga, kenyamanan superior, dan desain agresif untuk pengalaman touring terbaik.",
    price: 67965000,
    specs: {
      'Mesin': '250cc, Liquid Cooled 4-Stroke, SOHC',
      'Power': '16.8 kW / 7000 rpm',
      'Torsi': '24.3 Nm / 5500 rpm',
      'Transmisi': 'V-Belt Automatic',
    },
  ),
  Maxi(
    name: "NMAX 'Turbo' / Neo",
    image: "assets/nmax.png",
    desc:
        "NMAX generasi terbaru dengan teknologi Y-Connect dan Turbo Power Assist, memberikan sensasi akselerasi lebih responsif dan nyaman.",
    price: 33415000,
    specs: {
      'Mesin': '155cc, Liquid Cooled 4-Stroke, SOHC VVA',
      'Power': '11.3 kW / 8000 rpm',
      'Torsi': '14.2 Nm / 6500 rpm',
      'Transmisi': 'V-Belt Automatic',
    },
  ),
  Maxi(
    name: "Aerox Alpha",
    image: "assets/aerox.png",
    desc:
        "Skutik sporty dengan DNA Yamaha Racing, dilengkapi fitur Y-Connect, Smart Key System, dan suspensi tabung untuk performa maksimal.",
    price: 29900000,
    specs: {
      'Mesin': '155cc, Liquid Cooled 4-Stroke, SOHC VVA',
      'Power': '11.3 kW / 8000 rpm',
      'Torsi': '13.9 Nm / 6500 rpm',
      'Transmisi': 'V-Belt Automatic',
    },
  ),
  Maxi(
    name: "LEXi LX 155",
    image: "assets/lexi.png",
    desc:
        "MAXi skutik dengan desain ramping dan posisi berkendara rileks. Dilengkapi mesin 155cc Blue Core VVA dan fitur Stop & Start System.",
    price: 26800000,
    specs: {
      'Mesin': '155cc, Liquid Cooled 4-Stroke, SOHC VVA',
      'Power': '11.3 kW / 8000 rpm',
      'Torsi': '13.9 Nm / 6500 rpm',
      'Transmisi': 'V-Belt Automatic',
    },
  ),
  Maxi(
    name: "NMAX 155",
    image: "assets/nmax155.png",
    desc:
        "Live The Pride. Skutik premium dengan mesin Blue Core 155cc VVA, desain sporty, dan fitur canggih untuk kebanggaan berkendara maksimal.",
    price: 32175000,
    specs: {
      'Mesin': '155cc, Liquid Cooled 4-Stroke, SOHC VVA',
      'Power': '11.3 kW / 8000 rpm',
      'Torsi': '13.9 Nm / 6500 rpm',
      'Transmisi': 'V-Belt Automatic',
    },
  ),
  Maxi(
    name: "Aerox 155",
    image: "assets/aerox155.png",
    desc:
        "Sport Scooter 155cc dengan gaya agresif, performa tinggi, dan teknologi Y-Connect yang memadukan kecepatan dengan konektivitas modern.",
    price: 28330000,
    specs: {
      'Mesin': '155cc, Liquid Cooled 4-Stroke, SOHC VVA',
      'Power': '11.3 kW / 8000 rpm',
      'Torsi': '13.9 Nm / 6500 rpm',
      'Transmisi': 'V-Belt Automatic',
    },
  ),
];
