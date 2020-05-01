import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:messenger/home_components/friend_item.dart';
import 'package:messenger/components/logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  Home(this.prefs);

  final SharedPreferences prefs;

  Function(dynamic _) removeFriend(String key) => (_) {
        final oldFriends =
            (jsonDecode(prefs.getString('friends')) as List<dynamic>);
        final indexToRemove =
            oldFriends.indexWhere((element) => element['key'] == key);
        oldFriends.removeAt(indexToRemove);
        if (oldFriends.length > 0) {
          prefs.setString('friends', jsonEncode(oldFriends));
        } else {
          prefs.remove('friends');
        }
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Container(height: kToolbarHeight - 10, child: Logo()),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              iconSize: kToolbarHeight * 0.7,
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/qr'),
            )
          ],
        ),
        body: Builder(
          builder: (_) {
            if (!prefs.containsKey('friends')) {
              return Center(child: Text('No conversations'));
            }
            final friends =
                (jsonDecode(prefs.getString('friends')) as List<dynamic>)
                    .map((dynamic entry) => Friend.fromJson(entry));
            return ListView.builder(
                itemCount: friends.length,
                itemBuilder: (_, index) => FriendItem(
                    onDismissed: removeFriend(friends.elementAt(index).key),
                    friend: friends.elementAt(index)));
          },
        ),
      );
}
