class AdminModel {
  String? name;
  String? email;
  String? password;
  bool? isDemo;

  AdminModel({this.name, this.email, this.password, this.isDemo});

  @override
  String toString() {
    return 'AdminModel{name: $name, email: $email, password: $password, isDemo: $isDemo}';
  }

  AdminModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];

    isDemo = json['isDemo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['isDemo'] = isDemo ?? false;
    return data;
  }
}
