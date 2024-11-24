import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const GadgetPort());
}

class GadgetPort extends StatelessWidget {
  const GadgetPort({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gadget Port',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
