class SourceItemModule {
  final int id;
  final String name;
  final String cover;
  final String type;
  final String tag;
  final String director;
  final String actor;
  final String desc;

  SourceItemModule({
    this.id,
    this.name,
    this.cover,
    this.type,
    this.tag,
    this.director,
    this.actor,
    this.desc
  });

  factory SourceItemModule.fromJson(Map<String, dynamic> json) {
    return SourceItemModule(
      id: json['id'],
      name: json['name'],
      cover: json['cover'],
      type: json['type'],
      tag: json['tag'],
      director: json['director'],
      actor: json['actor'],
      desc: json['desc']
    );
  }
}

class SourceModule {
  final int total;
  final List<SourceItemModule> list;

  SourceModule({
    this.total,
    this.list
  });

  factory SourceModule.fromJson(Map<String, dynamic> json) {
    List<SourceItemModule> list = [];

    json['list'].forEach((s) {
      list.add(SourceItemModule.fromJson(s));
    });

    return SourceModule(
      total: json['total'],
      list: list
    );
  }
}