import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger/chat_components/message_view.dart';
import 'package:messenger/classes/chat_info.dart';
import 'package:messenger/classes/message.dart';

class ScrollableChat extends StatelessWidget {
  ScrollableChat({this.messages, this.chatInfo});

  final ChatInfo chatInfo;
  final List messages;

  @override
  Widget build(BuildContext context) => Expanded(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection(chatInfo.collectionId)
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child:
                      Text('No messages yet', style: TextStyle(fontSize: 25)));
            }
            return ListView.builder(
              reverse: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (_, index) => MessageView(
                  message: Message.fromJson(
                      snapshot.data.documents.elementAt(index)),
                  isAuthor: chatInfo.isAuthor),
            );
          },
        ),
      );
}
