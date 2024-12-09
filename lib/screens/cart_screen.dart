import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/screens/checkout_screen.dart';
import 'package:gadget_port_mobile/widgets/app_bar.dart';
import 'package:gadget_port_mobile/widgets/bottom_nav_bar.dart';

class CartScreen extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CartScreen({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the theme data
    final ThemeData theme = Theme.of(context);

    final List<Map<String, dynamic>> stores = [
      {
        'name': 'Samsung Official Store',
        'isOfficial': true,
        'items': [
          {
            'name': 'Samsung Galaxy S24 FE [8/256] - Graphite Smartphone AI',
            'price': 8999100,
            'originalPrice': 10999000,
            'discount': '18%',
            'variant': 'Graphite',
            'image': 'https://via.placeholder.com/100',
          },
        ],
      },
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Gadget Port'),
      body: Column(
        children: [
          // Cart items grouped by store
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: stores.length,
              itemBuilder: (context, storeIndex) {
                final store = stores[storeIndex];
                return Column(
                  children: [
                    // Store header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                          const Icon(
                            Icons.verified,
                            size: 20,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            store['name'],
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Store items
                    ...List.generate(
                      store['items'].length,
                      (itemIndex) {
                        final item = store['items'][itemIndex];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[200]!),
                            borderRadius: itemIndex == store['items'].length - 1
                                ? const BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  )
                                : null,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Checkbox
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Checkbox(
                                  value: false,
                                  onChanged: (value) {},
                                ),
                              ),
                              // Product image
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    item['image'],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Product details
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (item['discount'] != null)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.red[50],
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            item['discount'],
                                            style: theme.textTheme.bodySmall?.copyWith(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item['name'],
                                        style: theme.textTheme.titleSmall,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (item['variant'] != null) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          item['variant'],
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                      const SizedBox(height: 8),
                                      if (item['originalPrice'] != null)
                                        Text(
                                          'Rp${item['originalPrice'].toString().replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}',
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                            decoration: TextDecoration.lineThrough,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      Text(
                                        'Rp${item['price'].toString().replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}',
                                        style: theme.textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Action buttons
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.note_alt_outlined),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.favorite_border),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {},
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () {},
                                        ),
                                        Text('1'),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),

          // Footer with total price and checkout button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  const Text('Select All'),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total: Rp8.999.100',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckoutScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(
        selectedIndex: 3,
      ),
    );
  }
}