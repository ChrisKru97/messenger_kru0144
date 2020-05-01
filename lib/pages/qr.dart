import 'package:flutter/material.dart';
import 'package:messenger/components/logo.dart';
import 'package:messenger/qr_components/resizable_qr.dart';
import 'package:messenger/qr_components/scan_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QR extends StatelessWidget {
  QR(this.prefs, this.uid);

  final SharedPreferences prefs;
  final String uid;

  Future<String> getUserName() async {
    while (!prefs.containsKey('username')) {
      await Future.delayed(Duration(microseconds: 100));
    }
    return prefs.getString('username');
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
        body: Container(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Logo(color: Colors.black),
        ),
        FutureBuilder<String>(
            future: getUserName(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return ResizableQr(
                  username: snapshot.data,
                  uid: uid,
                  encryptionKey: prefs.getString('key'));
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ScanButton(prefs),
            RaisedButton(
              color: Colors.cyan[700],
              child: Text(
                'Messages',
                style: TextStyle(fontSize: fontSize, color: Colors.white),
              ),
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/home'),
            )
          ],
        )
      ],
    )));
  }
}
