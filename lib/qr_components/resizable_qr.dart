import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'arrows.dart';

class ResizableQr extends StatefulWidget {
  ResizableQr({this.username, this.uid, this.encryptionKey});

  final String username;
  final String uid;
  final String encryptionKey;

  @override
  _ResizableQrState createState() => _ResizableQrState();
}

class _ResizableQrState extends State<ResizableQr> {
  final StreamController<double> _sizeStreamController =
      StreamController<double>();

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final width = maxWidth * 0.5;
    final minWidth = maxWidth * 0.3;
    return StreamBuilder(
      stream: _sizeStreamController.stream,
      initialData: width,
      builder: (context, snapshot) => GestureDetector(
        onScaleUpdate: (value) {
          var newWidth = snapshot.data * (pow(value.scale, 1 / 8));
          if (newWidth > maxWidth) newWidth = maxWidth;
          if (newWidth < minWidth) newWidth = minWidth;
          _sizeStreamController.sink.add(newWidth);
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            if (snapshot.data < maxWidth * 0.95)
              Arrows(width: snapshot.data * 1.1),
            QrImage(
              size: snapshot.data,
              errorCorrectionLevel: QrErrorCorrectLevel.Q,
              data:
                  '${widget.username}::${widget.uid}::${widget.encryptionKey}',
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _sizeStreamController.close();
    super.dispose();
  }
}
