import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtable/Helpers/auth_service.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:provider/provider.dart';


enum Sky { midnight, viridian, cerulean }
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  // late PersistentTabController _controller;
  Map<Sky, Color> skyColors = <Sky, Color>{
    Sky.midnight: const Color(0xff191970),
    Sky.viridian: const Color(0xff40826d),
    Sky.cerulean: const Color(0xff007ba7),
  };
  Sky _selectedSegment = Sky.midnight;

  Users? loggedInUser;



  @override
  void initState() {
    super.initState();
    loggedInUser = Provider.of<NetworkProvider>(context, listen: false).users;
    // _controller = PersistentTabController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: loadSettings()
    );
  }

  // loadCuper(){
  //   return CupertinoPageScaffold(
  //     backgroundColor: skyColors[_selectedSegment],
  //     navigationBar: CupertinoNavigationBar(
  //       // This Cupertino segmented control has the enum "Sky" as the type.
  //       middle: CupertinoSegmentedControl<Sky>(
  //         selectedColor: skyColors[_selectedSegment],
  //         // Provide horizontal padding around the children.
  //         padding: const EdgeInsets.symmetric(horizontal: 12),
  //         // This represents a currently selected segmented control.
  //         groupValue: _selectedSegment,
  //         // Callback that sets the selected segmented control.
  //         onValueChanged: (Sky value) {
  //           setState(() {
  //             _selectedSegment = value;
  //             var timer2 = Timer(const Duration(milliseconds: 2), () => Provider.of<TablesProvider>(context, listen: false).onValueChanged(value.index));
  //           });
  //         },
  //         children: const <Sky, Widget>{
  //           Sky.midnight: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 20),
  //             child: Text('Midnight'),
  //           ),
  //           Sky.viridian: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 20),
  //             child: Text('Viridian'),
  //           ),
  //           Sky.cerulean: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 20),
  //             child: Text('Cerulean'),
  //           ),
  //         },
  //       ),
  //     ),
  //     child: Consumer<TablesProvider>(builder: (context, tab, child) {
  //       return Stack(
  //         children: [
  //           Visibility(
  //             child: loadAllContent(tab),
  //             visible: tab.selectedVal == 2,
  //             maintainSize: true,
  //             maintainAnimation: true,
  //             maintainState: true,
  //           ),
  //           Visibility(
  //             child: loadAssignedContent(tab),
  //             visible: tab.selectedVal == 1,
  //             maintainSize: true,
  //             maintainAnimation: true,
  //             maintainState: true,
  //           ),
  //           Visibility(
  //             child: loadReqContent(tab),
  //             visible: tab.selectedVal == 3,
  //             maintainSize: true,
  //             maintainAnimation: true,
  //             maintainState: true,
  //           ),
  //         ],
  //       );
  //     }),
  //   );
  // }

  // loadAssignedContent(TablesProvider tab) {
  //   return (tab.assignedTableMaster?.length ?? 0) > 0 ? ListView.builder(
  //       padding: const EdgeInsets.fromLTRB(8,0,8,12),
  //       itemCount: tab.assignedCategories.length,
  //       //physics: const NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       itemBuilder: (BuildContext context, int index){
  //         var cat = tab.assignedCategories[index];
  //         List<TableMaster>? table1 = tab.assignedTableMaster?.where((element) => element.tableCategory == cat).toList();
  //         print("on refresh 22");
  //         return StickyHeader(
  //           header: Text(cat),
  //           content: loadGridContent(table1!, context),
  //         );
  //       }) : Container();
  // }

  // loadReqContent(TablesProvider tab) {
  //   return (tab.reqTables?.length ?? 0) > 0 ? ListView.builder(
  //       padding: const EdgeInsets.fromLTRB(8,0,8,12),
  //       itemCount: tab.reqCategories.length,
  //       //physics: const NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       itemBuilder: (BuildContext context, int index){
  //         var cat = tab.reqCategories[index];
  //         List<TableMaster>? table1 = tab.reqTables?.where((element) => element.tableCategory == cat).toList();
  //         print("on refresh 22");
  //         return StickyHeader(
  //           header: Text(cat),
  //           content: loadGridContent(table1!, context),
  //         );
  //       }) : Container();
  // }

  // loadAllContent(TablesProvider tab) {
  //   return (tab.tableMaster.length ?? 0) > 0 ? ListView.builder(
  //       padding: const EdgeInsets.fromLTRB(8,0,8,12),
  //       itemCount: tab.categories.length,
  //       //physics: const NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       itemBuilder: (BuildContext context, int index){
  //         var cat = tab.categories[index];
  //         List<TableMaster>? table1 = tab.tableMaster.where((element) => element.tableCategory == cat).toList();
  //         print("on refresh 22");
  //         return StickyHeader(
  //           header: Text(cat),
  //           content: loadGridContent(table1!, context),
  //         );
  //       }) : Container();
  // }

  // getColor(TableMaster? table) {
  //   if(table?.isOccupied ?? false){
  //     return Colors.amber[200];
  //   }
  //   if((table?.requestingOtp ?? 0) > 0){
  //     return Colors.blue[200];
  //
  //   }
  // }
  //
  // int getItemCountPerRow(BuildContext context) {
  //   double minTileWidth = 120;
  //
  //   double availableWidth = MediaQuery.of(context).size.width;
  //   int i = availableWidth ~/ minTileWidth;
  //   return i;
  //
  // }

