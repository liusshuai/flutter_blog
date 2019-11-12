import 'dart:async';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

var dio = new Dio();

class Http {
  static Future<dynamic> get(String url, [dynamic data]) async {
    try {
      var appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      dio.interceptors.add(CookieManager(PersistCookieJar(dir: '$appDocPath/cookies')));

      final response = await dio.get(url, queryParameters: data ?? null);

      if (response.statusCode == 200) {
        return response.data;
      } else {

        print('第一次请求失败，第二次请求');

        final response_2 = await dio.get(url, queryParameters: data ?? null);

        if (response_2.statusCode == 200) {
          return response_2.data;
        }

        print('请求失败，请检查设备是否可以联网');

      }
    } on DioError catch (e) {
      print(e.request);
      print(e.message);
    }
  }

  static Future<dynamic> post(String url, dynamic data) async {
    try {
      var appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      dio.interceptors.add(CookieManager(PersistCookieJar(dir: '$appDocPath/cookies')));

      final response = await dio.post(url, data: data);

      if (response.statusCode == 200) {

        return response.data;
      } else {

        print('请求错误');
      }

    } on DioError catch (e) {
      print(e.request);
      print(e.message);
    }
  }
}