// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StrockedText extends StatelessWidget {
  String text;

  String fontFamily;
  bool overrideSizeStroke;
  double fontSize;
  double strokeWidth;
  Color strokeColor;
  List<Shadow> shadow;
  Color color;

  StrockedText(
    this.text, {
    Key? key,
    required this.fontFamily,
    this.overrideSizeStroke = false,
    required this.fontSize,
    this.strokeWidth = 0, // stroke width default
    this.strokeColor = Colors.white,
    required this.shadow,
    this.color = Colors.black,
  }) : super(key: key) {
    shadow;

    // stroke to big right, let make automate little

    // this.overrideSizeStroke will disable automate .. so we can set our number
    if (strokeWidth != 0 && !overrideSizeStroke) {
      // this code will resize stroke so size will set 1/7 of font size, if stroke size is more than 1/7 font size
      // yeayy
      if (fontSize / 7 * 1 < strokeWidth) {
        strokeWidth = fontSize / 7 * 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // to make a stroke text we need stack between 2 text..
    // 1 for text & one for stroke effect
    return Stack(
      // redundant right?
      // same effect & lest code later.. :)
      children: List.generate(2, (index) {
        // let declare style for text .. :)
        // index == 0 for effect

        TextStyle textStyle = index == 0
            ? TextStyle(
                fontFamily: fontFamily,
                fontSize: fontSize,
                shadows: shadow,
                foreground: Paint()
                  ..color = strokeColor
                  ..strokeWidth = strokeWidth
                  ..strokeCap = StrokeCap.round
                  ..strokeJoin = StrokeJoin.round
                  ..style = PaintingStyle.stroke,
              )
            : TextStyle(
                fontFamily: fontFamily,
                fontSize: fontSize,
                color: color,
              );

        // let disable stroke effect if this.strokeWidth == 0
        return Offstage(
          offstage: strokeWidth == 0 &&
              index == 0, // put index == 0 so just disable effect only.. yeayy
          child: Text(
            text,
            style: textStyle,
          ),
        );
      }).toList(),
    );
  }
}
