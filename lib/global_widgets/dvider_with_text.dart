// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class DviderWithText extends StatelessWidget {
  final String text;
  final double thickness;
  final Color color;
  const DviderWithText({
    required this.text,
    required this.thickness,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(
          thickness: thickness,
          color: color,
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style:  TextStyle(fontSize: 16, color: color),
          ),
        ),
        Expanded(
            child: Divider(
          thickness: thickness,
          color: color,
        )),
      ],
    );
  }
}
