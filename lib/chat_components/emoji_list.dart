import 'package:flutter/material.dart';

import '../utils.dart';

class EmojiList extends StatelessWidget {
  EmojiList({this.newMessageController});

  final TextEditingController newMessageController;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.transparent,
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
                      color: Colors.black26, blurRadius: 2, spreadRadius: 4)
                ]),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: GridView.builder(
              itemCount: emojiList.length,
              scrollDirection: Axis.horizontal,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (_, index) => Center(
                child: IconButton(
                  icon: Text(
                    emojiList.elementAt(index),
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () {
                    final newValue =
                        '${newMessageController.value.text}${emojiList.elementAt(index)}';
                    newMessageController.value = TextEditingValue(
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
      );
}
