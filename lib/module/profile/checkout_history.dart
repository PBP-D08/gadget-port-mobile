import 'dart:convert';  // To decode JSON
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const CheckoutHistoryApp());
}

class CheckoutHistoryApp extends StatelessWidget {
  const CheckoutHistoryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Riwayat Checkout',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 191, 219, 254),
      ),
      home: const CheckoutHistoryScreen(),
    );
  }
}

class CheckoutHistoryScreen extends StatefulWidget {
  const CheckoutHistoryScreen({Key? key}) : super(key: key);

  @override
  _CheckoutHistoryScreenState createState() => _CheckoutHistoryScreenState();
}

class _CheckoutHistoryScreenState extends State<CheckoutHistoryScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _orders = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchCheckoutHistory();
  }

  // Function to fetch checkout history
  Future<void> _fetchCheckoutHistory() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/user/profile/checkout_history/'));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _orders = data.map((order) => Map<String, dynamic>.from(order)).toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage = 'Failed to load checkout history.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Riwayat Checkout',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? Center(child: Text(_errorMessage))
                : _orders.isNotEmpty
                    ? ListView.builder(
                        itemCount: _orders.length,
                        itemBuilder: (context, index) {
                          final order = _orders[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 2,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order #${order['id']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('Total: ${order['grand_total']}'),
                                  Text('Alamat: ${order['address']['full_address']}'),
                                  Text('Tanggal Order: ${order['created_at']}'),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'Tidak ada riwayat checkout yang tersedia.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
      ),
    );
  }
}
