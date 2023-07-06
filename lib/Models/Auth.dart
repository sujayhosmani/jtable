class Auth {

  String? name = "";
  String? password = "";

  Auth(this.name, this.password);

  Auth.fromJson(dynamic json) {
    name = json['name'];
    password = json['password'];
  }



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['password'] = password;
    return map;
  }



}