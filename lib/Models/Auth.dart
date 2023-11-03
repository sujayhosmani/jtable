class Auth {

  String? name = "";
  String? password = "";
  String? resUniq = "";

  Auth(this.name, this.password, this.resUniq);

  Auth.fromJson(dynamic json) {
    name = json['name'];
    password = json['password'];
    resUniq = json['resUniq'];
  }



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['password'] = password;
    map['resUniq'] = resUniq;
    return map;
  }



}