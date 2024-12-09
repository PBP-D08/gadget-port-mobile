import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/screens/store/store_detail_screen.dart';
import 'package:gadget_port_mobile/models/store.dart';
import 'package:gadget_port_mobile/widgets/bottom_nav_bar.dart'; 

class StoreListPage extends StatefulWidget {
  const StoreListPage({Key? key}) : super(key: key);

  @override
  _StoreListPageState createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  final List<Store> stores = [
    Store(
      model: Model.STORE_STORE,
      pk: 1,
      fields: Fields(
        user: 1,
        nama: 'iBox Batam', 
        alamat: 'Jalan Batam',
        nomorTelepon: '+62123456789',
        logo: 'https://via.placeholder.com/128',
        jamBuka: '09:00',
        jamTutup: '21:00'
      )
    ),
    Store(
      model: Model.STORE_STORE,
      pk: 2,
      fields: Fields(
        user: 2,
        nama: 'Toko Makmur Jaya', 
        alamat: 'Jalan Batam 2',
        nomorTelepon: '+62987654321',
        logo: 'https://via.placeholder.com/128',
        jamBuka: '08:00',
        jamTutup: '22:00'
      )
    ),
  ];

  int _selectedIndex = 1;

  void _showAddStoreModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddStoreModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GadgetPort Stores'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddStoreModal,
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemCount: stores.length,
        itemBuilder: (context, index) {
          final store = stores[index];
          return _buildStoreCard(store);
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildStoreCard(Store store) {
    return GestureDetector(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Store Logo
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade50, Colors.grey.shade50],
                ),
              ),
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    image: DecorationImage(
                      image: NetworkImage(store.fields.logo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            
            // Store Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          store.fields.nama,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Text(
                          store.fields.alamat,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${store.fields.jamBuka} - ${store.fields.jamTutup}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to store detail page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoreDetailPage(store: store, products: [],),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[50],
                        foregroundColor: Colors.blue[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Visit Store'),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddStoreModal extends StatefulWidget {
  @override
  _AddStoreModalState createState() => _AddStoreModalState();
}

class _AddStoreModalState extends State<AddStoreModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  final TextEditingController _jamBukaController = TextEditingController();
  final TextEditingController _jamTutupController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Store',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 20),
                _buildTextFormField(
                  controller: _namaController,
                  label: 'Store Name',
                  validator: (value) => value?.isEmpty ?? true ? 'Please enter store name' : null,
                ),
                SizedBox(height: 10),
                _buildTextFormField(
                  controller: _alamatController,
                  label: 'Address',
                  validator: (value) => value?.isEmpty ?? true ? 'Please enter store address' : null,
                ),
                SizedBox(height: 10),
                _buildTextFormField(
                  controller: _nomorTeleponController,
                  label: 'Phone Number',
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildTimeField(
                        controller: _jamBukaController,
                        label: 'Open Time',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildTimeField(
                        controller: _jamTutupController,
                        label: 'Close Time',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Add Store',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildTimeField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: Icon(Icons.access_time),
      ),
      readOnly: true,
      onTap: () async {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          controller.text = pickedTime.format(context);
        }
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create a new Store object
      final newStore = Store(
        model: Model.STORE_STORE,
        pk: DateTime.now().millisecondsSinceEpoch, // Temporary unique ID
        fields: Fields(
          user: 1, // You might want to get the current user's ID dynamically
          nama: _namaController.text,
          alamat: _alamatController.text,
          nomorTelepon: _nomorTeleponController.text,
          logo: 'https://via.placeholder.com/128', // You might want to add logo upload functionality
          jamBuka: _jamBukaController.text,
          jamTutup: _jamTutupController.text,
        ),
      );

      // Process form submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Store Added Successfully!')),
      );
      Navigator.pop(context);
    }
  }
}