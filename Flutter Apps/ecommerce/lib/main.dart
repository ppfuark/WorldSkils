import 'package:ecommerce/models/cart.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/navigations/page_navigator.dart';

void main() {
  Product product1 = Product(
    name: "T-shirt",
    brand: "Nike",
    size: "M",
    quantity: 1,
    price: 29.99,
    gender: Gender.male,
    image: "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/b78bf412-58dc-42f5-be30-888f11675835/M+NSW+TEE+M90+FW+MBR+CNCT+HO25.png",
  );

  Product product2 = Product(
    name: "T-shirt",
    brand: "Nike",
    size: "M",
    quantity: 1,
    price: 29.99,
    gender: Gender.male,
    image: "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/b78bf412-58dc-42f5-be30-888f11675835/M+NSW+TEE+M90+FW+MBR+CNCT+HO25.png",
  );
  Product product3 = Product(
    name: "T-shirt",
    brand: "Nike",
    size: "M",
    quantity: 1,
    price: 29.99,
    gender: Gender.male,
    image: "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/b78bf412-58dc-42f5-be30-888f11675835/M+NSW+TEE+M90+FW+MBR+CNCT+HO25.png",
  );
  Product product4 = Product(
    name: "T-shirt",
    brand: "Nike",
    size: "M",
    quantity: 1,
    price: 29.99,
    gender: Gender.male,
    image: "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/b78bf412-58dc-42f5-be30-888f11675835/M+NSW+TEE+M90+FW+MBR+CNCT+HO25.png",
  );


Cart cart = Cart();
cart.addProduct(product1);
cart.addProduct(product2);
cart.addProduct(product3);
cart.addProduct(product1);
cart.addProduct(product4);

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
