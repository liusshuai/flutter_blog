import 'dart:async';
import 'package:app/constant.dart';
import 'package:app/module/bibi.dart';
import 'package:app/module/common.dart';
import 'package:app/util/http.dart';

class BibiDao {
  static Future<BibiModule> fetchBibi(int page) async {
    var url = '$base_url/api/tweet/getMyTweet?page=$page';

    final res = await Http.get(url);

    return BibiModule.fromJson(res['data']);
  }

  static Future<CommonModule> likeBibi(int id) async {
    var url = '$base_url/api/tweet/likeTweet';

    final res = await Http.post(url, {'id': id});

    return CommonModule.fromJson(res);
  }
}