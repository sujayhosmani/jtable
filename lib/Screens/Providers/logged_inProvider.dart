


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/auth_service.dart';
import 'package:jtable/Models/Auth.dart';
import 'package:jtable/Models/LoggedInUserPost.dart';
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

  List<LoggedInUsers>? _loggedInUserForTable;

  List<LoggedInUsers>? get loggedInUserForTable => _loggedInUserForTable;

  List<LoggedInUsers>? _notificationLoggedInUserForTable;

  List<LoggedInUsers>? get notificationLoggedInUserForTable => _notificationLoggedInUserForTable;

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<LoggedInUsers>?> GetLoggedInUserTableId(String id, BuildContext context) async {
    try{
      final response = await _helper.get("login/loggedInUserTableId/" + id, context);
      if(response != null){
        print("logged in user11");
        _loggedInUserForTable = List<LoggedInUsers>.from(response.map((model)=> LoggedInUsers.fromJson(model)));
        print("logged in user");
        notifyListeners();
        return _loggedInUserForTable;
      }

    }catch(e){
      return null;
    }

  }

  clearLoggedInUsers(){
    _loggedInUserForTable = [];
    _notificationLoggedInUserForTable = [];
  }

  Future<List<LoggedInUsers>?> GetAllNotifications(BuildContext context, String id) async {
    try{
      final response = await _helper.get("login/loggedInUserFromWithTableId/notification/" + id, context);
      if(response != null){
        _notificationLoggedInUserForTable = List<LoggedInUsers>.from(response.map((model)=> LoggedInUsers.fromJson(model)));
        print("logged notification in user" + (_notificationLoggedInUserForTable?.length ?? 0).toString());
        notifyListeners();
        return _notificationLoggedInUserForTable;
      }

    }catch(e){
      return null;
    }

  }

  Future<bool?> InsertLoggedIN(LoggedInUsersPost? loggedIn, BuildContext context) async{
    try{
      final response = await _helper.post("login/loggedInUser", loggedIn?.toJson(),  context);
      if(response != null){
        return true;
      }
      return null;
    }catch(e){
      return null;
    }
  }


}