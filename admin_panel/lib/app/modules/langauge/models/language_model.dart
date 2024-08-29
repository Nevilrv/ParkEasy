class LanguageModel {
  bool? active;
  String? id;
  String? name;
  String? code;

  LanguageModel({this.active, this.id, this.name, this.code});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active'] = active;
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}
