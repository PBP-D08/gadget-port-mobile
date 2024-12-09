import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const BioApp());
}

class BioApp extends StatelessWidget {
  const BioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Add/Edit Bio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          backgroundColor: const Color.fromARGB(255, 191, 219, 254),
        ),
      ),
      home: const BioScreen(),
    );
  }
}

class BioScreen extends StatefulWidget {
  const BioScreen({Key? key}) : super(key: key);

  @override
  State<BioScreen> createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with existing bio, e.g., fetched from API or local data
    _bioController.text = "Your existing bio here...";
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _saveBio() async {
    if (_formKey.currentState?.validate() ?? false) {
      final bio = _bioController.text;
      const String apiUrl = "http://127.0.0.1:8000/user/profile/";

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"user__bio": bio}),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bio saved successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to save bio. Status code: ${response.statusCode}'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Add/Edit Bio',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 191, 219, 254),
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bio:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _bioController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Enter your bio here...',
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
                            return 'Bio cannot be empty.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: _saveBio,
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF6499E9),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Save Bio',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
