import 'dart:async';
import 'package:app/constant.dart';
import 'package:app/module/common.dart';
import 'package:app/util/http.dart';

class SystemDao {
  static Future<CommonModule> follow(String username, String email) async {
    var url = '$base_url/api/follow/follow';

    var res = await Http.post(url, {
      'username': username,
      'email': email
    });

    return CommonModule.fromJson(res);  
  }

  static Future<VersionModule> getaAppInfo() async {
    var url = '$base_url/api/app/home/getAppInfo';

    final res = await Http.get(url);

    return VersionModule.fromJson(res['data']);
  }
}