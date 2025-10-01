import 'package:ecommerce/models/cart_item.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get totalItems {
    int total = 0;
    for (int i = 0; i < _items.length; i++) {
      total += _items[i].quantity;
    }
    return total;
  }

  double get totalPrice {
    double total = 0.0;
    for (int i = 0; i < _items.length; i++) {
      total += _items[i].totalPrice;
    }
    return total;
  }

  void addProduct(Product product) {
    final existingItemIndex = _items.indexWhere(
      (item) =>
          item.product.name == product.name &&
          item.product.brand == product.brand &&
          item.product.size == product.size,
    );

    if (existingItemIndex != -1) {
      final existingItem = _items[existingItemIndex];
      if (existingItem.increaseQuantity()) {
        notifyListeners();
      } else {
        throw Exception('Not enough stock available');
      }
    } else {
      if (product.hasStock(1)) {
        _items.add(CartItem(product: product, quantity: 1));
        notifyListeners();
      } else {
        throw Exception('Product out of stock');
      }
    }
  }

  void removeItem(CartItem item) {
    _items.removeWhere((cartItem) => cartItem == item);
    notifyListeners();
  }

  void increaseQuantity(CartItem item) {
    final itemIndex = _items.indexOf(item);
    if (itemIndex != -1) {
      if (_items[itemIndex].increaseQuantity()) {
        notifyListeners();
      } else {
        throw Exception('Not enough stock available');
      }
    }
  }

  void decreaseQuantity(CartItem item) {
    final itemIndex = _items.indexOf(item);
    if (itemIndex != -1) {
      final cartItem = _items[itemIndex];
      if (cartItem.quantity > 1) {
        cartItem.decreaseQuantity();
        notifyListeners();
      } else {
        removeItem(item);
      }
    }
  }

  void checkout() {
    for (final item in _items) {
      item.product.decreaseStock(item.quantity);
    }
    _items.clear();
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int getProductQuantity(Product product) {
    try {
      final item = _items.firstWhere(
        (item) =>
            item.product.name == product.name &&
            item.product.brand == product.brand &&
            item.product.size == product.size,
      );
      return item.quantity;
    } catch (e) {
      return 0;
    }
  }
}