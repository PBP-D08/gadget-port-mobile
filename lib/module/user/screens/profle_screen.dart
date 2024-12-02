import 'package:flutter/material.dart';
import '../widgets/profile_card.dart';
import '../widgets/profile_form.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ProfileCard(),
              SizedBox(height: 20),
              ProfileForm(),
            ],
          ),
        ),
      ),
    );
  }
}
