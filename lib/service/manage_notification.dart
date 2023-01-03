import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:on_the_bon/main.dart';
import 'package:on_the_bon/screens/orders_manage_screen/order_manage_screen.dart';
import 'package:on_the_bon/screens/orders_screen/orders_screen.dart';

class NotificationApi {
  static Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        announcement: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
  }

  static Future<void> setUpMainNotificationChannel() async {
    final flutterNotificationPlugin = FlutterLocalNotificationsPlugin();

    const androidINitiazize =
        AndroidInitializationSettings('@mipamp/ic_launcher');

    const initializetionSettings =
        InitializationSettings(android: androidINitiazize);
    flutterNotificationPlugin.initialize(initializetionSettings);
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'main_notification_channel', // id
        'main chennel', // title
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound("notification"));
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> sendNotification(
      {required String title, required String content, File? image}) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child("notification_images")
        .child("${DateTime.now()}.png");

    if (image != null) {
      await ref.putFile(image);
    }

    final url = image == null ? "" : await ref.getDownloadURL();
    await FirebaseFirestore.instance.collection("notifications").add({
      "title": title,
      "content": content,
      "imageUrl": url,
      "adminId": FirebaseAuth.instance.currentUser!.uid
    });
  }

  static Future<void> handeleBackgroundNotification(
      RemoteMessage message) async {}

  static Future<void> handeleForgroundNotification(
      RemoteMessage message) async {
    final flutterNotificationPlugin = FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid = const AndroidInitializationSettings(
        'mipmap/ic_launcher'); // <- default icon name is @mipmap/ic_launcher

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterNotificationPlugin.initialize(
      initializationSettings,
    );

    RemoteNotification? notification = message.notification;
    if (notification != null) {
      flutterNotificationPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'main_notification_channel',
              'main chennel',
            ),
          ));
    }
  }

  static Future<void> onNotificationOpenAPP(RemoteMessage message) async {
    if (message.notification == null) {
      final message = await FirebaseMessaging.instance.getInitialMessage();

      if (message == null) {
        return;
      }

      if (message.data["type"] == "new Order") {
        MyApp.navigatorKey.currentState!.pushNamed(OrderManageScreen.routeName);
      }

      return;
    }
    if (message.data["type"] == "users Notification") {
      MyApp.navigatorKey.currentState!.pushNamed(OrdersScreen.routeName);
    }
  }
}
