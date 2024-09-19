


import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/auth_service.dart';
import 'package:jtable/Models/Auth.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Models/staf_model.dart';
import 'package:jtable/Network/ApiBaseHelper.dart';
import 'package:jtable/Network/ApiResponse.dart';
import 'package:jtable/Network/network_repo.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:jtable/Screens/Providers/tables_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValue {
  String? category;
  bool isChecked = false;
  KeyValue(String cat, bool isCheck){
    this.category = cat;
    this.isChecked = isCheck;
  }
}

class TableKeyValue {
  TableMaster? tableMaster;
  bool isChecked = false;
  TableKeyValue(TableMaster? tab, bool isCheck){
    this.tableMaster = tab;
    this.isChecked = isCheck;
  }
}

class StaffProvider with ChangeNotifier{




  StafModel? _staff;

  StafModel? get staff => _staff;

  List<String> _tableIds = [];

  List<String> get tableIds => _tableIds;

  List<KeyValue> _cats = [];

  List<KeyValue> get cats => _cats;

  List<TableKeyValue> _tableValues = [];

  List<TableKeyValue> get tableValues => _tableValues;

  final ApiBaseHelper _helper = ApiBaseHelper();



  checkForEachTableValues(BuildContext context, bool isData, bool isNotify, String from){
    List<String> allCats = Provider.of<TablesProvider>(context, listen: false).categories;
    List<TableMaster> allTables = Provider.of<TablesProvider>(context, listen: false).tableMaster;
    List<KeyValue> keyValues = [];
    List<TableKeyValue> tableKeyValues = [];
    if(!isData){
      if(_cats.isEmpty){

      }

      allCats?.forEach((element) {
        KeyValue keyValue = KeyValue(element, false);
        keyValues.add(keyValue);
      });

      allTables.forEach((element) {
        TableKeyValue key = TableKeyValue(element, false);
        tableKeyValues.add(key);
      });

      _tableValues = tableKeyValues;
      _cats = keyValues;
      if(_tableValues.isEmpty){

      }

    }else{
      // _cats = [];
      // _tableValues = [];
      allTables.forEach((element) {
        bool isAvailable = _staff?.notificationTables?.contains(element.id) ?? false;
        TableKeyValue key = TableKeyValue(element, isAvailable);
        tableKeyValues.add(key);
      });
      _tableValues = tableKeyValues;

      // allCats?.forEach((catsEle) {
      //   bool isAllChecked = true;
      //   _tableValues.where((tabd) => tabd.tableMaster?.tableCategory == catsEle).forEach((element) {
      //     print(element.tableMaster?.tableCategory);
      //     print(element.tableMaster?.tableNo);
      //     if(!element.isChecked){
      //       print(element.tableMaster?.tableCategory);
      //       print(element.tableMaster?.tableNo);
      //       print("not selected");
      //       isAllChecked = false;
      //     }
      //     if(isAllChecked){
      //       KeyValue keyValue = KeyValue(catsEle, true);
      //       keyValues.add(keyValue);
      //     }else{
      //       KeyValue keyValue = KeyValue(catsEle, false);
      //       keyValues.add(keyValue);
      //     }
      //   });
      //
      //
      // });
      //
      // _cats = keyValues;
    }

    if(isNotify && from == "refresh"){
      notifyListeners();
    }

  }

  onCatClicked(KeyValue catName, bool value){
      int index = _cats.indexWhere((element) => element.category == catName.category);
      _cats[index] = KeyValue(_cats[index].category ?? "", value);
      _tableValues.forEach((element) {
        if(_cats[index].category == element.tableMaster?.tableCategory){
          element.isChecked = value;
        }
      });
      notifyListeners();
  }

  onTableClicked(TableKeyValue tableValue, bool value){
    int index = _tableValues.indexWhere((element) => element.tableMaster?.id == tableValue.tableMaster?.id);
    _tableValues[index] = TableKeyValue(_tableValues[index].tableMaster, value);
    bool isAllChecked = true;
    _tableValues.forEach((element) {
      if(element.tableMaster?.tableCategory == tableValue.tableMaster?.tableCategory){
        if(!element.isChecked){
          isAllChecked = false;
        }
      }
    });
    if(isAllChecked){
      int index = _cats.indexWhere((element) => element.category == tableValue.tableMaster?.tableCategory);
      _cats[index] = KeyValue(_cats[index].category ?? "", value);
    }else{
      int index = _cats.indexWhere((element) => element.category == tableValue.tableMaster?.tableCategory);
      _cats[index] = KeyValue(_cats[index].category ?? "", false);
    }
    notifyListeners();
  }


  Future<StafModel?> GetStaff(BuildContext context, bool isNotify, String from) async {
    checkForEachTableValues(context, false, isNotify, from);
    try{
      String id = Provider.of<NetworkProvider>(context, listen: false).users?.id ?? "";
      final response = await _helper.get("staff/staff/"+ id, context);
      print("network Model GetSubCategories" + response.toString());
      if(response != null){
        List<StafModel> staffs = List<StafModel>.from(response.map((model)=> StafModel.fromJson(model)));
        if(staffs != null && (staffs.length ?? 0) > 0) {
          _staff = staffs.first;
          _tableIds = staffs.first.notificationTables ?? [];
          checkForEachTableValues(context, true, true, "refresh");
            return staffs.first;
        }
      }
      return null;

    }catch(e){
      return null;
    }

  }

  Future<StafModel?> SubmitNotificationTables(BuildContext context) async{
    List<String> finalTables = [];
    _tableValues.forEach((element) {
        if(element.isChecked){
          if(element.tableMaster?.id != null){
            finalTables.add(element.tableMaster?.id ?? "");
          }
        }
    });
    _staff?.notificationTables = finalTables;

    try{
      final response = await _helper.post("staff/staff?isNotify=true", _staff, context);
      if(response != null){
        return await GetStaff(context, true, "refresh");
      }
    }catch(e){
      return null;
    }
  }

  // Future<bool> UpdateDeviceToken(BuildContext context, String id)async{
  //   try{
  //     final _firebaseMessaging = FirebaseMessaging.instance;
  //     final token = await _firebaseMessaging.getToken();
  //     print('FirebaseApi:::Token::: $token');
  //     staffToken staffT = staffToken(id, token);
  //     final response = await _helper.post("staff/staff?isToken=true", staffT.toJson(), context);
  //     if(response != null){
  //       return true;
  //     }
  //
  //   }catch(e){
  //     return false;
  //   }
  //
  //   return false;
  // }



}

class staffToken{
  String? id;
  String? deviceToken;

  staffToken(String id, String? deviceToken){
    this.id = id;
    this.deviceToken = deviceToken;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deviceToken'] = deviceToken;

    return map;
  }
}