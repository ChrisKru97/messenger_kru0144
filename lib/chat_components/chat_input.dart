import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger/chat_components/emoji_list.dart';
import 'package:messenger/classes/chat_info.dart';

final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.black));

class ChatInput extends StatelessWidget {
  ChatInput(
      {this.newMessageController,
      this.chatInfo,
      this.setBottomSheetController});

  final ChatInfo chatInfo;
  final TextEditingController newMessageController;
  final Function(PersistentBottomSheetController controller)
      setBottomSheetController;

  void sendMessage(String text) {
    if (text.length > 0) {
      Firestore.instance.collection(chatInfo.collectionId).add({
        'authorSent': chatInfo.isAuthor,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'text': text
      }).then((_) {
        newMessageController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        color: Colors.orangeAccent[100].withAlpha(80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                controller: newMessageController,
                style: TextStyle(fontSize: 25),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    hintText: 'Send something ...',
                    border: border,
                    focusedBorder: border),
                onSubmitted: sendMessage,
              ),
            ),
            IconButton(
              icon: Icon(Icons.insert_emoticon, color: Colors.blueGrey),
              onPressed: () {
                setBottomSheetController(Scaffold.of(context).showBottomSheet(
                    (_) => EmojiList(
                          newMessageController: newMessageController,
                        ),
                    backgroundColor: Colors.transparent));
              },
            ),
            IconButton(
              icon:
                  Transform.rotate(angle: 7 * pi / 8, child: Icon(Icons.reply)),
              color: Colors.blueGrey,
              onPressed: () => sendMessage(newMessageController.text),
            )
          ],
        ));
  }
}
