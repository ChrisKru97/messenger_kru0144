import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/components/logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const border =
    OutlineInputBorder(borderSide: BorderSide(color: Colors.black12));

class Login extends StatelessWidget {
  Login(this._prefs);

  final SharedPreferences _prefs;
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: fontSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Logo(color: Colors.black)),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      focusedBorder: border,
                      enabledBorder: border,
                      hintText: 'Your username',
                      hintStyle: TextStyle(fontSize: fontSize)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: RaisedButton(
                  color: Colors.cyan[700],
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: fontSize, color: Colors.white),
                  ),
                  onPressed: () {
                    _prefs.setString('username', _usernameController.text);
                  },
                ),
              )
            ],
          )),
    );
  }
}
