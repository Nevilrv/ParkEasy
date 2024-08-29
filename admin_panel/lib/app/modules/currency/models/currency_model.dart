import 'package:cloud_firestore/cloud_firestore.dart';

class CurrencyModel {
  bool? active;
  String? id;
  Timestamp? createdAt;
  String? decimalDigits;
  String? name;
  String? symbol;
  bool? symbolAtRight;

  CurrencyModel({this.active, this.id, this.createdAt, this.decimalDigits, this.name, this.symbol, this.symbolAtRight});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    id = json['id'];
    createdAt = json['createdAt'];
    decimalDigits = json['decimalDigits'];
    name = json['name'];
    symbol = json['symbol'];
    symbolAtRight = json['symbolAtRight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (active != null) data['active'] = active;
    if (id != null) data['id'] = id;
    if (createdAt != null) data['createdAt'] = createdAt;
    if (decimalDigits != null) data['decimalDigits'] = decimalDigits;
    if (name != null) data['name'] = name;
    if (symbol != null) data['symbol'] = symbol;
    if (symbolAtRight != null) data['symbolAtRight'] = symbolAtRight;
    return data;
  }
}
