import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Utils.dart';
import 'package:jtable/Helpers/signalR_services.dart';
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

class _TableDetailScreenState extends State<TableDetailScreen> with SingleTickerProviderStateMixin {
  late TableMaster finalTable;
  late TabController _tabController;
  TextEditingController mUserName = TextEditingController();
  TextEditingController mPhoneNumber = TextEditingController();
  TextEditingController mNoOfPeople = TextEditingController();

  @override
  void initState() {
    super.initState();
    finalTable = widget.tableMaster;
    _tabController = new TabController(vsync: this, length: 4);
    Future.delayed(Duration.zero,(){
      Provider.of<MenuProvider>(context, listen: false).onInitFirst(finalTable.tableNo ?? "");
    });

    callTheMethod();

    joinTheGroup();
  }

  SignalRService? numberGenerator;
  OrdersProvider? ordersProvider;
  @override
  void didChangeDependencies() {
    numberGenerator = Provider.of<SignalRService>(context, listen: false);
    ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    leaveTheGroup();
    super.dispose();


  }

  joinTheGroup(){
    Provider.of<SignalRService>(context,listen: false).joinOrder(finalTable.id ?? "", finalTable.occupiedById ?? "");
  }

  leaveTheGroup(){
    ordersProvider?.clearOrders();
    numberGenerator?.leaveOrder(finalTable.id ?? "", finalTable.occupiedById ?? "");
  }

  callTheMethod() async {
    TableMaster? mas  = await Provider.of<TablesProvider>(context, listen: false).onTableDetailViewPage(context, finalTable.tableNo ?? "");
    if(mas != null){
      setState(() {
        finalTable = mas;
      });

    }

  }

  callTheMethodOnlyTable() async {
    TableMaster? mas  = await Provider.of<TablesProvider>(context, listen: false).onUserSubmit(context, finalTable.tableNo ?? "");
    if(mas != null){
      setState(() {
        finalTable = mas;
      });

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            finalTable.tableNo ?? "",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
          ),
          actions: [

            TextButton(onPressed: () {}, child: Text("otp: ${finalTable.joinOTP ?? ""}" ?? "", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
            finalTable.isOccupied ?? false ? addItemAction() : Container(),
          ],
        ),
      body: Stack(
        children: [
          (finalTable.isOccupied ?? false)
              ?
          Consumer2<SliderProvider, OrdersProvider>(builder: (context, slide, orders, child) {
            print("consuminhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
            print(orders.pending_orders?.length ?? 0);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildPrimaryTopBar(slide.selectedVal),
                buildTabBar(slide, orders),
                buildTabBarView(slide, orders),
                //buildOtherViews(slide.selectedVal),
                Consumer<FooterProvider>(builder: (context, footer, child) {
                  return buildFooter(slide.selectedVal, footer.selectedFooter, orders);
                })
              ],
            );
          })
              : fillUserDetails(),
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
  }

  buildPrimaryTopBar(selectedVal){
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
        buildTopWidgets("Bill", 4, selectedVal, context),
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
            child: OutlinedButton(onPressed: ()=> print(""), child: Text("Go to Table view", style: TextStyle(color: Colors.black),), style: ElevatedButton.styleFrom(
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
      case 1: return buildTableFooter();
      case 2: return buildCartFooter();
      case 3: return buildOrderFooter(secVal, ordersProvider);
      case 4: return buildBillFooter();
      default: return Container();
    }
  }

  buildTableFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: ()=> print(""), child: Text("Switch Table", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
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
            child: ElevatedButton(onPressed: ()=> print(""), child: Text("Clear Table", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
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

  buildCartFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: ()=> onConfirmCart(), child: Text("Confirm", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
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

  buildOrderFooter(secVal, OrdersProvider ordersProvider) {
     switch(secVal){
       case 0: return buildForPending(ordersProvider.pending_orders, ordersProvider.inprogress_orders);
       case 1: return buildForProgress(ordersProvider.inprogress_orders);
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
            child: OutlinedButton(onPressed: ()=> print(""), child: Text("Close", style: TextStyle(color: Colors.black),), style: ElevatedButton.styleFrom(
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
            child: ElevatedButton(onPressed: ()=> print(""), child: Text("Add Item", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
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
                return MenuScreen(tableNo: finalTable.tableNo ?? "");
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
                      child: _itemList(orders: orders.pending_orders, from: 'pending',),
                    ),
                    Container(
                      //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: _itemList(orders: orders.inprogress_orders, from: 'in_progress',),
                    ),
                    Container(
                      //margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: _itemList(orders: orders.completedOrders, from: 'completed',),
                    ),
                    Container(
                      //margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: _itemList(orders: orders.merged_orders, from: 'all',),
                    ),
                  ]),
            ),
          ),
          buildOtherViews(slide.selectedVal)
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

  buildCartItems(BuildContext context, Orders? cartItem) {
    Orders? foods = cartItem; //.items;
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
    Provider.of<OrdersProvider>(context, listen: false).UpdateOrder(orders, context, orders?[0].ordersId ?? "", orders?[0].tableNo ?? "");
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
                  return MenuScreen(tableNo: finalTable.tableNo ?? "");
                },
                fullscreenDialog: true));
          }, child: Text("Add Items", style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87
            ),)
        ],
      ),);
  }


