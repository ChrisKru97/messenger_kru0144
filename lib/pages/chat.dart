import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger/chat_components/chat_input.dart';
import 'package:messenger/home_components/friend_item.dart';
import 'package:messenger/chat_components/scrollable_chat.dart';

class Chat extends StatelessWidget {
  Chat({this.uid, this.firestore});

  final Firestore firestore;
  final String uid;
  final TextEditingController _newMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final friend = ModalRoute.of(context).settings.arguments as Friend;
    if (friend == null) {
      Future.delayed(Duration(milliseconds: 10),
          () => Navigator.of(context).pushReplacementNamed('/home'));
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/home');
              },
            ),
            centerTitle: true,
            title: Text(friend.username)),
        body: Column(
          children: [
            ScrollableChat(),
            ChatInput(
                firestore: firestore,
                newMessageController: _newMessageController,
                uid: uid,
                friendUid: friend.id)
          ],
        ));
  }
}
