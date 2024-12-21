import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/main.dart';
import 'package:gadget_port_mobile/models/products.dart';
import 'package:gadget_port_mobile/screens/review/review_page.dart';
import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:gadget_port_mobile/models/review.dart'; // Pastikan Anda mengimpor model Review
import 'package:gadget_port_mobile/models/user.dart'; // Pastikan Anda mengimpor model User

class AddReviewPage extends StatefulWidget {
  final int productId; // Menambahkan parameter productId

  const AddReviewPage({super.key, required this.productId});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final _formKey = GlobalKey<FormState>(); // Menambahkan GlobalKey untuk form
  int? _rating; // Mengubah rating menjadi int?
  bool _wouldRecommend = false;
  String _reviewMessage = ""; // Mengubah reviewMessage menjadi string4

  Future<void> _submitReview() async {
    final request =
        context.read<CookieRequest>(); // Mengambil CookieRequest dari provider

    if (_formKey.currentState!.validate()) {
      try {
        // Mengambil data pengguna dari provider
        String username = UserInfo.data["username"] ??
            "default_username"; // Ganti dengan username default jika null
        print("CBA" + username);
        // Pastikan review message tidak kosong
        if (_reviewMessage.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Review message cannot be empty.")),
          );
          return; // Hentikan eksekusi jika review message kosong
        }

        // Pastikan productId tidak null
        if (widget.productId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Product ID cannot be null.")),
          );
          return; // Hentikan eksekusi jika productId null
        }

        final response = await request.postJson(
          "http://localhost:8000/review/add/${widget.productId}/",
          jsonEncode(<String, String>{
            'username': username,
            'rating': _rating.toString(), // Kirim rating sebagai string
            'review_message': _reviewMessage,
            'id': widget.productId
                .toString(), // Pastikan id dikirim sebagai string
          }),
        );

        if (context.mounted) {
          if (response['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Your review has been published!"),
                backgroundColor: Color.fromARGB(255, 100, 153, 233),
              ),
            );
            // Kembali ke homepage
            Navigator.popUntil(context, (route) => route.isFirst);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Terdapat kesalahan, silakan coba lagi."),
              ),
            );
          }
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text('Add Reviews', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Menggunakan form key
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: const Text(
                    'Your overall rating of this product',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      onPressed: () {
                        setState(() {
                          _rating = index + 1; // Set rating as integer
                        });
                      },
                      icon: Icon(
                        index < (_rating ?? 0) ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 32,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _reviewMessage = value; // Update review message
                    });
                  },
                  maxLength: 3000,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Your review...',
                    hintText: 'Your review...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your review';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Would you recommend this product?'),
                    Switch(
                      value: _wouldRecommend,
                      onChanged: (value) {
                        setState(() {
                          _wouldRecommend = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _submitReview(); // Memanggil fungsi untuk mengirim review
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
                          horizontal: 24.0,
                          vertical: 20.0), // Tinggi tombol diperbesar
                    ),
                    child: const Text(
                      'Submit Review',
                      style: TextStyle(
                          color: Color.fromARGB(255, 100, 153, 233),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
