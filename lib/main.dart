import 'package:flutter/material.dart';
import 'package:jtable/Helpers/auth_service.dart';
import 'package:jtable/Models/Orders.dart';
import 'package:jtable/Screens/HomeScreen/Components/home_screen.dart';
import 'package:jtable/Screens/LoginScreen/main_login_screen.dart';
import 'package:jtable/Screens/MenuScreen/menu_screen.dart';
import 'package:jtable/Screens/NavScreen/nav_screen.dart';
import 'package:jtable/Screens/Providers/global_provider.dart';
import 'package:jtable/Screens/Providers/logged_inProvider.dart';
import 'package:jtable/Screens/Providers/menu_provider.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:jtable/Screens/Providers/orders_provider.dart';
import 'package:jtable/Screens/Providers/tables_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthService appAuth = new AuthService();
  Widget _defaultHome = new NavScreen();

  bool _result = await appAuth.login();
  if (_result) {
    _defaultHome = new NavScreen();
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
        ChangeNotifierProvider(create: (context) => GlobalProvider()),
        ChangeNotifierProvider(create: (context) => NetworkProvider()),
        ChangeNotifierProvider(create: (context) => TablesProvider()),
        ChangeNotifierProvider(create: (context) => LoggedInProvider()),
        ChangeNotifierProvider(create: (context) => OrdersProvider()),
        ChangeNotifierProvider(create: (context) => MenuProvider()),
      ],
      child: MaterialApp(
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
