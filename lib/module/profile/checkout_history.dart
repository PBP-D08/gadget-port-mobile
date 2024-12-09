import 'package:flutter/material.dart';

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
        scaffoldBackgroundColor: const Color.fromARGB(
          255, 191, 219, 254),
      ),
      home: const CheckoutHistoryScreen(),
    );
  }
}

class CheckoutHistoryScreen extends StatelessWidget {
  const CheckoutHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example order data
    final List<Map<String, dynamic>> orders = [
      {
        'id': 123,
        'grand_total': 'Rp 150,000',
        'address': {'full_address': 'Jl. Merdeka No. 1, Jakarta'},
        'shipping_method': {'name': 'JNE Regular'},
        'created_at': '2024-12-09 12:34',
      },
      {
        'id': 124,
        'grand_total': 'Rp 200,000',
        'address': {'full_address': 'Jl. Sudirman No. 7, Bandung'},
        'shipping_method': {'name': 'GoSend'},
        'created_at': '2024-12-08 15:20',
      },
    ];

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
        child: orders.isNotEmpty
            ? ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
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
                          Text(
                              'Metode Pengiriman: ${order['shipping_method']['name']}'),
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
