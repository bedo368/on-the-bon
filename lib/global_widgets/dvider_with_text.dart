// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class DviderWithText extends StatelessWidget {
  final String text;
  final double thickness;
  const DviderWithText({
    required this.text,
    required this.thickness,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(
          thickness: thickness,
          color: Theme.of(context).primaryColor,
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Expanded(
            child: Divider(
          thickness: thickness,
          color: Theme.of(context).primaryColor,
        )),
      ],
    );
  }
}
