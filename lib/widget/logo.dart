import 'package:flutter_web/material.dart';

class Logo extends StatelessWidget {

  final double size;

  Logo({
    this.size: 100.0
  });
  
  @override
  Widget build(BuildContext context) {
    return Image.asset('images/logo_light.png', width: size);
  }
} 