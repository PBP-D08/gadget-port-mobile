import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Keranjang'),
      ),
      body: Column(
        children: [
          // Bagian header info toko
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Icon(Icons.store, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Nama Toko',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          // Daftar item di keranjang
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Ganti dengan jumlah item yang dinamis
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      // Gambar produk
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          'https://via.placeholder.com/80',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Produk',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text('Rp 50.000'),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Tombol tambah/kurang jumlah
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {},
                                    ),
                                    Text('1'), // Jumlah item
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                // Tombol hapus
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Bagian footer untuk total harga dan tombol checkout
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Harga', style: TextStyle(fontSize: 16)),
                    Text(
                      'Rp 150.000',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Aksi checkout
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 48),
                  ),
                  child: Text(
                    'Checkout',
                    style: TextStyle(fontSize: 16, color: Colors.white),
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