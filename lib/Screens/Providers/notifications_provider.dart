import 'package:flutter/cupertino.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Network/ApiBaseHelper.dart';

class NotificationProvider with ChangeNotifier{


  List<TableMaster>? _tableMaster;

  List<TableMaster>? get tableMaster => _tableMaster;

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<TableMaster>?> GetAllTables(BuildContext context) async {
    try{
      final response = await _helper.get("home/tablemaster", context);
      print("network Model");
      if(response != null){
        _tableMaster = List<TableMaster>.from(response.map((model)=> TableMaster.fromJson(model)));
        notifyListeners();
        return _tableMaster;
      }

    }catch(e){
      return null;
    }

  }


}