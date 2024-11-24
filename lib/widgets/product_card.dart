import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              productName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            productPrice,
            style: const TextStyle(color: Colors.teal),
          ),
        ],
      ),
    );
  }
}
