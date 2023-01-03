import 'package:flutter/rendering.dart';

class WaveClip extends CustomClipper<Path> {
  WaveClip({required this.lowPointPosition, required this.hightPointPosition});
  final double lowPointPosition;
  final double hightPointPosition;
  @override
  Path getClip(Size size) {
    Path path = Path();
    final lowPoint = size.height -lowPointPosition ;
    final highPoint = size.height - hightPointPosition;
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0 );
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
