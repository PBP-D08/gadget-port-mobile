import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/product_card.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Gadget Port'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return const ProductCard(
              productName: 'Laptop Gaming',
              productPrice: 'Rp 15.000.000',
              imageUrl: 'https://via.placeholder.com/150',
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0,),
    );
  }
}
