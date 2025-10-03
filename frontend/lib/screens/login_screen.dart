import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double? height;
  double? width;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLoading = false;
  String? errorMessage;

  Future<void> handleLogin() async {
    setState(() => isLoading = true);
    bool success = await _authService.login(
      emailController.text,
      passwordController.text,
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
              child: Container(
                width: width! * 1,
                height: height!  * 0.8,
                child: Image(image: AssetImage('assets/bgExpense.png')),
              )
            ),
            Positioned(
              top: height! * 0.65,
              left: width! * 0.1,
              child: Container(
                width: width! * 0.8,
                height: height! * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [BoxShadow(
                    blurRadius: 5,
                    color: Colors.black
                  )]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController, 
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person
                          ),
                          hint: Text("Name")
                          )
                        ),
                      TextField(
                        controller: passwordController, 
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock
                          ),
                          hint: Text("Password")
                          ), 
                        obscureText: true
                      ),
                      const SizedBox(height: 20),
                      if (errorMessage != null) Text(errorMessage!, style: const TextStyle(color: Colors.red)),
                      // ElevatedButton(
                      //   onPressed: isLoading ? null : handleLogin,
                      //   child: isLoading ? 
                      //   const CircularProgressIndicator() : 
                      //   const Text("Login"),
                      // ),
                      Center(
                        child: InkWell(
                          onTap: isLoading ? null : handleLogin,
                          child: Container(
                            height: height! * 0.05,
                            width: width! * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.yellow[800]
                            ),
                            child: Center(
                              child: Text("Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20
                              ),),
                            )
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, "/register"),
                        child: const Text("No account? Register"),
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
