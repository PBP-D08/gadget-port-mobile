# Proyek Akhir Semester PBP D08
## GadgetPort📱💻🛒
_"Empowering Your World, One Gadget at a Time"_  <br>
link APK : [GadgetPort]() # TBA

### Nama Anggota 🧑‍🎓👩‍🎓👨‍🎓🧑‍🎓👨‍🎓
1. Akhyar Rasyid Asy syifa (2306241682)
2. Ahmad Nizar Sauki (2306152046)
3. Muhammad Farid Hasabi (2306152512)
4. Micheline Wijaya Limbergh (2306207013)
5. Muhammad Albyarto Ghazali (2306241695)

### Deskripsi Singkat 🛍️
Di tengah pesatnya perkembangan teknologi dan tingginya permintaan pasar terhadap barang elektronik, kami melihat adanya kebutuhan yang mendesak untuk menyediakan solusi yang inovatif. Batam, dengan lokasi strategisnya dan akses logistik yang mudah ke negara-negara tetangga, memiliki potensi besar untuk menjadi pusat perdagangan elektronik yang menjangkau pasar internasional. Banyak konsumen di Indonesia, khususnya yang mencari produk elektronik berkualitas, harus berkeliling dari satu toko ke toko lainnya hanya untuk menemukan produk yang mereka inginkan. Selain itu, sulitnya membandingkan harga dan kualitas di antara berbagai toko sering kali memakan waktu dan tenaga.

Sebagai solusi, kami memperkenalkan "GadgetPort", sebuah platform canggih yang dirancang khusus untuk memenuhi kebutuhan generasi modern dalam membeli produk elektronik. GadgetPort memudahkan para penjual dan pembeli elektronik untuk bertemu dalam satu tempat digital yang terorganisir. Penjual dapat dengan mudah merilis produk terbaru mereka beserta informasi rinci, sementara pembeli dapat melihat katalog produk, melihat ulasan pengguna, dan langsung membeli produk yang diinginkan secara aman dan nyaman.

#### Fitur-fitur unggulan GadgetPort 
- **Filter Produk Cerdas** – Memungkinkan pengguna untuk mencari produk sesuai kategori seperti smartphone, laptop, dan headset, serta memfilter berdasarkan harga dan brand.
- **Memberi dan Membaca Ulasan** – Sebelum melakukan pembelian, pembeli dapat membaca ulasan dari pengguna lain untuk memastikan kualitas dan keunggulan produk yang mereka pilih. Setelah melakukan pembelian, pembeli juga bisa memberikan ulasan produk tersebut. 
- **Pembelian Product** – Memberikan pengalaman belanja yang aman, cepat, dan real-time dengan berbagai opsi pembayaran.
- **Wishlist** – Fitur wishlist memudahkan pengguna menyimpan produk yang ingin dibeli nanti.
- **Frequently Asked Question** - Memudahkan pengguna mencari solusi apabila terjadi kesalahan pada aplikasi secara umum yang sering dijumpai.
- **Update profil** - Pengguna dapat memperbarui profil.

Kami percaya bahwa dengan menghadirkan GadgetPort, kami tidak hanya memberikan solusi modern untuk kebutuhan belanja produk elektronik, tetapi juga membantu menghubungkan konsumen dengan toko-toko terpercaya di Batam dan seluruh Indonesia. Melalui platform ini, harapan untuk menghadirkan pengalaman belanja elektronik yang lebih mudah, transparan, dan efisien bukan lagi sekedar wacana, melainkan sebuah langkah nyata yang dapat diwujudkan bersama-sama. Dengan GadgetPort, masa depan belanja elektronik ada di genggaman Anda.

### Daftar Modul 🧑🏻‍💻
Berikut adalah daftar modul yang diimplementasikan:
1. **Modul Authentication & User Management — Bersama** 
   
      Modul ini untuk autentikasi akun User (Pelanggan dan Admin).
   
      | Pelanggan dan Admin |
      | :------------------- |
      |Pendaftaran pengguna (register), login, dan logout. |
      |Manajemen profil pengguna (menambahkan informasi seperti nama, email, foto).|
      |Validasi email atau nomor telepon untuk keamanan tambahan.|

3. **Modul Katalog Produk — Bersama** 

      Modul ini berfungsi untuk melihat detail produk serta dapat menggunakan filter untuk pencarian produk.
      
      Pelanggan | Admin
      -|-
      Pelanggan dapat melihat daftar produk yang dijual berdasarkan kategori (smartphone. laptop, headset)| Admin dapat menambah dan menghapus produk. |
      Pelanggan dapat menggunakan filter (harga, brand, dll).| Admin dapat menggunakan filter pencarian. |
      Pelanggan dapat melihat detail produk yang lengkap, termasuk spesifikasi, gambar, review, pengguna, dan rating| Admin dapat mengedit detail produk. |

