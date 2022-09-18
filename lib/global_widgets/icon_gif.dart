import 'package:flutter/material.dart';

class IconGif extends StatelessWidget {
  final double width;
  final String content;
  final String iconPath;
  const IconGif({
    Key? key,
    required this.width,
    required this.content,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
        margin: const EdgeInsets.only(top: 200),
        child: Column(
          children: [
            Image.asset(
              iconPath,
              fit: BoxFit.cover,
              width: width,
            ),
            Center(child: Text(content)),
          ],
        ),
      ),
    );
  }
}
