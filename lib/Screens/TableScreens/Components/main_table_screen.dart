import 'dart:async';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Utils.dart';
import 'package:jtable/Helpers/signalR_services.dart';
import 'package:jtable/Models/Logged_in_users.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Screens/HomeScreen/Components/home_screen.dart';
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
import 'package:jtable/Screens/TableDetalView/Components/table_detail_screen.dart';
import 'package:jtable/Screens/TableScreens/Widgets/all_table.dart';
import 'package:jtable/Screens/UserDetailScreen/user_detail_screen.dart';
import 'package:jtable/Screens/ViewTableScreen/table_view_screen.dart';
import 'package:jtable/Screens/settings/Components/settings_screen.dart';
import 'package:jtable/Screens/shared/loading_screen.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:simple_grouped_listview/simple_grouped_listview.dart';
import 'package:sticky_headers/sticky_headers.dart';


class MainTableScreen extends StatefulWidget {
  final bool isFromLogin;
  const MainTableScreen({super.key, required this.isFromLogin});

  @override
  State<MainTableScreen> createState() => _MainTableScreenState();
}

class _MainTableScreenState extends State<MainTableScreen> with AutomaticKeepAliveClientMixin<MainTableScreen>, TickerProviderStateMixin   {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();
  //late AnimationController _animationController;
  // Timer? timer;
  // Timer? timer2;

  late TabController _tabController;
  late TabController _tabController2;
  List<String> cats = [];

  @override
  void dispose() {
    print("on disposing");
    _tabController.dispose();
    // timer?.cancel();
    // timer = null;
    // _animationController.dispose();
    // timer2?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: this.cats.length, vsync: this);
    _tabController2 = TabController(length: 4, vsync: this);

    print("signalRService oninit state");
    // _animationController =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 500), )..repeat();
    // _animationController.forward();
    // _animationController.addListener(() {
    //   if (_animationController.isCompleted) {
    //     _animationController.reverse();
    //   }
    //   if(_animationController.isDismissed){
    //     _animationController.forward();
    //   }
    // });
    initialCalls();
    super.initState();
  }

  initialCalls() async {
    await Provider.of<NetworkProvider>(context, listen: false).fetchFromSharedPreference();
    await Provider.of<SignalRService>(context, listen: false).initializeConnection(context);
    await Provider.of<TablesProvider>(context, listen: false).GetAllTables(context, true);
    setState(() {
      this.cats = Provider.of<TablesProvider>(context, listen: false).categories;
      _tabController = TabController(length: this.cats.length, vsync: this);
      Provider.of<TablesProvider>(context, listen: false).onTabChanged(this.cats[0]);
    });

  }

