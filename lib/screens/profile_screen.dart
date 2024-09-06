// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:medconnected/screens/symptom_checker_screen.dart';
import 'package:medconnected/widgets/profile_picture.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProfilePicture(imageUrl: 'https://www.medconnect.com/profile.jpg'),
            const SizedBox(height: 16),
            Text('John Doe', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('johndoe@example.com',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit Profile'),
              onTap: () {
                // TODO: Implement edit profile logic
                Navigator.pushNamed(context, '/edit_profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // TODO: Implement settings logic
                Navigator.pushNamed(context, '/settings');
              },
            ),
            const SizedBox(height: 24),
            CustomButton(
              label: 'Logout',
              onPressed: () {
                // TODO: Implement logout logic
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              }, isLoading: false, text: '',
            ),
          ],
        ),
      ),
    );
  }
}
