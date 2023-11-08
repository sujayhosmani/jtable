import 'Variations.dart';

class Items {
  Items({
      this.itemName, 
      this.description, 
      this.price, 
      this.itemImage, 
      this.preference,

    this.maxQuantity,
    this.discount,
    this.itemType,
    this.minutes,
    this.info,
    this.category,
    this.status,
    this.tag,
    this.isDineIn,
    this.isTakeAway,
    this.isDelivery,
    this.isSelected,

      this.ingrediants,
      this.variations, 
      this.id, 
      this.code,
      this.isActive,
      this.quantity});

  Items.fromJson(dynamic json) {
    maxQuantity = json['maxQuantity'];
    discount = json['discount'];
    itemType = json['itemType'];
    minutes = json['minutes'];
    info = json['info'];
    category = json['category'];
    status = json['status'];
    tag = json['tag'];
    isDineIn = json['isDineIn'];
    isTakeAway = json['isTakeAway'];
    isDelivery = json['isDelivery'];
    isSelected = json['isSelected'];

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
  int? maxQuantity;
  int? discount;
  String? itemType;
  String? minutes;
  String? info;
  String? category;
  bool? status;
  String? tag;
  bool? isDineIn;
  bool? isTakeAway;
  bool? isDelivery;
  bool? isSelected;

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


    map['maxQuantity'] = maxQuantity;
    map['discount'] = discount;
    map['itemType'] = itemType;
    map['minutes'] = minutes;
    map['info'] = info;
    map['category'] = category;
    map['status'] = status;
    map['tag'] = tag;
    map['isDineIn'] = isDineIn;
    map['isTakeAway'] = isTakeAway;
    map['isDelivery'] = isDelivery;
    map['isSelected'] = isSelected;

    return map;
  }

}