4. **Modul Cart & Checkout — Ahmad Nizar Sauki**
      
      Modul ini berfungsi sebagai proses pembayaran.
   
      | Pelanggan |
      | -------   |
      |Pelanggan dapat menambahkan produk ke keranjang belanja. |
      |Pelanggan dapat memilih metode pembayaran (transfer bank, kartu kredit, e-wallet).|
      | Pelanggan dapat konfirmasi pembelian dan pengaturan pengiriman produk. |
5. **Modul Review dan Rating Produk — Muhammad Farid Hasabi** 
   
      Modul ini berfungsi untuk memberikan review dan rating terhadap suatu produk.
      
      Pelanggan | Admin
      -|-
      Pelanggan dapat memberikan ulasan dan rating untuk tiap produk.|Admin dapat menghapus review yang telah dibuat oleh Pelanggan.
6. **Modul Wishlist dan Frequently Asked Question (FAQ) — Akhyar Rasyid Asy syifa** 
   
      Modul ini berfungsi untuk melihat daftar wishlist dan Frequently Asked Question (F.A.Q).
    
      | Pelanggan | Admin |
      | --------- | ----- |
      | Pengguna dapat melihat kumpulan pertanyaan yang sering ditanyakan terkait penggunaan aplikasi, produk, dan layanan.| Admin dapat menambah, mengedit, dan menghapus daftar Frequently Asked Question. |
      | Pengguna dapat menambahkan produk ke wishlist untuk dibeli atau dilihat nanti.| -  |
   
7. **Modul Profile — Micheline Wijaya Limbergh**
    
     Modul ini berfungsi untuk mengubah data pada profil User.
     
     | Pelanggan | Admin |
     | --------- | ----- |
     | Pelanggan dapat mengubah nama, email, foto profil.| Admin bisa mengubah nama, email, dan foto profil|
     | Pelanggan dapat mengubah password | Admin dapat mengubah password |
     | Pelanggan dapat melihat history transaksi pemesanan. | -|
   
8. **Modul Toko — Muhammad Albyarto Ghazali**

      Modul ini berfungsi untuk mengatur pengelolaan produk yang dijual oleh toko, termasuk kategori produk dan harga.
   
      Pelanggan|Admin
      -|-
      Pelanggan dapat melihat tiap produk yang dijual oleh toko, termasuk kategori produk dan harga.|Admin dapat menambah, mengubah, serta menghapus produk pada toko mereka.

### Sumber Dataset 📊
Kategori Utama : Gadget

**Produk**:
- HP
- Laptop
- Headset/TWS

Headset    : https://www.kaggle.com/datasets/midhundasl/amazon-headset-specs <br>
HP         : https://www.kaggle.com/datasets/veer098/mobile-phone <br>
Laptop     : https://www.kaggle.com/datasets/owm4096/laptop-prices <br>

### Role pengguna 🙋🏻‍♀
- **Pelanggan** (perlu login)
    - Melihat daftar dan detail produk gadget
    - Memasukkan produk ke wishlist
    - Memasukkan produk ke keranjang
    - Membeli produk (mengakses fitur checkout)
    - Menambahkan review produk yang sudah dibeli
    - Mengakses fitur sort dan filter kategori gadget
    - Mencari berdasarkan nama produk gadget
- **Admin** (perlu login)
    - Menambah produk yang ingin dijual
    - Mengedit dan menghapus detail produk dan produk yang dijual 

### Alur pengintegrasian dengan web service
Langkah yang kami lakukan untuk mengintegrasikan GadgetPort mobile dengan web service Django adalah:
1. Mengimplementasikan REST API pada Django views.py dengan menggunakan JsonResponse atau Django JSON Serializer.
2. Menambahkan dependensi http ke proyek; dependensi ini digunakan untuk bertukar HTTP request antara aplikasi dengan web service.
3. Menggunakan dependensi `pbp_django_auth` untuk mengintegrasi *authentication* dari django web service
4. Membuat model sesuai dengan respons dari data yang berasal dari web service GadgetPort.
5. Membuat http request ke web service menggunakan dependensi http.
6. Mengkonversikan objek yang didapatkan dari web service ke model yang telah dibuat sebelumnya.
7. Menampilkan data yang telah dikonversi ke aplikasi dengan  `FutureBuilder`
8. Memanfaatkan method class `CookieRequest` dari `pbp_django_auth`, seperti `.login()`, dan `.register()` untuk mengurus request login dan register akun baru melalui aplikasi *mobile*.
9. Mengimplementasikan back-end pada project Django dengan menggunakan konsep asynchronous HTTP.
