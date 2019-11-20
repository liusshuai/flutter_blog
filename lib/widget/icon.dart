import 'package:flutter_web/material.dart';

class IconB extends StatelessWidget {

  final int code;
  final Color color;
  final double size;
  final String family;

  IconB({
    @required this.code,
    this.color = Colors.grey,
    this.size = 20.0,
    this.family = 'Blog'
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      IconData(code, fontFamily: family),
      color: color,
      size: size
    );
  }
}