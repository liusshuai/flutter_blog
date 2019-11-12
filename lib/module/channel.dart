class ChannelModel {
  final int id;
  final String name;
  final int articlecount;
  final String cover;

  ChannelModel({
    this.id,
    this.name,
    this.articlecount,
    this.cover
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['id'],
      name: json['name'],
      articlecount: json['articlecount'],
      cover: json['cover']
    );
  }
}