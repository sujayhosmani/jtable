import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Utils.dart';
import 'package:jtable/Models/Logged_in_users.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Screens/HomeScreen/Widgets/headings_home.dart';
import 'package:jtable/Screens/HomeScreen/Widgets/parent_detail.dart';
import 'package:jtable/Screens/Providers/global_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:jtable/Screens/Providers/logged_inProvider.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:jtable/Screens/Providers/tables_provider.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/assigned_tables.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/rank_widget.dart';
import 'package:jtable/Screens/TableScreens/Widgets/all_table.dart';
import 'package:jtable/Screens/ViewTableScreen/table_view_screen.dart';
import 'package:jtable/Screens/shared/loading_screen.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';


class MainTableScreen extends StatefulWidget {
  const MainTableScreen({super.key});

  @override
  State<MainTableScreen> createState() => _MainTableScreenState();
}

class _MainTableScreenState extends State<MainTableScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();
  late AnimationController _animationController;

  @override
  void initState() {
    print("signalRService oninit state");
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500), )..repeat();
    Provider.of<TablesProvider>(context, listen: false).GetAllTables(context);
    _animationController.forward();
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      }
      if(_animationController.isDismissed){
        _animationController.forward();
      }
    });
    super.initState();
  }

  Future<void> _handleRefresh() async {
    Provider.of<TablesProvider>(context, listen: false).GetAllTables(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OttoMan"),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_transit)),
                  Tab(icon: Icon(Icons.directions_bike)),
                ],
              ),
              title: const Text('Tabs Demo'),
            ),
            body: const TabBarView(
              children: [
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int getItemCountPerRow(BuildContext context) {
    double minTileWidth = 120; //in your case
    double availableWidth = MediaQuery.of(context).size.width;
    print(availableWidth);

    int i = availableWidth ~/ minTileWidth;
    print(i);
    return i;

  }

  onAccepted(LoggedInUsers? loggedIn) {}

  getColor(TableMaster? table) {
    if(table?.isOccupied ?? false){
      return Colors.amber[200];
    }
    if((table?.requestingOtp ?? 0) > 0){
      return Colors.blue[200];

    }
  }


}


// Stack(
// children: [
// SingleChildScrollView(
// child: Container(
// // height: MediaQuery.of(context).size.height,
// child: Column(
// children: [
// ParentDetails(),
// SizedBox(height: 12),
// Divider(height: 1, color: Utils.scaffold),
// SizedBox(height: 12),
// Consumer<TablesProvider>(builder: (context, tab, child) {
// return
// (tab.tableMaster?.length ?? 0) > 0 ? GridView.builder(
// physics: ScrollPhysics(),
// shrinkWrap: true,
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: getItemCountPerRow(context),
// //childAspectRatio: (3 / 2),
// ),
// itemCount: tab.tableMaster?.length,
// itemBuilder: (BuildContext context, int index) {
// var table = tab.tableMaster?[index];
// return Stack(
// children: [
// Container(
// child: Card(
// color: getColor(table),
// child: Center(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// badges.Badge(
// badgeContent: Text((table?.pending ?? 0).toString(), style: TextStyle(color: Colors.white),),
// showBadge: ((table?.pending ?? 0) > 0),
// badgeStyle: const badges.BadgeStyle(
// // badgeColor: Colors.red,
// ),
//
// ),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8),
// child: Text(table?.tableNo ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
// ),
// badges.Badge(
// badgeContent: Text((table?.progress ?? 0).toString(), style: TextStyle(color: Colors.white),),
// showBadge: ((table?.progress ?? 0) > 0),
// badgeStyle: const badges.BadgeStyle(
// badgeColor: Colors.blue,
// )
// ),
// ],
// ),
// (table?.noOfPeople ?? 0) > 0 ? Text((table?.noOfPeople ?? 0).toString() + " members", style: TextStyle(fontSize: 12),) : Container(),
// (table?.duration) != null ? Text(table?.duration.toString() ?? "", style: const TextStyle( fontSize: 14),) : Container(),
// (table?.totalBill ?? 0) > 0 ? Text((table?.totalBill.toString() ?? "") + " Rs", style: const TextStyle( fontSize: 14, fontWeight: FontWeight.bold),) : Container()
// ],
// ),
// ),
// ),
// ),
// (table?.requestingOtp ?? 0) > 0 ? Align(
// alignment: Alignment.topCenter,
// child: badges.Badge(
// showBadge: false,
// child: Container(
// margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
// child: RotationTransition(
// turns: Tween(begin: 0.0, end: -.1).chain(CurveTween(curve: Curves.elasticIn)).animate(_animationController),
// child: Icon(Icons.notifications_active, color: Colors.pink),
// )
//
// // Icon(Icons.notifications_active, color: Colors.pink),
// ),
// ),
// ) : Container(),
//
// ],
// );
// }) : Container();
//
// }),
// ],
// ),
//
// ),
// ),
// // SingleChildScrollView(
// //   child: Container(
// //     color: Colors.white,
// //     child: Column(
// //       children: [
// //         ParentDetails(),
// //         SizedBox(height: 12),
// //         Divider(height: 1, color: Utils.scaffold),
// //         SizedBox(height: 12),
// //         Consumer<TablesProvider>(builder: (context, tab, child) {
// //           return AllTables(
// //             tableMaster: tab.tableMaster,
// //             onPressed: (value) => {
// //               Navigator.push(context, MaterialPageRoute(
// //                   builder: (BuildContext context) {
// //                     return TableViewScreen(tableMaster: value);
// //                   }))
// //             },
// //           );
// //         }),
// //       ],
// //     ),
// //   ),
// // ),
// Consumer<GlobalProvider>(builder: (context, global, child) {
// print(global.error);
// return LoadingScreen(
// isBusy: global.isBusy,
// error: global?.error ?? "",
// onPressed: () {},
// );
// })
// ],
// )
