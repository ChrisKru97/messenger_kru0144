import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  Logo({this.color});

  final Color color;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxHeight < constraints.maxHeight / 4
            ? constraints.maxWidth
            : constraints.maxHeight * 4;
        final height = constraints.maxWidth > constraints.maxHeight * 4
            ? constraints.maxHeight
            : constraints.maxWidth / 4;
        return CustomPaint(
          size: Size(width, height),
          painter: _LogoPainter(color: color),
        );
      });
}

class _LogoPainter extends CustomPainter {
  _LogoPainter({this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final titlePainter = TextPainter(
        text: TextSpan(
            text: 'messenger',
            style: GoogleFonts.nunito(color: color ?? Colors.white)),
        textScaleFactor: size.height * 0.0573,
        textDirection: TextDirection.ltr)
      ..layout();
    final signaturePainter = TextPainter(
        text: TextSpan(
            text: '©Krutsche',
            style: GoogleFonts.pacifico(color: color ?? Colors.white)),
        textScaleFactor: size.height * 0.025,
        textDirection: TextDirection.ltr)
      ..layout();
    titlePainter.paint(canvas, Offset(0, -size.height * 0.3));
    signaturePainter.paint(
        canvas, Offset(size.width * 0.554, size.height * 0.44));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
