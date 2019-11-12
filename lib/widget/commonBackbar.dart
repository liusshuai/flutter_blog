import 'package:app/widget/icon.dart';
import 'package:flutter/material.dart';

class CommonBackBar extends StatelessWidget {

  final String extra;
  final String color;

  CommonBackBar({
    this.extra,
    this.color = 'black'
  });

  List<Widget> renderList() {
    List<Widget> list = [];

    list.add(IconB(code: 0xe659, size: 26.0, color: color == 'black' ? Colors.black : Colors.white));

    if (extra != null) {
      list.add(Text(extra, style: TextStyle(color: color == 'black' ? Colors.black : Colors.white)));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(children: renderList())
    );
  }
}