import 'package:app/widget/icon.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {

  final String placeholder;
  final void Function (String key) search;

  SearchBar({
    this.placeholder = 'search',
    this.search
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 32.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(width: 1.0, color: Colors.black)
            ),
          ),
          TextField(
            textInputAction: TextInputAction.search,
            style: TextStyle(fontSize: 14.0),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: placeholder,
              prefixIcon: IconB(code: 0xe63c, color: Colors.black, size: 22.0)
            ),
            onSubmitted: (v) {
              if (search != null) {
                search(v);
              }
            },
          )
        ]
      )
    );
  }
}