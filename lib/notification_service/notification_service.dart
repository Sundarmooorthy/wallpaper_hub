import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

// initialize App icon
  static AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('ic_launcher');

  static final AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'your_channel_id', // id
    'Your Channel Name', // name
    importance: Importance.high,
  );

  static Future<void> requestNotificationPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

//
// static initializeNotification() async {
//   final InitializationSettings initializationSettings =
//       InitializationSettings(
//     android: androidInitializationSettings,
//     iOS: DarwinInitializationSettings(),
//   );
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//   // Create a notification channel for Android (API 26+)
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(_channel);
// }

  // Handle foreground notifications
  static void handleForegroundNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  // Initialize notifications
  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher'); // your app icon here

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Create a notification channel for Android (API 26+)
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  // Handle background notifications (when the app is in the background but not terminated)
  static void handleBackgroundNotifications() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Background message handler function (must be a top-level function)
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            icon: 'launch_background',
          ),
        ),
      );
    }
  }

  // Handle notifications when the app is terminated (cold start)
  static Future<void> handleTerminatedNotifications() async {
    // This handles notification taps when the app is terminated (cold start)
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      RemoteNotification? notification = initialMessage.notification;
      AndroidNotification? android = initialMessage.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              icon: 'launch_background',
            ),
          ),
        );
      }
    }
  }
}
