import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messenger/pages/friend_list.dart';
import 'package:messenger/pages/qr.dart';
import 'package:messenger/pages/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/info.dart';
import 'pages/login.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs;
    AuthResult authData;
    Future<SharedPreferences> savePrefs() async {
      prefs = await SharedPreferences.getInstance();
      return prefs;
    }

    Future<void> login() async {
      authData = await _auth.signInAnonymously();
      print(authData.user.uid);
    }

    return MaterialApp(
      title: 'Messenger',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.quicksandTextTheme(),
      ),
      initialRoute: '/splash',
      routes: <String, WidgetBuilder>{
        '/splash': (_) => Splash(login(), savePrefs()),
        '/login': (_) => Login(prefs),
        '/qr': (_) => QR(prefs, authData.user.uid),
        '/list': (_) => FriendList(prefs),
        '/info': (_) => Info()
      },
    );
  }
}
