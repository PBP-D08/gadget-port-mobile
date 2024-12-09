import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const EditProfileApp());
}

class EditProfileApp extends StatelessWidget {
  const EditProfileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edit Profile',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 191, 219, 254),
        scaffoldBackgroundColor: const Color.fromARGB(255, 241, 247, 255),
      ),
      home: const EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProfile(); // Call GET request during initialization
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullnameController.dispose();
    _emailController.dispose();
    _alamatController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _fetchProfile() async {
    const url = 'http://127.0.0.1:8000/user/profile/json'; // Adjust the endpoint
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body)[0]; // Assuming you're fetching a single profile
        setState(() {
          _usernameController.text = data['user__username'];
          _fullnameController.text = data['user__full_name'];
          _emailController.text = data['user__email'];
          _alamatController.text = data['user__alamat'];
          _bioController.text = data['user__bio'] ?? '';
        });
      } else {
        _showErrorSnackBar('Failed to load profile.');
      }
    } catch (e) {
      _showErrorSnackBar('Error fetching profile: $e');
    }
  }

  Future<void> _saveProfile() async {
    const url = 'http://127.0.0.1:8000/user/profile'; // Adjust the endpoint
    final body = json.encode({
      'user__username': _usernameController.text,
      'user__full_name': _fullnameController.text,
      'user__email': _emailController.text,
      'user__alamat': _alamatController.text,
      'user__bio': _bioController.text,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        _showSuccessSnackBar('Profile saved successfully!');
      } else {
        _showErrorSnackBar('Failed to save profile.');
      }
    } catch (e) {
      _showErrorSnackBar('Error saving profile: $e');
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Edit Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 191, 219, 254),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _usernameController,
                    label: 'Username',
                    placeholder: 'Enter your username',
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _fullnameController,
                    label: 'Full Name',
                    placeholder: 'Enter your full name',
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    placeholder: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _alamatController,
                    label: 'Address',
                    placeholder: 'Enter your address',
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _bioController,
                    label: 'Bio',
                    placeholder: 'Enter your bio',
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _saveProfile(); // Call POST request on save
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 191, 219, 254),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String placeholder = '',
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: placeholder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 191, 219, 254),
                width: 2,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '$label cannot be empty.';
            }
            return null;
          },
        ),
      ],
    );
  }
}
