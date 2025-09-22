import 'package:flutter/material.dart';
import 'package:flutter_helloworld/pages/matic_pages.dart';
import 'package:flutter_helloworld/pages/product_detail.dart';
import 'package:flutter_helloworld/pages/maxi_pages.dart';

class Product {
  String _title;
  String _imagePath;
  String _description;
  Widget _page;

  Product(this._title, this._imagePath, this._description, this._page);

  // Getter
  String get title => _title;
  String get imagePath => _imagePath;
  String get description => _description;
  Widget get page => _page;

  // Setter
  set title(String value) => _title = value;
  set imagePath(String value) => _imagePath = value;
  set description(String value) => _description = value;
  set page(Widget value) => _page = value;
}

List<Product> products = [
  Product(
    "MAXI",
    "assets/maxi.png",
    "Kategori motor MAXI Yamaha",
    const MaxiPage(),
  ),
  Product(
    "Matic",
    "assets/matic.png",
    "Kategori motor Matic Yamaha",
    const MaticPage(),
  ),
  Product(
    "Sport",
    "assets/sport.png",
    "Kategori motor Sport Yamaha",
    DetailPage(
      title: "Sport",
      imagePath: "assets/sport.png",
      description: "Kategori motor Sport Yamaha",
    ),
  ),
];
