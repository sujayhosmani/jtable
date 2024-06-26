


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

class SliderProvider with ChangeNotifier{




  int _selectedVal = 0;

  int get selectedVal => _selectedVal;

  int _selectedSecVal = 0;

  int get selectedSecVal => _selectedSecVal;


  onValueChanged(int v, {bool isNotify = true}){
    _selectedVal = v;
    if(v == 3){

    }
    if(isNotify){
      notifyListeners();
    }

  }

  onValueChangedForSec(int v){
    _selectedSecVal = v;
    notifyListeners();
  }



}

class FooterProvider with ChangeNotifier{


  int _selectedFooter = 0;

  int get selectedFooter => _selectedFooter;

  int _selectedFooterOTP = 0;

  int get selectedFooterOTP => _selectedFooterOTP;


  onValueChanged(int v, {bool isNotify = true}){
    _selectedFooter = v;
    if(isNotify){
      notifyListeners();
    }

  }

  onValueChangedOnOTP(int v, {bool isNotify = true}){
    _selectedFooterOTP = v;
    if(isNotify){
      notifyListeners();
    }

  }



}