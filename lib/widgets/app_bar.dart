// import 'package:flutter/material.dart';
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   const CustomAppBar({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(title),
//       centerTitle: true,
//       // actions: [
//       // ],
//       // titleTextStyle: TextStyle(
//       //   color: Colors.lightBlue[200],
//       //   fontWeight: FontWeight.w900,
//       //   fontFamily: 'Nunito',
//       //   fontSize: 20,
//       // ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

@override
Widget build(BuildContext context) {
  return AppBar(
    backgroundColor: Color.fromARGB(255, 191, 219, 254), // Warna latar belakang AppBar
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Mengatur ruang antara logo dan ikon
      children: [
        // Logo di sebelah kiri
        Image.asset(
          'assets/images/Logo_gadget-port.png', // Pastikan path ini benar
          height: 40, // Sesuaikan ukuran logo
        ),
        // Ikon pencarian di sebelah kanan
        IconButton(
          icon: Icon(Icons.search), // Menggunakan ikon pencarian
          onPressed: () {
            // Tambahkan aksi yang diinginkan saat ikon ditekan
          },
        ),
      ],
    ),
    centerTitle: false, // Tidak memusatkan judul
  );
}

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Default AppBar height
}
