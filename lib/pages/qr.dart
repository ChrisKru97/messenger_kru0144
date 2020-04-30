import 'package:flutter/material.dart';
import 'package:messenger/components/logo.dart';
import 'package:messenger/components/scan_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QR extends StatelessWidget {
  QR(this.prefs, this.uid);

  final SharedPreferences prefs;
  final String uid;

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Logo(color: Colors.black),
                QrImage(
                  errorCorrectionLevel: QrErrorCorrectLevel.Q,
                  data:
                      '${prefs.getString('username')}::$uid::${prefs.getString('key')}',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ScanButton(prefs),
                    RaisedButton(
                      color: Colors.cyan[700],
                      child: Text(
                        'Messages',
                        style:
                            TextStyle(fontSize: fontSize, color: Colors.white),
                      ),
                      onPressed: () =>
                          Navigator.of(context).pushReplacementNamed('/list'),
                    )
                  ],
                )
              ],
            )));
  }
}
