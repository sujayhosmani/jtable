class Variations {
  Variations({
      this.name, 
      this.description,
      this.price,
  this.quantity,
  this.isSelected});

  Variations.fromJson(dynamic json) {
    name = json['name'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    isSelected = json['isSelected'];
  }
  String? name;
  String? description;
  int? price;
  int? quantity;
  bool? isSelected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['description'] = description;
    map['price'] = price;
    map['quantity'] = quantity;
    map['isSelected'] = isSelected;
    return map;
  }

}