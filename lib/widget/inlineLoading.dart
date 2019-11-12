import 'package:flutter/material.dart';

class InlineLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: Center(
        child: Opacity(
          opacity: 1.0,
          child: Image.network(
            'http://www.lsshuai.com/static/images/load_more.gif',
            fit: BoxFit.cover
          )
        )
      )
    );
  }
}