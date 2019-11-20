import 'package:flutter_web/material.dart';

class Empty extends StatelessWidget {

  final String text;

  Empty({this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text, style: TextStyle(color: Colors.grey))
    );
  }
}