import 'package:ecommerce/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/navigations/page_navigator.dart';

void main() {
Cart cart = Cart();

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
      home: PageNavigator(cart: cart),
    );
  }
}
