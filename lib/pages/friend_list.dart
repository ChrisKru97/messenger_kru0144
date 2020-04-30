import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:messenger/components/logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Friend {
  Friend(this.username, this.id, this.key);

  final String username;
  final String id;
  final String key;

  Friend.fromJson(dynamic json)
      : username = json['username'],
        id = json['id'],
        key = json['key'];

  Map<String, String> toJson() => {
        'username': username,
        'id': id,
        'key': key,
      };
}

class FriendList extends StatelessWidget {
  FriendList(this.prefs);

  final SharedPreferences prefs;

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
              itemBuilder: (_, index) => Column(
                children: <Widget>[
                  Dismissible(
                      key: Key(index.toString()),
                      onDismissed: (_) {
                        final key = friends.elementAt(index).key;
                        final oldFriends =
                            (jsonDecode(prefs.getString('friends'))
                                as List<dynamic>);
                        final indexToRemove = oldFriends
                            .indexWhere((element) => element['key'] == key);
                        print(index);
                        print(indexToRemove);
                        oldFriends.removeAt(indexToRemove);
                        if (oldFriends.length > 0) {
                          prefs.setString('friends', jsonEncode(oldFriends));
                        } else {
                          prefs.remove('friends');
                        }
                      },
                      background: Container(
                          color: Colors.red[400],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Icon(Icons.delete_forever,
                                    color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Icon(Icons.delete_forever,
                                    color: Colors.white),
                              ),
                            ],
                          )),
                      child: ListTile(
                        title: Text(friends.elementAt(index).username),
                      )),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                ],
              ),
            );
          },
        ),
      );
}
