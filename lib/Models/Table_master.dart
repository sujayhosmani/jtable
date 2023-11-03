class TableMaster {

  String? tableNo;
  String? tableCategory;
  String? tableName;
  bool? isOccupied;
  bool? isReserved;
  String? occupiedBy;
  String? occupiedById;
  String? occupiedPh;
  String? occupiedName;
  int? noOfPeople;
  String? joinOTP;
  String? assignedStaffId;
  String? assignedStaffName;
  String? assignedStaffPh;
  String? reason;
  String? id;
  int? code;
  String? createdDateTime;
  String? updatedDateTime;
  bool? isActive;
  String? createdBy;
  String? updatedBy;
  String? from;

  String? insertedBy;
  String? loggedInTime;
  int? isPrinted;
  int? totalBill;
  int? serviceChargeInPer;
  bool? isServiceModified;
  int? discountInPer;
  bool? isDiscountModified;
  String? duration;
  int? pending;
  int? progress;
  int? completed;
  int? cancelled;
  int? serviceCharge;
  int? discount;
  int? cgst;
  int? sgst;
  int? subTotal;
  int? requestingOtp;
  bool? status;
  int? capacity;


  TableMaster({
      this.tableNo,
      this.tableName,
      this.tableCategory, 
      this.isOccupied, 
      this.isReserved, 
      this.occupiedBy, 
      this.occupiedById, 
      this.occupiedPh, 
      this.occupiedName, 
      this.noOfPeople, 
      this.joinOTP,
      this.assignedStaffId, 
      this.assignedStaffName, 
      this.assignedStaffPh,
      this.reason,
      this.id, 
      this.code, 
      this.createdDateTime, 
      this.updatedDateTime, 
      this.isActive, 
      this.createdBy, 
      this.updatedBy,
      this.requestingOtp,
      this.cancelled,
      this.capacity,
      this.cgst,
      this.completed,
      this.discount,
      this.discountInPer,
      this.duration,
      this.from,
      this.insertedBy,
      this.isDiscountModified,
      this.isPrinted,
      this.isServiceModified,
      this.loggedInTime,
      this.pending,
      this.progress,
      this.serviceCharge,
      this.serviceChargeInPer,
      this.sgst,
      this.status,
      this.subTotal,
      this.totalBill});

  TableMaster.fromJson(dynamic json) {
    tableNo = json['tableNo'];
    tableName = json['tableName'];
    tableCategory = json['tableCategory'];
    isOccupied = json['isOccupied'];
    isReserved = json['isReserved'];
    occupiedBy = json['occupiedBy'];
    occupiedById = json['occupiedById'];
    occupiedPh = json['occupiedPh'];
    occupiedName = json['occupiedName'];
    noOfPeople = json['noOfPeople'];
    joinOTP = json['joinOTP'];
    assignedStaffId = json['assignedStaffId'];
    assignedStaffName = json['assignedStaffName'];
    assignedStaffPh = json['assignedStaffPh'];
    reason = json['reason'];
    id = json['id'];
    code = json['code'];
    createdDateTime = json['createdDateTime'];
    updatedDateTime = json['updatedDateTime'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    from = json['from'];

    tableName = json['tableName'];
    insertedBy = json['insertedBy'];
    loggedInTime = json['loggedInTime'];
    isPrinted = json['isPrinted'];
    totalBill = json['totalBill'];
    serviceChargeInPer = json['serviceChargeInPer'];
    isServiceModified = json['isServiceModified'];
    discountInPer = json['discountInPer'];
    isDiscountModified = json['isDiscountModified'];
    duration = json['duration'];
    pending = json['pending'];
    progress = json['progress'];
    completed = json['completed'];
    cancelled = json['cancelled'];
    serviceCharge = json['serviceCharge'];
    discount = json['discount'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    subTotal = json['subTotal'];
    requestingOtp = json['requestingOtp'];
    status = json['status'];
    capacity = json['capacity'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tableNo'] = tableNo;
    map['tableCategory'] = tableCategory;
    map['isOccupied'] = isOccupied;
    map['isReserved'] = isReserved;
    map['occupiedBy'] = occupiedBy;
    map['occupiedById'] = occupiedById;
    map['occupiedPh'] = occupiedPh;
    map['occupiedName'] = occupiedName;
    map['noOfPeople'] = noOfPeople;
    map['joinOTP'] = joinOTP;
    map['assignedStaffId'] = assignedStaffId;
    map['assignedStaffName'] = assignedStaffName;
    map['assignedStaffPh'] = assignedStaffPh;
    map['reason'] = reason;
    map['id'] = id;
    map['code'] = code;
    map['createdDateTime'] = createdDateTime;
    map['updatedDateTime'] = updatedDateTime;
    map['isActive'] = isActive;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['from'] = from;

    map['tableName'] = tableName;
    map['insertedBy'] = insertedBy;
    map['loggedInTime'] = loggedInTime;
    map['isPrinted'] = isPrinted;
    map['totalBill'] = totalBill;
    map['serviceChargeInPer'] = serviceChargeInPer;
    map['isServiceModified'] = isServiceModified;
    map['discountInPer'] = discountInPer;
    map['isDiscountModified'] = isDiscountModified;
    map['duration'] = duration;
    map['pending'] = pending;
    map['progress'] = progress;
    map['completed'] = completed;
    map['cancelled'] = cancelled;
    map['serviceCharge'] = serviceCharge;
    map['discount'] = discount;
    map['cgst'] = cgst;
    map['sgst'] = sgst;
    map['subTotal'] = subTotal;
    map['requestingOtp'] = requestingOtp;
    map['status'] = status;
    map['capacity'] = capacity;

    return map;
  }

}