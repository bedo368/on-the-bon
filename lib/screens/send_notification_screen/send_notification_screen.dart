import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/send_notification_screen/notification_from.dart';

class SendNotificationScreen extends StatelessWidget {
  const SendNotificationScreen({super.key});
  static String routeName = "/send-notification";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ارسال اشعار"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        height: MediaQuery.of(context).size.height,
        child: const SingleChildScrollView(
            child: Center(
          child: NotificationForm(),
        )),
      ),
    );
  }
}
