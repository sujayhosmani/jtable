


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
      final response = await _helper.get("home/tablemaster", context);
      print("network Model");
      if(response != null){
        _tableMaster = List<TableMaster>.from(response.map((model)=> TableMaster.fromJson(model)));
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
      final response = await _helper.post("home/tablemaster", table?.toJson(),  context);
      if(response != null){
        await GetAllTables(context);
      }

    }catch(e){
      return null;
    }
  }


}