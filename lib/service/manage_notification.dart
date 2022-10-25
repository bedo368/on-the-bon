import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  final flutterNotificationPlugin = FlutterLocalNotificationsPlugin();
  static Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
  }

  static Future<void> setUpMainNotificationChannel() async {
    // final androidINitiazize =
    //     const AndroidInitializationSettings('@mipamp/ic_launcher');

    // final initializetionSettings =
    //     InitializationSettings(android: androidINitiazize);
    // flutterNotificationPlugin.initialize(initializetionSettings);
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

    final url =  image == null ? "" : await ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection("notifications")
        .add({"title": title, "content": content, "imageUrl": url});

    
  }
}
