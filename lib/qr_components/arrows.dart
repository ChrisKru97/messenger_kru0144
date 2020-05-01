import 'package:flutter/material.dart';

class Arrows extends StatelessWidget {
  Arrows({this.width});

  final double width;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: ArrowsPainter(),
        size: Size(width, width),
      );
}

class ArrowsPainter extends CustomPainter {
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = size.width * 0.015
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(size.width * 0.93, size.width * 0.07),
        Offset(size.width, 0), paint);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, size.width * 0.04), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width * 0.96, 0), paint);
    canvas.drawLine(Offset(size.width * 0.07, size.width * 0.93),
        Offset(0, size.width), paint);
    canvas.drawLine(Offset(0, size.width), Offset(0, size.width * 0.96), paint);
    canvas.drawLine(
        Offset(0, size.width), Offset(size.width * 0.04, size.width), paint);
  }
}
