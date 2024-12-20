import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/module/profile/add_bio.dart';
import 'package:gadget_port_mobile/module/profile/checkout_history.dart';
import 'package:gadget_port_mobile/module/profile/edit_bio.dart';
import 'package:gadget_port_mobile/module/profile/edit_profile.dart';
import 'package:google_fonts/google_fonts.dart';
import '/../widgets/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String fullName = 'Loading...';
  String email = 'Loading...';
  String address = 'Loading...';
  String bio = '';  // Menambahkan field untuk bio

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/user/profile/view/json/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        fullName = data['user__full_name'] ?? 'No Name';
        email = data['user__email'] ?? 'No Email';
        address = data['user__alamat'] ?? 'No Address';
        bio = data['user__bio'] ?? '';  // Menyimpan bio
      });
    } else {
      // Handle error if needed
      setState(() {
        fullName = 'Failed to load data';
        email = 'Failed to load data';
        address = 'Failed to load data';
      });
    }
  }

  Future<void> _deleteBio() async {
    // Panggil API untuk menghapus bio
    final response = await http.delete(Uri.parse('http://127.0.0.1:8000/user/profile/delete_bio/'));

    if (response.statusCode == 200) {
      setState(() {
        bio = '';  // Hapus bio dari state setelah berhasil dihapus
      });
    } else {
      // Tangani jika penghapusan gagal
      print('Failed to delete bio');
    }
  }

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
              'Profile: ',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Full Name: $fullName'),
            Text('Email: $email'),
            Text('Address: $address'),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                    );
                  },
                  child: const Text('Edit Profile'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BioApp()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Add Bio'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Bio: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            bio.isEmpty
                ? const Text('No bio available. Add one!')
                : Column(
                    children: [
                      Text(bio),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const EditBioApp()),
                              );
                            },
                            child: const Text('Edit Bio'),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: _deleteBio,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, // Warna merah untuk tombol delete
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Delete Bio'),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                _buildQuickAccessButton(context, 'Dashboard', const CheckoutHistoryApp()),
                _buildQuickAccessButton(context, 'Products', const EditBioApp()),
                _buildQuickAccessButton(context, 'Store', const EditProfileApp()),
                _buildQuickAccessButton(context, 'Cart', const BioApp()),
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

Widget _buildQuickAccessButton(BuildContext context, String label, Widget destination) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Text(label, style: const TextStyle(color: Colors.white)),
  );
}