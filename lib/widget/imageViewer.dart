import 'package:flutter_web/material.dart';

class ImageViwer extends StatelessWidget {

  final String src;

  ImageViwer({this.src});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        color: Colors.black,
        child: Center(
          child: Image.network(
            src,
            fit: BoxFit.cover
          )
        ),
      )
    );
  }
}