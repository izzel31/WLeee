import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  final String saran =
      'Saran dari saya bisa saat sesi pembelajaran ada demo aplikasi langsung terhadap setiap materi yang dipelajari setiap minggunya sehingga para mahasiswa mungkin lebih mudah menangkap dan memahami isi dan tujuan dari materi yang dipaparkan.';
  final String masukan =
      'Kesan saya terhadap mata kuliah Pemrograman Aplikasi Mobile itu menyenangkan karna dosen nya asik,humble dan santai saat sesi pembelajaran,saya merasa saya cukup enjoy dengan mata kuliah ini';

  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Saran
            const Text("Saran & Kesan", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue[300]!, width: 2),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saran',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    saran,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),

            // Bagian Masukan
            Container(
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange[300]!, width: 2),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kesan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    masukan,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
