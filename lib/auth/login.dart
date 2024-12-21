import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/main.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:gadget_port_mobile/auth/register.dart';
import 'package:gadget_port_mobile/auth/widgets/login_button.dart';
import '/../themes/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  double _elementsOpacity = 1;
  bool loadingBallAppear = false;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }
// Future<void> loginUser(String username, String password) async {
//   try {
//     setState(() {
//       loadingBallAppear = true;
//     });

//     final request = context.read<CookieRequest>();
//     final response = await request.login(
//       "http://localhost:8000/signin/login_flutter/",
//       {'username': username, 'password': password},
//     );

//     if (response != null && response['username'] != null) {
//       Map<String, dynamic> userData = {
//         "username": response["username"],
//       };
      
//       print("Data before login: $userData");
//       UserInfo.login(userData);
//       print("UserInfo after login: ${UserInfo.data}");
      
//       if (UserInfo.loggedIn) {
//         print("Login successful: ${UserInfo.getString('username')}");
//       } else {
//         print("Login failed: UserInfo not updated properly");
//       }
//     } else {
//       print("Invalid response format: $response");
//     }
//   } catch (e) {
//     print("Error during login: $e");
//   } finally {
//     setState(() {
//       loadingBallAppear = false;
//     });
//   }
// }
Future<void> loginUser(String username, String password) async {
  try {
    setState(() {
      loadingBallAppear = true;
    });

    final request = context.read<CookieRequest>();
    final response = await request.login(
      "http://localhost:8000/signin/login_flutter/",
      {'username': username, 'password': password},
    );
    if (response != null) {
      // Print setiap key yang ada di response
      response.forEach((key, value) {
        print("Key: $key, Value: $value");
      });

      Map<String, dynamic> userData = {
        "username": response["username"],
      };
      UserInfo.login(userData);
    }
  } catch (e, stackTrace) {
    print("Error during login: $e");
    print("Stack trace: $stackTrace");
  }
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Use the predefined light theme
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          bottom: false,
          child: loadingBallAppear
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 70),
                        TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 300),
                          tween: Tween(begin: 1, end: _elementsOpacity),
                          builder: (_, value, __) => Opacity(
                            opacity: value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/Logo_gadget-port.png', // Make sure this path is correct
                                  height: 60, // Adjust the size of the logo
                                ),
                                const SizedBox(height: 25),
                                Text(
                                  "Sign in to continue",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize: 35,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              TextField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  hintText: 'Enter your username',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  hintText: 'Enter your password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                obscureText: true,
                              ),
                              const SizedBox(height: 40),
                              GetStartedButton(
                                usernameController: usernameController,
                                passwordController: passwordController,
                                elementsOpacity: _elementsOpacity,
                                onTap: () async {
                                  setState(() {
                                    _elementsOpacity = 0;
                                  });

                                  await loginUser(
                                    usernameController.text,
                                    passwordController.text,
                                  );

                                  setState(() {
                                    _elementsOpacity = 1;
                                  });
                                },
                                onAnimatinoEnd: () async {
                                  await Future.delayed(
                                      const Duration(milliseconds: 500));
                                  setState(() {
                                    loadingBallAppear = true;
                                  });
                                },
                              ),
                              const SizedBox(height: 36.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Register',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 52, 152, 219),
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
