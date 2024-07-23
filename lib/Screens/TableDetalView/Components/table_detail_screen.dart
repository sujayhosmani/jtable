import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Utils.dart';
import 'package:jtable/Helpers/signalR_services.dart';
import 'package:jtable/Models/OrdersPost.dart';
import 'package:jtable/Models/LoggedInUserPost.dart';
import 'package:jtable/Models/Logged_in_users.dart';
import 'package:jtable/Models/Orders.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Screens/MenuScreen/helping_widgets.dart';
import 'package:jtable/Screens/MenuScreen/menu_screen.dart';
import 'package:jtable/Screens/Providers/global_provider.dart';
import 'package:jtable/Screens/Providers/logged_inProvider.dart';
import 'package:jtable/Screens/Providers/menu_provider.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:jtable/Screens/Providers/orders_provider.dart';
import 'package:jtable/Screens/Providers/slider_provider.dart';
import 'package:jtable/Screens/Providers/tables_provider.dart';
import 'package:jtable/Screens/TableDetalView/Components/bill_detail_view.dart';
import 'package:jtable/Screens/TableDetalView/Components/table_detail_view_screen.dart';
import 'package:jtable/Screens/TableDetalView/Dialogs/clear_avoid_dialog.dart';
import 'package:jtable/Screens/TableDetalView/Dialogs/clear_table_choice_dialog.dart';
import 'package:jtable/Screens/TableDetalView/Dialogs/switch_table_dialog.dart';
import 'package:jtable/Screens/TableDetalView/Widgets/items.dart';
import 'package:jtable/Screens/ViewTableScreen/table_view_screen.dart';
import 'package:jtable/Screens/shared/input.dart';
import 'package:jtable/Screens/shared/loading_screen.dart';
import 'package:provider/provider.dart';

class TableDetailScreen extends StatefulWidget {
  final TableMaster tableMaster;
  const TableDetailScreen({super.key, required this.tableMaster});

  @override
  State<TableDetailScreen> createState() => _TableDetailScreenState();
}

