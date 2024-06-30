import 'package:flutter/material.dart';
import 'package:jtable/Helpers/signalR_services.dart';
import 'package:jtable/Screens/StudentScreen/Components/student_screen.dart';
import 'package:jtable/Screens/TableScreens/Components/main_table_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class PersistStyleNavBar extends StatefulWidget {
  const PersistStyleNavBar({super.key});

  @override
  State<PersistStyleNavBar> createState() => _PersistStyleNavBarState();
}

class _PersistStyleNavBarState extends State<PersistStyleNavBar> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  List<Widget> _buildScreens() => [

    const MainTableScreen(isFromLogin: false),
    Text("rr"),
    StudentProfile(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Live Table",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        activeColorSecondary: Colors.blue,
        inactiveColorSecondary: Colors.purple),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.search),
      title: "Orders",
      activeColorPrimary: Colors.teal,
      inactiveColorPrimary: Colors.grey,
      activeColorSecondary: Colors.teal,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.settings),
      title: "Settings",
      activeColorPrimary: Colors.indigo,
      activeColorSecondary: Colors.indigo,
      inactiveColorPrimary: Colors.grey,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
    _hideNavBar = false;
    print("signalRService oninit state");
    Provider.of<SignalRService>(context, listen: false).initializeConnection(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignalRService>(builder: (context, signal, child) {
      return Scaffold(
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
                ) : ElevatedButton(onPressed: () => signal.initializeConnection(context), child: Text("Retry now!")),
              ],
            ),
          )
        ],
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
           border: const Border(top: BorderSide(width: 0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
         // borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.red,
        ),
        items: _navBarsItems(),
        onItemSelected: (selected){
          print(selected);
        },
        // selectedTabScreenContext: (final context) {
        //   testContext = context!;
        // },
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        hideNavigationBar: _hideNavBar,
        navBarStyle: NavBarStyle
            .style6, // Choose the nav bar style with this property
      ),
    );
    });
  }
}
