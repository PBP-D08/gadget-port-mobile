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
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 4.0), // Padding untuk gambar
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  height: 160, // Sesuaikan tinggi gambar
                  width: double.infinity, // Gambar memenuhi lebar kartu
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                productName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // Untuk teks panjang
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

