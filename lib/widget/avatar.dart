import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {

  final String url;
  final double size;
  final bool border;

  Avatar({
    @required this.url,
    this.size = 50.0,
    this.border = true
  });

  @override
  Widget build(BuildContext context) {

    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: border ? Border.all(width: 2.0, color: Color(0xffFF7F24))
            : Border.all(width: 0.0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(size / 2),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover
          ),
        ),
      ),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}