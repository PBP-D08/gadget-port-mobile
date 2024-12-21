import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF222831), // Primary color (Navbar)
        secondary: Color(0xFF00ADB5), // Secondary color (Accent color)
      ),
      scaffoldBackgroundColor:
          const Color(0xFFEEEEEE), // Abu-abu terang untuk background
      appBarTheme: AppBarTheme(
        backgroundColor:
            const Color.fromARGB(255, 158, 197, 255), // Navbar background
        titleTextStyle: GoogleFonts.nunito(
          fontWeight: FontWeight.bold, // Apply bold weight to the font
          color: Colors.black, // Set text color
          fontSize: 20, // Set font size
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF222831), // Navbar background color
        selectedItemColor: Color(0xFF00ADB5), // Icon color when selected
        unselectedItemColor: Color(0xFF393E46), // Icon color when not selected
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black, fontSize: 18),
        bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00ADB5), // Button background color
        ),
      ),
    );
  }
}
