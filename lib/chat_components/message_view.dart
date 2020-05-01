import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messenger/classes/message.dart';

class MessageView extends StatelessWidget {
  MessageView({this.message, this.isAuthor});

  final Message message;
  final bool isAuthor;

  @override
  Widget build(BuildContext context) {
    final asAuthor = isAuthor ? message.authorSent : !message.authorSent;
    final time = Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          DateFormat(asAuthor ? 'H:m d/M/yy' : 'd/M/yy H:m')
              .format(DateTime.fromMillisecondsSinceEpoch(message.timestamp)),
          style: TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold),
        ));
    return Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              asAuthor ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (asAuthor) time,
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: asAuthor
                      ? Colors.indigoAccent[100]
                      : Colors.pinkAccent[100]),
              child: Text(
                message.text,
                style: TextStyle(fontSize: 25),
                textAlign: asAuthor ? TextAlign.end : TextAlign.start,
              ),
            ),
            if (!asAuthor) time,
          ],
        ));
  }
}
