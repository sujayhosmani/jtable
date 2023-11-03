import 'package:flutter/material.dart';
import 'package:jtable/Helpers/signalR_services.dart';
import 'package:jtable/Screens/Dashboard/dashboard_screen.dart';
import 'package:jtable/Screens/HomeScreen/Components/home_screen.dart';
import 'package:jtable/Screens/TableScreens/Components/main_table_screen.dart';
import 'package:jtable/Screens/StudentScreen/Components/student_screen.dart';
import 'package:provider/provider.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    MainTableScreen(),
  HomeScreen(),

  StudentProfile(),
  ];

  @override
  void initState() {
    print("signalRService oninit state");
    //Provider.of<SignalRService>(context, listen: false).initializeConnection();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Notifications',

          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}