  Future<void> _handleRefresh({bool isSignal = false, required SignalRService signal}) async {
      Provider.of<TablesProvider>(context, listen: false).GetAllTables(context, true);
      signal.initializeConnection(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignalRService>(builder: (context, signal, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: signal.connectionIsOpen ? Colors.orangeAccent : Colors.redAccent,
          title: Text("OttoMan"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.refresh, color: Colors.black,),
                        onPressed: () => {
                          _handleRefresh(signal: signal)
                        },
                      ),
                      !signal.connectionIsOpen ? ElevatedButton(onPressed: () => _handleRefresh(signal: signal, isSignal: true), child: Text("Retry now!")):SizedBox(height: 0, width: 0,) ,
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            buildTables2(signal),
            Consumer<GlobalProvider>(builder: (context, global, child) {
              print(global.error);
              return LoadingScreen(
                isBusy: global.isBusy,
                error: global.error ?? "",
                onPressed: () {},
              );
            })
          ],
        ),
        bottomNavigationBar: Consumer<SliderProvider>(builder: (context, slide, child){
          return Container(
              color: Color(0xFF3F5AA6),
              child: TabBar(
                onTap: (v){
                  int val = v + 1;
                  if(val <= 3){

                  }
                  slide.onValueChanged(val);
                  //timer2 = Timer(const Duration(milliseconds: 2), () => Provider.of<TablesProvider>(context, listen: false).onValueChanged(v));
                  //timer.cancel();
                  Provider.of<TablesProvider>(context, listen: false).onValueChanged(val);

                },
                controller: _tabController2,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorSize: TabBarIndicatorSize.tab,

                indicatorPadding: EdgeInsets.all(0),
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(
                    text: "Assigned",
                    icon: Icon(Icons.euro_symbol, size: 20),
                  ),
                  Tab(
                    text: "All Tables",
                    icon: Icon(Icons.assignment, size: 20),
                  ),
                  Tab(
                    text: "Requesting",
                    icon: Icon(Icons.account_balance_wallet, size: 20),
                  ),
                  Tab(
                    text: "Options",
                    icon: Icon(Icons.settings, size: 20),
                  ),
                ],
              )
          );
        })
      );
    });
  }



  buildTables2(signal) {
    var count = 0;
    return Column(
      children: [
        // const SizedBox(height: 12,),
        //segmentedControl(),



        Expanded(
          child: Consumer<TablesProvider>(builder: (context, tab, child) {
            print("on refresh");
            return Stack(
              children: [
                Visibility(
                  child: loadAllContent(tab, signal),
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
                Visibility(
                    child: SettingsScreen(),
                  visible: tab.selectedVal == 4,
                )
              ],
            );


          }),
        ),
      ],
    );
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
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return TableDetailScreen(tableMaster: table,);
                  }));
                },
                child: Card(
                  color: getColor(table),
                  child: allTextContent(table),
                ),
              ),
              (table.requestingOtp ?? 0) > 0 ? Align(
                alignment: Alignment.topCenter,
                child: badges.Badge(
                  showBadge: false,
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: const Icon(Icons.notifications_active, color: Colors.pink),
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
          (table?.joinOTP) != null ? Text("${table?.joinOTP.toString() ?? ""}", style: const TextStyle( fontSize: 14, fontWeight: FontWeight.bold),) : Container()
        ],
      ),
    );
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
          return StickyHeader(
            header: Text(cat),
            content: loadGridContent(table1!, context),
          );
        }) : Container();
  }

  loadAllContent(TablesProvider tab, signal) {
    print(tab.filterTableMaster?.length);
    return (tab.filterTableMaster?.length ?? 0) > 0 ?
    Column(
      children: [
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: Color(0x303F5AA6),
            // borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: TabBar(
            isScrollable: true,
            onTap: (int val){
              print("on tap");
              print(val);
              Provider.of<TablesProvider>(context, listen: false).onTabChanged(this.cats[val]);
            },
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,

            indicator: BoxDecoration(
              // borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFF3F5AA6)
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black87,
            tabs: List.generate(
              this.cats.length,
                  (index) => Tab(
                child: Row(
                  children: [
                    Text("${this.cats[index]}", overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12,),
        GridView.builder(
            cacheExtent: 100,
            // physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: getItemCountPerRow(context),
//childAspectRatio: (3 / 2),
            ),
            itemCount: tab.filterTableMaster?.length,
            itemBuilder: (BuildContext context, int index) {
              var table = tab.filterTableMaster[index];
              return Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                        return TableDetailScreen(tableMaster: table,);
                      }));
                    },
                    child: Card(
                      color: getColor(table),
                      child: allTextContent(table),
                    ),
                  ),
                  (table.requestingOtp ?? 0) > 0 ? Align(
                    alignment: Alignment.topCenter,
                    child: badges.Badge(
                      showBadge: false,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: const Icon(Icons.notifications_active, color: Colors.pink),
// Icon(Icons.notifications_active, color: Colors.pink),
                      ),
                    ),
                  ) : Container(),

                ],
              );
            }),
      ],
    )
        : Container();
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
          slide.onValueChanged(v);
          //timer2 = Timer(const Duration(milliseconds: 2), () => Provider.of<TablesProvider>(context, listen: false).onValueChanged(v));
          //timer.cancel();
          Provider.of<TablesProvider>(context, listen: false).onValueChanged(v);

        },
      );
    });
  }







  @override
  bool get wantKeepAlive => true;


}





