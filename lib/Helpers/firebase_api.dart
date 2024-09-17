
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jtable/main.dart';




class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;

  final AndroidNotificationChannel _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();


  void handleMessage(RemoteMessage? message){
    print("FirebaseApi::: will handle the message here hannnnnnnnnnnnnnn");
    if(message == null) return;
    print("FirebaseApi::: will handle the message here");
  }

  Future initLocalNotifications() async{
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: android);
    _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    await _localNotifications.initialize(initializationSettings, onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    try{
      await _localNotifications.initialize(initializationSettings, onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse);
    }catch(ex){

    }finally{
      final platform = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      await platform?.createNotificationChannel(_androidChannel);
    }

  }

  Future initPushNotification() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      print('FirebaseApi::: on messagr received');
        final notification = message.notification;
        if(notification == null) return;

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

  Future<void> initNotifications() async{
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
    initPushNotification();
    initLocalNotifications();
  }

  void onDidReceiveNotificationResponse(NotificationResponse details) {
    if(details != null){
      if(details?.payload != null){
        print('FirebaseApi::: details details:::  $details');
        final String payload = details.payload ?? "";
        final message = RemoteMessage.fromMap(jsonDecode(payload));
        handleMessage(message);
      }
    }

  }
}