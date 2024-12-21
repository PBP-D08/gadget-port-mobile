import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/main.dart';
import 'package:gadget_port_mobile/screens/review/add_review.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gadget_port_mobile/models/review.dart';
import '/../widgets/bottom_nav_bar.dart';
import 'components/review_card.dart';
import 'package:gadget_port_mobile/models/user.dart'; // Pastikan Anda mengimpor model User

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


  @override
  Widget build(BuildContext context) {
    String? userRole = UserInfo.data['role'].toString().toLowerCase();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 191, 219, 254),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Reviews', style: TextStyle(color: Colors.black)),
          centerTitle: true,
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(right: 16.0),
                              child: Text(
                                '4.5', // Ganti dengan rating rata-rata dinamis jika tersedia
                                style: TextStyle(fontSize: 48),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => Icon(
                                      Icons.star,
                                      color: index < 4 ? Colors.yellow : Colors.grey, // Ganti "4" dengan jumlah rating dinamis
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text('from 25 reviews'),
                              ],
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
                        children: snapshot.data!.map((review) {
                          return ReviewCard(
                            reviewText: review.fields.reviewText,
                            username: review.user.username, // Gunakan username dari user
                            timestamp: review.fields.timestamp.toIso8601String(),
                            rating: review.fields.rating,
                            reviewId: review.id, // Kirimkan ID review
                            currentUser: currentUser,
                            onRefresh: refreshReviews, 
                            userRole: userRole,
                            onDelete: () {
                              setState(() {
                                reviews = fetchReviews(widget.productId); // Muat ulang data review
                              });
                            }, // Callback untuk memperbarui state
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