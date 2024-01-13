import 'package:flutter/src/widgets/framework.dart';

class LoggedInUsersPost {
  LoggedInUsersPost({
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

    this.resUniq,
    this.updatedBy,});

  LoggedInUsersPost.fromJson(dynamic json) {
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
    createdDateTime = json['createdDateTime'];
    updatedDateTime = json['updatedDateTime'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];

    insertedBy = json['insertedBy'];
    noOfPeople = json['noOfPeople'];
    token = json['token'];


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
  String? otpById;
  String? otpByName;
  String? otpByPh;
  String? status;
  bool? isFirst;
  String? id;
  int? code;
  String? createdDateTime;
  String? updatedDateTime;
  bool? isActive;
  String? createdBy;
  String? updatedBy;
  String? insertedBy;
  String? token;
  int? noOfPeople;

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
    map['resUniq'] = resUniq;

    return map;
  }

}