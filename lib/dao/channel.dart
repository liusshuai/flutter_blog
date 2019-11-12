import 'dart:async';
import 'package:app/constant.dart';
import 'package:app/module/channel.dart';
import 'package:app/util/http.dart';

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