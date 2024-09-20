
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jtable/Helpers/auth_service.dart';
import 'package:jtable/Helpers/firebase_api.dart';
import 'package:jtable/Helpers/navigation_service.dart';
import 'package:jtable/Helpers/signalR_services.dart';
import 'package:jtable/Models/Orders.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Screens/LoginScreen/main_login_screen.dart';
import 'package:jtable/Screens/MenuScreen/menu_screen.dart';
import 'package:jtable/Screens/Providers/global_provider.dart';
import 'package:jtable/Screens/Providers/logged_inProvider.dart';
import 'package:jtable/Screens/Providers/menu_provider.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:jtable/Screens/Providers/orders_provider.dart';
import 'package:jtable/Screens/Providers/slider_provider.dart';
import 'package:jtable/Screens/Providers/staff_provider.dart';
import 'package:jtable/Screens/Providers/tables_provider.dart';
import 'package:jtable/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:jtable/Screens/TableScreens/Components/main_table_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screens/TableDetalView/Components/table_detail_screen.dart';


Future<void> handleBackgroundMessage(RemoteMessage message)async {
  await Firebase.initializeApp();
  print('FirebaseApi::: will handle the message here hannnnnnnnnnnnnnn 777');
  print("Handling a background message: ${message.messageId}");
  print(message.notification?.title ?? "");
  print(' body $message.notification?.body ?? ""');
  print('data $message.data');

}

void onDidReceiveNotificationResponse(NotificationResponse details, BuildContext context) {
  print('FirebaseApi::: will handle the message here hannnnnnnnnnnnnnn 000');
  if(details != null){
    if(details?.payload != null){
      print('FirebaseApi::: details details:::  $details');
      final String payload = details.payload ?? "";
      final message = RemoteMessage.fromMap(jsonDecode(payload));
      print(details.payload);
      print(message.data["TableId"]);
      String tableId = message.data["TableId"];
      List<TableMaster> allTables = Provider.of<TablesProvider>(context, listen: false).tableMaster;
      TableMaster table = allTables.firstWhere((element) => element.id == tableId);
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
        return TableDetailScreen(tableMaster: table,);
      }));
    }
  }

}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AuthService appAuth = new AuthService();
  Widget _defaultHome = new MainLogin();

  // final prefs = await SharedPreferences.getInstance();
  // prefs.setString("userValues", "");
  bool _result = await appAuth.login();
  if (_result) {
    _defaultHome = new MainTableScreen(isFromLogin: true,);
  }
  runApp(MyApp(home: _defaultHome,));
}

class MyApp extends StatelessWidget {
  final Widget home;

  const MyApp({Key? key, required this.home}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NetworkProvider()),
        ChangeNotifierProvider(create: (context) => LoggedInProvider()),
        ChangeNotifierProvider(create: (context) => GlobalProvider()),
        ChangeNotifierProvider(create: (context) => SignalRService()),
        ChangeNotifierProvider(create: (context) => TablesProvider()),
        ChangeNotifierProvider(create: (context) => OrdersProvider()),
        ChangeNotifierProvider(create: (context) => MenuProvider()),
        ChangeNotifierProvider(create: (context) => SliderProvider()),
        ChangeNotifierProvider(create: (context) => FooterProvider()),
        ChangeNotifierProvider(create: (context) => StaffProvider()),
      ],
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          appBarTheme: AppBarTheme(color: Colors.orangeAccent),
          useMaterial3: true,
        ),
        home: home,
      ),
    );
  }
}
