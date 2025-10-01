import 'dart:io';

import 'package:ecommerce/data/products_data.dart';
import 'package:ecommerce/models/cart.dart';
import 'package:ecommerce/pages/cart_page.dart';
import 'package:ecommerce/widgets/product_card_home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Cart cart;

  const HomePage({super.key, required this.cart});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          GestureDetector(
            child: Icon(Icons.shopping_cart, color: Colors.white,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cart: widget.cart),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: ProductsData.allProducts.length,
        itemBuilder: (context, index) {
          final product = ProductsData.allProducts[index];
          final cartQuantity = widget.cart.getProductQuantity(product);

          return ProductCardHome(
            product: product,
            cartQuantity: cartQuantity,
            onAddToCart: () {
              try {
                widget.cart.addProduct(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} added to cart!'),
                    duration: const Duration(seconds: 1),
                  ),
                );
                setState(() {});
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString()),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            onViewDetails: () {
              stdout.write(product);
            },
          );
        },
      ),
    );
  }
}
