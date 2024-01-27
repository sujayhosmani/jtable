


import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/auth_service.dart';
import 'package:jtable/Models/Auth.dart';
import 'package:jtable/Models/Orders.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Network/ApiBaseHelper.dart';
import 'package:jtable/Network/ApiResponse.dart';
import 'package:jtable/Network/network_repo.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
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

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Orders>?> GetOrdersByOrderId(BuildContext context, String orderId, String tableNo) async {
    try{
      final response = await _helper.get("orders/ordersByBothId/" + orderId + "/" + tableNo + "/true", context);
      print("network Model");
      if(response != null){
        log("from network $response");
        _orders = List<Orders>.from(response.map((model)=> Orders.fromJson(model)));
        fillOtherOrders(List<Orders>.from(response.map((model)=> Orders.fromJson(model))), List<Orders>.from(response.map((model)=> Orders.fromJson(model))));
        print("notifyinggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg");
        print(_orders?.length);
        notifyListeners();
        return _orders;
      }

    }catch(e){
      return null;
    }

  }

  updateFromSignalR(response){
    print("the length first");
    response =  response.substring(1, response.length - 1); // Hello
    response = json.decode(json.encode(response));
    log("the log $response");
    try{
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
  }


}