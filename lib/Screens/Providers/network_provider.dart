


import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
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

  String? resUniq;
  String? id;
  String? phone;
  String? resId;
  String? role;
  String? resUniqLogin;
  String? userIdLogin;

  final ApiBaseHelper _helper = ApiBaseHelper();

  NetworkProvider()  {
    fetchFromSharedPreference();
  }

  Future<Users?> UserLogin(BuildContext context, String name, String password, String id) async {
    try{
      final _firebaseMessaging = FirebaseMessaging.instance;
      final token = await _firebaseMessaging.getToken();
      print('FirebaseApi:::Token::: $token');
      final response = await _helper.post("login/auth?isToken=true", Auth(name, password, id, token).toJson(), context);
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
    print("the tokennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn 2222");
    String resUniqL = prefs?.getString("resUniq") ?? "";
    String userIdL = prefs?.getString("UserName") ?? "";

    resUniqLogin = resUniqL;
    userIdLogin = userIdL;
    if(userValues != ""){
      print(userValues);
      Users user = Users.fromJson(jsonDecode(userValues));
      _users = user;
      setToken(_users?.token);
      notifyListeners();
    }
  }

  saveToSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
    prefs?.setString(loginUser, jsonEncode(_users?.toJson()));

    setToken(_users?.token);
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  void clearAll(){
    resUniq = "";
    id = "";
    phone = "";
    resId = "";
    role = "";
  }

  void setToken(String? token) {
    if (token != null) {
      Map<String, dynamic> jCur = parseJwt(token ?? "");
      resUniq = jCur['ResUniq'];
      resUniqLogin = jCur['ResUniq'];
      userIdLogin = jCur['UserName'];
      print("userIdLogin:::::::::::::::::::::::::::::" + (userIdLogin ?? ""));
      id = jCur['Id'];
      phone = jCur['Phone'];
      resId = jCur['ResId'];
      role = jCur['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
      prefs?.setString("resUniq", (resUniq ?? ""));
      prefs?.setString("UserName", (userIdLogin ?? ""));
    }
  }

}