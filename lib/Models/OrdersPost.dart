

class OrdersPost {
  OrdersPost({
    this.itemId,
    this.itemName,
    this.itemImage,
    this.isVeriation,
    this.varName,
    this.varId,
    this.price,
    this.discount,
    this.quantity,
    this.description,
    this.preference,
    this.ordersId,
    this.addedById,
    this.status,

    this.tableNo,
    this.tableId,

    this.insertedBy,
    this.insertedById,
    this.insertedByName,
    this.insertedByPh,
    this.isAccepted,
    this.isRunning,
    this.isCancelled,


  });

  OrdersPost.fromJson(dynamic json) {
    itemId = json['itemId'];
    itemName = json['itemName'];
    itemImage = json['itemImage'];
    isVeriation = json['isVeriation'];
    varName = json['varName'];
    varId = json['varId'];
    price = json['price'];
    discount = json['discount'];
    quantity = json['quantity'];
    description = json['description'];
    preference = json['preference'];
    ordersId = json['ordersId'];
    addedById = json['addedById'];

    status = json['status'];

    tableNo = json['tableNo'];
    tableId = json['tableId'];

    insertedBy = json['insertedBy'];

    insertedById = json['insertedById'];
    insertedByName = json['insertedByName'];
    insertedByPh = json['insertedByPh'];

    isAccepted = json['isAccepted'];
    isRunning = json['isRunning'];
    isCancelled = json['isCancelled'];


  }
  String? itemId;
  String? itemName;
  String? itemImage;
  bool? isVeriation;
  String? varName;
  String? varId;
  int? price;
  int? discount;
  int? quantity;
  String? description;
  String? preference;
  String? ordersId;
   String? addedById;
  String? status;

  String? tableNo;
  String? tableId;

  String? insertedBy;
  String? insertedById;
  String? insertedByName;
  String? insertedByPh;

  bool? isAccepted;
  bool? isRunning = false;
  bool? isCancelled;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['itemId'] = itemId;
    map['itemName'] = itemName;
    map['itemImage'] = itemImage;
    map['isVeriation'] = isVeriation;
    map['varName'] = varName;
    map['varId'] = varId;
    map['price'] = price;
    map['discount'] = discount;
    map['quantity'] = quantity;
    map['description'] = description;
    map['preference'] = preference;
    map['ordersId'] = ordersId;

    map['status'] = status;

    map['tableNo'] = tableNo;
    map['tableId'] = tableId;

    map['insertedBy'] = insertedBy;

    map['insertedById'] = insertedById;
    map['insertedByName'] = insertedByName;
    map['insertedByPh'] = insertedByPh;

    map['isRunning'] = isRunning;
    map['isAccepted'] = isAccepted;
    map['isCancelled'] = isCancelled;
  map['addedById'] = addedById;

    return map;
  }

}