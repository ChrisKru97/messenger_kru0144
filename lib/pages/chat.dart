import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger/chat_components/chat_input.dart';
import 'package:messenger/classes/chat_info.dart';
import 'package:messenger/chat_components/scrollable_chat.dart';
import 'package:messenger/classes/friend.dart';

class Chat extends StatefulWidget {
  Chat({this.uid});

  final String uid;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _newMessageController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PersistentBottomSheetController bottomSheetController;

  Future<ChatInfo> getChatInfo(String myId, String friendId) async {
    final secondaryCollection =
        '${friendId.substring(0, 9)}-${myId.substring(0, 9)}';
    if ((await Firestore.instance
                .collection(secondaryCollection)
                .getDocuments())
            .documents
            .length >
        0) {
      return ChatInfo(collectionId: secondaryCollection, isAuthor: false);
    }
    return ChatInfo(
        collectionId: '${myId.substring(0, 9)}-${friendId.substring(0, 9)}',
        isAuthor: true);
  }

  @override
  Widget build(BuildContext context) {
    final friend = ModalRoute.of(context).settings.arguments as Friend;
    if (friend == null) {
      Future.delayed(Duration(milliseconds: 10),
          () => Navigator.of(context).pushReplacementNamed('/home'));
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/home');
              },
            ),
            centerTitle: true,
            title: Text(friend.username)),
        body: Builder(
            builder: (context) => GestureDetector(
                  onTap: () {
                    if (bottomSheetController != null) {
                      bottomSheetController.close();
                    }
                  },
                  child: FutureBuilder<ChatInfo>(
                      future: getChatInfo(widget.uid, friend.id),
                      builder: (context, snapshot) => snapshot.hasData
                          ? Column(
                              children: [
                                ScrollableChat(chatInfo: snapshot.data),
                                ChatInput(
                                    newMessageController: _newMessageController,
                                    chatInfo: snapshot.data,
                                    setBottomSheetController:
                                        (PersistentBottomSheetController
                                            controller) {
                                      setState(() {
                                        bottomSheetController = controller;
                                      });
                                    })
                              ],
                            )
                          : Center(child: CircularProgressIndicator())),
                )));
  }
}
