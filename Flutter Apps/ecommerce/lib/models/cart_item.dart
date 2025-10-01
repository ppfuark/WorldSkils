import 'package:ecommerce/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;

  bool get hasEnoughStock => product.hasStock(quantity);

  bool increaseQuantity() {
    if (product.hasStock(quantity + 1)) {
      quantity++;
      return true;
    }
    return false;
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}