class TaxModel {
  bool? active;
  String? id;
  String? name;
  String? country;
  bool? isFix;
  String? value;

  TaxModel({this.active, this.id, this.name, this.country, this.isFix, this.value});

  TaxModel.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    id = json['id'];
    name = json['name'];
    country = json['country'];
    isFix = json['isFix'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active'] = active;
    data['id'] = id;
    data['name'] = name;
    data['country'] = country;
    data['isFix'] = isFix;
    data['value'] = value;
    return data;
  }
}
