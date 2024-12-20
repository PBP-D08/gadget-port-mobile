import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String imageUrl;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Tambahkan aksi onTap di sini
      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255), // Abu-abu gelap untuk kartu produk
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                productName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Teks produk
                ),
              ),
            ),
            Text(
              productPrice,
              style: const TextStyle(
                color: Color.fromARGB(255, 100, 153, 233), // Hijau toska untuk harga
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
