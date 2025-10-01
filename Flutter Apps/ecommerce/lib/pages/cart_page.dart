import 'package:ecommerce/models/cart.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final Cart cart;

  const CartPage({super.key, required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final items = widget.cart.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey[100],
                  child: Row(
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "\$${widget.cart.totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            widget.cart.checkout();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Purchase completed successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text("Checkout"),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ProductCardCart(
                        item: item,
                        onIncrease: () {
                          try {
                            widget.cart.increaseQuantity(item);
                            setState(() {});
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          }
                        },
                        onDecrease: () {
                          widget.cart.decreaseQuantity(item);
                          setState(() {});
                        },
                        onRemove: () {
                          widget.cart.removeItem(item);
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}