import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLoading = false;
  String? errorMessage;

  Future<void> handleLogin() async {
    setState(() => isLoading = true);
    bool success = await _authService.register(
      emailController.text,
      passwordController.text
    );

    setState(() => isLoading = false);

    if (success) {
      Navigator.pushReplacementNamed(context, "/profile");
    } else {
      setState(() => errorMessage = "Invalid email or password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
            const SizedBox(height: 20),
            if (errorMessage != null) Text(errorMessage!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: isLoading ? null : handleLogin,
              child: isLoading ? const CircularProgressIndicator() : const Text("Login"),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, "/register"),
              child: const Text("No account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
