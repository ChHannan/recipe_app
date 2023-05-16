import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login Screen'),
            TextButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
