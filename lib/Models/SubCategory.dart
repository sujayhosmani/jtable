import 'SubCategories.dart';

class SubCategory {
  SubCategory({
      this.catDiscount,
      this.categoryName, 
      this.catImage, 
      this.subCategories, 
      this.id, 
      this.code, 
      this.createdDateTime, 
      this.updatedDateTime, 
      this.isActive, 
      this.createdBy, 
      this.updatedBy,
  this.catMaxQuantity,
  this.catStatus});

  SubCategory.fromJson(dynamic json) {
    catDiscount = json['catDiscount'];
    categoryName = json['categoryName'];
    catImage = json['catImage'];
    if (json['subCategories'] != null) {
      subCategories = [];
      json['subCategories'].forEach((v) {
        subCategories?.add(SubCategories.fromJson(v));
      });
    }
    id = json['id'];
    code = json['code'];
    createdDateTime = json['createdDateTime'];
    updatedDateTime = json['updatedDateTime'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];

    catMaxQuantity = json['catMaxQuantity'];
    catStatus = json['catStatus'];
  }
  String? catDiscount;
  String? categoryName;
  String? catImage;
  List<SubCategories>? subCategories;
  String? id;
  int? code;
  String? createdDateTime;
  String? updatedDateTime;
  bool? isActive;
  String? createdBy;
  String? updatedBy;

  int? catMaxQuantity;
  bool? catStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['catDiscount'] = catDiscount;
    map['categoryName'] = categoryName;
    map['catImage'] = catImage;
    if (subCategories != null) {
      map['subCategories'] = subCategories?.map((v) => v.toJson()).toList();
    }
    map['id'] = id;
    map['code'] = code;
    map['createdDateTime'] = createdDateTime;
    map['updatedDateTime'] = updatedDateTime;
    map['isActive'] = isActive;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;

    map['catMaxQuantity'] = catMaxQuantity;
    map['catStatus'] = catStatus;
    return map;
  }

}