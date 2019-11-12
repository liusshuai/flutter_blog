class Image {
  final String src;

  Image({
    this.src
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      src: json['src']
    );
  }
}

class BibiItemModule {
  final int id;
  final String pubtime;
  final String content;
  final String fromw;
  final int likenum;
  final int comments;
  final List<Image> imgs; 

  BibiItemModule({
    this.id,
    this.pubtime,
    this.content,
    this.fromw,
    this.likenum,
    this.comments,
    this.imgs
  });

  factory BibiItemModule.fromJson(Map<String, dynamic> json) {

    List<Image> images = [];

    json['imgs'].forEach((img) {
      images.add(Image.fromJson(img));
    });

    return BibiItemModule(
      id: json['id'],
      pubtime: json['pubtime'],
      content: json['content'],
      fromw: json['fromw'],
      likenum: json['likenum'],
      comments: json['comments'],
      imgs: images
    );
  }
}

class BibiModule {
  final int total;
  final List<BibiItemModule> data;

  BibiModule({
    this.total,
    this.data
  });

  factory BibiModule.fromJson(Map<String, dynamic> json) {
    List<BibiItemModule> list = [];

    json['data'].forEach((bibi) {
      list.add(BibiItemModule.fromJson(bibi));
    });

    return BibiModule(
      total: json['total'],
      data: list
    );
  }
}