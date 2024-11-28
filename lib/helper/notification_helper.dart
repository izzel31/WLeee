import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Inisialisasi plugin notifikasi
  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);

    // Menambahkan channel di Android
    await _createNotificationChannel();
  }

  // Fungsi untuk membuat channel
  static Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel_id', // ID channel
      'Channel Name', // Nama channel
      description:
          'This is the description of the channel', // Deskripsi channel
      importance: Importance.high, // Tingkat pentingnya notifikasi
      playSound: true, // Memutar suara saat notifikasi muncul
      enableLights: true, // Menyalakan lampu saat ada notifikasi
    );

    // Mendaftarkan channel di plugin
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Fungsi untuk menampilkan notifikasi
  static Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id', // ID channel yang telah dibuat
      'Channel Name', // Nama channel
      channelDescription: 'This is the description of the channel.',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0, // ID notifikasi
      title,
      body,
      notificationDetails,
    );
  }
}
