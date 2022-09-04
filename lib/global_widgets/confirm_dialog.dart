import 'package:flutter/material.dart';

Future<void> showMyDialog({
  required BuildContext context,
  required Function onConfirm,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'حذف من عربة التسوق',
          textAlign: TextAlign.end,
        ),
        content: SingleChildScrollView(
          child: Column(
            children: const <Widget>[
              Text(
                'هل تريد حذف المنتج من العربه ',
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
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
