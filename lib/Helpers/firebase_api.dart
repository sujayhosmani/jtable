
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jtable/main.dart';
import 'package:provider/provider.dart';

import '../Models/Table_master.dart';
import '../Screens/Providers/tables_provider.dart';
import '../Screens/TableDetalView/Components/table_detail_screen.dart';




class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;

  final AndroidNotificationChannel _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();


  void handleMessage(RemoteMessage? message, BuildContext context){
    print("FirebaseApi::: will handle the message here hannnnnnnnnnnnnnn 111");
    if(message == null) return;

    print("FirebaseApi::: will handle the message here hannnnnnnnnnnnnnn 222");

    print(message.data);
    print("FirebaseApi::: will handle the message here hannnnnnnnnnnnnnn 333");

    String tableId = message.data["TableId"];
    List<TableMaster> allTables = Provider.of<TablesProvider>(context, listen: false).tableMaster;
    TableMaster table = allTables.firstWhere((element) => element.id == tableId);
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
      return TableDetailScreen(tableMaster: table,);
    }));

  }

  Future initLocalNotifications(BuildContext context) async{
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: android);
    _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    // await _localNotifications.initialize(initializationSettings, onDidReceiveNotificationResponse: (payload) {
    //   print("payload 111 222");
    // });

    try{
      // await _localNotifications.initialize(initializationSettings, onDidReceiveBackgroundNotificationResponse: (payload) {
      //   print("payload 111");
      // });
      await _localNotifications.initialize(
          initializationSettings,
          onDidReceiveNotificationResponse: (payload){
            // handle interaction when app is active for android
            onDidReceiveNotificationResponse(payload, context);
          }
      );
    }catch(ex){

    }finally{
      final platform = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      await platform?.createNotificationChannel(_androidChannel);
    }

  }

  Future initPushNotification(BuildContext context) async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true
    );
    FirebaseMessaging.instance.getInitialMessage().then((mess) {handleMessage(mess, context);});
    FirebaseMessaging.onMessageOpenedApp.listen((messageT) {handleMessage(messageT, context);});
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      print('FirebaseApi::: on messagr received');
        final notification = message.notification;
        if(notification == null) return;

      initLocalNotifications(context);
        _localNotifications.show(
            0,
            notification.title,
            notification.body,
            payload: jsonEncode(message.toMap()),
            NotificationDetails(
              android: AndroidNotificationDetails(
                  _androidChannel.id,
                  _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  importance: Importance.max,
                  priority: Priority.max,
                  color: Colors.blue,
                  playSound: true,
                  ticker: 'ticker',
                  icon: '@mipmap/ic_launcher'
                // icon: android?.smallIcon,
                // other properties...
              ),
            ));
    });
  }

  Future<void> initNotifications(BuildContext context) async{
    await  await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    final token = await _firebaseMessaging.getToken();
    print('FirebaseApi::: Token:::  $token');
    initPushNotification(context);
    initLocalNotifications(context);
  }


}

