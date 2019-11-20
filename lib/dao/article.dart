import 'dart:async';
import 'package:webapp/constant.dart';
import 'package:webapp/module/article.dart';
import 'package:webapp/util/http.dart';

class ArticleDao {
  static Future<ArticleModule> fetchByAuthor(int page) async {
    var url = '$base_url/api/article/getByAuthor?page=$page&author=$author&limit=10&show=1';

    final res = await Http.get(url);

    return ArticleModule.fromJson(res['data']);
  }

  static Future<ArticleModule> fetchByChannel(int page, int cid) async {
    var url = '$base_url/api/article/getByChannel?page=$page&cid=$cid&limit=10';

    final res = await Http.get(url);

    return ArticleModule.fromJson(res['data']);
  }

  static Future<ArticleModule> fetchByKeyword(int page, String key) async {
    var url = '$base_url/api/article/getByKeyword?show=1&page=$page&keyword=$key&limit=10';

    final res = await Http.get(url);

    return ArticleModule.fromJson(res['data']);
  }
}