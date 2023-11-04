import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jtable/Helpers/auth_service.dart';
import 'package:jtable/Helpers/signalR_services.dart';
import 'package:jtable/Models/Logged_in_users.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Screens/HomeScreen/Widgets/headings_home.dart';
import 'package:jtable/Screens/Providers/global_provider.dart';
import 'package:jtable/Screens/Providers/logged_inProvider.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:jtable/Screens/Providers/tables_provider.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/assigned_tables.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/latest_doubts.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/rank_widget.dart';
import 'package:jtable/Screens/ViewTableScreen/table_view_screen.dart';
import 'package:jtable/Screens/shared/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../Helpers/Constants.dart';
import '../../../Helpers/Utils.dart';
import '../Widgets/LatestAnnouncement.dart';
import '../Widgets/latestIssues.dart';
import '../Widgets/latest_story.dart';
import '../Widgets/main_cards.dart';
import '../Widgets/morning_toast.dart';
import '../Widgets/parent_detail.dart';
import '../Widgets/upcoming_event.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  @override
  void initState() {
    super.initState();
    //Provider.of<TablesProvider>(context, listen: false).GetAllTables(context);
    Provider.of<LoggedInProvider>(context, listen: false)
        .GetAllNotifications(context);
  }

  Future<void> _handleRefresh() async {
    //await Provider.of<SignalRService>(context, listen: false).initializeConnection(context);
    // Provider.of<TablesProvider>(context, listen: false).GetAllTables(context);
    // Provider.of<LoggedInProvider>(context, listen: false)
    //     .GetAllNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OttoMan"),
      ),
      // backgroundColor: Colors.black87,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ParentDetails(),
                    SizedBox(height: 12),
                    Divider(height: 1, color: Utils.scaffold),
                    SizedBox(height: 12),
                    Consumer<TablesProvider>(builder: (context, tables, child) {
                      return RankWig(tableMaster: tables.tableMaster);
                    }),
                    Divider(height: 1, color: Utils.scaffold),
                    SizedBox(height: 12),
                    Consumer<TablesProvider>(builder: (context, tab, child) {
                      return AssignedTables(
                        tableMaster: tab.assignedTableMaster,
                        onPressed: (value) => {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return TableViewScreen(tableMaster: value);
                          }))
                        },
                      );
                    }),
                    SizedBox(height: 12),
                    Divider(height: 10, color: Utils.scaffold),
                    SizedBox(height: 12),
                    Consumer<LoggedInProvider>(
                        builder: (context, loggedInUser, child) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 6),
                          child: Column(
                            children: [
                              HeadingTitle(
                                label: "Notifications",
                                color: Utils.fromHex("#F67B5A"),
                                onTap: () {
                                  Provider.of<LoggedInProvider>(context,
                                          listen: false)
                                      .GetAllNotifications(context);
                                },
                              ),
                              (loggedInUser.loggedInUser?.length ?? 0) > 0
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          loggedInUser.loggedInUser?.length,
                                      itemBuilder: (context, index) {
                                        LoggedInUsers? loggedIn =
                                            loggedInUser.loggedInUser?[index];
                                        return Container(
                                          height: 100,
                                          padding:
                                              EdgeInsets.symmetric(vertical: 6),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                color: Utils.scaffold,
                                                child: Stack(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                loggedInUser
                                                                        .loggedInUser?[
                                                                            index]
                                                                        .tableNo ??
                                                                    "",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              loggedIn?.otp !=
                                                                      null
                                                                  ? Text(loggedIn
                                                                          ?.otp ??
                                                                      "")
                                                                  : Container(),
                                                            ],
                                                          ),
                                                        ),
                                                        VerticalDivider(
                                                          width: 1,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 12,
                                                                  top: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                loggedIn?.name ??
                                                                    "",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(loggedIn
                                                                      ?.phone ??
                                                                  ""),
                                                              //Text("5mem", style: TextStyle(fontSize: 9),),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  onAccepted(
                                                                      loggedIn),
                                                              child: Text(
                                                                  "Refresh"),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {},
                                                              child: Text(
                                                                  "Cancel",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red
                                                                          .shade300)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        );
                                      })
                                  : Text(""),
                            ],
                          ));
                    }),
                  ],
                ),
              ),
            ),
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
      ),
    );
  }

  onAccepted(LoggedInUsers? loggedIn) async {
    print("on accepting");
    Users? user = Provider.of<NetworkProvider>(context, listen: false).users;
    // loggedIn?.ordersId = loggedIn.id;
    // loggedIn?.otpByName = user?.name;
    // loggedIn?.otpById = user?.id;
    // loggedIn?.otpByPh = user?.phone;
    // loggedIn?.isFirst = true;
    // loggedIn?.otp = null;

    TableMaster? table = Provider.of<TablesProvider>(context, listen: false)
        .tableMaster
        ?.where((element) => element.id == loggedIn?.tableId)
        .firstOrNull;
    table?.assignedStaffId = user?.id;
    table?.assignedStaffName = user?.name;
    table?.assignedStaffPh = user?.phone;
    table?.noOfPeople = 1;
    table?.occupiedBy = loggedIn?.name;
    table?.occupiedById = loggedIn?.id;
    table?.occupiedName = loggedIn?.name;
    table?.occupiedPh = loggedIn?.phone;
    table?.from = "otp";

    await Provider.of<TablesProvider>(context, listen: false)
        .UpdateTable(table, context);

    table = Provider.of<TablesProvider>(context, listen: false)
        .tableMaster
        ?.where((element) => element.id == loggedIn?.tableId)
        .firstOrNull;

    setState(() {
      loggedIn?.otp = table?.joinOTP;
    });

    //Provider.of<TablesProvider>(context, listen: false).UpdateTable(table, context);
  }
}
