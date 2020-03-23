import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/components/logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatelessWidget {
  Splash(this.auth, this.prefFuture);

  final FirebaseAuth auth;
  final Future prefFuture;

  Future<bool> initApp() async {
    await auth.signInAnonymously();
    SharedPreferences prefs = await prefFuture;
    return prefs.getString('username') == null;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
      future: initApp(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Future.delayed(
              Duration(milliseconds: 10),
              () => Navigator.of(context)
                  .pushReplacementNamed(snapshot.data ? '/info' : '/login'));
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
