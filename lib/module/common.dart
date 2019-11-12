class CommonModule {
  final String msg;
  final int code;

  CommonModule({
    this.msg,
    this.code
  });

  factory CommonModule.fromJson(Map<String, dynamic> json) {
    return CommonModule(
      msg: json['msg'],
      code: json['code']
    );
  }
}

class VersionModule {
  final String version;
  final List<String> details;

  VersionModule({
    this.version,
    this.details
  });

  factory VersionModule.fromJson(Map<String, dynamic> json) {

    List<String> details = [];

    json['details'].forEach((d) {
      details.add(d.toString());
    });

    return VersionModule(
      version: json['version'],
      details: details
    );
  }
}
