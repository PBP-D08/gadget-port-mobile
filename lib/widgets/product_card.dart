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
      color: const Color.fromARGB(255, 191, 219, 254), // Abu-abu gelap untuk kartu produk
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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white, // Teks produk
              ),
            ),
          ),
          Text(
            productPrice,
            style: const TextStyle(
              color: Color(0xFF00ADB5), // Hijau toska untuk harga
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
