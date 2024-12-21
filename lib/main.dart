import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/auth/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const GadgetPort());
}

// Session
class UserInfo {
  static bool loggedIn = false;
  static Map<String, dynamic> data = {};

  static void login(Map<String, dynamic> userData) {
    if (userData.isEmpty) {
      print("Warning: userData is empty!");
      return;
    }

    if (userData['username'] == null) {
      print("Warning: username is null in userData!");
      return;
    }

    loggedIn = true;
    data = Map<String, dynamic>.from(userData); // Create a new copy
    
    print("UserInfo.loggedIn: $loggedIn"); // Debug print
  }

  static void logout() {
    loggedIn = false;
    data = {};
  }
}

class GadgetPort extends StatelessWidget {
  const GadgetPort({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gadget Port',
        theme: AppTheme.lightTheme,
        // home: const LoginPage(),
        home: const HomeScreen()
      ),
    );
  }
}


// Method Buat Logout, mungkin taro di Profile


// void logout() {
//   UserInfo.logout();
//   Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(builder: (context) => const LoginPage()),
//   );
// }