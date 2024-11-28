import 'package:flutter/material.dart';
import 'package:movie_app/pages/login_page.dart';
import '../service/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _authService = AuthService();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  void _register(BuildContext context) async {
    setState(() {
      _isLoading = true; // Show the loading indicator
    });

    final message = await _authService.register(
      fullName: fullNameController.text,
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      _isLoading = false; // Hide the loading indicator
    });

    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful! Please login.')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo or App Name Section
            const Center(
              child: Icon(
                Icons.movie_creation,
                size: 100,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 30),

            // Full Name TextField
            TextFormField(
              controller: fullNameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 20),

            // Username TextField
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                prefixIcon:
                    Icon(Icons.account_circle, color: Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 20),

            // Email TextField
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),

            // Password TextField
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 30),

            // Register Button
            Center(
              child: ElevatedButton(
                onPressed: _isLoading ? null : () => _register(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize:
                      const Size(double.infinity, 50), // Full width button
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
              ),
            ),
            const SizedBox(height: 20),

            // Already have an account (Login)
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: const Text(
                  "Already Have an Account? Login",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
