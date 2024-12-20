import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class EditReviewPage extends StatefulWidget {
  final int reviewId;

  const EditReviewPage({super.key, required this.reviewId});

  @override
  State<EditReviewPage> createState() => _EditReviewPageState();
}

class _EditReviewPageState extends State<EditReviewPage> {
  final _formKey = GlobalKey<FormState>();
  int? _rating;
  bool _wouldRecommend = false;
  String _reviewMessage = "";

  Future<void> _fetchReviewData() async {
    final request = context.read<CookieRequest>();

    try {
      final response = await request.get("http://localhost:8000/review/edit/${widget.reviewId}/");
      print(response);
      if (response['status'] == 'success') {
        setState(() {
          _rating = int.tryParse(response['data']['rating'] ?? '0');
          _reviewMessage = response['data']['review_message'] ?? '';
          _wouldRecommend = response['data']['would_recommend'] == 'true';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to fetch review data.")),
        );
      }
    } catch (e) {
      print('Error fetching review: $e');
    }
  }
Future<void> _submitEditedReview() async {
    // Ubah dari watch menjadi read
    final request = context.read<CookieRequest>();

    if (_formKey.currentState!.validate()) {
      try {
        final response = await request.postJson(
          "http://localhost:8000/review/edit/${widget.reviewId}/",
          jsonEncode(<String, dynamic>{
            'rating': _rating.toString(),
            'review_message': _reviewMessage,
            'would_recommend': _wouldRecommend.toString(),
          }),
        );

        if (context.mounted) {
          if (response['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Your review has been updated!"),
                backgroundColor: Color.fromARGB(255, 100, 153, 233),
              ),
            );
            Navigator.pop(context, true);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to update review. Please try again.")),
            );
          }
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchReviewData();
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
        title: const Text('Edit Review', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: const Text(
                    'Update your rating',
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
                          _rating = index + 1;
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
                  initialValue: _reviewMessage,
                  onChanged: (value) {
                    setState(() {
                      _reviewMessage = value;
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
                    onPressed: _submitEditedReview,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 100, 153, 233),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: const Color.fromARGB(255, 100, 153, 233)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(color: Color.fromARGB(255, 100, 153, 233), fontWeight: FontWeight.bold),
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
