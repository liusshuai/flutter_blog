import 'dart:async';
import 'package:app/constant.dart';
import 'package:app/module/source.dart';
import 'package:app/util/http.dart';

class SourceDao {
  static Future<SourceModule> fetchSource(int page, [String key = '']) async {
    var url ='$base_url/api/movie/getAll?page=$page&key=$key';

    final res = await Http.get(url);

    return SourceModule.fromJson(res['data']); 
  }
}