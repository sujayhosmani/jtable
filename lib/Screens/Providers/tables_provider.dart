


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/auth_service.dart';
import 'package:jtable/Models/Auth.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Network/ApiBaseHelper.dart';
import 'package:jtable/Network/ApiResponse.dart';
import 'package:jtable/Network/network_repo.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TablesProvider with ChangeNotifier{


  List<TableMaster>? _tableMaster;

  List<TableMaster>? get tableMaster => _tableMaster;

  List<TableMaster>? _assignedTableMaster;

  List<TableMaster>? get assignedTableMaster => _assignedTableMaster;

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<TableMaster>?> GetAllTables(BuildContext context) async {
    try{
      final response = await _helper.get("table/tablemaster", context);
      print("network Model" + response.toString());
      if(response != null){
        _tableMaster = List<TableMaster>.from(response.map((model)=> TableMaster.fromJson(model)));
        calculateDuration();
        String? id = Provider.of<NetworkProvider>(context, listen: false).users?.id;
        _assignedTableMaster = _tableMaster?.where((element) => element.assignedStaffId == id && element?.isOccupied == true).toList();
        notifyListeners();
        print("the table masters");
        print(_tableMaster?.length!.toString());
        return _tableMaster;
      }

    }catch(e){
      print("network Model: " + e.toString());
    }

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
        _assignedTableMaster = _tableMaster?.where((element) => element.assignedStaffId == id && element?.isOccupied == true).toList();
        notifyListeners();
        return _tableMaster;
      }

    }catch(e){
      return null;
    }

  }


  UpdateTable(TableMaster? table, BuildContext context) async {
    try{
      final response = await _helper.post("table/tablemaster", table?.toJson(),  context);
      if(response != null){
        await GetAllTables(context);
      }

    }catch(e){
      return null;
    }
  }

  void calculateDuration() {
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
  }


}