import 'package:app/module/channel.dart';

class ArticleModule {
  final int total;
  final List<ArticleItemModule> list;

  ArticleModule({
    this.total,
    this.list
  });

  factory ArticleModule.fromJson(Map<String, dynamic> json) {
    List<ArticleItemModule> list = [];

    json['list'].forEach((a) {
      list.add(ArticleItemModule.fromJson(a));
    });

    return ArticleModule(
      total: json['total'],
      list: list
    );
  }
}

class ArticleItemModule {
  final String pubtime;
  final int id;
  final String title;
  final String desc;
  final String tags;
  final int views;
  final int likes;
  final int comments;
  final String cover;
  final ChannelModel channel;

  ArticleItemModule({
    this.pubtime,
    this.id,
    this.title,
    this.desc,
    this.tags,
    this.views,
    this.likes,
    this.comments,
    this.channel,
    this.cover
  });

  factory ArticleItemModule.fromJson(Map<String, dynamic> json) {
    return ArticleItemModule(
      pubtime: json['pubtime'],
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      tags: json['tags'],
      views: json['views'],
      likes: json['likes'],
      comments: json['comments'],
      cover: json['cover'],
      channel: ChannelModel.fromJson(json['channel'])
    );
  }
}