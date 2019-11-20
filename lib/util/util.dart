import 'package:flutter_web/material.dart';

String combinUrl(url, params) {
  var extra = [];
  for (var key in params) {
    extra.add(params[key]);
  }

  return url + '?' + extra.join('&');
}

Future routerGo(BuildContext context, Widget router) async {
  return await Navigator.push(context, MaterialPageRoute(
    builder: (context) => router
  ));
}