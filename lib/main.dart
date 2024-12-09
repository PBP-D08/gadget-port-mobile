import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<CookieRequest>(
      // Pastikan Anda mendefinisikan 'create' dengan benar
      create: (_) => CookieRequest(),
      child: MaterialApp(
        title: 'HouseHunt',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[200],
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.grey,
          ).copyWith(secondary: Colors.grey[800]),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Center(
        child: Text('Welcome to Login Page'),
      ),
    );
  }
}
