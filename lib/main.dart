import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/chat.dart';
import 'pages/info.dart';
import 'pages/login.dart';
import 'pages/home.dart';
import 'pages/qr.dart';
import 'pages/splash.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final Firestore _firestore = Firestore.instance;

void main() => runApp(MyApp());

//Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
//  if (message.containsKey('data')) {
//    // Handle data message
//    final dynamic data = message['data'];
//  }
//
//  if (message.containsKey('notification')) {
//    // Handle notification message
//    final dynamic notification = message['notification'];
//  }
//
//  // Or do other work.
//}
//
//final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    _firebaseMessaging.requestNotificationPermissions();
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print("onMessage: $message");
//        _showItemDialog(message);
//      },
//      onBackgroundMessage: myBackgroundMessageHandler,
//      onLaunch: (Map<String, dynamic> message) async {
//        print("onLaunch: $message");
//        _navigateToItemDetail(message);
//      },
//      onResume: (Map<String, dynamic> message) async {
//        print("onResume: $message");
//        _navigateToItemDetail(message);
//      },
//    );
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
        '/home': (_) => Home(prefs),
        '/info': (_) => Info(),
        '/chat': (_) => Chat(firestore: _firestore, uid: authData.user.uid)
      },
    );
  }
}
