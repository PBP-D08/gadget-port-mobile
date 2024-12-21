import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/main.dart';
import 'package:http/http.dart' as http;
import 'package:gadget_port_mobile/screens/product/detail_product.dart';
import 'package:intl/intl.dart';
import '../widgets/app_bar.dart';
import 'product/product_card.dart';
import '../widgets/bottom_nav_bar.dart';
import 'review/review_page.dart';
import '../models/products.dart'; // Ganti dengan path yang sesuai

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Katalog> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8000/products/json/'));

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

// Future<void> fetchStore() async {} // buat fetch store nanti taro di storeMap

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Gadget Port'),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : products.isEmpty
              ? Center(child: Text('No products available'))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
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
                                storeMap: {},
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
      bottomNavigationBar: const BottomNavBar(
        selectedIndex: 0,
      ),
    );
  }
}
