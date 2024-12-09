import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/models/store.dart';
import 'package:gadget_port_mobile/models/products.dart';

class StoreDetailPage extends StatefulWidget {
  final Store store;
  final List<Katalog> products;

  const StoreDetailPage({Key? key, required this.store, required this.products})
      : super(key: key);

  @override
  _StoreDetailPageState createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  bool _isStoreOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.store.fields.nama),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.shade100,
                          Colors.blue.shade50,
                          Colors.white
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Hero(
                      tag: 'store_logo_${widget.store.pk}',
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white, width: 3),
                          image: widget.store.fields.logo.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(widget.store.fields.logo),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: widget.store.fields.logo.isEmpty
                            ? Icon(Icons.store, size: 50, color: Colors.grey)
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Navigate to edit store page
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Show delete confirmation dialog
                },
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Store Details Section
                _buildStoreDetailsCard(),

                // Products Section
                SizedBox(height: 20),
                _buildProductsSection(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreDetailsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address
            _buildDetailRow(
              icon: Icons.location_on,
              title: 'Address',
              subtitle: widget.store.fields.alamat,
            ),
            SizedBox(height: 16),

            // Contact
            _buildDetailRow(
              icon: Icons.phone,
              title: 'Contact',
              subtitle: widget.store.fields.nomorTelepon,
            ),
            SizedBox(height: 16),

            // Operating Hours
            _buildOperatingHoursSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      {required IconData icon,
      required String title,
      required String subtitle}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue, size: 24),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(subtitle, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOperatingHoursSection() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isStoreOpen ? Colors.green : Colors.red,
            ),
          ),
          SizedBox(width: 10),
          Text(
            _isStoreOpen ? 'Currently Open' : 'Currently Closed',
            style: TextStyle(
              color: _isStoreOpen ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Text(
            '${widget.store.fields.jamBuka} - ${widget.store.fields.jamTutup}',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Products',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        widget.products.isEmpty
            ? _buildNoProductsWidget()
            : _buildProductGrid(),
      ],
    );
  }

  Widget _buildNoProductsWidget() {
    return Center(
      child: Column(
        children: [
          Icon(Icons.inbox, size: 80, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            'No Products Available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        final product = widget.products[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildProductCard(Katalog product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                image: product.fields.imageLink.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(product.fields.imageLink),
                        fit: BoxFit.contain,
                      )
                    : null,
              ),
              child: product.fields.imageLink.isEmpty
                  ? Center(child: Icon(Icons.image_not_supported))
                  : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.fields.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  product.fields.brand,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rp ${product.fields.price.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to product details
                      },
                      child: Text('View'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(60, 30),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
