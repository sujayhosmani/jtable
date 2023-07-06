import 'package:jtable/Models/Items.dart';

class SubCategories {
  SubCategories({
      this.subCategoryId, 
      this.subCategoryName, 
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
  }
  String? subCategoryId;
  String? subCategoryName;
  int? itemCount;
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subCategoryId'] = subCategoryId;
    map['subCategoryName'] = subCategoryName;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    map['itemCount'] = itemCount;
    return map;
  }

}