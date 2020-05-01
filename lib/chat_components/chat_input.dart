import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.black));

class ChatInput extends StatelessWidget {
  ChatInput(
      {this.newMessageController, this.uid, this.friendUid, this.firestore});

  final Firestore firestore;
  final String uid;
  final String friendUid;
  final TextEditingController newMessageController;

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
              ),
            ),
            IconButton(
              icon: Icon(Icons.insert_emoticon, color: Colors.blueGrey),
              onPressed: () {
                Scaffold.of(context).showBottomSheet(
                    (_) => Padding(
                          padding: EdgeInsets.only(
                              bottom: 70,
                              left: MediaQuery.of(context).size.width * 0.25,
                              right: MediaQuery.of(context).size.width * 0.05),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 2,
                                      spreadRadius: 4)
                                ]),
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.05),
                            child: GridView.builder(
                              itemCount: emojiList.length,
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4),
                              itemBuilder: (_, index) => Center(
                                child: IconButton(
                                  icon: Text(
                                    emojiList.elementAt(index),
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  onPressed: () {
                                    final newValue =
                                        '${newMessageController.value.text}${emojiList.elementAt(index)}';
                                    newMessageController.value =
                                        TextEditingValue(
                                      text: newValue,
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: newValue.length),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                    backgroundColor: Colors.transparent);
              },
            ),
            IconButton(
              icon:
                  Transform.rotate(angle: 7 * pi / 8, child: Icon(Icons.reply)),
              color: Colors.blueGrey,
              onPressed: () {
                final DocumentReference postRef =
                    firestore.document('$uid-$friendUid');
                firestore.runTransaction((Transaction tx) async {
                  DocumentSnapshot postSnapshot = await tx.get(postRef);
                  print(postSnapshot.exists.toString());
                  if (postSnapshot.exists) {
                    await tx.update(postRef, <String, dynamic>{
                      DateTime.now().toIso8601String():
                          newMessageController.text
                    });
                  }
                });
              },
            )
          ],
        ));
  }
}
