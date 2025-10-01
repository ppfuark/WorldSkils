import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class ProductCardHome extends StatelessWidget {
  final Product product;
  final int cartQuantity;
  final VoidCallback onAddToCart;
  final VoidCallback onViewDetails;

  const ProductCardHome({
    super.key,
    required this.product,
    required this.cartQuantity,
    required this.onAddToCart,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.network(
                  product.image,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, size: 50, color: Colors.grey),
                    );
                  },
                ),
              ),
              if (cartQuantity > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$cartQuantity in cart',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.brand,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Size: ${product.size}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      product.gender.name.toUpperCase(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Stock: ${product.stock}',
                      style: TextStyle(
                        color: product.stock > 0 ? Colors.deepPurpleAccent : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: product.stock > 0 ? onAddToCart : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      product.stock > 0 ? 'Add to Cart' : 'Out of Stock',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}