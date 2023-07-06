


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/auth_service.dart';
import 'package:jtable/Models/Auth.dart';
import 'package:jtable/Models/Logged_in_users.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Network/ApiBaseHelper.dart';
import 'package:jtable/Network/ApiResponse.dart';
import 'package:jtable/Network/network_repo.dart';
import 'package:jtable/Screens/Providers/tables_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggedInProvider with ChangeNotifier{


  List<LoggedInUsers>? _loggedInUser;

  List<LoggedInUsers>? get loggedInUser => _loggedInUser;

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<LoggedInUsers>?> GetAllNotifications(BuildContext context) async {
    try{
      final response = await _helper.get("home/loggedInUserFrom/notification", context);
      if(response != null){
        print("logged in user11");
        _loggedInUser = List<LoggedInUsers>.from(response.map((model)=> LoggedInUsers.fromJson(model)));
        print("logged in user");
        notifyListeners();
        return _loggedInUser;
      }

    }catch(e){
      return null;
    }

  }

  UpdateLoggedIN(LoggedInUsers? loggedIn, BuildContext context) async{
    try{
      final response = await _helper.post("home/loggedInUser", loggedIn?.toJson(),  context);
      if(response != null){
        //await Provider.of<TablesProvider>(context, listen: false).GetAllTables(context);
        await GetAllNotifications(context);
        // get new notification and new table
      }

    }catch(e){
      return null;
    }
  }


}