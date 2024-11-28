import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class AuthService {
  // base url untuk API auth
  final String baseUrl = 'https://vertifyokay.vercel.app/dev/auth';

  // Box buat simpen token
  final Box _authBox = Hive.box('authBox');

  // // Kunci static buat enkripsi (pke kunci dengan panjang 32 byte untuk AES-256)
  final _encrypter = encrypt.Encrypter(encrypt.AES(
    encrypt.Key.fromUtf8('12345678901234567890123456789012'),
    mode: encrypt.AESMode.ecb,
  ));

  // Fungsi untuk mengenkripsi password
  String encryptPassword(String password) {
    final encrypted = _encrypter.encrypt(password);
    return encrypted.base64;
  }

  // Register
  Future<String?> register({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      },
      body: jsonEncode({
        "full_name": fullName,
        "username": username,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    } else {
      return null;
    }
  }

  // Login
  Future<String?> login(String email, String password) async {
    // Enkripsi password sebelum dikirim
    final encryptedPassword = encryptPassword(password);

    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      },
      body: jsonEncode({
        "email": email,
        "password": encryptedPassword, // Kirim password terenkripsi
      }),
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['data']['token'];

      // Simpan token ke Hive
      await _authBox.put('token', token);

      return jsonDecode(response.body)['message'];
    } else {
      return null;
    }
  }

  // Mengambil token dari Hive
  String? getToken() {
    final token = _authBox.get('token');
    if (token != null) {
      return token;
    }
    return null;
  }

  // Logout
  Future<void> logout() async {
    await _authBox.delete('token');
  }
}
