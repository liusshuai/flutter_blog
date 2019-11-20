import 'package:flutter_web/material.dart';

class PageWrap extends StatelessWidget {

  final Widget header;
  final Widget body;
  final FloatingActionButton button;
  final int colorValue;
  final int headerColor;

  PageWrap({
    this.header,
    this.button,
    @required this.body,
    this.colorValue = 0xfff6f6f6,
    this.headerColor = 0xffffffff
  });

  @override
  Widget build(BuildContext context) {

    EdgeInsets padding = MediaQuery.of(context).padding;

    List<Widget> renderContent() {
      List<Widget> list = [];

      if (this.header != null) {
        list.add(Container(
          color: Color(headerColor),
          padding: EdgeInsets.fromLTRB(14.0, 6.0, 14.0, 6.0),
          child: header
        ));
      }

      list.add(Flexible(
        child: body
      ));

      return list;
    }

    return Scaffold(
      backgroundColor: Color(colorValue),
      body: Column(children: renderContent()),
      floatingActionButton: button
    );
  }
}