import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  Logo({this.color = Colors.cyan});

  final Color color;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxHeight < constraints.maxHeight * 9 / 22
            ? constraints.maxWidth
            : constraints.maxHeight * 22 / 9;
        final height = constraints.maxWidth > constraints.maxHeight * 22 / 9
            ? constraints.maxHeight
            : constraints.maxWidth * 9 / 22;
        return CustomPaint(
          size: Size(width, height),
          painter: _LogoPainter(),
        );
      });
}

class _LogoPainter extends CustomPainter {
  _LogoPainter({this.color = Colors.cyan});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final titlePainter = TextPainter(
        text: TextSpan(
            text: 'messenger',
            style: GoogleFonts.nunito(fontSize: size.width / 5)),
        textDirection: TextDirection.ltr)
      ..layout();
    final signaturePainter = TextPainter(
        text: TextSpan(
            text: '©Krutsche',
            style: GoogleFonts.pacifico(fontSize: size.width / 10)),
        textDirection: TextDirection.ltr)
      ..layout();
    titlePainter.paint(canvas, Offset(0, 0));
    signaturePainter.paint(canvas, Offset(size.width / 2, size.height - 40));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

//Align(
//alignment: Alignment.topLeft,
//widthFactor: 0.5,
//heightFactor: 2,
//child: Text('messenger',
//style: GoogleFonts.nunito(
//fontSize: 64,
//decoration: TextDecoration.none, color: Colors.white)),
//),
//Align(
//alignment: Alignment.bottomRight,
//widthFactor: 2,
//heightFactor: 2,
//child: Text('©Krutsche',
//style: GoogleFonts.righteous(
//fontSize: MediaQuery.of(context).size.width / 15,
//fontWeight: FontWeight.w300,
//decoration: TextDecoration.none,
//color: Colors.white)),
//),
//]
