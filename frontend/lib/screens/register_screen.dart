import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double? width;
  double? height;

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLoading = false;
  String? errorMessage;

  Future<void> handleRegister() async {
    setState(() => isLoading = true);
    bool success = await _authService.register(
      usernameController.text,
      emailController.text,
      passwordController.text,
    );

    setState(() => isLoading = false);

    if (success) {
      // ✅ after registration, send them to login
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      setState(() => errorMessage = "Registration failed. Try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: height! * 0.0001,
              child: SizedBox(
                width: width! * 1,
                height: height!  * 0.8,
                child: Image(image: AssetImage('assets/bgExpense.png')),
              )
            ),
            Positioned(
              top: height! * 0.6,
              left: width! * 0.1,
              child: Container(
                width: width! * 0.8,
                height: height! * 0.35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [BoxShadow(
                    blurRadius: 20,
                    color: Colors.black
                  )]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                       TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(labelText: "Username"),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: "Email"),
                      ),
                      TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(labelText: "Password"),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      if (errorMessage != null)
                        Text(errorMessage!, style: const TextStyle(color: Colors.red)),
                      ElevatedButton(
                        onPressed: isLoading ? null : handleRegister,
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text("Register"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, "/login"),
                        child: const Text("Already have an account? Login"),
                      ),
                    ],
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