  buildOtherViews(selectedVal) {

    switch(selectedVal){
      case 1: return const TableDetailViewScreen();
      case 2: {
        return Consumer<MenuProvider>(builder: (context, menu, child){
            return (menu.cartItems.length ?? 0) <= 0 ? emptyCartView() :
            ListView.builder(
              itemCount: menu.cartItems.length,
                itemBuilder: (BuildContext context, int index){
                Orders? ord = menu.cartItems?[index];
                return buildCartItems(context, ord);
            });
        });
      }
      case 4: return const BillDetailViewScreen();
      default: return Container();
    }
  }

  onConfirmCart() {
    Users? loggedInUser = Provider.of<NetworkProvider>(context, listen: false).users;
    List<Orders> cartItems = Provider.of<MenuProvider>(context, listen: false).cartItems;
    cartItems.forEach((data) {
      data.addedById = finalTable.occupiedById;
      data.tableNo = finalTable.tableNo;
      data.tableId = finalTable.id;
      data.ordersId = finalTable.occupiedById;
      data.insertedBy = loggedInUser?.role;
      data.insertedById = loggedInUser?.id;
      data.insertedByName = loggedInUser?.name;
      data.insertedByPh = loggedInUser?.phone;
      data.status = "pending";
      data.isRunning = false;
      data.isAccepted = false;
      data.isCancelled = false;
    });
    print(finalTable);
    log(json.encode(cartItems));
    print("--------------------------------------------------------------------------------------------------");
    print(finalTable.occupiedById);
    Provider.of<OrdersProvider>(context, listen: false).UpdateOrder(cartItems, context, finalTable.occupiedById ?? "", finalTable.tableNo ?? "");

  }

  fillUserDetails() {
    return Column(
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
            onPressed: () { onUserSubmit(); },
          ),
        ),
      ],
    );
  }

  void onUserSubmit() async {
    TableMaster? tableDetails = await Provider.of<TablesProvider>(context, listen: false).onUserSubmit(context, finalTable.tableNo ?? "");
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
            callTheMethod();
          }
        }
      }else{
        callTheMethod();
      }
    }
  }


}




class _itemList extends StatelessWidget {
  final List<Orders>? orders;
  final String from;
  // final Function onCancel;

