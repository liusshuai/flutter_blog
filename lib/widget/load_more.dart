import 'package:app/widget/inlineLoading.dart';
import 'package:flutter/material.dart';

class LoadMore extends StatelessWidget {
  final bool hasMore;

  LoadMore(this.hasMore);

  @override
  Widget build(BuildContext context) {
    if (hasMore) {
      return InlineLoading();
    }


    return Container(
      height: 70.0,
      child: Center(
        child: Text('————已经到底啦(┬＿┬)↘————', style: TextStyle(
          color: Colors.grey
        ))
      )
    );
  }
}