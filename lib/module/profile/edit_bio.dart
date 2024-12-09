import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const EditBioApp());
}

class EditBioApp extends StatelessWidget {
  const EditBioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edit Bio',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 191, 219, 254),
        scaffoldBackgroundColor: const Color.fromARGB(255, 232, 242, 255),
      ),
      home: const EditBioScreen(),
    );
  }
}

class EditBioScreen extends StatefulWidget {
  const EditBioScreen({Key? key}) : super(key: key);

  @override
  State<EditBioScreen> createState() => _EditBioScreenState();
}

class _EditBioScreenState extends State<EditBioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = true; // Untuk indikator loading

  @override
  void initState() {
    super.initState();
    _fetchBio(); // Panggil GET saat init
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _fetchBio() async {
    const String url = 'http://127.0.0.1:8000/user/profile/edit_bio/json'; // Ganti dengan URL API Anda
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _bioController.text = data['user__bio'] ?? 'Bio belum diatur';
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load bio');
      }
    } catch (error) {
      setState(() {
        _bioController.text = 'Gagal memuat bio.';
        _isLoading = false;
      });
      debugPrint('Error fetching bio: $error');
    }
  }

  Future<void> _saveBio() async {
    const String url = 'http://127.0.0.1:8000/user/profile/edit_bio'; // Ganti dengan URL API Anda
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'user__bio': _bioController.text}),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bio berhasil disimpan!')),
        );
      } else {
        throw Exception('Failed to save bio');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan bio.')),
      );
      debugPrint('Error saving bio: $error');
    }
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Edit Bio',
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
                                hintText: 'Masukkan bio Anda di sini...',
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
                                  return 'Bio tidak boleh kosong.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  _saveBio();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 191, 219, 254),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Simpan Perubahan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: _cancel,
                              child: const Text(
                                'Batal',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
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
