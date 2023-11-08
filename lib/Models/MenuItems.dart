import 'Items.dart';

class MenuItems {
  MenuItems({
      this.categoryId,
      this.subCategoryId,
      this.itemId,
    this.status,
      this.items, 
      this.id, 
      this.code,
      this.isActive,});

  MenuItems.fromJson(dynamic json) {
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    status = json['status'];
    itemId = json['itemId'];
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
    id = json['id'];
    code = json['code'];
    isActive = json['isActive'];
  }
  String? categoryId;
  String? subCategoryId;
  String? itemId;
  Items? items;
  bool? status;
  String? id;
  int? code;
  bool? isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryId'] = categoryId;
    map['status'] = status;
    map['subCategoryId'] = subCategoryId;
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