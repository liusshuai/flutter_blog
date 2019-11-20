import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:webapp/util/util.dart';

class Http {
  static Future<dynamic> get(String url, [dynamic data]) async {
    try {
      String _url = url;

      if (data != null) {
        _url = combinUrl(url, data);
      }

      final response = await http.get(_url);

      if (response.statusCode == 200) {
        return convert.jsonDecode(response.body);
      } else {

        print('第一次请求失败，第二次请求');

        final response_2 = await http.get(url);

        if (response_2.statusCode == 200) {
          return convert.jsonDecode(response_2.body);
        }

        print('请求失败，请检查设备是否可以联网');

      }
    } catch (e) {
      print(e.request);
      print(e.message);
    }
  }

  static Future<dynamic> post(String url, dynamic data) async {
    try {
      final response = await http.post(url, body: data);

      if (response.statusCode == 200) {

        return convert.jsonDecode(response.body);
      } else {

        print('请求错误');
      }

    } catch (e) {
      print(e.request);
      print(e.message);
    }
  }
}