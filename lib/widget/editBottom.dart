import 'package:flutter/material.dart';

class EditBottom extends StatelessWidget {

  final void Function () submit;
  final void Function () clear;
  final String cancelText;
  final String okText;

  EditBottom({
    this.submit,
    this.clear,
    this.cancelText = '取消',
    this.okText = '确定'
  });

  @override
  Widget build(BuildContext context) {

    EdgeInsets padding = MediaQuery.of(context).padding;

    double bottom = padding != null && padding.bottom != null 
      && padding.bottom < 10.0 ? 10.0 : padding.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, bottom),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (clear != null) {
                  clear();
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.black),
                  borderRadius: BorderRadius.circular(6.0)
                ),
                child: Center(child: Text(cancelText, style: TextStyle(fontSize: 16.0)))
              )
            )
          ),
          SizedBox(width: 14.0),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (submit != null) {
                  submit();
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.black),
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.black
                ),
                child: Center(child: Text(okText, style: TextStyle(fontSize: 16.0, color: Colors.white)))
              )
            )
          )
        ]
      )
    );
  }
}