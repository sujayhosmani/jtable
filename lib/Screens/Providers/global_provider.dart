import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier {
  bool _isBusy = false;
  String? _error;

  bool get isBusy => _isBusy;
  String? get error => _error;


  setIsBusy(bool val, dynamic error){
    _isBusy = val;
    _error = error;
    refresh();
  }

  refresh(){
    try{
      Future.delayed(Duration.zero, () async {
        notifyListeners();
      });

    }catch(e){

    }
  }


}