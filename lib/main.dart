import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    Future<SharedPreferences> savePrefs() async {
      prefs = await SharedPreferences.getInstance();
      return prefs;
    }

    return MaterialApp(
      title: 'Messenger',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.quicksandTextTheme(),
      ),
      initialRoute: '/splash',
      routes: <String, WidgetBuilder>{
        '/splash': (_) => Splash(_auth, savePrefs()),
        '/login': (_) => Login(prefs),
        '/info': (_) => Info()
      },
    );
  }
}