  const _itemList(
      {super.key, required this.orders, required this.from});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 45),
        itemCount: orders?.length ?? 0,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder(bottom: BorderSide(width: 1,
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid)),
                columnWidths: from == "pending" || from == "in_progress" ? const {
                  0: FlexColumnWidth(6),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(3)
                }:
                from == "completed" ?
                const {
                  0: FlexColumnWidth(6),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2)
                }:
                const {
                  0: FlexColumnWidth(6),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                orders?[index].itemName ?? "", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800),),
                              orders?[index].varName != null
                                  ? Text(orders?[index].varName ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w100, fontSize: 11),)
                                  : Container()
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
                          child: Text(
                            "X${orders?[index].quantity.toString() ?? ""}" ??
                                "", style: TextStyle(fontSize: 13.0),),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
                          child: Text(orders?[index].status == "cancelled" ? "cancelled" : (orders?[index].price.toString() ?? ""),
                              style: TextStyle(fontSize: 12.0),
                              textAlign: TextAlign.end),
                        ),
                        from != "all" ? Padding(
                          padding: const EdgeInsets.fromLTRB(8, 5, 0, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 1),
                                    child: Icon(Icons.delete_outline,
                                      color: Colors.red.shade400,),
                                  ),
                                  onTap: () => {
                                    showDialog(
                                      context: context,
                                      builder: (context) => CancelItemDialog(order: orders![index]),
                                    )
                                  }
                              ),
                              from == "pending" || from == "in_progress" ? SizedBox(width: 10,): Container(),
                              from == "pending" || from == "in_progress" ?  InkWell(
                                  child: Container(

                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 4),
                                        child: Icon(Icons.done,
                                          color: Colors.green.shade500,),
                                      )
                                  ),
                                  onTap: () =>
                                  {
                                    onAcceptPending(orders![index], context, from)
                                  }
                              ) : Container(),
                              SizedBox(width: 6,),

                            ],
                          ),
                        ): Container(),
                      ],
                      decoration: BoxDecoration(
                          color: orders?[index]?.status == "cancelled" ? Colors.red.shade200 : Colors.transparent
                      )),
                ],
              ),
            ],
          );
        });
  }

  onAcceptPending(Orders order, BuildContext context, String from) {
    print(from);
    if(from == "pending"){
      order.status = "in_progress";
    }else if(from == "in_progress"){
      order.status = "completed";
    }
    List<Orders> orders = [];
    orders.add(order);
    log(json.encode(orders));
    Provider.of<OrdersProvider>(context, listen: false).UpdateOrder(orders, context, order.ordersId ?? "", order.tableNo ?? "");
  }




}


class CancelItemDialog extends StatefulWidget {
  final Orders order;
  const CancelItemDialog({super.key, required this.order});

  @override
  State<CancelItemDialog> createState() => _CancelItemDialogState();
}

class _CancelItemDialogState extends State<CancelItemDialog> {
  String? reason = "User ordered by mistake";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Do you want to cancel", style: TextStyle(fontSize: 16),),
                Text(widget.order.itemName ?? "", style: TextStyle(color: Colors.grey, fontSize: 14),)
              ],
            ),
            content: Container(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(value: "User ordered by mistake", materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, groupValue: reason, onChanged: (value){
                          setState(() {
                            reason = value.toString();
                          });
                        }),
                        Text("User selected by mistake")
                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: "Not available", materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, groupValue: reason, onChanged: (value){
                          setState(() {
                            reason = value.toString();
                          });
                        }),
                        Text("Not available")
                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: "Wrongly listed in menu", materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,groupValue: reason, onChanged: (value){
                          setState(() {
                            reason = value.toString();
                          });
                        }),
                        Text("Wrongly listed in menu")
                      ],
                    )
                  ],
                ),
              ),
            ),

            contentPadding: EdgeInsets.zero,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                onPressed: () {
                  OnCancelledItem(widget.order, reason!);
                },
                child: Text('Ok'),
              ),
            ],
          ),
        ),
        Consumer<GlobalProvider>(builder: (context, global, child){
          print(global.error);
          return LoadingScreen(isBusy: global.isBusy,error: global?.error ?? "", onPressed: (){},);
        })

      ],
    );
  }

  Future<void> OnCancelledItem(Orders order, String remark) async {

    Users? user = Provider.of<NetworkProvider>(context, listen: false).users;
    order.status = "cancelled";
    order.cancelledById = user?.id;
    order.cancelledByName = user?.name;
    order.remarks = remark;
    List<Orders> orders = [];
    orders.add(order);
    await Provider.of<OrdersProvider>(context, listen: false).UpdateOrder(orders, context, order.ordersId ?? "", order.tableNo ?? "");
    Navigator.pop(context);
  }
}
