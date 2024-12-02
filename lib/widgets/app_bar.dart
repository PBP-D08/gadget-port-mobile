import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      // actions: [
      // ],
      // titleTextStyle: TextStyle(
      //   color: Colors.lightBlue[200],
      //   fontWeight: FontWeight.w900,
      //   fontFamily: 'Nunito',
      //   fontSize: 20,
      // ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
