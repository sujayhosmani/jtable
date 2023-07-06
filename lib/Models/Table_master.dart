class TableMaster {
  TableMaster({
      this.tableNo, 
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
    this.from,});

  TableMaster.fromJson(dynamic json) {
    tableNo = json['tableNo'];
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
  }
  String? tableNo;
  String? tableCategory;
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
    return map;
  }

}