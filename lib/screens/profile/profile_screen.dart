import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/../widgets/bottom_nav_bar.dart';

void main() {
  runApp(const GadgetPortApp());
}

class GadgetPortApp extends StatelessWidget {
  const GadgetPortApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gadget-Port',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gadget-Port'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Icon(Icons.shopping_cart_outlined),
                SizedBox(width: 16),
                Icon(Icons.favorite_border),
                SizedBox(width: 16),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.blue,
                  child: Text('P', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Full Name: pertama'),
            const Text('Email: pertama@gmail.com'),
            const Text('Address:'),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Edit Profile'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Add Bio'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Bio:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text('No bio available. Add one!'),
            const SizedBox(height: 20),
            const Text(
              'Quick Access',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildQuickAccessButton('Dashboard'),
                _buildQuickAccessButton('Products'),
                _buildQuickAccessButton('Store'),
                _buildQuickAccessButton('Cart'),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Purchase History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No purchase history available.'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}

Widget _buildQuickAccessButton(String label) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Text(label, style: const TextStyle(color: Colors.white)),
  );
}
