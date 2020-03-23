import 'package:flutter/material.dart';
import 'package:messenger/components/logo.dart';

class List extends StatelessWidget {
  List(this.prefs);

  final SharedPreferences prefs;

  Future<List> getData() async {
    prefs.get
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Container(height: kToolbarHeight, child: Logo()),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              iconSize: kToolbarHeight * 0.7,
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/qr'),
            )
          ],
        ),
        body: FutureBuilder<List>(future: getData()),
      );
}
