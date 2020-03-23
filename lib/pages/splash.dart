import 'package:flutter/material.dart';
import 'package:messenger/components/logo.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      color: Colors.teal[300],
      child: Center(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6),
              child: Logo())));
}
