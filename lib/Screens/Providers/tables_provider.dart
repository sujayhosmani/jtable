


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/auth_service.dart';
import 'package:jtable/Models/Auth.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Network/ApiBaseHelper.dart';
import 'package:jtable/Network/ApiResponse.dart';
import 'package:jtable/Network/network_repo.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:jtable/Screens/Providers/orders_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TablesProvider with ChangeNotifier{


  List<TableMaster> _tableMaster = [];

  List<TableMaster> get tableMaster => _tableMaster;

  List<TableMaster> _filterTableMaster = [];

  List<TableMaster> get filterTableMaster => _filterTableMaster;

  String _selectedTab = "";
  String get selectedTab => _selectedTab;

  List<TableMaster> _reqTables = [];

  List<TableMaster> get reqTables => _reqTables;

  List<TableMaster>? _finalTableMaster;

  List<TableMaster>? get finalTableMaster => _finalTableMaster;

  List<String> _categories = [];

  List<String> get categories => _categories;

  List<String> _assignedCategories = [];

  List<String> get assignedCategories => _assignedCategories;

  List<String> _reqCategories = [];

  List<String> get reqCategories => _reqCategories;

  int _selectedVal = 2;

  int? get selectedVal => _selectedVal;

  List<TableMaster> _assignedTableMaster = [];

  List<TableMaster> get assignedTableMaster => _assignedTableMaster;



  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<TableMaster>?> GetAllTables(BuildContext context, bool isFromRefresh) async {
    try{
      if(isFromRefresh){
        await performGetTables(context);
      }else if(((_tableMaster?.length ?? 0) == 0)){
        await performGetTables(context);
      }
      
        return _tableMaster;
    }catch(e){
      print("network Model: " + e.toString());
    }

  }

  onTabChanged(String val){
    _selectedTab = val;
    print(val);
    _filterTableMaster = [];
    _filterTableMaster = _tableMaster.where((element) => element.tableCategory == val).toSet().toList();
    print(_filterTableMaster.length);
    notifyListeners();
  }
  
  performGetTables(BuildContext context) async {
    final response = await _helper.get("table/tablemaster", context);
    print("network Model2323" + response.toString());
    if(response != null){
      _tableMaster = List<TableMaster>.from(response.map((model)=> TableMaster.fromJson(model)));

      _filterTableMaster = List<TableMaster>.from(response.map((model)=> TableMaster.fromJson(model)));
      if(_selectedTab != ""){
        _filterTableMaster = _tableMaster.where((element) => element.tableCategory == _selectedTab).toSet().toList();
      }
      calculateDuration(false);
      String? id = Provider.of<NetworkProvider>(context, listen: false).users?.id;
      _assignedTableMaster = _tableMaster.where((element) => element.assignedStaffId == id && element?.isOccupied == true).toList();
      _reqTables = _tableMaster.where((element) => (element.requestingOtp ?? 0) > 0).toList();
      loadCategories();
      notifyListeners();
    }
  }


  Future<TableMaster?> onTableDetailViewPage(BuildContext context, String tableNo) async {
    int? index = _tableMaster?.indexWhere((element) => element.tableNo == tableNo);
    List<TableMaster>? master = await GetTableByTableId(context, tableNo);

    if(index != null){
      TableMaster? val = master?[index];

      if(master?[index].isOccupied ?? false){
        Provider.of<OrdersProvider>(context, listen: false).GetOrdersByOrderId(
            context,
            val?.occupiedById ?? "",
            val?.tableNo ?? "", shouldNavigate: true);
      }
      if(val != null){
        Provider.of<OrdersProvider>(context, listen: false).updateCurrentTable(val, context);
        return val;
      }

    }
    return null;

  }

  Future<TableMaster?> onUserSubmitViewPage(BuildContext context, String tableNo) async {
    int? index = _tableMaster?.indexWhere((element) => element.tableNo == tableNo);
    List<TableMaster>? master = await GetTableByTableId(context, tableNo);
    if(index != null){
      TableMaster? val = master?[index];

      if(val != null){
        Provider.of<OrdersProvider>(context, listen: false).updateCurrentTable(val, context);
        return val;
      }

    }
    return null;
  }

  Future<List<TableMaster>?> GetTableByTableId(BuildContext context, String tableNo) async {
    try{
      final response = await _helper.get("table/tablemaster/" + tableNo, context);
      print("network Model");
      if(response != null){
        List<TableMaster> tableById = List<TableMaster>.from(response.map((model)=> TableMaster.fromJson(model)));
        int? index = _tableMaster?.indexWhere((element) => element.tableNo == tableNo);
        if(index != null){
          _tableMaster?[index] = tableById.first;
        }
        String? id = Provider.of<NetworkProvider>(context, listen: false).users?.id;
        _assignedTableMaster = _tableMaster.where((element) => element.assignedStaffId == id && element?.isOccupied == true).toList();
        _reqTables = _tableMaster.where((element) => (element.requestingOtp ?? 0) > 0).toList();
        if(_selectedTab != ""){
          _filterTableMaster = _tableMaster.where((element) => element.tableCategory == _selectedTab).toSet().toList();
        }
        notifyListeners();
        return _tableMaster;
      }

    }catch(e){
      return null;
    }

  }

  updateFromSignalR(List<TableMaster> tables, BuildContext context){
    try{
      print("updateFromSignalR 1");
      TableMaster table = tables.first;
      print("updateFromSignalR 2");
      int index = _tableMaster.indexWhere((element) => element.tableNo == table.tableNo);
      var id = _assignedTableMaster.first.assignedStaffId;
      if(id == table.assignedStaffId && (((table.pending ?? 0) > (tableMaster[index].pending ?? 0)) || ((table.progress ?? 0) > (tableMaster[index].progress ?? 0)))){
        HapticFeedback.heavyImpact();
      }
      if(table.isOccupied == false && (table.requestingOtp ?? 0) > 0){
        HapticFeedback.heavyImpact();
      }
      _tableMaster[index] = table;
      print("updateFromSignalR 3");

      print("updateFromSignalR 4");


      _assignedTableMaster = _tableMaster.where((element) => element.assignedStaffId == id && element?.isOccupied == true).toList();
      print("updateFromSignalR 5");

      _reqTables = _tableMaster.where((element) => (element.requestingOtp ?? 0) > 0).toList();
      print(_tableMaster.length);

      if(_filterTableMaster.length > 0 && _selectedTab != ""){
        _filterTableMaster = _tableMaster.where((element) => element.tableCategory == _selectedTab).toSet().toList();
      }

      Provider.of<OrdersProvider>(context, listen: false).updateCurrentTable(table, context);
      print("updateFromSignalR 6");
      loadCategories();
      notifyListeners();
      print("updateFromSignalR 7");
      print(_tableMaster[index].pending);
      print("updateFromSignalR 7++");
    }catch(e){
      print("updateFromSignalR 8 exception");
      print(e.toString());
    }

  }


  UpdateTable(TableMaster? table, BuildContext context) async {
    try{
      print(json.encode(table?.toJson()));
      final response = await _helper.post("table/tablemaster", table?.toJson(),  context);
      if(response != null){
        print("inside the response");
        print(response);
        Provider.of<OrdersProvider>(context, listen: false).updateCurrentTable(table, context);
        await GetAllTables(context, true);
      }

    }catch(e){
      return null;
    }
  }

  SwitchTable(TableMaster? fromTable, TableMaster? toTable, BuildContext context) async {
    try{
      var val = {
        'FromTableDetails': fromTable,
        'ToTableDetails': toTable
      };
      final response = await _helper.post("table/tableswitch", val,  context);
      if(response != null){
        await GetAllTables(context, true);
      }

    }catch(e){
      return null;
    }
  }


  void onValueChanged(int value){
    _selectedVal = value;
     notifyListeners();
     //addToFinalTable();
  }

  void calculateDuration(bool isNotify) {
    DateTime currentDate = DateTime.now();
    _tableMaster?.forEach((e) {
      if (e.loggedInTime != null) {
        var timeStart = DateTime.parse(e?.loggedInTime ?? "").millisecondsSinceEpoch;
        var timeEnd = currentDate.millisecondsSinceEpoch;
        var hourDiff = timeEnd - timeStart; //in ms
        var minDiff = hourDiff / 60 / 1000; //in minutes
        var hDiff = hourDiff / 3600 / 1000; //in hours
        int hours = hDiff.floor();
        int minutes = (minDiff - 60 * hours).floor();
        if (hours > 0) {
          e.duration = '$hours hr $minutes min';
        } else {
          e.duration = '$minutes min';
        }
      } else {
        // e.duration = '0 mins';
      }
    });
    if(isNotify){
      notifyListeners();
    }

  }

  void addToFinalTable() {
    if(selectedVal == 1){
      _finalTableMaster = _assignedTableMaster;
    }else if(selectedVal == 3){
      _finalTableMaster = _reqTables;
    }else{
      _finalTableMaster = _tableMaster;
    }

  }

  void loadCategories() {
    _categories = [];
    _tableMaster?.forEach((element) {
      _categories.add(element.tableCategory ?? "NA");
    });
    _categories = _categories.toSet().toList();
    //
    _assignedCategories = [];
    _assignedTableMaster?.forEach((element) {
      _assignedCategories.add(element.tableCategory ?? "NA");
    });
    _assignedCategories = _assignedCategories.toSet().toList();
    //
    _reqCategories = [];
    _reqTables?.forEach((element) {
      _reqCategories.add(element.tableCategory ?? "NA");
    });
    _reqCategories = _reqCategories.toSet().toList();
  }


}