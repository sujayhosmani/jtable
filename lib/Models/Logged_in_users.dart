import 'package:flutter/src/widgets/framework.dart';

class LoggedInUsers {
  LoggedInUsers({
      this.name, 
      this.ordersId, 
      this.tableId, 
      this.phone, 
      this.tableNo, 
      this.email, 
      this.dateOf, 
      this.monthOf, 
      this.otp, 
      this.otpById, 
      this.otpByName, 
      this.otpByPh, 
      this.status, 
      this.isFirst,
      this.id, 
      this.code, 
      this.createdDateTime, 
      this.updatedDateTime, 
      this.isActive, 
      this.createdBy,
    this.insertedBy,
    this.noOfPeople,
    this.token,
    this.amount,
    this.count,
    this.finalStatusCode,
    this.isBilled,
    this.ratingFromStaff,
    this.resUniq,
    this.joinOTP,
      this.updatedBy,});

  LoggedInUsers.fromJson(dynamic json) {
    name = json['name'];
    ordersId = json['ordersId'];
    tableId = json['tableId'];
    phone = json['phone'];
    tableNo = json['tableNo'];
    email = json['email'];
    dateOf = json['dateOf'];
    monthOf = json['monthOf'];
    otp = json['otp'];
    otpById = json['otpById'];
    otpByName = json['otpByName'];
    otpByPh = json['otpByPh'];
    status = json['status'];
    isFirst = json['isFirst'];
    id = json['id'];
    code = json['code'];
    createdDateTime = DateTime.parse(json['createdDateTime']);
    updatedDateTime = json['updatedDateTime'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];

    insertedBy = json['insertedBy'];
    noOfPeople = json['noOfPeople'];
    token = json['token'];
    amount = json['amount'];
    count = json['count'];
    finalStatusCode = json['finalStatusCode'];
    isBilled = json['isBilled'];
    ratingFromStaff = json['ratingFromStaff'];
    joinOTP = json['joinOTP'];
    resUniq = json['resUniq'];
  }
  String? name;
  String? ordersId;
  String? tableId;
  String? phone;
  String? tableNo;
  String? email;
  String? dateOf;
  String? monthOf;
  String? otp;
  String? joinOTP;
  String? otpById;
  String? otpByName;
  String? otpByPh;
  String? status;
  bool? isFirst;
  String? id;
  int? code;
  DateTime? createdDateTime;
  String? updatedDateTime;
  bool? isActive;
  String? createdBy;
  String? updatedBy;
  String? insertedBy;
  String? token;
  int? noOfPeople;
  int? finalStatusCode;
  int? amount;
  bool? isBilled;
  int? ratingFromStaff;
  int? count;
  String? resUniq;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['ordersId'] = ordersId;
    map['tableId'] = tableId;
    map['phone'] = phone;
    map['tableNo'] = tableNo;
    map['email'] = email;
    map['dateOf'] = dateOf;
    map['monthOf'] = monthOf;
    map['otp'] = otp;
    map['otpById'] = otpById;
    map['otpByName'] = otpByName;
    map['otpByPh'] = otpByPh;
    map['status'] = status;
    map['isFirst'] = isFirst;
    map['id'] = id;
    map['code'] = code;
    map['createdDateTime'] = createdDateTime;
    map['updatedDateTime'] = updatedDateTime;
    map['isActive'] = isActive;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;

    map['insertedBy'] = insertedBy;
     map['noOfPeople'] = noOfPeople;
     map['token'] = token;
     map['amount'] = amount;
     map['count'] = count;
     map['finalStatusCode'] = finalStatusCode;
     map['isBilled'] = isBilled;
     map['ratingFromStaff'] = ratingFromStaff;
    map['resUniq'] = resUniq;
    map['joinOTP'] = joinOTP;

    return map;
  }

}