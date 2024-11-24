import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.teal,
      scaffoldBackgroundColor: const Color(0xFFEFF5F5), // Warna mint terang
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.teal,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black, fontSize: 18),
        bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}
