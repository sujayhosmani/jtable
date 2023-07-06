
class Users{
  final String? name;
  final String? password;
  final String? userName;
  final String? role;
  final String? dob;
  final String? phone;
  final String? refId;
  final bool? status;
  final String? email;
  final String? token;
  final String? id;

  Users(this.name, this.password, this.userName, this.role, this.dob, this.phone, this.refId, this.status, this.email, this.token, this.id);

  factory Users.fromJson(Map<String, dynamic> json) =>
      _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);

}

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
  json['name'] as String?,
  json['password'] as String?,
  json['userName'] as String?,
  json['role'] as String?,
  json['dob'] as String?,
  json['phone'] as String?,
  json['refId'] as String?,
  json['status'] as bool?,
  json['email'] as String?,
  json['token'] as String?,
  json['id'] as String?,
);

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
  'name': instance.name,
  'password': instance.password,
  'userName': instance.userName,
  'role': instance.role,
  'dob': instance.dob,
  'phone': instance.phone,
  'refId': instance.refId,
  'status': instance.status,
  'email': instance.email,
  'token': instance.token,
  'id': instance.id,
};