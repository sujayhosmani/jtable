
import 'dart:io';

import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Screens/Providers/tables_provider.dart';
import 'package:provider/provider.dart';
import 'package:signalr_flutter/signalr_flutter.dart';
// import 'package:signalr_netcore/signalr_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:signalr_pure/signalr_pure.dart';

// import 'package:logging/logging.dart';
// import 'package:signalr_netcore/signalr_client.dart';


class SignalRService with ChangeNotifier{

  static const _serverUrl = "https://jmenu.azurewebsites.net/api/notify";
   late HubConnection connection;
  // late Logger _logger;
  bool connectionIsOpen = false;
  static late BuildContext cntx;



  Future<void> initializeConnection(BuildContext contexts) async {
    cntx = contexts;
    try{
      print("signalRService initialize" + _serverUrl);

      if(!connectionIsOpen){
        final builder = HubConnectionBuilder()
          ..url = _serverUrl
          ..logLevel = LogLevel.warning
          ..reconnect = true;

        connection = builder.build();

        if (connection.state != HubConnectionState.connected) {



          connection.on('SendTableDetails', (args) {
            print("signalRService on Table details Received" + args.toString());
            List<TableMaster> tableById = List<TableMaster>.from(args.map((model)=> TableMaster.fromJson(model)));
            print(tableById.length);
            Provider.of<TablesProvider>(cntx, listen: false).updateFromSignalR(tableById);
          },);


          await connection.startAsync();
          await connection.invokeAsync('JoinGroup', ["table" + ResId]);
          connectionIsOpen = true;


          connection.onreconnected((connectionId) {
            print("signalRService on reconnected");
            connectionIsOpen = true;
            notifyListeners();
          });

          connection.onreconnecting((connectionId) {
            print("signalRService on reconnecting");
            connectionIsOpen = false;
            notifyListeners();
          });

          connection.onclose((error) {
            print("signalRService onclose $error");
            connectionIsOpen = false;
            notifyListeners();
          });

          print("signalRService - notificatins from connection");
          notifyListeners();
        }else{
          connectionIsOpen = false;
        }
      }
      

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

//   Future<void> initializeConnection2() async {
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