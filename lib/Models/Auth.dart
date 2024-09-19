class Auth {

  String? name = "";
  String? password = "";
  String? resUniq = "";
  String? deviceToken = "";

  Auth(this.name, this.password, this.resUniq, this.deviceToken);

  Auth.fromJson(dynamic json) {
    name = json['name'];
    password = json['password'];
    resUniq = json['resUniq'];
    deviceToken = json['deviceToken'];
  }



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['password'] = password;
    map['resUniq'] = resUniq;
    map['deviceToken'] = deviceToken;
    return map;
  }



}