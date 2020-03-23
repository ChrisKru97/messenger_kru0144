//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messenger/pages/splash.dart';

//final FirebaseAuth _auth = FirebaseAuth.instance;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messenger',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.quicksandTextTheme(),
      ),
      initialRoute: '/splash',
      routes: <String, WidgetBuilder>{'/splash': (_) => Splash()},
    );
  }
}


