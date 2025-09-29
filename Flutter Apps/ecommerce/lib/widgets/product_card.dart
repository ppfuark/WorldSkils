import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 2))
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image (with fallback if null or empty)
          ClipRRect(
            child: Image.network(
              widget.product.image,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),

          // Product Details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.product.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Brand: ${widget.product.brand}",
                    style: const TextStyle(color: Colors.grey)),
                Text("Size: ${widget.product.size}"),
                Text("Gender: ${widget.product.gender.name}"),
                Text("Price: \$${widget.product.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent)),
                Text("Stock: ${widget.product.quantity}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
