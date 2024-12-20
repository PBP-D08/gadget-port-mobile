import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/auth/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const GadgetPort());
}

class UserInfo {
  static bool loggedIn = false;
  static Map<String, dynamic> data = {};

  static void login(Map<String, dynamic> data) {
    loggedIn = true;
    UserInfo.data = data;
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
        home: const LoginPage(),
        // home: const HomeScreen()

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