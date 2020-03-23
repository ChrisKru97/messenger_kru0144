import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:messenger/components/logo.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
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
                    Builder(
                      builder: (BuildContext context) => RaisedButton(
                        color: Colors.cyan[700],
                        child: Text(
                          'Scan',
                          style: TextStyle(
                              fontSize: fontSize, color: Colors.white),
                        ),
                        onPressed: () => Scaffold.of(context)
                            .showBottomSheet((context) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  child: Container(
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                      decoration: BoxDecoration(
                                          color: Colors.orange[100],
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(0, 0),
                                                blurRadius: 5,
                                                spreadRadius: 1),
                                          ]),
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      child: QrCamera(
                                          qrCodeCallback: (String value) {
                                        final data = value.split('::');
                                        final friends = jsonDecode(
                                            prefs.getString('friends') ??
                                                '[]') as List<Object>;
                                        friends.add({
                                          'username': data[0],
                                          'id': data[1],
                                          'key': data[2]
                                        });
                                        prefs.setString(
                                            'friends', jsonEncode(friends));
                                        if (data.length == 3) {
                                          Navigator.pop(context);
                                          Navigator.of(context)
                                              .pushReplacementNamed('/list');
                                        }
                                      })),
                                )),
                      ),
                    ),
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
