class CommentItemModule {
  final String pubtime;
  final int id;
  final int host;
  final String content;
  final String username;
  final String useremail;
  final String replyname;
  final String replyemail;
  final String replycontent;
  final int type;

  CommentItemModule({
    this.pubtime,
    this.id,
    this.host,
    this.content,
    this.username,
    this.useremail,
    this.replyname,
    this.replyemail,
    this.replycontent,
    this.type
  });

  factory CommentItemModule.fromJson(Map<String, dynamic> json) {
    return CommentItemModule(
      pubtime: json['pubtime'],
      id: json['id'],
      host: json['host'],
      content: json['content'],
      username: json['username'],
      useremail: json['useremail'],
      replyname: json['replyname'],
      replyemail: json['replyemail'],
      replycontent: json['replycontent'],
      type: json['type']
    );
  }
}

class CommentModule {
  final int total;
  final List<CommentItemModule> list;

  CommentModule({
    this.total,
    this.list
  });

  factory CommentModule.fromJson(Map<String, dynamic> json) {
    List<CommentItemModule> list = [];

    json['list'].forEach((c) {
      list.add(CommentItemModule.fromJson(c));
    });

    return CommentModule(
      total: json['total'],
      list: list
    );
  }
}