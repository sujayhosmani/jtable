


import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/auth_service.dart';
import 'package:jtable/Helpers/signalR_services.dart';
import 'package:jtable/Models/Auth.dart';
import 'package:jtable/Models/Orders.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Network/ApiBaseHelper.dart';
import 'package:jtable/Network/ApiResponse.dart';
import 'package:jtable/Network/network_repo.dart';
import 'package:jtable/Screens/Providers/logged_inProvider.dart';
import 'package:jtable/Screens/Providers/menu_provider.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:jtable/Screens/Providers/slider_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersProvider with ChangeNotifier{


  List<Orders>? _orders;
  List<Orders>? get orders => _orders;

  List<Orders>? _pending_orders = [];
  List<Orders>? get pending_orders => _pending_orders;

  List<Orders>? _inprogress_orders;
  List<Orders>? get inprogress_orders => _inprogress_orders;

  List<Orders>? _completedOrders;
  List<Orders>? get completedOrders => _completedOrders;

  List<Orders>? _delivered_orders;
  List<Orders>? get delivered_orders => _delivered_orders;

  List<Orders>? _merged_orders;
  List<Orders>? get merged_orders => _merged_orders;

  List<Orders>? _merged_ordersExceptCancel;
  List<Orders>? get merged_ordersExceptCancel => _merged_ordersExceptCancel;

  TableMaster? _currentTable;
  TableMaster? get currentTable => _currentTable; //TODO yet to implement instead of finalTable


  clearOrders(){
    _orders = [];
    _pending_orders = [];
    _inprogress_orders = [];
    _completedOrders = [];
    _delivered_orders = [];
    _merged_orders =[];
    _merged_ordersExceptCancel = [];

  }

  updateCurrentTable(TableMaster? table, BuildContext context){
    if(_currentTable != null && _currentTable?.id != null){
      if(_currentTable?.id == table?.id){
        if(_currentTable?.isOccupied == false && table?.isOccupied == true){
          Provider.of<SignalRService>(context,listen: false).joinOrder(table?.id ?? "", table?.occupiedById ?? "");
          Provider.of<SliderProvider>(context, listen: false).onValueChanged(2, isNotify: false);
        }else if(table?.from == "clear"){
          Provider.of<LoggedInProvider>(context, listen: false).clearLoggedInUsers(isNotify: true);
        }

        _currentTable = table;
        calculateDurationId();
        notifyListeners();
      }

    }
  }

  void calculateDurationId() {
    DateTime currentDate = DateTime.now();

      if (_currentTable?.loggedInTime != null) {
        var timeStart = DateTime.parse(_currentTable?.loggedInTime ?? "").millisecondsSinceEpoch;
        var timeEnd = currentDate.millisecondsSinceEpoch;
        var hourDiff = timeEnd - timeStart; //in ms
        var minDiff = hourDiff / 60 / 1000; //in minutes
        var hDiff = hourDiff / 3600 / 1000; //in hours
        int hours = hDiff.floor();
        int minutes = (minDiff - 60 * hours).floor();
        if (hours > 0) {
          _currentTable?.duration = '$hours hr $minutes min';
        } else {
          _currentTable?.duration = '$minutes min';
        }
      } else {
        // e.duration = '0 mins';
      }
  }

  AddCurrentTable(TableMaster table){
    _currentTable = table;
  }

  ClearCurrentTable(){
    _currentTable = null;
  }

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Orders>?> GetOrdersByOrderId(BuildContext context, String orderId, String tableNo, {bool shouldNavigate = false}) async {
    try{
      final response = await _helper.get("orders/ordersByBothId/" + orderId + "/" + tableNo + "/true", context);
      print("network Model");
      if(response != null){
        log("from network $response");
        _orders = List<Orders>.from(response.map((model)=> Orders.fromJson(model)));
        fillOtherOrders(List<Orders>.from(response.map((model)=> Orders.fromJson(model))), List<Orders>.from(response.map((model)=> Orders.fromJson(model))));
        print("notifyinggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg");
        print(_orders?.length);
        if(shouldNavigate){
          if((_pending_orders?.length ?? 0) > 0){
            Provider.of<SliderProvider>(context, listen: false).onValueChanged(3, isNotify: false);
          }else{
            Provider.of<SliderProvider>(context, listen: false).onValueChanged(2, isNotify: false);
          }
        }


        notifyListeners();
        return _orders;
      }

    }catch(e){
      return null;
    }

  }

  updateFromSignalR(response){
    print("the length first");
    // response =  response.substring(1, response.length - 1); // Hello
     response = response[0];
    log("the log $response");
    try{
      clearOrders();
      _orders = List<Orders>.from(response.map((model)=> Orders.fromJson(model)));
    }catch(e){
      print(e);
    }

    print("the length second");
    print(_orders?.length);
    fillOtherOrders(List<Orders>.from(response.map((model)=> Orders.fromJson(model))), List<Orders>.from(response.map((model)=> Orders.fromJson(model))));
    print("the length third");
    notifyListeners();
  }

  List<Orders>? getMergedList(List<Orders>? allOrders){
    List<Orders>? theOrders = [];
    for(int i = 0; i < (allOrders?.length ?? 0); i++){
      if((theOrders?.length ?? 0) > 0){
        Orders? item = theOrders?.where((element) => element.itemId == allOrders?[i].itemId && element?.varName == allOrders?[i]?.varName).firstOrNull;
        if(item != null){
          print("in quantity change " + (item?.itemName ?? ""));
          item.quantity = ((item.quantity ?? 0) + (allOrders?[i].quantity ?? 0)) ?? 0;
        }else{
          print("not present");
          theOrders?.add(allOrders![i]);
        }
      }else{
        print("first time");
        theOrders?.add(allOrders![i]);
      }
    }
    return theOrders;
  }


  UpdateOrder(List<Orders>? order, BuildContext context, String orderId, String tableNo) async {
    try{
      print(tableNo);
      final response = await _helper.post("orders/orders", order,  context);
      if(response != null){
        // _orders = order;
        // fillOtherOrders(order, order);
        // notifyListeners();
        Provider.of<MenuProvider>(context, listen: false).resetItems();
        await GetOrdersByOrderId(context, orderId, tableNo);
      }


    }catch(e){
      return null;
    }
  }

  void fillOtherOrders(List<Orders>? orderz, List<Orders>? orderz2) {
    _pending_orders = _orders?.where((element) => element.status == "pending").toList();
    _inprogress_orders = _orders?.where((element) => element.status == "in_progress").toList();
    _completedOrders = _orders?.where((element) => element.status == "completed").toList();
    _delivered_orders = _orders?.where((element) => element.status == "delivered").toList();
    List<Orders>? allOrdersExceptCancelled = orderz;// List<Orders>.from(response.map((model)=> Orders.fromJson(model)));
    List<Orders>? cancelled = orderz2;//List<Orders>.from(response.map((model)=> Orders.fromJson(model)));
    allOrdersExceptCancelled = allOrdersExceptCancelled?.where((element) => element.status != "cancelled").toList();
    cancelled = cancelled?.where((element) => element.status == "cancelled").toList();
    List<Orders>? mergedAllExceptCancelled = getMergedList(allOrdersExceptCancelled);
    List<Orders>? mergedAllCancelled = getMergedList(cancelled);
    mergedAllExceptCancelled?.addAll(mergedAllCancelled as Iterable<Orders>);
    _merged_orders = mergedAllExceptCancelled;
    _merged_ordersExceptCancel = getMergedList(allOrdersExceptCancelled);
  }


}