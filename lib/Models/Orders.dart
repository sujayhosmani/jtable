class Orders {
  Orders({
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
      this.orderIdInt, 
      this.addedByName, 
      this.addedById, 
      this.assignedId, 
      this.assignedName, 
      this.status, 
      this.isAccepted, 
      this.cancelledByName, 
      this.cancelledById, 
      this.remarks, 
      this.instructions, 
      this.tableNo, 
      this.tableId, 
      this.orderNo,
      this.isRunning,
      this.id,
      this.code, 
      this.createdDateTime, 
      this.updatedDateTime, 
      this.isActive, 
      this.createdBy, 
      this.updatedBy,
      this.insertedBy,
      this.addedByPh,
      this.assignedPh,
      this.insertedById,
      this.insertedByName,
      this.insertedByPh,
      this.isCancelled,
      this.loggedInStatus});

  Orders.fromJson(dynamic json) {
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
    orderIdInt = json['orderIdInt'];
    addedByName = json['addedByName'];
    addedById = json['addedById'];
    assignedId = json['assignedId'];
    assignedName = json['assignedName'];
    status = json['status'];
    isAccepted = json['isAccepted'];
    cancelledByName = json['cancelledByName'];
    cancelledById = json['cancelledById'];
    remarks = json['remarks'];
    instructions = json['instructions'];
    tableNo = json['tableNo'];
    tableId = json['tableId'];
    orderNo = json['orderNo'];
    isRunning = json['isRunning'];
    id = json['id'];
    code = json['code'];
    createdDateTime = json['createdDateTime'];
    updatedDateTime = json['updatedDateTime'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];

    insertedBy = json['insertedBy'];
    addedByPh = json['addedByPh'];
    assignedPh = json['assignedPh'];
    insertedById = json['insertedById'];
    insertedByName = json['insertedByName'];
    insertedByPh = json['insertedByPh'];
    isCancelled = json['isCancelled'];
    loggedInStatus = json['loggedInStatus'];

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
  String? orderIdInt;
  String? addedByName;
  String? addedById;
  String? assignedId;
  String? assignedName;
  String? status;
  bool? isAccepted;
  String? instructions;
  String? tableNo;
  String? tableId;
  int? orderNo;
  bool? isRunning;
  String? cancelledByName;
  String? cancelledById;
  String? remarks;
  String? id;
  int? code;
  String? createdDateTime;
  String? updatedDateTime;
  bool? isActive;
  String? createdBy;
  String? updatedBy;

  String? addedByPh;
  String? assignedPh;
  String? loggedInStatus;
  bool? isCancelled;
  String? insertedBy;
  String? insertedById;
  String? insertedByName;
  String? insertedByPh;



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
    map['orderIdInt'] = orderIdInt;
    map['addedByName'] = addedByName;
    map['addedById'] = addedById;
    map['assignedId'] = assignedId;
    map['assignedName'] = assignedName;
    map['status'] = status;
    map['isAccepted'] = isAccepted;
    map['cancelledByName'] = cancelledByName;
    map['cancelledById'] = cancelledById;
    map['remarks'] = remarks;
    map['instructions'] = instructions;
    map['tableNo'] = tableNo;
    map['tableId'] = tableId;
    map['orderNo'] = orderNo;
    map['isRunning'] = isRunning;
    map['id'] = id;
    map['code'] = code;
    map['createdDateTime'] = createdDateTime;
    map['updatedDateTime'] = updatedDateTime;
    map['isActive'] = isActive;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;

    map['insertedBy'] = insertedBy;
    map['addedByPh'] = addedByPh;
    map['assignedPh'] = assignedPh;
    map['insertedById'] = insertedById;
    map['insertedByName'] = insertedByName;
    map['insertedByPh'] = insertedByPh;
    map['isCancelled'] = isCancelled;
    map['loggedInStatus'] = loggedInStatus;
    return map;
  }

}