import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:gadget_port_mobile/screens/home_screen.dart';

class GetStartedButton extends StatefulWidget {
  final Function onTap;
  final Function onAnimatinoEnd;
  final double elementsOpacity;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const GetStartedButton({
    super.key,
    required this.onTap,
    required this.onAnimatinoEnd,
    required this.elementsOpacity,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  State<GetStartedButton> createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<GetStartedButton> {
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    String username = widget.usernameController.text;
    String password = widget.passwordController.text;

    final request = context.read<CookieRequest>();

    final response = await request.login(
      "http:///localhost:8000/signin/login_flutter/", // Gunakan IP emulator Android
      {'username': username, 'password': password},
    );

    setState(() {
      _isLoading = false;
    });

    if (request.loggedIn) {
      String message = response['message'];
      String uname = response['username'];

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$message Selamat datang, $uname.")),
        );
      }
    } else {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Gagal'),
            content: Text(response['message']),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color.fromARGB(255, 191, 219, 254), // Warna tombol
              minimumSize: Size(double.infinity, 50),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 20),
            ),
          );
  }
}
