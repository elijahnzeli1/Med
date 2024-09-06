// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:medconnected/providers/user_provider.dart';
import 'package:medconnected/screens/symptom_checker_screen.dart';
import 'package:medconnected/services/auth_service.dart';
import 'package:medconnected/utils/validators.dart';
import 'package:medconnected/widgets/input_field.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final authService = AuthService();
        final user = await authService.signIn(
          _emailController.text,
          _passwordController.text,
        );

        Provider.of<UserProvider>(context, listen: false).setUser(user);

        Navigator.of(context).pushReplacementNamed('/home');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.toString()}')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputField(
                label: 'Email',
                controller: _emailController,
                validator: Validators.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              InputField(
                label: 'Password',
                controller: _passwordController,
                validator: Validators.validatePassword,
                obscureText: true,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Login',
                onPressed: _login,
                isLoading: _isLoading, label: '',
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/signup');
                },
                child: const Text('Don\'t have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
