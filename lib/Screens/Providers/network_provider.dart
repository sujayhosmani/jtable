


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/auth_service.dart';
import 'package:jtable/Models/Auth.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Network/ApiBaseHelper.dart';
import 'package:jtable/Network/ApiResponse.dart';
import 'package:jtable/Network/network_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkProvider with ChangeNotifier{

  SharedPreferences? prefs;
  NetworkRepository? _networkRepository;

  Users? _users;

  Users? get users => _users;

  final ApiBaseHelper _helper = ApiBaseHelper();

  NetworkProvider()  {
    fetchFromSharedPreference();
  }

  Future<Users?> UserLogin(BuildContext context, String name, String password) async {
    try{
      final response = await _helper.post("Menu/auth", Auth(name, password).toJson(), context);
      print("network Model");
      if(response != null){
        _users = Users.fromJson(response);
        await saveToSharedPreference();
        notifyListeners();
        return _users;
      }

    }catch(e){
      return null;
    }

  }

  fetchFromSharedPreference()async{
    prefs = await SharedPreferences.getInstance();
    String userValues = prefs?.getString(loginUser) ?? "";
    if(userValues != ""){
      print(userValues);
      Users user = Users.fromJson(jsonDecode(userValues));
      _users = user;
      notifyListeners();
    }
  }

  saveToSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
    prefs?.setString(loginUser, jsonEncode(_users?.toJson()));
  }

}