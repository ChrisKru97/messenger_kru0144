import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:messenger/components/logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatelessWidget {
  Splash(this.authFuture, this.prefFuture);

  final Future authFuture;
  final Future prefFuture;

  Future<String> initApp() async {
    await authFuture;
    SharedPreferences prefs = await prefFuture;
    if (prefs.getString('key') == null) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final uuid = Platform.isAndroid
          ? (await deviceInfoPlugin.androidInfo).androidId
          : (await deviceInfoPlugin.iosInfo).identifierForVendor;
      final key = Key.fromUtf8(
          '${DateTime.now().microsecondsSinceEpoch}${DateTime.now().microsecondsSinceEpoch}');
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key));
      final encrypted = encrypter.encrypt(uuid, iv: iv);
      prefs.setString('key', encrypted.base64);
    }
    if (prefs.getString('username') == null) {
      return '/info';
    }
    print(prefs.getString('username'));
    print(prefs.getString('key'));
    prefs.setString('friends',
        '[{"username":"Christian","id":"GxySXnG6eBSABackrKQAHVLL2np2","key":"06B8oYb4zgR8XO0PewJ2vz1xk3Zr2XCAPNuiuGoYwIfDCPQkor1RyA5xKGOUAxBF"},{"username":"Mirka","id":"GxySnG6eBSABackrKQAHVLL2np2","key":"0B8oYb4zgR8XO0PewJ2vz1x3Zr2XCAPNuiuGoYwIfDCPQkor1RyA5xKGOUAxBF"},{"username":"Roman","id":"GxySXnG6eBSBackrKQAHVLL2np2","key":"06BoYb4zgR8XO0Pewvz1xk3Zr2XCAPNuiuGoYwIfDCPQkor1RyA5xKGOAxBF"},{"username":"Zdeno","id":"GxySXnGABackrKQAHVLL2np2","key":"06BoYb4zgR8XO0PewJ2vzZr2XCAPNuiuGoYwIfDCPQkor1RyA5xKGOUAxBF"}]');
    if (!prefs.containsKey('friends')) {
      return '/qr';
    }
    return '/list';
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<String>(
      future: initApp(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Future.delayed(Duration(milliseconds: 10),
              () => Navigator.of(context).pushReplacementNamed(snapshot.data));
        }
        return Container(
            color: Colors.teal[300],
            child: Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Logo()),
            ));
      });
}
