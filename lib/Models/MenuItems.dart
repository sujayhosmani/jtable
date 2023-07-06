import 'Items.dart';

class MenuItems {
  MenuItems({
      this.categoryId,
    this.categoryName,
      this.subCategoryId,
    this.subCategoryName,
      this.itemId, 
      this.items, 
      this.id, 
      this.code,
      this.isActive,});

  MenuItems.fromJson(dynamic json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    subCategoryId = json['subCategoryId'];
    subCategoryName = json['subCategoryName'];
    itemId = json['itemId'];
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
    id = json['id'];
    code = json['code'];
    isActive = json['isActive'];
  }
  String? categoryId;
  String? categoryName;
  String? subCategoryId;
  String? subCategoryName;
  String? itemId;
  Items? items;
  String? id;
  int? code;
  bool? isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryId'] = categoryId;
    map['categoryName'] = categoryName;
    map['subCategoryId'] = subCategoryId;
    map['subCategoryName'] = subCategoryName;
    map['itemId'] = itemId;
    if (items != null) {
      map['items'] = items?.toJson();
    }
    map['id'] = id;
    map['code'] = code;
    map['isActive'] = isActive;
    return map;
  }

}