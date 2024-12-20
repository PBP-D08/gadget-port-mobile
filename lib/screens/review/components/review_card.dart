import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewCard extends StatelessWidget {
  final String reviewText;
  final String username; // Menggunakan username
  final String timestamp;
  final int rating;
  final int reviewId; // Menambahkan ID review
  final String currentUser; // Menambahkan username pengguna saat ini
  final VoidCallback onDelete; // Callback untuk memperbarui tampilan setelah penghapusan

  const ReviewCard({
    Key? key,
    required this.reviewText,
    required this.username,
    required this.timestamp,
    required this.rating,
    required this.reviewId, // Menambahkan parameter reviewId
    required this.currentUser, // Menambahkan parameter currentUser
    required this.onDelete, // Callback untuk memperbarui tampilan
  }) : super(key: key);

  String formatTimestamp() {
    try {
      final DateTime dateTime = DateTime.parse(timestamp);
      return DateFormat('dd MMM yyyy HH:mm').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }

  Future<void> deleteReview(BuildContext context) async {
    final url = 'http://localhost:8000/review/delete-flutter/$reviewId/'; // Ganti dengan URL API Anda
    final response = await http.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    print(response);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Review deleted successfully")),
      );
      onDelete(); // Panggil callback untuk memperbarui tampilan
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete review: ${response}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.account_circle,
            size: 40,
            color: Colors.grey,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      username, // Menggunakan username langsung
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatTimestamp(), // Menggunakan method formatTimestamp()
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: index < rating ? Colors.yellow : Colors.grey,
                      size: 20, // Menambahkan ukuran ikon yang lebih kecil
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  reviewText,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                if (username == currentUser) // Hanya tampilkan jika pengguna adalah pemilik review
                  IconButton(
                    icon: const Icon(Icons.delete_forever, color: Colors.red),
                    onPressed: () {
                      deleteReview(context);
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
