import 'package:flutter/material.dart';

class ScrollableChat extends StatelessWidget {
  ScrollableChat({this.messages});

  final List messages;

  @override
  Widget build(BuildContext context) {
    if ((messages?.length ?? 0) == 0) {
      return Expanded(child: Center(child: Text('No messages yet')));
    }
    return ListView.builder(itemBuilder: (_, index) => Center());
  }
}
