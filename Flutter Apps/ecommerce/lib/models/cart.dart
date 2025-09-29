import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    if (_products.contains(product)) {
      Product productToEdit =
          _products.where((target) => target == product) as Product;
      productToEdit.quantity += 1;
    } else {
      _products.add(product);
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.removeWhere((target) => target == product);
    notifyListeners();
  }
}
