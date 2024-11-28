import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movie_app/helper/notification_helper.dart';
import 'package:movie_app/pages/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigasi otomatis ke halaman Login setelah 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage()), // Ganti ke LoginPage
      );
    });

    // Mulai notifikasi random
    startRandomNotifications();

    return const Scaffold(
      backgroundColor: Colors.blue, // Latar belakang biru
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.movie_creation, // Ikon film
              size: 80,
              color: Colors.white, // Warna putih
            ),
            SizedBox(height: 20), // Spasi antara ikon dan teks
            Text(
              'Movie App',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Warna teks putih
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Fungsi untuk memulai notifikasi random
  void startRandomNotifications() {
    Timer.periodic(const Duration(seconds: 15), (timer) async {
      int randomDelay = Random().nextInt(60) + 15; // Random 15-60 detik
      await Future.delayed(Duration(seconds: randomDelay));
      NotificationHelper.showNotification(
        'Notifikasi Background !!',
        'Ini notifikasi dummy yang muncul secara random durasi.',
      );
    });
  }
}
