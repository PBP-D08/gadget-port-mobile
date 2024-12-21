import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/auth/login.dart';
import 'package:gadget_port_mobile/main.dart';
import 'package:gadget_port_mobile/models/review.dart';
import 'package:gadget_port_mobile/models/store.dart';
import 'package:gadget_port_mobile/screens/cart/cart_screen.dart'; // Import halaman store
import 'package:gadget_port_mobile/screens/store/store_detail_screen.dart';
import 'package:gadget_port_mobile/screens/wishlist/wishlist_screen.dart';
import '../../models/products.dart';
import '../review/components/rating_card.dart';
import '../review/review_page.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

const double defaultPadding = 16.0;

class DetailProductPage extends StatelessWidget {
  final Katalog product;
  final List<Store> stores;

  const DetailProductPage({
    Key? key,
    required this.product,
    required this.stores,
  }) : super(key: key);

  Future<List<Review>> fetchReviews(int productId) async {
    try {
      final url = Uri.parse(
          'http://localhost:8000/review/get-product-review-json/$productId/');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return reviewFromJson(response.body);
      } else {
        print('Error status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching reviews: $e');
      return [];
    }
  }

  double calculateAverageRating(List<Review> reviews) {
    if (reviews.isEmpty) return 0.0;
    final totalRating =
        reviews.fold<double>(0.0, (sum, review) => sum + review.fields.rating);
    return (totalRating / reviews.length * 10).round() / 10;
  }

  Map<int, int> calculateStarCounts(List<Review> reviews) {
    // Inisialisasi map dengan nilai default 0
    final Map<int, int> starCounts = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

    // Jika tidak ada reviews, langsung return map dengan nilai default 0
    if (reviews.isEmpty) return starCounts;

    for (var review in reviews) {
      final rating = review.fields.rating.round();
      if (starCounts.containsKey(rating)) {
        starCounts[rating] = starCounts[rating]! + 1;
      }
    }
    return starCounts;
  }

  Widget buildRatingCard(List<Review> reviews) {
    if (reviews.isEmpty) {
      // Tampilkan default values jika reviews kosong
      return const Padding(
        padding: EdgeInsets.fromLTRB(1, 2, 1, 5),
        child: RatingCard(
          rating: 0.0,
          numOfReviews: 0,
          numOfFiveStar: 0,
          numOfFourStar: 0,
          numOfThreeStar: 0,
          numOfTwoStar: 0,
          numOfOneStar: 0,
        ),
      );
    }

    final averageRating = calculateAverageRating(reviews);
    final starCounts = calculateStarCounts(reviews);

    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 2, 1, 5),
      child: RatingCard(
        rating: averageRating,
        numOfReviews: reviews.length,
        numOfFiveStar: starCounts[5] ?? 0,
        numOfFourStar: starCounts[4] ?? 0,
        numOfThreeStar: starCounts[3] ?? 0,
        numOfTwoStar: starCounts[2] ?? 0,
        numOfOneStar: starCounts[1] ?? 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? userRole = UserInfo.data['role'];
    // Future<List<Review>> reviews  = fetchReviews(product.pk);
    // Cari store berdasarkan storeId
    return Scaffold(
      appBar: AppBar(
        title: Text(product.fields.name),
        backgroundColor: Color.fromARGB(255, 191, 219, 254),
        actions: [
          if (UserInfo.loggedIn) ...{
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(
                      selectedIndex:
                          0, // Replace with your desired selectedIndex value
                      onItemTapped: (index) {
                        // Handle item tapping logic
                      },
                    ),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart_outlined),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WishlistPage(),
                  ),
                );
              },
              icon: Icon(Icons.favorite_border),
            ),
          } else ...{
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 100, 153, 233),
                backgroundColor: Colors.white,
                side:
                    const BorderSide(color: Color.fromARGB(255, 100, 153, 233)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
              ),
              child: const Text('Login'),
            ),
          },
          const SizedBox(width: 16),
        ],
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

              // Harga dengan format mata uang
              Text(
                'Rp ${NumberFormat('#,###', 'id_ID').format(product.fields.price)}',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 8.0),
              // Nama produk
              Text(
                product.fields.name,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
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

              FutureBuilder<List<Review>>(
                future: fetchReviews(product.pk),
                builder: (context, AsyncSnapshot<List<Review>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Failed to load reviews"),
                    );
                  }

                  // Gunakan data kosong sebagai fallback jika snapshot.data null
                  final reviews = snapshot.data ?? [];
                  return buildRatingCard(reviews);
                },
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
                  title: Text('See Reviews',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: stores != null
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StoreDetailPage(
                                  store: stores[product.fields.store],
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Ikon Logo dalam Container untuk penyesuaian posisi
                        Container(
                          height: 40.0, // Sesuaikan tinggi sesuai kebutuhan
                          alignment:
                              Alignment.center, // Pusatkan ikon secara vertikal
                          child: Icon(Icons.storefront,
                              size: 40.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(width: 16.0),

                        // Informasi Toko
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nama Toko
                            Text(
                              stores != null
                                  ? stores[product.fields.store].fields.nama
                                  : product.fields.brand,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(height: 4.0),

                            // Alamat Toko
                            Text(
                              stores[product.fields.store].fields.alamat != null
                                  ? (stores[product.fields.store]
                                              .fields
                                              .alamat
                                              .length >
                                          50
                                      ? '${stores[product.fields.store].fields.alamat.substring(0, 50)}...'
                                      : stores[product.fields.store]
                                          .fields
                                          .alamat)
                                  : "Alamat tidak tersedia",
                              style: const TextStyle(
                                  fontSize: 14.0, color: Colors.grey),
                            ),
                            const SizedBox(height: 4.0),

                            // Jam Buka dan Tutup
                            Text(
                              "Jam buka: ${stores[product.fields.store]?.fields.jamBuka ?? '-'} - ${stores[product.fields.store]?.fields.jamTutup ?? '-'}",
                              style: const TextStyle(
                                  fontSize: 14.0, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: userRole == 'buyer'
          ? Container(
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
                              content: Text(
                                  '${product.fields.name} added to wishlist!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            const Color.fromARGB(255, 100, 153, 233),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 20.0),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite_border_rounded,
                              color: Colors.white),
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
                              content: Text(
                                  '${product.fields.name} added to cart!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 100, 153, 233),
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            color: Color.fromARGB(255, 100, 153, 233)),
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
            )
          : UserInfo.loggedIn == false
              ? Container(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
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
                    child: const Text('Login'),
                  ),
                )
              : null,
    );
  }
}
