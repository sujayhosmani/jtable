import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Utils.dart';
import 'package:jtable/Screens/HomeScreen/Widgets/main_cards.dart';
import 'package:jtable/Screens/HomeScreen/Widgets/morning_toast.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/assignment_wig.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/final_time_table.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/latest_doubts.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/notes_widget.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/rank_widget.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/student_titles.dart';
import 'dart:async';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:jtable/Screens/Providers/slider_provider.dart';
import 'package:jtable/Screens/Providers/tables_provider.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/assigned_tables.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/rank_widget.dart';
import 'package:jtable/Screens/TableScreens/Widgets/all_table.dart';
import 'package:jtable/Screens/ViewTableScreen/table_view_screen.dart';
import 'package:jtable/Screens/shared/loading_screen.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:simple_grouped_listview/simple_grouped_listview.dart';
import 'package:sticky_headers/sticky_headers.dart';


class StudentProfile extends StatefulWidget {
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> with AutomaticKeepAliveClientMixin<StudentProfile>, SingleTickerProviderStateMixin  {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();
  late AnimationController _animationController;
  Timer? timer;
  Timer? timer2;

  @override
  void dispose() {
    print("on disposing");
    timer?.cancel();
    timer = null;
    _animationController.dispose();
    timer2?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    print("signalRService oninit state");
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500), )..repeat();
    Provider.of<TablesProvider>(context, listen: false).GetAllTables(context, false);
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
    Provider.of<TablesProvider>(context, listen: false).GetAllTables(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          buildTables3(),
          Consumer<GlobalProvider>(builder: (context, global, child) {
            print(global.error);
            return LoadingScreen(
              isBusy: global.isBusy,
              error: global?.error ?? "",
              onPressed: () {},
            );
          })
        ],
      ),
    );
  }

  simpleGridAll(TablesProvider tab){
    return (((tab.tableMaster?.length) ?? 0) > 0) ? GroupedListView.grid(
      cacheExtent: 100,
      addAutomaticKeepAlives: true,
      items: tab.tableMaster,
      headerBuilder: (context, String? isEven) {
        return Text(isEven ?? "");
      },
      gridItemBuilder:
          (context, int countInGroup, int itemIndexInGroup, TableMaster item, _) =>
          Stack(
            children: [
              Card(
                color: getColor(item),
                child: allTextContent(item),
              ),
              (item.requestingOtp ?? 0) > 0 ? Align(
                alignment: Alignment.topCenter,
                child: badges.Badge(
                  showBadge: false,
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: RotationTransition(
                        turns: Tween(begin: 0.0, end: -.1).chain(CurveTween(curve: Curves.elasticIn)).animate(_animationController),
                        child: const Icon(Icons.notifications_active, color: Colors.pink),
                      )

// Icon(Icons.notifications_active, color: Colors.pink),
                  ),
                ),
              ) : Container(),

            ],
          ),
      itemGrouper: (TableMaster i) => i.tableCategory,
      crossAxisCount: getItemCountPerRow(context),

    ) : Container();
  }

  simpleGridAssigned(TablesProvider tab){
    return (((tab.assignedTableMaster.length) ?? 0) > 0) ? GroupedListView.grid(
      cacheExtent: 100,
      addAutomaticKeepAlives: true,
      items: tab.assignedTableMaster,
      headerBuilder: (context, String? isEven) {
        return Text(isEven ?? "");
      },
      gridItemBuilder:
          (context, int countInGroup, int itemIndexInGroup, TableMaster item, _) =>
          Stack(
            children: [
              Card(
                color: getColor(item),
                child: allTextContent(item),
              ),
              (item.requestingOtp ?? 0) > 0 ? Align(
                alignment: Alignment.topCenter,
                child: badges.Badge(
                  showBadge: false,
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: RotationTransition(
                        turns: Tween(begin: 0.0, end: -.1).chain(CurveTween(curve: Curves.elasticIn)).animate(_animationController),
                        child: const Icon(Icons.notifications_active, color: Colors.pink),
                      )

// Icon(Icons.notifications_active, color: Colors.pink),
                  ),
                ),
              ) : Container(),

            ],
          ),
      itemGrouper: (TableMaster i) => i.tableCategory,
      crossAxisCount: getItemCountPerRow(context),

    ) : Container();
  }

  simpleGridReq(TablesProvider tab){
    return (((tab.reqTables.length) ?? 0) > 0) ? GroupedListView.grid(
      items: tab.reqTables,
      cacheExtent: 100,
      addAutomaticKeepAlives: true,
      headerBuilder: (context, String? isEven) {
        return Text(isEven ?? "");
      },
      gridItemBuilder:
          (context, int countInGroup, int itemIndexInGroup, TableMaster item, _) =>
          Stack(
            children: [
              Card(
                color: getColor(item),
                child: allTextContent(item),
              ),
              (item.requestingOtp ?? 0) > 0 ? Align(
                alignment: Alignment.topCenter,
                child: badges.Badge(
                  showBadge: false,
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: RotationTransition(
                        turns: Tween(begin: 0.0, end: -.1).chain(CurveTween(curve: Curves.elasticIn)).animate(_animationController),
                        child: const Icon(Icons.notifications_active, color: Colors.pink),
                      )

// Icon(Icons.notifications_active, color: Colors.pink),
                  ),
                ),
              ) : Container(),

            ],
          ),
      itemGrouper: (TableMaster i) => i.tableCategory,
      crossAxisCount: getItemCountPerRow(context),

    ) : Container();
  }

  int getItemCountPerRow(BuildContext context) {
    double minTileWidth = 120;

    double availableWidth = MediaQuery.of(context).size.width;
    int i = availableWidth ~/ minTileWidth;
    return i;

  }


  getColor(TableMaster? table) {
    if(table?.isOccupied ?? false){
      return Colors.amber[200];
    }
    if((table?.requestingOtp ?? 0) > 0){
      return Colors.blue[200];

    }
  }

  loadGridContent(List<TableMaster> table1, BuildContext context) {
    // return Text("fh");
    return GridView.builder(
        cacheExtent: 100,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getItemCountPerRow(context),
//childAspectRatio: (3 / 2),
        ),
        itemCount: table1.length,
        itemBuilder: (BuildContext context, int index) {
          var table = table1[index];
          return Stack(
            children: [
              Card(
                color: getColor(table),
                child: allTextContent(table),
              ),
              (table.requestingOtp ?? 0) > 0 ? Align(
                alignment: Alignment.topCenter,
                child: badges.Badge(
                  showBadge: false,
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: RotationTransition(
                        turns: Tween(begin: 0.0, end: -.1).chain(CurveTween(curve: Curves.elasticIn)).animate(_animationController),
                        child: const Icon(Icons.notifications_active, color: Colors.pink),
                      )

// Icon(Icons.notifications_active, color: Colors.pink),
                  ),
                ),
              ) : Container(),

            ],
          );
        });
  }

  allTextContent(TableMaster? table){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              badges.Badge(
                badgeContent: Text((table?.pending ?? 0).toString(), style: const TextStyle(color: Colors.white),),
                showBadge: ((table?.pending ?? 0) > 0),
                badgeStyle: const badges.BadgeStyle(
// badgeColor: Colors.red,
                ),

              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(table?.tableNo ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              badges.Badge(
                  badgeContent: Text((table?.progress ?? 0).toString(), style: const TextStyle(color: Colors.white),),
                  showBadge: ((table?.progress ?? 0) > 0),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.blue,
                  )
              ),
            ],
          ),
          (table?.noOfPeople ?? 0) > 0 ? Text("${table?.noOfPeople ?? 0} members", style: TextStyle(fontSize: 12),) : Container(),
          // (table?.duration) != null ? Text(table?.duration.toString() ?? "", style: const TextStyle( fontSize: 14),) : Container(),
          (table?.totalBill ?? 0) > 0 ? Text("${table?.totalBill.toString() ?? ""} Rs", style: const TextStyle( fontSize: 14, fontWeight: FontWeight.bold),) : Container()
        ],
      ),
    );
  }

  loadMainContent(TablesProvider tab) {
    return (tab.finalTableMaster?.length ?? 0) > 0 ? ListView.builder(
        padding: const EdgeInsets.fromLTRB(8,0,8,12),
        itemCount: tab.categories.length,
        //physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index){
          var cat = tab.categories[index];
          List<TableMaster>? table1 = tab.finalTableMaster?.where((element) => element.tableCategory == cat).toList();
          print("on refresh 22");
          return StickyHeader(
            header: Text(cat),
            content: loadGridContent(table1!, context),
          );
        }) : Container();
  }

  loadAssignedContent(TablesProvider tab) {
    return (tab.assignedTableMaster?.length ?? 0) > 0 ? ListView.builder(
        padding: const EdgeInsets.fromLTRB(8,0,8,12),
        itemCount: tab.assignedCategories.length,
        //physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index){
          var cat = tab.assignedCategories[index];
          List<TableMaster>? table1 = tab.assignedTableMaster?.where((element) => element.tableCategory == cat).toList();
          print("on refresh 22");
          return StickyHeader(
            header: Text(cat),
            content: loadGridContent(table1!, context),
          );
        }) : Container();
  }

  loadAllContent(TablesProvider tab) {
    return (tab.tableMaster?.length ?? 0) > 0 ? ListView.builder(
        padding: const EdgeInsets.fromLTRB(8,0,8,12),
        itemCount: tab.categories.length,
        //physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index){
          var cat = tab.categories[index];
          List<TableMaster>? table1 = tab.tableMaster?.where((element) => element.tableCategory == cat).toList();
          print("on refresh 22");
          return StickyHeader(
            header: Text(cat),
            content: loadGridContent(table1!, context),
          );
        }) : Container();
  }

  loadReqContent(TablesProvider tab) {
    return (tab.reqTables?.length ?? 0) > 0 ? ListView.builder(
        padding: const EdgeInsets.fromLTRB(8,0,8,12),
        itemCount: tab.reqCategories.length,
        //physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index){
          var cat = tab.reqCategories[index];
          List<TableMaster>? table1 = tab.reqTables?.where((element) => element.tableCategory == cat).toList();
          print("on refresh 22");
          return StickyHeader(
            header: Text(cat),
            content: loadGridContent(table1!, context),
          );
        }) : Container();
  }

  segmentedControl() {
    return Consumer<SliderProvider>(builder: (context, slide, child) {
      return CustomSlidingSegmentedControl<int>(
        initialValue: 2,
        children: const {
          1: Text('Assigned Tab'),// style: TextStyle(fontWeight: slide.selectedVal == 1 ? FontWeight.w600 : FontWeight.w400),),
          2: Text('All Tables'),// style: TextStyle(fontWeight: slide.selectedVal == 2 ? FontWeight.w600 : FontWeight.w400),),
          3: Text('Requesting'),
        },
        decoration: BoxDecoration(
          color: CupertinoColors.lightBackgroundGray,
          borderRadius: BorderRadius.circular(8),
        ),
        thumbDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: Offset(
                0.0,
                2.0,
              ),
            ),
          ],
        ),
        duration: Duration(milliseconds: 0),
        curve: Curves.easeInToLinear,
        onValueChanged: (v) async {
          //slide.onValueChanged(v);
          timer2 = Timer(const Duration(milliseconds: 2), () => Provider.of<TablesProvider>(context, listen: false).onValueChanged(v));
          //timer.cancel();
          //Provider.of<TablesProvider>(context, listen: false).onValueChanged(v);

        },
      );
    });
  }

  buildTables() {
    return Column(
      children: [
        const SizedBox(height: 12,),
        segmentedControl(),
        const SizedBox(height: 12,),
        Expanded(
          child: Consumer<TablesProvider>(builder: (context, tab, child) {
            if(((tab.finalTableMaster?.length ?? 0) > 0) && timer == null){
              //timer = Timer.periodic(const Duration(seconds: 60), (Timer t) => tab.calculateDuration(true));
            }
            print("on refresh");
            if(tab.selectedVal == 1){
              return loadAssignedContent(tab);
            }
            if(tab.selectedVal == 2){
              return loadAllContent(tab);
            }
            return loadReqContent(tab);


          }),
        ),
      ],
    );
  }

  buildTables2() {
    return Column(
      children: [
        const SizedBox(height: 12,),
        segmentedControl(),
        const SizedBox(height: 12,),
        Expanded(
          child: Consumer<TablesProvider>(builder: (context, tab, child) {
            if(((tab.finalTableMaster?.length ?? 0) > 0) && timer == null){
              timer = Timer.periodic(const Duration(seconds: 60), (Timer t) => tab.calculateDuration(true));
            }
            print("on refresh");
            return Stack(
              children: [
                Visibility(
                  child: loadAllContent(tab),
                  visible: tab.selectedVal == 2,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                ),
                Visibility(
                  child: loadAssignedContent(tab),
                  visible: tab.selectedVal == 1,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                ),
                Visibility(
                  child: loadReqContent(tab),
                  visible: tab.selectedVal == 3,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                ),
              ],
            );


          }),
        ),
      ],
    );
  }

  buildTables3() {
    return Column(
      children: [
        const SizedBox(height: 12,),
        segmentedControl(),
        const SizedBox(height: 12,),
        Expanded(
          child: Consumer<TablesProvider>(builder: (context, tab, child) {
            if(((tab.finalTableMaster?.length ?? 0) > 0) && timer == null){
              timer = Timer.periodic(const Duration(seconds: 60), (Timer t) => tab.calculateDuration(true));
            }
            print("on refresh");
            return Stack(
              children: [
                Visibility(
                  child: simpleGridAssigned(tab),
                  visible: tab.selectedVal == 1,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                ),
                Visibility(
                  child: simpleGridAll(tab),
                  visible: tab.selectedVal == 2,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                ),
                Visibility(
                  child: simpleGridReq(tab),
                  visible: tab.selectedVal == 3,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                ),
              ],
            );


          }),
        ),
      ],
    );
  }

  loadTabView() {
    return DefaultTabController(
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
        body: Consumer<TablesProvider>(builder: (context, tab, child) {
          if(((tab.finalTableMaster?.length ?? 0) > 0) && timer == null){
            //timer = Timer.periodic(const Duration(seconds: 60), (Timer t) => tab.calculateDuration(true));
          }
          return TabBarView(
            children: [
              loadAssignedContent(tab),
              loadAllContent(tab),
              Icon(Icons.directions_bike),
            ],
          );


        }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;


}