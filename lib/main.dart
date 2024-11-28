import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/helper/notification_helper.dart';
import 'package:movie_app/pages/splashscreen_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load file .env
  await dotenv.load();

  // inisialisasi hive
  await Hive.initFlutter();
  // box buat simpen jwt tokenn
  await Hive.openBox('authBox');

  await NotificationHelper.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
