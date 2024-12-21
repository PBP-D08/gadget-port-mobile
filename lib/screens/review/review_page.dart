import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/main.dart';
import 'package:gadget_port_mobile/screens/review/add_review.dart';
import 'package:http/http.dart' as http;
import 'package:gadget_port_mobile/models/review.dart';
import 'components/review_card.dart';
import '../../themes/app_theme.dart';

class ReviewPage extends StatefulWidget {
  final int productId; // Tambahkan property productId
  const ReviewPage({super.key, required this.productId}); // Tambahkan productId ke konstruktor
  
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  // Future<List<Review>>? reviewsFuture;
  late Future<List<Review>> reviews;
  late String currentUser ; // Menambahkan variabel untuk menyimpan username pengguna saat ini
  int? selectedRating; // Filter rating
  bool isAscending = true; // Untuk sorting

  @override
  void initState() {
    super.initState();
    reviews = fetchReviews(widget.productId); // Panggil fetchReviews() dengan productId
    currentUser = UserInfo.data["username"] ?? "Guest";
    print(UserInfo.data);
    debugPrint("Current User: ${currentUser}");

  }

  Future<List<Review>> fetchReviews(int productId) async {
    try {
      final url = Uri.parse('http://localhost:8000/review/get-product-review-json/$productId/');
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
    Future<void> _navigateToAddReviewPage(int productId) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddReviewPage(productId: productId),
      ),
    );

    if (result == true) {
      refreshReviews(); // Panggil fungsi untuk memperbarui daftar review
    }
  }

 void refreshReviews() {
    setState(() {
      reviews = fetchReviews(widget.productId); // Method yang mengambil data review dari API
    });
  }

  List<Review> filterAndSortReviews(List<Review> reviews) {
    // Filter berdasarkan rating jika ada filter yang dipilih
    var filteredReviews = selectedRating != null
        ? reviews.where((review) => review.fields.rating == selectedRating).toList()
        : reviews;

    // Sort berdasarkan rating
    filteredReviews.sort((a, b) {
      if (isAscending) {
        return a.fields.rating.compareTo(b.fields.rating);
      } else {
        return b.fields.rating.compareTo(a.fields.rating);
      }
    });

    return filteredReviews;
  }
  double calculateAverageRating(List<Review> reviews) {
    if (reviews.isEmpty) return 0.0;
    final totalRating =
        reviews.fold<double>(0.0, (sum, review) => sum + review.fields.rating);
    return totalRating / reviews.length;
  }

  int countTotalReviews(List<Review> reviews) {
    return reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    String? userRole = UserInfo.data['role'].toString().toLowerCase();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text(
            'Reviews',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black, // Menambahkan warna teks untuk konsistensi
            ),
          ),
          backgroundColor: Color.fromARGB(255, 191, 219, 254),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder<List<Review>>(
          future: reviews,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 16.0),
                              child: Text(
                                'Belum ada Review produk ini', // Teks yang ditampilkan
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                          ),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddReviewPage(productId: widget.productId),
                              ),
                            );
                            if (result == true) {
                              refreshReviews();  // Memanggil refresh jika add review berhasil
                            }
                          },
                          child: const ListTile(
                            leading: Icon(Icons.add, color: Colors.black),
                            title: Text('Add Review', style: TextStyle(fontWeight: FontWeight.bold)),
                            trailing: Icon(Icons.chevron_right, color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              final allReviews = snapshot.data!; // Semua review
              final filteredAndSortedReviews = filterAndSortReviews(allReviews);
              final averageRating = calculateAverageRating(allReviews); // Hitung rata-rata dari semua review
              final totalReviews = countTotalReviews(allReviews); // Hitung total dari semua review

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  
                  child: Column(
                    children: <Widget>[
                      // Container untuk rata-rata rating
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text(
                                averageRating.toStringAsFixed(1), // Rata-rata rating dari semua review
                                style: const TextStyle(fontSize: 48),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => Icon(
                                      Icons.star,
                                      color: index < averageRating.floor()
                                          ? Colors.yellow
                                          : Colors.grey, // Warna berdasarkan rating
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text('from $totalReviews reviews'), // Total review dari semua review
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16), // Spasi antar elemen

                      // Filter Rating dan Sort Button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Filter Rating
                            DropdownButton<int>(
                              hint: const Text('Filter Rating'),
                              value: selectedRating,
                              items: [null, 1, 2, 3, 4, 5].map((rating) {
                                return DropdownMenuItem<int>(
                                  value: rating,
                                  child: Text(
                                    rating == null ? 'All Ratings' : '$rating Star',
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedRating = value;
                                });
                              },
                              // Properti tambahan untuk perbaikan
                              alignment: Alignment.centerLeft, // Menjaga dropdown tetap di posisi
                              dropdownColor: Colors.white, // Warna background dropdown
                              icon: const Icon(Icons.arrow_drop_down), // Ikon dropdown
                              iconEnabledColor: Colors.grey, // Warna ikon dropdown
                            ),

                            // Sort Button
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  isAscending = !isAscending; // Toggle sorting order
                                });
                              },
                              icon: Icon(
                                isAscending ? Icons.arrow_downward : Icons.arrow_upward,
                                color: const Color.fromARGB(255, 100, 153, 233), // Warna ikon
                              ),
                              label: Text(
                                isAscending ? 'Terendah' : 'Tertinggi', // Teks label
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 100, 153, 233)), // Warna teks
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 12.0),
                          ),
                          onPressed: () {
                            if (UserInfo.loggedIn) {
                              // Jika pengguna sudah login, navigasi ke AddReviewPage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddReviewPage(
                                      productId: widget
                                          .productId), // Kirimkan productId yang benar
                                ),
                              );
                            } else {
                              // Jika pengguna belum login, tampilkan snackbar
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Anda belum login'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: const ListTile(
                            leading: Icon(Icons.add, color: Colors.black),
                            title: Text('Add Review',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            trailing:
                                Icon(Icons.chevron_right, color: Colors.grey),
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: Text('Recent Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      
                      Column(
                        children: filteredAndSortedReviews.map((review) {
                          return ReviewCard(
                            reviewText: review.fields.reviewText,
                            username: review.user.username,
                            timestamp: review.fields.timestamp.toIso8601String(),
                            rating: review.fields.rating,
                            reviewId: review.id,
                            currentUser: currentUser,
                            onRefresh: refreshReviews,
                            userRole: userRole,
                            onDelete: () {
                              setState(() {
                                reviews = fetchReviews(widget.productId);
                              });
                            },
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}