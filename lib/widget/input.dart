import 'package:flutter/material.dart';

class Input extends StatefulWidget {

  final bool require;
  final String label;
  final int maxLine;
  final String hintText;
  final void Function (String v) onChanged;
  final TextEditingController controller;

  Input({
    this.require = false,
    this.label,
    this.maxLine = 1,
    this.hintText = '',
    this.onChanged,
    this.controller
  });

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  FocusNode focusNode = FocusNode();
  bool isFocus = false;

  @override
  void initState() { 
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isFocus = true;
        });
      } else {
        setState(() {
          isFocus = false;
        });
      }
    });
  }

  List<Widget> renderMain() {
    List<Widget> list = [];

    if (widget.require) {
      list.add(Text('*', style: TextStyle(color: Colors.red, fontSize: 18.0)));
    }

    if (widget.label != null) {
      list.add(Text(widget.label, style: TextStyle(fontSize: 15.0)));
      list.add(SizedBox(width: 12.0));
    }

    list.add(Expanded(child: Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: isFocus ? Colors.black26 : Color(0xffeeeeee)),
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.white
      ),
      child: TextField(
        focusNode: focusNode,
        maxLines: widget.maxLine,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText
        ),
        controller: widget.controller,
        onChanged: (v) {
          if (widget.onChanged != null) {
            widget.onChanged(v);
          }
        },
        
      )
    )));

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: renderMain()
      ),
    );
  }
}