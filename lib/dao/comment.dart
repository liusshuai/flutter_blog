import 'dart:async';
import 'package:webapp/constant.dart';
import 'package:webapp/module/comment.dart';
import 'package:webapp/module/common.dart';
import 'package:webapp/util/http.dart';

class CommentDao {
  static Future<CommentModule> fetchBoards(int page) async {
    var url = '$base_url/api/blogComment/getByBoard?page=$page';

    var res = await Http.get(url);

    return CommentModule.fromJson(res['data']);
  }

  static Future<CommentModule> fetchByArticle(int aid, int page) async {
    var url = '$base_url/api/blogComment/getByArticle?page=$page&aid=$aid';

    var res = await Http.get(url);

    return CommentModule.fromJson(res['data']);
  }

  static Future<CommentModule> fetchByTweet(int tid, int page) async {
    var url = '$base_url/api/blogComment/getByTweet?page=$page&tid=$tid';

    var res = await Http.get(url);

    return CommentModule.fromJson(res['data']);
  }

  static Future<CommentModule> fetchBySource(int mid, int page) async {
    var url = '$base_url/api/blogComment/getByMovie?page=$page&mid=$mid';

    var res = await Http.get(url);

    return CommentModule.fromJson(res['data']);
  }

  static Future<CommonModule> addComment(dynamic params) async {
    var url = '$base_url/api/blogComment/addComment';

    var res = await Http.post(url, params);

    return CommonModule.fromJson(res);
  }
}