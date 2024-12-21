import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/main.dart';
import 'package:gadget_port_mobile/screens/review/edit_review.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ReviewCard extends StatelessWidget {
  final String reviewText;
  final String username;
  final String timestamp;
  final int rating;
  final int reviewId;
  final String currentUser;
  final VoidCallback onDelete;
  final VoidCallback onRefresh;  // Tambahkan parameter ini
  final String userRole;

  const ReviewCard({
    Key? key,
    required this.reviewText,
    required this.username,
    required this.timestamp,
    required this.rating,
    required this.reviewId,
    required this.currentUser,
    required this.userRole,
    required this.onDelete,
    required this.onRefresh,  // Tambahkan ini ke constructor
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
    final url = 'http://localhost:8000/review/delete-flutter/$reviewId/';
    final response = await http.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Review deleted successfully")),
      );
      onDelete();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete review: ${response.body}")),
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
                      username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatTimestamp(),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    
                    if (username == currentUser || userRole == 'admin')
                      PopupMenuButton<String>(
                        onSelected: (String value) async {
                          if (value == 'edit') {
                            if(userRole == 'buyer') {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditReviewPage(reviewId: reviewId),
                                ),
                              );
                              // Jika hasil edit sukses, refresh reviews
                              if (result == true) {
                                onRefresh();  // Panggil callback untuk refresh
                              }
                            } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Admin tidak bisa mengedit review!"),
                                ),
                              );
                            }
                          } else if (value == 'delete') {
                            deleteReview(context);
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Delete'),
                              ],
                            ),
                          ),
                        ],
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
                      size: 20,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