//   allTextContent(TableMaster? table){
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               badges.Badge(
//                 badgeContent: Text((table?.pending ?? 0).toString(), style: const TextStyle(color: Colors.white),),
//                 showBadge: ((table?.pending ?? 0) > 0),
//                 badgeStyle: const badges.BadgeStyle(
// // badgeColor: Colors.red,
//                 ),
//
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: Text(table?.tableNo ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
//               ),
//               badges.Badge(
//                   badgeContent: Text((table?.progress ?? 0).toString(), style: const TextStyle(color: Colors.white),),
//                   showBadge: ((table?.progress ?? 0) > 0),
//                   badgeStyle: const badges.BadgeStyle(
//                     badgeColor: Colors.blue,
//                   )
//               ),
//             ],
//           ),
//           (table?.noOfPeople ?? 0) > 0 ? Text("${table?.noOfPeople ?? 0} members", style: TextStyle(fontSize: 12),) : Container(),
//           // (table?.duration) != null ? Text(table?.duration.toString() ?? "", style: const TextStyle( fontSize: 14),) : Container(),
//           (table?.totalBill ?? 0) > 0 ? Text("${table?.totalBill.toString() ?? ""} Rs", style: const TextStyle( fontSize: 14, fontWeight: FontWeight.bold),) : Container()
//         ],
//       ),
//     );
//   }

//   loadGridContent(List<TableMaster> table1, BuildContext context) {
//     // return Text("fh");
//     return GridView.builder(
//         cacheExtent: 100,
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: getItemCountPerRow(context),
// //childAspectRatio: (3 / 2),
//         ),
//         itemCount: table1.length,
//         itemBuilder: (BuildContext context, int index) {
//           var table = table1[index];
//           return Stack(
//             children: [
//               Card(
//                 color: getColor(table),
//                 child: allTextContent(table),
//               ),
//               (table.requestingOtp ?? 0) > 0 ? Align(
//                 alignment: Alignment.topCenter,
//                 child: badges.Badge(
//                   showBadge: false,
//                   child: Container(
//                       margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                       child: const Icon(Icons.notifications_active, color: Colors.pink),
//                       // child: RotationTransition(
//                       //   turns: Tween(begin: 0.0, end: -.1).chain(CurveTween(curve: Curves.elasticIn)).animate(_animationController),
//                       //   child: const Icon(Icons.notifications_active, color: Colors.pink),
//                       // )
//
// // Icon(Icons.notifications_active, color: Colors.pink),
//                   ),
//                 ),
//               ) : Container(),
//
//             ],
//           );
//         });
//   }

  loadSettings() {
    return Column(
      children: [
        Expanded(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Container(
                              color: Colors.blueGrey,
                              height: 75,
                              width: 75,
                              child: (loggedInUser?.name ?? "NAA").length > 1 ? Center(child: Text(((loggedInUser?.name ?? "NAA").substring(0,2)).toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),))
                                  : Center(child: Text("NA", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),)),
                            )
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(loggedInUser?.name ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                            Text(loggedInUser?.role ?? ""),
                            Text(loggedInUser?.phone ?? ""),
                          ],
                        )

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Divider(height: 0.1, color: Colors.grey[300]),
                // ListTile(title: Text("Choose Preffered Tables"), dense: false, leading: Icon(Icons.select_all), onTap: () => print("sdf"),),
                // Divider(height: 0.1, color: Colors.grey[300]),
                //
                // ListTile(title: Text("Refresh token"), dense: false, leading: Icon(Icons.refresh), onTap: () => print("sdf"),),
                // Divider(height: 0.1, color: Colors.grey[300]),
                // ListTile(title: Text("Sync Menu"), dense: false, leading: Icon(Icons.sync), onTap: () => print("sdf"),),
                // Divider(height: 0.1, color: Colors.grey[300]),
                // ListTile(title: Text("Change Password"), dense: false, leading: Icon(Icons.password), onTap: () => print("sdf"),),
                // Divider(height: 0.1, color: Colors.grey[300]),
                ListTile(title: Text("Logout"), dense: false, leading: Icon(Icons.logout), onTap: () => handleLogout(),),
                Divider(height: 0.1, color: Colors.grey[300]),
              ],
            )
        ),
        // Container(
        //     width: double.infinity,
        //     child: ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("Go to Home")))

      ],
    );
  }

  handleLogout() {
    Provider.of<NetworkProvider>(context, listen: false).clearAll();
    AuthService auth = new AuthService();
    auth.logout(context);
  }
}
