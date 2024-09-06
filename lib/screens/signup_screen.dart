// lib/screens/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:medconnected/routes/app_routes.dart';
import 'package:medconnected/screens/symptom_checker_screen.dart';
import 'package:medconnected/widgets/input_field.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputField(label: 'Full Name', controller: TextEditingController(), keyboardType: TextInputType.text,),
            const SizedBox(height: 16),
            InputField(
                label: 'Email', keyboardType: TextInputType.emailAddress, controller: TextEditingController(),),
            const SizedBox(height: 16),
            InputField(label: 'Password', obscureText: true, controller: TextEditingController(), keyboardType: TextInputType.text,),
            const SizedBox(height: 16),
            InputField(label: 'Confirm Password', obscureText: true, controller: TextEditingController(), keyboardType: TextInputType.text,),
            const SizedBox(height: 24),
            CustomButton(
              label: 'Sign Up',
              onPressed: () {
                // TODO: Implement signup logic
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              }, isLoading: false, text: '',
            ),
            const SizedBox(height: 16),
            TextButton(
              child: const Text('Already have an account? Log in'),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
            ),
          ],
        ),
      ),
    );
  }
}
