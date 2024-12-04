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

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/images/Logo_gadget-port.png', // Make sure this path is correct
        height: 40, // Adjust the size of the logo
      ),
      backgroundColor: Color.fromARGB(255, 191, 219, 254), // Adjust the AppBar background color
      centerTitle: true, // Center the logo
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Default AppBar height
}
