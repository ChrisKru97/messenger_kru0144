import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blue[100],
        body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hello!\n\nWelcome to really secure messenger application.\n\nEverything is correctly encrypted, do not be worried to send private text!\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06),
                ),
                RaisedButton(
                  color: Colors.cyan[700],
                  textColor: Colors.white,
                  child: Text('I understand',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.white)),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/login'),
                )
              ],
            )),
      );
}
