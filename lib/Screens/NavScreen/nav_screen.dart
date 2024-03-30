import 'package:flutter/material.dart';
import 'package:jtable/Helpers/signalR_services.dart';
import 'package:jtable/Screens/Dashboard/dashboard_screen.dart';
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
  final List<Widget> _widgetOptions = <Widget>[
    const MainTableScreen(),
    const Text("sf"),
    // StudentProfile(),
  ];

  @override
  void initState() {
    print("signalRService oninit state");
    //Provider.of<SignalRService>(context, listen: false).initializeConnection(context);
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignalRService>(builder: (context, signal, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: signal.connectionIsOpen ? Colors.orangeAccent : Colors.red,
          title: Text("OttoMan"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  signal.connectionIsOpen ?
                  IconButton(
                    icon: const Icon(Icons.refresh, color: Colors.white,),
                    onPressed: () => {
                      //_handleRefresh()
                    },
                  ) : ElevatedButton(onPressed: () => signal.initializeConnection(context), child: Text("Retry nowsd!")),
                ],
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Consumer<SignalRService>(builder: (context, sig, child){
            return _widgetOptions.elementAt(_selectedIndex);
          }) ,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.business),
            //   label: 'Orders',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',

            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      );
    });
  }
}