class _TableDetailScreenState extends State<TableDetailScreen> with TickerProviderStateMixin, WidgetsBindingObserver {
  late TableMaster finalTable2;
  late TabController _tabController;
  late TabController _tabController2;
  TextEditingController mUserName = TextEditingController();
  TextEditingController mPhoneNumber = TextEditingController();
  TextEditingController mNoOfPeople = TextEditingController();
  bool isOrderJoined = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    finalTable2 = widget.tableMaster;
    Provider.of<OrdersProvider>(context, listen: false).AddCurrentTable(widget.tableMaster);
    _tabController = new TabController(vsync: this, length: 4);
    _tabController2 = new TabController(vsync: this, length: 2);
    onInitialization();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        onInitialization();
        print('qqqqqqqqqqqqqqqqqqqqqqqq Back to app222222222222222');
        break;
      case AppLifecycleState.paused:
        print('qqqqqqqqqqqqqqqqqqqqqqqq App minimised or Screen locked2222222222222');
        break;
      default:break;
    }
  }


  onInitialization(){
    finalTable2 = Provider.of<OrdersProvider>(context, listen: false).currentTable!;
    Future.delayed(Duration.zero,(){
      Provider.of<MenuProvider>(context, listen: false).onInitFirst(finalTable2.tableNo ?? "");
    });

    callTheMethod();


  }

  SignalRService? numberGenerator;
  OrdersProvider? ordersProvider;
  FooterProvider? footerProvider;
  SliderProvider? slideProvider;
  @override
  void didChangeDependencies() {
    numberGenerator = Provider.of<SignalRService>(context, listen: false);
    ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    footerProvider = Provider.of<FooterProvider>(context, listen: false);
    slideProvider = Provider.of<SliderProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    leaveTheGroup();
    super.dispose();


  }

  joinTheGroup(){
    finalTable2 = Provider.of<OrdersProvider>(context, listen: false).currentTable!;
    Provider.of<SignalRService>(context,listen: false).joinOrder(finalTable2.id ?? "", finalTable2.occupiedById ?? "");
    isOrderJoined = true;
  }

  leaveTheGroup(){
    ordersProvider?.clearOrders();
    numberGenerator?.leaveOrder(finalTable2.id ?? "", finalTable2.occupiedById ?? "");
    footerProvider?.onValueChanged(0, isNotify: false);
    slideProvider?.onValueChanged(0, isNotify: false);
  }

  callTheMethod() async {
    finalTable2 = Provider.of<OrdersProvider>(context, listen: false).currentTable!;
    if(!(finalTable2.isOccupied ?? false)){
      getLoggedInUsersOTP(context, finalTable2.id ?? "");
    }else{
      joinTheGroup();
    }
    Provider.of<LoggedInProvider>(context, listen: false).clearLoggedInUsers();
    TableMaster? mas  = await Provider.of<TablesProvider>(context, listen: false).onTableDetailViewPage(context, finalTable2.tableNo ?? "");
    if(!isOrderJoined){
      joinTheGroup();
    }

  }


  getOrdersByOrderId(){
    finalTable2 = Provider.of<OrdersProvider>(context, listen: false).currentTable!;
    if(finalTable2.isOccupied ?? false){
      Provider.of<OrdersProvider>(context, listen: false).GetOrdersByOrderId(
          context,
          finalTable2.occupiedById ?? "",
          finalTable2.tableNo ?? "", shouldNavigate: true);
    }

  }

  callTheMethodOnlyTable() async {
    TableMaster? mas  = await Provider.of<TablesProvider>(context, listen: false).onUserSubmitViewPage(context, finalTable2.tableNo ?? "");
    if(!isOrderJoined){
      joinTheGroup();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignalRService>(builder: (context, signal, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: signal.connectionIsOpen ? Colors.orangeAccent : Colors.redAccent,
            title: Text(
              finalTable2.tableNo ?? "",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
            actions: [
          Consumer<OrdersProvider>(builder: (context, orders, child) {
              return Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.black,),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    signal.initializeConnection(context);
                    if(orders.currentTable?.isOccupied ?? false) {callTheMethod();}else{getLoggedInUsersOTP(context, finalTable2.id ?? "");}
                  },
                ),
                // orders.currentTable?.isOccupied ?? false ? Text("otp: ${orders.currentTable?.joinOTP ?? ""}" ?? "", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),): Container(),
                orders.currentTable?.isOccupied ?? false ? addItemAction() : Container(),
                orders.currentTable?.isOccupied ?? false ?   SizedBox(height: 0, width: 0,) : addViewOTPAction(orders)
              ],
              );
          })

            ],
          ),
          body: Stack(
            children: [

              Consumer2<SliderProvider, OrdersProvider>(builder: (context, slide, orders, child) {
                print("consuminhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
                print(orders.currentTable?.totalBill);
                print(orders.pending_orders?.length ?? 0);
                if(!isOrderJoined && (orders.currentTable?.isOccupied ?? false) == true){
                  joinTheGroup();
                }
                return (orders.currentTable?.isOccupied ?? false) ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    buildPrimaryTopBar(slide.selectedVal, orders),
                    buildTabBar(slide, orders),
                    buildTabBarView(slide, orders),
                    //buildOtherViews(slide.selectedVal),
                    Consumer<FooterProvider>(builder: (context, footer, child) {
                      return buildFooter(slide.selectedVal, footer.selectedFooter, orders);
                    })
                  ],
                ) : fillUserDetails2(orders);
              }),
              Consumer<GlobalProvider>(builder: (context, global, child) {
                print(global.error);
                return LoadingScreen(
                  isBusy: global.isBusy,
                  error: global.error ?? "",
                  onPressed: () {},
                );
              })
            ],
          )

      );
    });

  }

  buildPrimaryTopBar(selectedVal, OrdersProvider orders){
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300, width: 1),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildTopWidgets("Table", 1, selectedVal, context),
        buildTopWidgets("Cart", 2, selectedVal, context),
        buildTopWidgets("Orders", 3, selectedVal, context),
        ((orders.orders?.length ?? 0) > 0) ?  buildTopWidgets("Bill", 4, selectedVal, context) : SizedBox(height: 0, width: 0,),
      ],
    ),
  );
  }

  buildTopWidgets(name, i, int selectedVal, context){
    return Flexible(
      flex: 1,
      child: InkWell(
        highlightColor: Colors.redAccent,
        onTap: () => Provider.of<SliderProvider>(context, listen: false).onValueChanged(i),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Text(name, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),),
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300, width: 0.4,),color: selectedVal == i ? Utils.fromHex("#ce3737") : Utils.fromHex("#495057")),
        ),
      ),
    );
  }

  buildFooter(selectedVal, secVal, OrdersProvider ordersProvider) {

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          getFooterBarBasedOnSelectedVal(selectedVal, secVal, ordersProvider),
          //buildAddItemFooter()
        ],
      ),
    );
  }

  buildGoBackFooter(){

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: OutlinedButton(onPressed: ()=> Navigator.pop(context), child: Text("Go to Table view", style: TextStyle(color: Colors.black),), style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                backgroundColor: Colors.grey[200],
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),

      ],
    );
  }

  getFooterBarBasedOnSelectedVal(selectedVal, secVal, OrdersProvider ordersProvider) {
    switch(selectedVal){
      case 1: return buildTableFooter(ordersProvider);
      case 2: return buildCartFooter(ordersProvider);
      case 3: return buildOrderFooter(secVal, ordersProvider);
      case 4: return buildBillFooter();
      default: return Container();
    }
  }

  buildTableFooter(OrdersProvider ordersProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: ()=> onSwitchTable(ordersProvider), child: Text("Switch Table", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                backgroundColor: Colors.orange,
                // padding: EdgeInsets.zero,
                // tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: () async => await onTableClear(ordersProvider), child: Text("Clear Table", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                backgroundColor: Colors.black87,
                // padding: EdgeInsets.zero,
                // tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),
      ],
    );
  }

  buildCartFooter(OrdersProvider orders) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: Consumer<MenuProvider>(builder: (context, menu, child){
              return (menu.cartItems.length ?? 0) <= 0 ? buildGoBackFooter() :
              ElevatedButton(onPressed: ()=> onConfirmCart(orders), child: Text("Confirm", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                backgroundColor: Colors.green,
                // padding: EdgeInsets.zero,
                // tapTargetSize: MaterialTapTargetSize.shrinkWrap
              ));
            })
          ),
        ),

      ],
    );
  }

  buildOrderFooter(secVal, OrdersProvider ordersProvider) {
     switch(secVal){
       case 0: return ((ordersProvider.pending_orders?.length ?? 0) > 0) ? buildForPending(ordersProvider.pending_orders, ordersProvider.inprogress_orders) : buildGoBackFooter();
       case 1: return ((ordersProvider.inprogress_orders?.length ?? 0) > 0) ? buildForProgress(ordersProvider.inprogress_orders) : buildGoBackFooter();
       case 2: return buildGoBackFooter();
       default: return buildGoBackFooter();
     }
     return Container();
  }

  buildBillFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: OutlinedButton(onPressed: ()=> Navigator.pop(context), child: Text("Close", style: TextStyle(color: Colors.black),), style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                backgroundColor: Colors.grey[200],
                // padding: EdgeInsets.zero,
                // tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MenuScreen(tableNo: finalTable2.tableNo ?? "");
                  },
                  fullscreenDialog: true));
            }, child: Text("Add Item", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                backgroundColor: Colors.black87,
                // padding: EdgeInsets.zero,
                // tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),
      ],
    );
  }

  addItemAction() {
    return Padding(
        padding: const EdgeInsets.only(top: 5),
        // child: IconButton(onPressed: ()=>print("sdg"), icon: Icon(Icons.add_circle_rounded),),
        child: ElevatedButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) {
                return MenuScreen(tableNo: finalTable2.tableNo ?? "");
              },
              fullscreenDialog: true));
        }, child: Text("Add Items", style: TextStyle(color: Colors.white),),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              )
          ),
        )
    );
  }

  addViewOTPAction(OrdersProvider orders) {
    return Consumer<LoggedInProvider>(builder: (context, loggedIn, child){
      int len = loggedIn.notificationLoggedInUserForTable?.length ?? 0;
      Users? user = Provider.of<NetworkProvider>(context, listen: false).users;
       return (len > 0) ? Padding(
          padding: const EdgeInsets.only(top: 5),
          // child: IconButton(onPressed: ()=>print("sdg"), icon: Icon(Icons.add_circle_rounded),),
          child: ElevatedButton(onPressed: () async {
            List<LoggedInUsers>? loggedInUsers = loggedIn.notificationLoggedInUserForTable;//await Provider.of<LoggedInProvider>(context, listen: false).GetAllNotifications(context, finalTable2.id ?? "");
            print("here");
            print(loggedInUsers?.length ?? 0);
            if(loggedInUsers != null && (loggedInUsers.length ?? 0) > 0){
              loggedInUsers.sort((a,b) => b.createdDateTime!.compareTo(a.createdDateTime!));
              onAccepted(loggedInUsers.first, orders);
            }
          }, child: (orders.currentTable?.joinOTP == null || user?.id != orders.currentTable?.assignedStaffId)
              ? Text("View OTP", style: TextStyle(color: Colors.white),)
              : (orders.currentTable?.joinOTP != null && user?.id == orders.currentTable?.assignedStaffId)
              ? Text(orders.currentTable?.joinOTP ?? "NA", style: TextStyle(color: Colors.white))
              : Text("NA", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                )
            ),
          )
      ): Container();
    });
  }

  buildSecondaryTopBar(int selectedVal, int secVal) {
    switch(selectedVal){
      case 3: return buildSecondaryOrdersView(secVal);
    }
    return Container();
  }

  buildTabBar(SliderProvider slide, OrdersProvider orders) {
    return Visibility(
      visible: slide.selectedVal == 3,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: SizedBox(
        width: double.infinity,
        height: slide.selectedVal == 3 ? 45 : 0,
        child:
        TabBar(
            // isScrollable: true,
            padding: EdgeInsets.zero,
            controller: _tabController,
            // labelPadding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
            indicatorColor: Colors.black87,

            onTap: (index){
              Provider.of<FooterProvider>(context, listen: false).onValueChanged(index);
            },
            tabs: [
              Tab(
                child: Badge(
                  offset: const Offset(12, -9),
                  alignment: Alignment.topRight,
                  label: Text((orders.pending_orders?.length.toString()) ?? ""),
                  child: const Text("Pending"),

                ),
              ),

              Tab(
                child: Badge(
                  child: Text("Progress"),
                  offset: Offset(12, -9),
                  backgroundColor: Colors.green,
                  alignment: Alignment.topRight,
                  label: Text((orders.inprogress_orders?.length.toString()) ?? ""),
                ),
              ),
              Tab(text: "Done", ),
              Tab(text: "All"),
            ]),
      ),
    );
  }

  buildTabBarView(SliderProvider slide, OrdersProvider orders) {
    return Expanded(
      child: Stack(
        children: [
          Visibility(
            visible: slide.selectedVal == 3,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Container(
              // color: Colors.blue,
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    Container(
                      //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: ItemList(orders: orders.pending_orders, from: 'pending',),
                    ),
                    Container(
                      //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: ItemList(orders: orders.inprogress_orders, from: 'in_progress',),
                    ),
                    Container(
                      //margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: ItemList(orders: orders.completedOrders, from: 'completed',),
                    ),
                    Container(
                      //margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: ItemList(orders: orders.merged_orders, from: 'all',),
                    ),
                  ]),
            ),
          ),
          buildOtherViews(slide.selectedVal, orders)
        ],
      )
    );
  }

  buildSecondaryOrdersView(selectedVal) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildOrdersSecWidgets("All", 1, selectedVal, context),
          buildOrdersSecWidgets("Pending", 2, selectedVal, context),
          buildOrdersSecWidgets("Done", 3, selectedVal, context),
          buildOrdersSecWidgets("Cancelled", 4, selectedVal, context),
        ],
      ),
    );
  }

  buildCartItems(BuildContext context, OrdersPost? cartItem) {
    OrdersPost? foods = cartItem; //.items;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,0),
            child: foods?.preference?.toLowerCase() == "veg" ?  const VegBadgeView() : foods?.preference?.toLowerCase() == "non veg" ? const NonVegBadgeView()  : Container(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text( foods?.itemName ?? "", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue.shade900),),
                ),

                foods?.varName != null && foods?.varName != "" ? Text(
                  foods?.varName ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(
                    fontSize: 12.0,
                    color: Colors.grey[500],
                  ),
                ) : Container(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,10,0),
            child: Text(foods?.varName != null && foods?.varName != "" ? foods?.price.toString() ?? ""  : foods?.price.toString() ?? "", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
          ),
          CartBtnView(quantity: foods?.quantity ?? 0, onItemPlus: (){
            Provider.of<MenuProvider>(context, listen: false).onCartItemScreen(isFromVar: (foods?.isVeriation ?? false), cartItem: foods!, isAdd: true, isRemove: false);
          }, onItemMinus: () {
            Provider.of<MenuProvider>(context, listen: false).onCartItemScreen(isFromVar: (foods?.isVeriation ?? false), cartItem: foods!, isAdd: false, isRemove: false);
          },)

        ],
      ),
    );
  }

  buildOrdersSecWidgets(name, i, int selectedVal, context){
    return Flexible(
      flex: 1,
      child: InkWell(
        highlightColor: Colors.redAccent,
        onTap: () => Provider.of<SliderProvider>(context, listen: false).onValueChangedForSec(i),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Text(name, textAlign: TextAlign.center, style: TextStyle(color: selectedVal == i ? Colors.white : Colors.black, fontWeight: selectedVal == i ? FontWeight.bold : FontWeight.w500, fontSize: 13),),
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300, width: 0.4,),color: selectedVal == i ? Utils.fromHex("#ce3737") : Utils.fromHex("#f5f5f5")),
        ),
      ),
    );
  }

  buildForPending(List<Orders>? pendingOrders, List<Orders>? progressOrders) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: ()=> onAcceptAll(pendingOrders, context, "in_progress"), child: Text("Move All to Done", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero
              ),
              backgroundColor: Colors.green,
              // padding: EdgeInsets.zero,
              // tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: ()=> onAcceptAll(pendingOrders, context, "pending"), child: Text("Move All to Progress", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero
              ),
              backgroundColor: Colors.orange,
              // padding: EdgeInsets.zero,
              // tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),
      ],
    );
  }

  buildForProgress(List<Orders>? progressOrders) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: ()=> onAcceptAll(progressOrders, context, "in_progress"), child: Text("Move All to Done", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero
              ),
              backgroundColor: Colors.green,
              // padding: EdgeInsets.zero,
              // tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),
      ],
    );
  }

  onAcceptAll(List<Orders>? orders, BuildContext context, String from) {
    orders?.forEach((element) {
      if(from == "pending"){
        element.status = "in_progress";
      }else if(from == "in_progress"){
        element.status = "completed";
      };
    });
    Provider.of<OrdersProvider>(context, listen: false).UpdateOrderNormal(orders, context, orders?[0].ordersId ?? "", orders?[0].tableNo ?? "");
  }


  emptyCartView(){
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("There are no items in cart"),
          ElevatedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return MenuScreen(tableNo: finalTable2.tableNo ?? "");
                },
                fullscreenDialog: true));
          }, child: Text("Add Items", style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87
            ),)
        ],
      ),);
  }


  buildOtherViews(selectedVal, OrdersProvider orders) {

    switch(selectedVal){
      case 1: return TableDetailViewScreen(tableMaster: orders.currentTable!, orderDetails: (orders.orders?.length ?? 0) > 0 ? orders.orders?.first : null);
      case 2: {
        return Consumer<MenuProvider>(builder: (context, menu, child){
            return (menu.cartItems.length ?? 0) <= 0 ? emptyCartView() :
            ListView.builder(
              itemCount: menu.cartItems.length,
                itemBuilder: (BuildContext context, int index){
                OrdersPost? ord = menu.cartItems?[index];
                return buildCartItems(context, ord);
            });
        });
      }
      case 4: return ((orders.orders?.length ?? 0) > 0) ? BillDetailViewScreen(tableMaster: orders.currentTable!, orderDetails: (orders.orders?.length ?? 0) > 0 ? orders.orders : null) : SizedBox(height: 0, width: 0,);
      default: return Container();
    }
  }

  onConfirmCart(OrdersProvider orders) async {
    Users? loggedInUser = Provider.of<NetworkProvider>(context, listen: false).users;
    List<OrdersPost> cartItems = Provider.of<MenuProvider>(context, listen: false).cartItems;
    cartItems.forEach((data) {
      data.addedById = orders.currentTable?.occupiedById;
      data.tableNo = orders.currentTable?.tableNo;
      data.tableId = orders.currentTable?.id;
      data.ordersId = orders.currentTable?.occupiedById;
      data.insertedBy = loggedInUser?.role;
      data.insertedById = loggedInUser?.id;
      data.insertedByName = loggedInUser?.name;
      data.insertedByPh = loggedInUser?.phone;
      data.status = "pending";
      data.isRunning = false;
      data.isAccepted = false;
      data.isCancelled = false;
    });

    // List<OrdersPost> confirmCartItems = [];
    // cartItems.forEach((data) {
    //   OrdersPost order = OrdersPost(
    //     id: data.id,
    //     addedById: data.addedById,
    //     addedByName: data.addedByName,
    //     addedByPh: data.addedByPh,
    //     assignedId: data.assignedId,
    //     assignedName: data.assignedName,
    //     assignedPh: data.assignedPh,
    //     cancelledById: data.cancelledById,
    //     cancelledByName: data.cancelledByName,
    //     description: data.description,
    //     discount: data.discount,
    //     insertedBy: data.insertedBy,
    //     insertedById: data.insertedById,
    //     insertedByName: data.insertedByName,
    //     insertedByPh: data.insertedByPh,
    //     instructions: data.instructions,
    //     isAccepted: data.isAccepted,
    //     isCancelled: data.isCancelled,
    //     isRunning: data.isRunning,
    //     isVeriation: data.isVeriation,
    //     itemId: data.itemId,
    //     itemImage: data.itemImage,
    //     itemName: data.itemName,
    //     loggedInStatus: data.loggedInStatus,
    //     orderIdInt: data.loggedInStatus,
    //     orderNo: data.orderNo,
    //     ordersId: data.ordersId,
    //     preference: data.preference,
    //     price: data.price,
    //     quantity: data.quantity,
    //     remarks: data.remarks,
    //     status: data.status,
    //     tableId: data.tableId,
    //     tableNo: data.tableNo,
    //     varId: data.varId,
    //     varName: data.varName,
    //   );
    // });

    print(orders.currentTable);
    log(json.encode(cartItems));
    print("--------------------------------------------------------------------------------------------------");
    print(orders.currentTable?.occupiedById);
     Provider.of<OrdersProvider>(context, listen: false).UpdateOrderPost(cartItems, context, orders.currentTable?.occupiedById ?? "", orders.currentTable?.tableNo ?? "");

  }

  fillUserDetails2(OrdersProvider orders){
    return Container(
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("Enter the user details", style: TextStyle(fontSize: 18, ),)),
                    ),
                    SizedBox(height: 6,),
                    InputText(isPassword: false,title: "Username",icon: Icons.person, mCtrl: mUserName),
                    SizedBox(height: 15,),
                    InputText(isPassword: false,title: "Phone number",icon: Icons.phone, mCtrl: mPhoneNumber),
                    SizedBox(height: 15,),
                    InputText(isPassword: false,title: "No of people",icon: Icons.group, mCtrl: mNoOfPeople),
                    SizedBox(height: 15,),
                    // Container(
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(50),
                    //       gradient: Utils.btnGradient
                    //   ),
                    //   margin: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    //   child: TextButton(
                    //     style: TextButton.styleFrom(
                    //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    //         padding: EdgeInsets.symmetric(vertical: 15),
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(60)
                    //         )
                    //     ),
                    //
                    //     child: new Text('Submit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    //     onPressed: () { onUserSubmit(orders); },
                    //   ),
                    // ),
                  ],
                ),
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () async => await onTableClear(orders), child: Text("Clear all logins", style: TextStyle(color: Colors.white),), style:
                  ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero
                      ),
                      backgroundColor: Colors.black87,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  )),
                ),
              ),
              Flexible(
                flex: 1,
                child:  Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: Utils.btnGradient
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.symmetric(vertical: 15),
                    ),

                    child: new Text('Submit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    onPressed: () { onUserSubmit(orders); },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  fillUserDetails(OrdersProvider orders) {
    print("fillUserDetails - fillUserDetails - fillUserDetails - fillUserDetails");
    return Column(
      children: [
        TabBar(
          // isScrollable: true,
            padding: EdgeInsets.zero,
            controller: _tabController2,
            // labelPadding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
            indicatorColor: Colors.black87,

            onTap: (index){
              Provider.of<FooterProvider>(context, listen: false).onValueChangedOnOTP(index);
            },
            tabs: [
              Tab(
                child: Consumer<LoggedInProvider>(builder: (context, loggedInUser, child){
                  return  Badge(
                    offset: const Offset(12, -9),
                    alignment: Alignment.topRight,
                    isLabelVisible: (loggedInUser.notificationLoggedInUserForTable?.length ?? 0) > 0,
                    label: (loggedInUser.notificationLoggedInUserForTable?.length ?? 0) > 0
                        ? Text(loggedInUser.notificationLoggedInUserForTable?.length.toString() ?? "")
                        : Text(""),
                    child: const Text("Users OTP"),

                  );
                }),
              ),

              Tab(
                child: Text("Add User"),
              )
            ]),
        Expanded(
          child : TabBarView(
            controller: _tabController2,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Consumer<LoggedInProvider>(builder: (context, loggedInUser, child){
                return  (loggedInUser.notificationLoggedInUserForTable?.length ?? 0) > 0
                    ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                    loggedInUser.notificationLoggedInUserForTable?.length,
                    itemBuilder: (context, index) {
                      LoggedInUsers? loggedIn = loggedInUser.notificationLoggedInUserForTable?[index];
                      Users? user = Provider.of<NetworkProvider>(context, listen: false).users;
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
                                          (orders.currentTable?.joinOTP == null || user?.id != orders.currentTable?.assignedStaffId) ? TextButton(
                                            onPressed: () =>
                                                onAccepted(loggedIn, orders),
                                            child: Text(
                                                "Accept otp"),
                                          ): Container(),
                                          (orders.currentTable?.joinOTP != null && user?.id == orders.currentTable?.assignedStaffId) ? TextButton(
                                            onPressed: () =>
                                                setState(() {

                                                  orders.currentTable?.joinOTP = null;
                                                }),
                                            child: Text(
                                                orders.currentTable?.joinOTP ?? "NA"),
                                          ): Container(),

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      );
                    })
                    : Text("");
              }),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("Enter the user details", style: TextStyle(fontSize: 18, ),)),
                      ),
                      SizedBox(height: 6,),
                      InputText(isPassword: false,title: "Username",icon: Icons.person, mCtrl: mUserName),
                      SizedBox(height: 15,),
                      InputText(isPassword: false,title: "Phone number",icon: Icons.phone, mCtrl: mPhoneNumber),
                      SizedBox(height: 15,),
                      InputText(isPassword: false,title: "No of people",icon: Icons.group, mCtrl: mNoOfPeople),
                      SizedBox(height: 15,),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: Utils.btnGradient
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60)
                              )
                          ),

                          child: new Text('Submit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          onPressed: () { onUserSubmit(orders); },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ),
        Consumer2<LoggedInProvider, FooterProvider>(builder: (context, loggedInUser, footer, child){
          return  footer.selectedFooterOTP == 0
              ? Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: () async => await onTableClear(orders), child: Text("Clear Tables", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                backgroundColor: Colors.black87,
                // padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          )
              : Text("");
        }),


      ],
    );
  }

  void onUserSubmit(OrdersProvider orders) async {
    TableMaster? tableDetails = await Provider.of<TablesProvider>(context, listen: false).onUserSubmitViewPage(context, orders.currentTable?.tableNo ?? "");
    if(tableDetails != null){
      if (tableDetails.isOccupied == false){
        Users? loggedInUser = Provider.of<NetworkProvider>(context, listen: false).users;
        Provider.of<NetworkProvider>(context, listen: false).setToken(loggedInUser?.token);
        String? valResUniq = Provider.of<NetworkProvider>(context, listen: false).resUniq;
        LoggedInUsersPost createUser = LoggedInUsersPost();
        createUser.insertedBy = loggedInUser?.role;
        createUser.name = mUserName.text;
        createUser.phone = mPhoneNumber.text;
        createUser.noOfPeople = int.parse(mNoOfPeople.text);
        createUser.isFirst = true;
        createUser.tableId = tableDetails.id;
        createUser.tableNo = tableDetails.tableNo;
        createUser.otpById = loggedInUser?.id;
        createUser.otpByName = loggedInUser?.name;
        createUser.otpByPh = loggedInUser?.phone;
        createUser.status = "entered";
        createUser.resUniq = valResUniq ?? "";

        print(json.encode(createUser));
        bool? isInserted = await Provider.of<LoggedInProvider>(context, listen: false).InsertLoggedIN(createUser, context);
        if(isInserted != null){
          if(isInserted){
            Provider.of<SliderProvider>(context, listen: false).onValueChanged(2, isNotify: false);
            callTheMethod();
          }
        }
      }else{
        callTheMethod();
      }
    }
  }

  onAccepted(LoggedInUsers? loggedIn, OrdersProvider orders) async {
    print("on accepting");
    print("on accepting");
    print("on accepting");
    print("on accepting");
    print(loggedIn?.name);
    Users? user = Provider.of<NetworkProvider>(context, listen: false).users;
    // loggedIn?.ordersId = loggedIn.id;
    // loggedIn?.otpByName = user?.name;
    // loggedIn?.otpById = user?.id;
    // loggedIn?.otpByPh = user?.phone;
    // loggedIn?.isFirst = true;
    // loggedIn?.otp = null;

    TableMaster? table = orders.currentTable;
    table?.assignedStaffId = user?.id;
    table?.assignedStaffName = user?.name;
    table?.assignedStaffPh = user?.phone;
    table?.occupiedBy = loggedIn?.name;
    table?.occupiedById = loggedIn?.id;
    table?.occupiedName = loggedIn?.name;
    table?.occupiedPh = loggedIn?.phone;
    table?.from = "otp2";
    // correct
    await Provider.of<TablesProvider>(context, listen: false)
        .UpdateTable(table, context);

    callTheMethodOnlyTable();
  }

  void getLoggedInUsersOTP(BuildContext context, String id) {
    Provider.of<LoggedInProvider>(context, listen: false).GetAllNotifications(context, id ?? "");
  }

  onTableClear(OrdersProvider orders) async {
    await Provider.of<TablesProvider>(context, listen: false).onUserSubmitViewPage(context, finalTable2.tableNo ?? "");
    TableMaster? table = orders.currentTable;
    if(table?.isOccupied ?? false){
      if ((table?.completed ?? 0) + (table?.pending ?? 0) + (table?.progress ?? 0) > 0) {
        showDialog(
          context: context,
          builder: (context) => ClearAvoidDialog(),
        );
      }else{
        showDialog(
          context: context,
          builder: (context) => ClearChoiceDialog(tableMaster: table),
        );
      }
    }else{
        await onConfirmTableClear(table, "not occupied");
    }


  }

  onConfirmTableClear(TableMaster? table, String reason) async {
    table?.joinOTP = null;
    table?.assignedStaffId = null;
    table?.reason = reason;
    table?.from = "clear";


    print("111111111111111111111111111111111111111111111111111111111111111111111111111");
    print(jsonEncode(table));
    print("111111111111111111111111111111111111111111111111111111111111111111111111111");
    await Provider.of<TablesProvider>(context, listen: false)
        .UpdateTable(table, context);

    Navigator.pop(context);
  }

  onSwitchTable(OrdersProvider orders) {
    TableMaster? table = orders.currentTable;
    List<TableMaster> destinations = Provider.of<TablesProvider>(context, listen: false).tableMaster;
    showDialog(
      context: context,
      builder: (context) => SwitchTableDialog(currentTable: table, destinations: destinations,),

    );
  }


}










