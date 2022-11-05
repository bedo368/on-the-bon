import 'package:flutter/rendering.dart';

class CustomClipPaht extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.moveTo(size.width * 0.9983333, 0);
    path.moveTo(0, 0);
    path.lineTo(size.width * 1.0014310, 0);
    path.lineTo(size.width * 1.0012414, size.height * 1.0001594);
    path.quadraticBezierTo(size.width * 0.8523534, size.height * 0.9530528,
        size.width * 0.8473793, size.height * 0.9069472);
    path.cubicTo(
        size.width * 0.8337500,
        size.height * 0.7606375,
        size.width * 0.7261121,
        size.height * 0.9539044,
        size.width * 0.6655948,
        size.height * 0.9784064);
    path.cubicTo(
        size.width * 0.5693103,
        size.height * 1.0159662,
        size.width * 0.5119052,
        size.height * 0.8166335,
        size.width * 0.4593966,
        size.height * 0.8135707);
    path.cubicTo(
        size.width * 0.4171552,
        size.height * 0.8128237,
        size.width * 0.4068276,
        size.height * 1.0090937,
        size.width * 0.2894741,
        size.height * 0.9648108);
    path.cubicTo(
        size.width * 0.2053534,
        size.height * 0.8146464,
        size.width * 0.1557672,
        size.height * 1.0636554,
        size.width * 0.1175776,
        size.height * 0.9329731);
    path.quadraticBezierTo(size.width * 0.0871293, size.height * 0.8390289,
        size.width * 0.0034483, size.height * 0.9950200);

    path.lineTo(w, 0);
    path.close();
    return path;
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
