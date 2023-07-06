import 'Variations.dart';

class Items {
  Items({
      this.itemName, 
      this.description, 
      this.price, 
      this.itemImage, 
      this.preference, 
      this.ingrediants,
      this.variations, 
      this.id, 
      this.code,
      this.isActive,
      this.quantity});

  Items.fromJson(dynamic json) {
    itemName = json['itemName'];
    description = json['description'];
    price = json['price'];
    itemImage = json['itemImage'];
    preference = json['preference'];
    ingrediants = json['ingrediants'];
    if (json['variations'] != null) {
      variations = [];
      json['variations'].forEach((v) {
        variations?.add(Variations.fromJson(v));
      });
    }
    id = json['id'];
    code = json['code'];
    isActive = json['isActive'];
    quantity = json['quantity'];
  }
  String? itemName;
  String? description;
  int? price;
  String? itemImage;
  String? preference;
  String? ingrediants;
  List<Variations>? variations;
  String? id;
  int? code;
  bool? isActive;
  int? quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['itemName'] = itemName;
    map['description'] = description;
    map['price'] = price;
    map['itemImage'] = itemImage;
    map['preference'] = preference;
    map['ingrediants'] = ingrediants;
    if (variations != null) {
      map['variations'] = variations?.map((v) => v.toJson()).toList();
    }
    map['id'] = id;
    map['code'] = code;
    map['isActive'] = isActive;
    map['quantity'] = quantity;
    return map;
  }

}