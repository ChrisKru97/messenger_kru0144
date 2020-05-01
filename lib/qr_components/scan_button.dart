import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanButton extends StatelessWidget {
  ScanButton(this.prefs);

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) => RaisedButton(
        color: Colors.cyan[700],
        child: Text(
          'Scan',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              color: Colors.white),
        ),
        onPressed: () =>
            Scaffold.of(context).showBottomSheet((context) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.05),
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
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: QrCamera(qrCodeCallback: (String value) {
                        print(value);
                        final data = value.split('::');
                        if (data.length == 3) {
                          final newList = prefs.containsKey('friends')
                              ? jsonDecode(prefs.getString('friends'))
                                  as List<dynamic>
                              : [];
                          final inList = newList
                              .any((element) => element['key'] == data[2]);
                          if (!inList) {
                            newList.add({
                              'username': data[0],
                              'id': data[1],
                              'key': data[2]
                            });
                            prefs.setString('friends', jsonEncode(newList));
                          }
                          Navigator.of(context).pushReplacementNamed('/home');
                        }
                      })),
                )),
      );
}
