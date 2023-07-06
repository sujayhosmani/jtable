import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jtable/Screens/LoginScreen/main_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants.dart';


class AuthService {
  // Login
  Future<bool> login() async {
    final prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(loginUser) ?? "";
    if(auth != ""){
      return true;
    }else {
      return false;
    }
  }

  // Logout
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(loginUser, "");
    // Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
      return MainLogin();
    }));
  }
}