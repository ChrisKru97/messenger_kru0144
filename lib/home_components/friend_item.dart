import 'package:flutter/material.dart';

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

class FriendItem extends StatelessWidget {
  FriendItem({this.onDismissed, this.friend});

  final Friend friend;
  final Function(DismissDirection direction) onDismissed;

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Dismissible(
              key: Key(friend.id),
              onDismissed: onDismissed,
              background: Container(
                  color: Colors.red[400],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Icon(Icons.delete_forever, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(Icons.delete_forever, color: Colors.white),
                      ),
                    ],
                  )),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/chat',
                      arguments: friend);
                },
                title: Text(friend.username),
              )),
          Divider(
            height: 1,
            thickness: 1,
          ),
        ],
      );
}
