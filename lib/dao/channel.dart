import 'dart:async';
import 'package:webapp/constant.dart';
import 'package:webapp/module/channel.dart';
import 'package:webapp/util/http.dart';

class ChannelDao {
  static Future<List> fetchChannels() async {
    var url = '$base_url/api/channel/getAllChannel';

    final res = await Http.get(url);
    List<ChannelModel> list = [];
    res['data'].forEach((c) {
      list.add(ChannelModel.fromJson(c));
    });

    return list;
  }
}