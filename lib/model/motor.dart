// Parent class
class Motor {
  String _name;
  String _image;
  String _desc;
  int _price;

  // Constructor
  Motor({
    required String name,
    required String image,
    required String desc,
    required int price,
  }) : _name = name,
       _image = image,
       _desc = desc,
       _price = price;

  // Getter
  String get name => _name;
  String get image => _image;
  String get desc => _desc;
  int get price => _price;

  // Setter
  set name(String value) => _name = value;
  set image(String value) => _image = value;
  set desc(String value) => _desc = value;
  set price(int value) => _price = value;

  // Polymorphism (akan dioverride child)
  String getCategory() {
    return "Motor Yamaha";
  }
}
