import 'dart:async';
import 'package:webapp/constant.dart';
import 'package:webapp/module/source.dart';
import 'package:webapp/util/http.dart';

class SourceDao {
  static Future<SourceModule> fetchSource(int page, [String key = '']) async {
    var url ='$base_url/api/movie/getAll?page=$page&key=$key';

    final res = await Http.get(url);

    return SourceModule.fromJson(res['data']); 
  }
}