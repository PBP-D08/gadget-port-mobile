import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/screens/review/add_review.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gadget_port_mobile/models/review.dart';
import '/../widgets/bottom_nav_bar.dart';
import '/../themes/app_theme.dart';

// class ReviewPage extends StatefulWidget {
//   const ReviewPage({super.key});

//   @override
//   State<ReviewPage> createState() => _ReviewPageState();
// }

// class _ReviewPageState extends State<ReviewPage> {
//   late Future<List<Review>> reviews;

//   @override
//   void initState() {
//     super.initState();
//     reviews = fetchReviews();
//   }

//   Future<List<Review>> fetchReviews() async {
//     final response = await http.get(Uri.parse('http://localhost:8000/review/json')); // Replace with your backend endpoint

//     if (response.statusCode == 200) {
//       return reviewFromJson(response.body);
//     } else {
//       throw Exception('Failed to load reviews');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Reviews'),
//       ),
//       body: FutureBuilder<List<Review>>(
//         future: reviews,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No reviews available'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final review = snapshot.data![index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'User ID: ${review.fields.user}',
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 16),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Review: ${review.fields.reviewText}',
//                           style: const TextStyle(fontSize: 14),
//                         ),
//                         const SizedBox(height: 8),
//                         Text('Rating: ${review.fields.rating}/5'),
//                         const SizedBox(height: 8),
//                         Text('Product ID: ${review.fields.product}'),
//                         const SizedBox(height: 8),
//                         Text('Timestamp: ${review.fields.timestamp}'),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late Future<List<Review>> reviews;

  @override
  void initState() {
    super.initState();
    reviews = fetchReviews();
  }

  Future<List<Review>> fetchReviews() async {
    // Dummy data for testing purposes
    final dummyData = [
      {
        "model": "review",
        "pk": 1,
        "fields": {
          "user": 101,
          "review_text": "Great product! Highly recommend it.",
          "rating": 5,
          "product": 1001,
          "timestamp": "2024-12-04T12:34:56Z"
        }
      },
      {
        "model": "review",
        "pk": 2,
        "fields": {
          "user": 102,
          "review_text": "Good quality, but a bit expensive.",
          "rating": 4,
          "product": 1002,
          "timestamp": "2024-12-03T10:20:30Z"
        }
      }
    ];

    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return reviewFromJson(json.encode(dummyData));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Use the predefined light theme
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
              return const Center(child: Text('No reviews available'));
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
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text(
                                '4.5', // Replace with dynamic average rating if available
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
                                      color: index < 4 ? Colors.yellow : Colors.grey, // Replace "4" with dynamic rating count
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
                            primary: Colors.blue,
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
                                  builder: (context) => const AddReviewPage()),
                            );
                          },
                          child: ListTile(
                            leading: const Icon(Icons.add, color: Colors.black),
                            title: const Text('Add Review',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AddReviewPage()),
                              );
                            },
                            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: Text('Recent Reviews',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Column(
                        children: snapshot.data!.map((review) {
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
                                )
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'User ${review.fields.user}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${review.fields.timestamp}',
                                            style: const TextStyle(
                                                color: Colors.grey, fontSize: 12),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: List.generate(
                                          5,
                                          (index) => Icon(
                                            Icons.star,
                                            color: index < review.fields.rating
                                                ? Colors.yellow
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        review.fields.reviewText,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
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
        bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
      ),
    );
  }
}
