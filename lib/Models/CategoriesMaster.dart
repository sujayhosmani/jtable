class CategoriesMaster {
  CategoriesMaster({
      this.categoryName, 
      this.catImage, 
      this.id, 
      this.code, 
      this.createdDateTime, 
      this.isActive});

  CategoriesMaster.fromJson(dynamic json) {
    categoryName = json['categoryName'];
    catImage = json['catImage'];
    id = json['id'];
    code = json['code'];
    createdDateTime = json['createdDateTime'];
    isActive = json['isActive'];
  }
  String? categoryName;
  String? catImage;
  String? id;
  int? code;
  String? createdDateTime;
  bool? isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryName'] = categoryName;
    map['catImage'] = catImage;
    map['id'] = id;
    map['code'] = code;
    map['createdDateTime'] = createdDateTime;
    map['isActive'] = isActive;
    return map;
  }

}