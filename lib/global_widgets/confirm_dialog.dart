import 'dart:ui';

import 'package:flutter/material.dart';

Future<void> showConfirmDialog({
  required String content,
  required String title,
  required String confirmText,
  required String cancelText,
  required BuildContext context,
  required Function onConfirm,
  required Function onCancel,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context1) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: AlertDialog(
          title: Text(
            title,
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  content,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                cancelText,
                style: const TextStyle(
                    fontWeight: FontWeight.w200, color: Colors.grey),
              ),
              onPressed: () {
                onCancel();
                Navigator.of(context1).pop();
              },
            ),
            TextButton(
              child: Text(
                confirmText,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              onPressed: () {
                onConfirm();
                Navigator.of(context1).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
