import 'package:flutter/material.dart';
import 'package:movie_app/pages/home_page.dart';
import 'package:movie_app/pages/register_page.dart';
import 'package:hive/hive.dart';
import '../service/auth_service.dart';

class LoginPage extends StatelessWidget {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  Future<void> _checkToken(BuildContext context) async {
    final authBox = Hive.box('authBox');
    final token = authBox.get('token');

    if (token != null) {
      // Jika token ditemukan, langsung ke HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  void _login(BuildContext context) async {
    // Menampilkan indikator loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Memanggil login API
    final message =
        await _authService.login(emailController.text, passwordController.text);

    // Menutup indikator loading setelah login selesai
    Navigator.of(context).pop();

    if (message != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message ?? "Login failed!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Cek token saat widget pertama kali ditampilkan
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkToken(context);
    });

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

            // Login Button
            Center(
              child: ElevatedButton(
                onPressed: () => _login(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize:
                      const Size(double.infinity, 50), // Full width button
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Don't have an account (Register)
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: const Text(
                  "Don't have an account? Register",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ),

            // Continue as guest
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: const Text(
                  "Continue as guest",
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
