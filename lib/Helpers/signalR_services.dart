
import 'dart:io';

import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:signalr_flutter/signalr_flutter.dart';
// import 'package:signalr_netcore/signalr_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:signalr_pure/signalr_pure.dart';

// import 'package:logging/logging.dart';
// import 'package:signalr_netcore/signalr_client.dart';


class SignalRService with ChangeNotifier{

  static const _serverUrl = "https://jmenu.azurewebsites.net/api/notify";
  // late HubConnection _hubConnection;
  // late Logger _logger;
  bool _connectionIsOpen = false;


  Future<void> initializeConnection() async {
    try{
      print("signalRService initialize" + _serverUrl);
      final builder = HubConnectionBuilder()
        ..url = _serverUrl
        ..logLevel = LogLevel.warning
        ..reconnect = true;
      final connection = builder.build();
      connection.on('SendTableDetails', (args) {
        print("signalRService on Table details Received" + args.toString());
      },);
      await connection.startAsync();
      final obj = await connection.invokeAsync('JoinGroup', ["table" + ResId]);
      print("signalRService invoking ");
      print(obj);
    }catch(e){
      print("signalRService initializeConnection exception" + e!.toString());
    }
  }


  // Future<void> initializeConnection() async {
  //   try{
  //     print("signalRService initialize" + _serverUrl);
  //     SignalR signalR = SignalR(
  //         _serverUrl,
  //         "api/notify",
  //         //hubMethods: ["<Your Hub Method Names>"],
  //         statusChangeCallback: (status) => print(status),
  //   hubCallback: (methodName, message) => print('MethodName = $methodName, Message = $message'));
  //   signalR.connect();
  //     //signalR.invokeMethod("JoinGroup", arguments: ["table" + ResId]);
  //   }catch(e){
  //     print("signalRService initializeConnection exception" + e!.toString());
  //   }
  // }

//   Future<void> initializeConnection() async {
//     _connectionIsOpen = false;
//
//     Logger.root.level = Level.ALL;
//     Logger.root.onRecord.listen((record) {
//       print('${record.level.name}: ${record.time}: ${record.message}');
//     });
//     _logger = Logger("ChatPageViewModel");
//     final hubProtLogger = Logger("SignalR - hub");
// // If youn want to also to log out transport messages:
//     final transportProtLogger = Logger("SignalR - transport");
//     print("signalRService initializeConnection " + _serverUrl);
//     try{
//       final connectionOptions = HttpConnectionOptions;
//       final httpOptions = new HttpConnectionOptions(logger: transportProtLogger, transport: HttpTransportType.WebSockets); // default transport type.
//       _hubConnection = HubConnectionBuilder()
//           .withUrl(_serverUrl, options: httpOptions)
//           .withAutomaticReconnect()
//           .configureLogging(hubProtLogger)
//           .build();
//
//       _hubConnection.onclose(({error}) => _connectionIsOpen = false);
//       _hubConnection.onreconnecting(({error}) {
//         print("signalRService onreconnecting called");
//         _connectionIsOpen = false;
//       });
//       _hubConnection.onreconnected(({connectionId}) {
//         print("signalRService onreconnected called");
//         _connectionIsOpen = true;
//       });
//
//       if (_hubConnection.state != HubConnectionState.Connected) {
//         await _hubConnection.start();
//         _connectionIsOpen = true;
//       }else{
//         await joinRequiredGroups();
//       }
//     }catch(e){
//       print("signalRService initializeConnection exception" + e!.toString());
//     }
//
//   }

  // Future<void> joinRequiredGroups() async{
  //   final result = await _hubConnection.invoke("JoinGroup", args: <Object>["table" + ResId]);
  //   print("signalRService Result: '$result");
  // }
  //
  // Future<void> joinOrder(String tableId, String orderId) async{
  //   final result = await _hubConnection.invoke("JoinGroup", args: <Object>["order" + ResId + tableId + orderId]);
  //   print("signalRService Result: '$result");
  // }
  //
  // Future<void> leaveOrder(String tableId, String orderId) async{
  //   final result = await _hubConnection.invoke("LeaveGroup", args: <Object>["order" + ResId + tableId + orderId]);
  //   print("signalRService Result: '$result");
  // }
  //
  // Future<void> setSignalrClientMethods() async{
  //   //_hubConnection.on("SendTableDetails", _handleTableDetails);
  //   //_hubConnection.on("SendOrdersByOrderId", _handleOrderDetails);
  // }
  //
  // void _handleTableDetails(TableMaster parameters) {
  //   print("signalRService _handleTableDetails");
  // }
  //
  // void _handleOrderDetails(List<Object> parameters) {
  //   print("signalRService _handleOrderDetails");
  // }


}