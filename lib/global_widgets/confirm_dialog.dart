import 'package:flutter/material.dart';

Future<void> showMyDialog({
  required String content,
  required String title,
  required BuildContext context,
  required Function onConfirm,
   Function? onCancel = null,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.end,
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
            child: const Text('حذف'),
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('الغاء'),
            onPressed: () {
              onCancel!();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
