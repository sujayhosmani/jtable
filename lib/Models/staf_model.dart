class StafModel {
  StafModel({
      String? name, 
      String? age, 
      String? gender, 
      String? phone, 
      String? city, 
      String? state, 
      String? pincode, 
      String? password, 
      String? address, 
      String? userName, 
      String? role, 
      String? email, 
      bool? status, 
      dynamic category, 
      dynamic deviceToken, 
      dynamic kitchenCategory, 
      List<String>? notificationTables, 
      String? id, 
      int? code, 
      String? createdDateTime, 
      dynamic updatedDateTime, 
      bool? isActive, 
      String? createdBy, 
      dynamic updatedBy, 
      int? restaurentId, 
      int? groupId, 
      String? resUniq, 
      String? guidId,}){
    _name = name;
    _age = age;
    _gender = gender;
    _phone = phone;
    _city = city;
    _state = state;
    _pincode = pincode;
    _password = password;
    _address = address;
    _userName = userName;
    _role = role;
    _email = email;
    _status = status;
    _category = category;
    _deviceToken = deviceToken;
    _kitchenCategory = kitchenCategory;
    _notificationTables = notificationTables;
    _id = id;
    _code = code;
    _createdDateTime = createdDateTime;
    _updatedDateTime = updatedDateTime;
    _isActive = isActive;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _restaurentId = restaurentId;
    _groupId = groupId;
    _resUniq = resUniq;
    _guidId = guidId;
}

  StafModel.fromJson(dynamic json) {
    _name = json['name'];
    _age = json['age'];
    _gender = json['gender'];
    _phone = json['phone'];
    _city = json['city'];
    _state = json['state'];
    _pincode = json['pincode'];
    _password = json['password'];
    _address = json['address'];
    _userName = json['userName'];
    _role = json['role'];
    _email = json['email'];
    _status = json['status'];
    _category = json['category'];
    _deviceToken = json['deviceToken'];
    _kitchenCategory = json['kitchenCategory'];
    _notificationTables = json['notificationTables'] != null ? json['notificationTables'].cast<String>() : [];
    _id = json['id'];
    _code = json['code'];
    _createdDateTime = json['createdDateTime'];
    _updatedDateTime = json['updatedDateTime'];
    _isActive = json['isActive'];
    _createdBy = json['createdBy'];
    _updatedBy = json['updatedBy'];
    _restaurentId = json['restaurentId'];
    _groupId = json['groupId'];
    _resUniq = json['resUniq'];
    _guidId = json['guidId'];
  }
  String? _name;
  String? _age;
  String? _gender;
  String? _phone;
  String? _city;
  String? _state;
  String? _pincode;
  String? _password;
  String? _address;
  String? _userName;
  String? _role;
  String? _email;
  bool? _status;
  dynamic _category;
  dynamic _deviceToken;
  dynamic _kitchenCategory;
  List<String>? _notificationTables;
  String? _id;
  int? _code;
  String? _createdDateTime;
  dynamic _updatedDateTime;
  bool? _isActive;
  String? _createdBy;
  dynamic _updatedBy;
  int? _restaurentId;
  int? _groupId;
  String? _resUniq;
  String? _guidId;

  String? get name => _name;
  String? get age => _age;
  String? get gender => _gender;
  String? get phone => _phone;
  String? get city => _city;
  String? get state => _state;
  String? get pincode => _pincode;
  String? get password => _password;
  String? get address => _address;
  String? get userName => _userName;
  String? get role => _role;
  String? get email => _email;
  bool? get status => _status;
  dynamic get category => _category;
  dynamic get deviceToken => _deviceToken;
  dynamic get kitchenCategory => _kitchenCategory;
  List<String>? get notificationTables => _notificationTables;
  String? get id => _id;
  int? get code => _code;
  String? get createdDateTime => _createdDateTime;
  dynamic get updatedDateTime => _updatedDateTime;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  dynamic get updatedBy => _updatedBy;
  int? get restaurentId => _restaurentId;
  int? get groupId => _groupId;
  String? get resUniq => _resUniq;
  String? get guidId => _guidId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['age'] = _age;
    map['gender'] = _gender;
    map['phone'] = _phone;
    map['city'] = _city;
    map['state'] = _state;
    map['pincode'] = _pincode;
    map['password'] = _password;
    map['address'] = _address;
    map['userName'] = _userName;
    map['role'] = _role;
    map['email'] = _email;
    map['status'] = _status;
    map['category'] = _category;
    map['deviceToken'] = _deviceToken;
    map['kitchenCategory'] = _kitchenCategory;
    map['notificationTables'] = _notificationTables;
    map['id'] = _id;
    map['code'] = _code;
    map['createdDateTime'] = _createdDateTime;
    map['updatedDateTime'] = _updatedDateTime;
    map['isActive'] = _isActive;
    map['createdBy'] = _createdBy;
    map['updatedBy'] = _updatedBy;
    map['restaurentId'] = _restaurentId;
    map['groupId'] = _groupId;
    map['resUniq'] = _resUniq;
    map['guidId'] = _guidId;
    return map;
  }

}