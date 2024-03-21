import 'package:flutter/material.dart';

class BackgroundDesign extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();
    Path upperPath = Path();
    Path bottomPath = Path();

    upperPath.moveTo(0, height * 0.35);
    upperPath.quadraticBezierTo(
        width * 0.1, height * 0.3, width * 0.15, height * 0.25);
    upperPath.quadraticBezierTo(
        width * 0.3, height * 0.05, width * 0.6, height * 0.05);
    upperPath.quadraticBezierTo(
        width * 0.78, height * 0.05, width * 0.9, height * 0.0);
    upperPath.lineTo(width * 1, height * 0);
    upperPath.lineTo(0, 0);
    upperPath.close();

    bottomPath.moveTo(width * 1, height * 1);
    bottomPath.lineTo(width * 1, height * 0.65);
    bottomPath.quadraticBezierTo(
        width * 0.9, height * 0.7, width * 0.85, height * 0.75);
    bottomPath.quadraticBezierTo(
        width * 0.7, height * 0.95, width * 0.45, height * 0.95);
    bottomPath.quadraticBezierTo(
        width * 0.3, height * 0.95, width * 0, height * 1);
    bottomPath.lineTo(0, height * 1);
    bottomPath.close();
    paint.color = Colors.blue;
    canvas.drawPath(bottomPath, paint);

    paint.color = Colors.blue;
    canvas.drawPath(upperPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}