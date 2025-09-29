import 'package:ecommerce/models/cart.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/navigations/page_navigator.dart';

void main() {
  // Create products
  Product product1 = Product(
    name: "T-shirt",
    brand: "Nike",
    size: "M",
    quantity: 1,
    price: 29.99,
    gender: Gender.male,
  );

  Product product2 = Product(
    name: "Jeans",
    brand: "Levi's",
    size: "32",
    quantity: 2,
    price: 49.99,
    gender: Gender.male,
  );

  Product product3 = Product(
    name: "Sneakers",
    brand: "Adidas",
    size: "10",
    quantity: 1,
    price: 89.99,
  );

  Product product4 = Product(
    name: "Hoodie",
    brand: "Puma",
    size: "L",
    quantity: 3,
    price: 59.99,
    gender: Gender.female,
  );

  // Add products to cart
  Cart cart = Cart();
  cart.addProduct(product1);
  cart.addProduct(product2);
  cart.addProduct(product3);
  cart.addProduct(product1);
  cart.addProduct(product4);

  // ✅ Pass cart into MyApp
  runApp(MyApp(cart: cart));
}

class MyApp extends StatelessWidget {
  final Cart cart;

  const MyApp({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ecommerce",
      debugShowCheckedModeBanner: false,
      home: PageNavigator(cart: cart), // ✅ Forward cart
    );
  }
}
