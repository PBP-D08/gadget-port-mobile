import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/auth/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const GadgetPort());
}

class GadgetPort extends StatelessWidget {
  const GadgetPort({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Gadget Port',
  //     theme: AppTheme.lightTheme,
  //     home: const LoginPage(),
  //   );
  // }

    // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Gadget Port',
        theme: ThemeData(

        colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.lightBlue,
        ).copyWith(secondary: Colors.white),

        scaffoldBackgroundColor: Colors.lightBlue[100]),
        home: const LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
