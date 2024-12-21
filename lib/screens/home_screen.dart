import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/auth/login.dart';
import 'package:gadget_port_mobile/auth/register.dart';
import 'package:gadget_port_mobile/main.dart';
import 'package:gadget_port_mobile/models/store.dart';
import 'package:gadget_port_mobile/screens/store/store_detail_screen.dart';
import 'package:gadget_port_mobile/screens/store/store_list_screen.dart';
import 'package:http/http.dart' as http;
import 'package:gadget_port_mobile/screens/product/detail_product.dart';
import 'package:intl/intl.dart';
import '../widgets/app_bar.dart';
import 'product/product_card.dart';
import '../widgets/bottom_nav_bar.dart';
import 'review/review_page.dart';
import '../models/products.dart'; // Ganti dengan path yang sesuai

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Katalog> products = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   Future<void> fetchProducts() async {
//     try {
//       final response = await http.get(Uri.parse('http://localhost:8000/products/json/'));

//       if (response.statusCode == 200) {
//         // print("HOMESCREEN" + UserInfo.data['Username']);

//         final List<dynamic> body = json.decode(response.body);
//         final List<Katalog> fetchedProducts = body.map((item) {
//           try {
//             return Katalog.fromJson(item);
//           } catch (e) {
//             print('Error parsing item: $item, Error: $e');
//             return null;
//           }
//         }).whereType<Katalog>().toList();

//         setState(() {
//           products = fetchedProducts;
//           isLoading = false;
//         });

//         if (products.isEmpty) {
//           print('No valid products found!');
//         }

//       } else {
//         throw Exception('Failed to load products');
//       }

//     } catch (e) {
//       print('Error during JSON parsing: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

// // Future<void> fetchStore() async {} // buat fetch store nanti taro di storeMap

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(title: 'Gadget Port'),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : products.isEmpty
//               ? Center(child: Text('No products available'))
//               : Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: GridView.builder(
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.8,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     itemCount: products.length,
//                     itemBuilder: (context, index) {
//                       final product = products[index];
//                       return ProductCard(
//                         productName: product.fields.name,
//                         productPrice: 'Rp ${NumberFormat('#,###', 'id_ID').format(product.fields.price)}',
//                         imageUrl: product.fields.imageLink,
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   DetailProductPage(product: product, storeMap: {},),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//       bottomNavigationBar: const BottomNavBar(
//         selectedIndex: 0,
//       ),
//     );
//   }
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Katalog> products = [];
  List<Store> stores = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchStore();
  }

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8000/products/json/'));
      // print(response.body);
      if (response.statusCode == 200) {
        // print("HOMESCREEN" + UserInfo.data['Username']);

        final List<dynamic> body = json.decode(response.body);
        final List<Katalog> fetchedProducts = body
            .map((item) {
              try {
                return Katalog.fromJson(item);
              } catch (e) {
                print('Error parsing item: $item, Error: $e');
                return null;
              }
            })
            .whereType<Katalog>()
            .toList();

        setState(() {
          products = fetchedProducts;
          isLoading = false;
        });

        if (products.isEmpty) {
          print('No valid products found!');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error during JSON parsing: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchStore() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8000/store/json/'));
      // print(response.body);
      if (response.statusCode == 200) {
        // print("HOMESCREEN" + UserInfo.data['Username']);

        final List<dynamic> body = json.decode(response.body);
        final List<Store> fetchedStores = body
            .map((item) {
              try {
                return Store.fromJson(item);
              } catch (e) {
                print('Error parsing item: $item, Error: $e');
                return null;
              }
            })
            .whereType<Store>()
            .toList();

        setState(() {
          stores = fetchedStores;
          isLoading = false;
        });

        if (products.isEmpty) {
          print('No valid products found!');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error during JSON parsing: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  List<Map<String, String>> categories = [
    {'name': 'iPhone', 'image': 'assets/images/iphone.webp'},
    {'name': 'Laptop', 'image': 'assets/images/laptop.webp'},
    {'name': 'Earphone', 'image': 'assets/images/earphone.webp'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Gadget Port'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!UserInfo.loggedIn) ...[
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login atau Register untuk kemudahan dalam berbelanja di GadgetPort. 😉',
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  const Color.fromARGB(255, 100, 153, 233),
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 100, 153, 233)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 10.0),
                            ),
                            child: const Text('Login'),
                          ),
                           const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(255, 100, 153, 233),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 10.0),
                            ),
                            child: const Text('Register'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Banner Section
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          category['image']!,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * 0.8,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Category Buttons
              const Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Action for All Products
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            Color.fromARGB(255, 100, 153, 233), // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                      ),
                      child: Text('All Products'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Action for Handphone
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 100, 153, 233),
                        backgroundColor:
                            Color.fromARGB(255, 255, 255, 255), // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Small circular border
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.smartphone), // Smartphone icon
                          SizedBox(width: 5),
                          Text('Handphone'),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Action for Laptop
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 100, 153, 233),
                        backgroundColor: const Color.fromARGB(
                            255, 254, 254, 254), // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Small circular border
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.laptop), // Laptop icon
                          SizedBox(width: 5),
                          Text('Laptop'),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Action for Earphone
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 100, 153, 233),
                        backgroundColor: const Color.fromARGB(
                            255, 255, 255, 255), // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Small circular border
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.headset), // Headphone icon
                          SizedBox(width: 5),
                          Text('Earphone'),
                        ],
                      ),
                    ),
                    // Add more buttons here if needed
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Top Products
              const Text(
                'Popular Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final selectedIndexes = [0, 50, 90, 84];
                    final productIndex = selectedIndexes[index];
                    if (productIndex >= products.length) {
                      return const SizedBox(); // Jika index melebihi panjang array
                    }
                    final product = products[productIndex];

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width *
                            0.4, // Lebar seragam
                        child: ProductCard(
                          productName: product.fields.name,
                          productPrice:
                              'Rp ${NumberFormat('#,###', 'id_ID').format(product.fields.price)}',
                          imageUrl: product.fields.imageLink,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailProductPage(
                                  product: product,
                                  stores: stores,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Container(
                width:
                    MediaQuery.of(context).size.width, // Lebar mengikuti layar
                height: 200, // Tinggi gambar kedua
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.asset(
                    'assets/images/brand.webp',
                    fit: BoxFit.cover, // Mengisi kontainer
                  ),
                ),
              ),
              // Gambar kedua
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoreDetailPage(
                        store: stores[7],
                        products: [],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      'assets/images/applestore.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Aksi saat tombol "More Stores" ditekan
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StoreListPage(), // Ganti dengan halaman yang sesuai
                          ),
                        );
                      }, // Action to perform when pressed
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 60), // Ukuran tombol
                        foregroundColor:
                            Color.fromARGB(255, 100, 153, 233), // Warna teks
                        backgroundColor: const Color.fromARGB(
                            255, 255, 255, 255), // Warna latar belakang
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color.fromARGB(
                                255, 100, 153, 233), // Warna border
                            width: 2, // Lebar border
                          ),
                          borderRadius:
                              BorderRadius.circular(20), // Radius border
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0), // Add vertical padding
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.store, // Icon store
                              color: Color.fromARGB(
                                  255, 100, 153, 233), // Warna icon
                            ),
                            SizedBox(height: 5), // Jarak antara icon dan teks
                            Text(
                              'More Stores',
                              style: TextStyle(fontSize: 20), // Ukuran teks
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'Best Sellers',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final selectedIndexes = [10, 80, 95, 30, 15];
                    final productIndex = selectedIndexes[index];
                    if (productIndex >= products.length) {
                      return const SizedBox(); // Jika index melebihi panjang array
                    }
                    final product = products[productIndex];

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width *
                            0.4, // Lebar seragam
                        child: ProductCard(
                          productName: product.fields.name,
                          productPrice:
                              'Rp ${NumberFormat('#,###', 'id_ID').format(product.fields.price)}',
                          imageUrl: product.fields.imageLink,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailProductPage(
                                  product: product,
                                  stores: stores,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(
        selectedIndex: 0,
      ),
    );
  }
}
