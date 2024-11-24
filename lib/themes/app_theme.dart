import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFF222831), // Hitam untuk navbar
      scaffoldBackgroundColor: const Color(0xFFEEEEEE), // Abu-abu terang untuk background
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF222831), // Navbar
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF222831), // Navbar
        selectedItemColor: Color(0xFF00ADB5), // Hijau toska untuk ikon terpilih
        unselectedItemColor: Color(0xFF393E46), // Abu-abu gelap untuk ikon tidak terpilih
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black, fontSize: 18),
        bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00ADB5), // Hijau toska untuk tombol
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
