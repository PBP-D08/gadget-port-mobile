import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadget_port_mobile/main.dart';
import 'package:gadget_port_mobile/models/store.dart';
import 'package:gadget_port_mobile/screens/cart/cart_screen.dart'; // Import halaman store
import 'package:gadget_port_mobile/screens/store/store_detail_screen.dart';
import '../../models/products.dart';
import 'product_card.dart';
import '../review/components/rating_card.dart';
import '../review/review_page.dart';
import 'package:intl/intl.dart';

const double defaultPadding = 16.0;

class DetailProductPage extends StatelessWidget {
  final Katalog product;
  final Map<int, Store> storeMap;

  const DetailProductPage({
    Key? key,
    required this.product,
    required this.storeMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cari store berdasarkan storeId
    final store = storeMap[product.fields.store];

    return Scaffold(
      appBar: AppBar(
        title: Text(product.fields.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar produk
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Image.network(
                  product.fields.imageLink,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16.0),

              // Nama produk
              Text(
                product.fields.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8.0),

              // Harga dengan format mata uang
              Text(
                'Rp ${NumberFormat('#,###', 'id_ID').format(product.fields.price)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 16.0),

              // Spesifikasi
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Product Info:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      product.fields.formattedSpec,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // RatingCard
              const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: RatingCard(
                  rating: 4.3,
                  numOfReviews: 100,
                  numOfFiveStar: 10,
                  numOfFourStar: 30,
                  numOfThreeStar: 5,
                  numOfTwoStar: 4,
                  numOfOneStar: 1,
                ),
              ),

              // Button Reviews
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewPage(productId: product.pk),
                    ),
                  );
                },
                child: const ListTile(
                  leading: Icon(Icons.reviews_rounded, color: Colors.black),
                  title: Text('Reviews',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: store != null
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StoreDetailPage(
                                  store: store,
                                  products: [], // Jika ada daftar produk di store
                                ),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.white, // Ubah warna tombol menjadi putih
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ikon Logo
                        Icon(Icons.storefront,
                            size: 40.0, color: Theme.of(context).primaryColor),
                        const SizedBox(width: 16.0),

                        // Informasi Toko
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nama Toko
                            Text(
                              store != null
                                  ? store.fields.nama
                                  : product.fields.brand,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(height: 4.0),

                            // Alamat Toko
                            Text(
                              store?.fields.alamat ?? "Alamat tidak tersedia",
                              style: const TextStyle(
                                  fontSize: 14.0, color: Colors.grey),
                            ),
                            const SizedBox(height: 4.0),

                            // Jam Buka dan Tutup
                            Text(
                              "Jam buka: ${store?.fields.jamBuka ?? '-'} - ${store?.fields.jamTutup ?? '-'}",
                              style: const TextStyle(
                                  fontSize: 14.0, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Wishlist Button
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('${product.fields.name} added to wishlist!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 100, 153, 233),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 20.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border_rounded, color: Colors.white),
                    SizedBox(width: 8.0),
                    Text('Add to Wishlist'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            // Cart Button
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('${product.fields.name} added to cart!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 100, 153, 233),
                  backgroundColor: Colors.white,
                  side: BorderSide(
                      color: const Color.fromARGB(255, 100, 153, 233)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 20.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_shopping_cart,
                        color: Color.fromARGB(255, 100, 153, 233)),
                    SizedBox(width: 8.0),
                    Text('Add to Cart'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
