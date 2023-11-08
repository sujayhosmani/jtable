import 'package:jtable/Models/Items.dart';

class SubCategories {
  SubCategories({
      this.subCategoryId, 
      this.subCategoryName,
      this.discount,
      this.maxQuantity,
      this.status,
    this.catId,
      this.itemCount,
    this.items});

  SubCategories.fromJson(dynamic json) {
    subCategoryId = json['subCategoryId'];
    subCategoryName = json['subCategoryName'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
    itemCount = json['itemCount'];

    discount = json['discount'];
    maxQuantity = json['maxQuantity'];
    status = json['status'];
  }
  String? subCategoryId;
  String? subCategoryName;
  int? itemCount;
  List<Items>? items;
  String? catId;
  int? discount;
  int? maxQuantity;
  bool? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subCategoryId'] = subCategoryId;
    map['subCategoryName'] = subCategoryName;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    map['itemCount'] = itemCount;

    map['discount'] = discount;
    map['maxQuantity'] = maxQuantity;
    map['status'] = status;
    return map;
  }

}