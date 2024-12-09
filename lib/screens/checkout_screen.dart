import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPaymentMethod = 'BNI Virtual Account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 191, 219, 254),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address Section
            _buildAddressSection(),
            
            // Plus Membership Banner
            _buildPlusMembershipBanner(),
            
            // Store and Product Section
            _buildStoreAndProductSection(),
            
            // Delivery Options Section
            _buildDeliveryOptionsSection(),
            
            // Add Note Section
            _buildAddNoteSection(),
            
            // Promo Code Section
            _buildPromoCodeSection(),
            
            // Payment Method Section
            _buildPaymentMethodSection(),
            
            // Order Summary Section
            _buildOrderSummarySection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomPaymentButton(),
    );
  }

  Widget _buildAddressSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'Alamat pengiriman kamu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right),
                  ],
                ),
                const Text(
                  'gedung PESANTREN MAHASISWA ALHIKAM Sebelah a...',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlusMembershipBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/plus_icon.png',
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Terbatas Coba PLUS Gratis 30 hari',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Nikmati Bebas Ongkir tanpa batas dan keuntungan lainnya!',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildStoreAndProductSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.verified, color: Colors.green, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Dojiso Official Sport Store',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Image.network(
                'https://via.placeholder.com/60',
                width: 60,
                height: 60,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Payung Otomatis 3 lipat anti UV (Bahan Vinyl) Anti Panas',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 4),
                    Text('Hitam'),
                    SizedBox(height: 4),
                    Text(
                      'Rp35.000',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 52, 152, 219),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOptionsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'BEBAS ONGKIR',
                style: TextStyle(
                  color: Color.fromARGB(255, 52, 152, 219),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('Bisa COD'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.access_time, size: 20),
              SizedBox(width: 8),
              Text('Estimasi tiba besok - 13 Dec'),
              Spacer(),
              Icon(Icons.chevron_right),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.verified_user_outlined, size: 20),
              const SizedBox(width: 8),
              const Text('Pakai '),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Asuransi Pengiriman',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color.fromARGB(255, 52, 152, 219),
                  ),
                ),
              ),
              const Text(' (Rp300)'),
              const Spacer(),
              Icon(
                Icons.check_circle,
                color: Colors.green.shade400,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddNoteSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Icon(Icons.note_add_outlined),
          SizedBox(width: 8),
          Text('Kasih Catatan'),
          Spacer(),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green.shade400),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Kupon promo berhasil dipakai!',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text('Yay, kamu hemat Rp11.500 🎉'),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Metode pembayaran',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Lihat Semua',
                style: TextStyle(
                  color: Color.fromARGB(255, 52, 152, 219),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildPaymentOption(
            'BNI Virtual Account',
            'assets/images/bni_logo.png',
            isSelected: selectedPaymentMethod == 'BNI Virtual Account',
          ),
          const SizedBox(height: 8),
          _buildPaymentOption(
            'COD (Bayar di Tempat)',
            'assets/images/cod_icon.png',
            isSelected: selectedPaymentMethod == 'COD',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String title, String iconPath, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 52, 152, 219)
                : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 12),
            Text(title),
            const Spacer(),
            isSelected
                ? const Icon(
                    Icons.radio_button_checked,
                    color: Color.fromARGB(255, 52, 152, 219),
                  )
                : Icon(Icons.radio_button_off, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummarySection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cek ringkasan transaksimu, yuk',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildSummaryItem('Total Harga (1 Barang)', 'Rp35.000'),
          _buildSummaryItem('Total Ongkos Kirim', 'Rp0', originalPrice: 'Rp11.500'),
          _buildSummaryItem('Total Asuransi Pengiriman', 'Rp300'),
          _buildSummaryItem('Total Biaya Proteksi (1 Polis)', 'Rp1.000'),
          _buildSummaryItem('Biaya Jasa Aplikasi', 'Rp1.000', originalPrice: 'Rp2.000'),
          _buildSummaryItem('Biaya Layanan', 'Rp1.000'),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total Tagihan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Rp38.300',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 52, 152, 219),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String price, {String? originalPrice}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Row(
            children: [
              if (originalPrice != null) ...[
                Text(
                  originalPrice,
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Text(price),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPaymentButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -4),
            blurRadius: 8,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 52, 152, 219),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.lock_outline,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Bayar Sekarang',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Extension method for price formatting (optional)
extension PriceFormatter on String {
  String toRupiah() {
    return 'Rp$this';
  }
}