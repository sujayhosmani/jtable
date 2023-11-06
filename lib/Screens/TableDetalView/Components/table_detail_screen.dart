import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Utils.dart';
import 'package:jtable/Models/Orders.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Screens/Providers/global_provider.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:jtable/Screens/Providers/orders_provider.dart';
import 'package:jtable/Screens/Providers/slider_provider.dart';
import 'package:jtable/Screens/ViewTableScreen/table_view_screen.dart';
import 'package:jtable/Screens/shared/loading_screen.dart';
import 'package:provider/provider.dart';

class TableDetailScreen extends StatefulWidget {
  final TableMaster tableMaster;
  const TableDetailScreen({super.key, required this.tableMaster});

  @override
  State<TableDetailScreen> createState() => _TableDetailScreenState();
}

class _TableDetailScreenState extends State<TableDetailScreen> {

  void initState() {
    super.initState();
    Provider.of<OrdersProvider>(context, listen: false).GetOrdersByOrderId(
        context,
        widget.tableMaster.occupiedById ?? "",
        widget.tableMaster.tableNo ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.tableMaster.tableNo ?? "",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
          ),
          actions: [

            TextButton(onPressed: () {}, child: Text("otp: " + (widget.tableMaster.joinOTP ?? "") ?? "", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
            addItemAction(),
          ],
        ),
      body: Consumer2<SliderProvider, OrdersProvider>(builder: (context, slide, orders, child) {
        return DefaultTabController(
          length: 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildPrimaryTopBar(slide.selectedVal),
              buildTabBar(slide, orders),
              buildTabBarView(slide, orders),
              buildFooter(slide.selectedVal)
            ],
          ),
        );
      })

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

  buildFooter(selectedVal) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          getFooterBarBasedOnSelectedVal(selectedVal),
          //buildAddItemFooter()
        ],
      ),
    );
  }

  buildAddItemFooter(){
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

  getFooterBarBasedOnSelectedVal(selectedVal) {
    switch(selectedVal){
      case 1: return buildTableFooter();
      case 2: return buildCartFooter();
      case 3: return buildOrderFooter();
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
            child: ElevatedButton(onPressed: ()=> print(""), child: Text("Confirm", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
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

  buildOrderFooter() {
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
        child: ElevatedButton(onPressed: ()=>print(""), child: Text("Add Items", style: TextStyle(color: Colors.white),),
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
        height: 45,
        child:
        TabBar(isScrollable: true,
            padding: EdgeInsets.zero,
            // labelPadding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
            indicatorColor: Colors.black87,
            onTap: (index){
              //slide.onValueChangedForSec(index);
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
                  child: Text("In Progress"),
                  offset: Offset(12, -9),
                  backgroundColor: Colors.green,
                  alignment: Alignment.topRight,
                  label: Text((orders.inprogress_orders?.length.toString()) ?? ""),
                ),
              ),
              Tab(text: "Completed"),
              Tab(text: "All"),
            ]),
      ),
    );
  }

  buildTabBarView(SliderProvider slide, OrdersProvider orders) {
    return Expanded(
      child: Visibility(
        visible: slide.selectedVal == 3,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Container(
          // color: Colors.blue,
          child: TabBarView(children: [
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
    );
    // switch(slide.selectedVal){
    //   case 3: return Expanded(
    //     child: Container(
    //       // color: Colors.blue,
    //       child: TabBarView(children: [
    //         Container(
    //           //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
    //           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    //           child: _itemList(orders: orders.pending_orders, from: 'pending',),
    //         ),
    //         Container(
    //           //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
    //           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    //           child: _itemList(orders: orders.inprogress_orders, from: 'in_progress',),
    //         ),
    //         Container(
    //           //margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
    //           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    //           child: _itemList(orders: orders.completedOrders, from: 'completed',),
    //         ),
    //         Container(
    //           //margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
    //           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    //           child: _itemList(orders: orders.merged_orders, from: 'all',),
    //         ),
    //       ]),
    //     ),
    //   );
    // }
    // return Container();
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
}

class _tabselection extends StatelessWidget{
  final OrdersProvider orders;
  // final Function onAccept;
  // final Function onCancel;

  const _tabselection({super.key, required this.orders});

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 40,
            child:
            TabBar(isScrollable: true,
                padding: EdgeInsets.zero,
                // labelPadding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
                indicatorColor: Colors.black87,
                tabs: [
                  Tab(
                    child: Badge(
                      child: Text("Pending"),
                      offset: Offset(12, -9),
                      alignment: Alignment.topRight,
                      label: Text((orders.pending_orders?.length.toString()) ?? ""),
                    ),
                  ),

                  Tab(
                    child: Badge(
                      child: Text("In Progress"),
                      offset: Offset(12, -9),
                      backgroundColor: Colors.green,
                      alignment: Alignment.topRight,
                      label: Text((orders.inprogress_orders?.length.toString()) ?? ""),
                    ),
                  ),
                  Tab(text: "Completed"),
                  Tab(text: "All"),
                ]),
          ),
          TabBarView(children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: _itemList(orders: orders.pending_orders, from: 'pending',),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: _itemList(orders: orders.inprogress_orders, from: 'in_progress',),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: _itemList(orders: orders.completedOrders, from: 'completed',),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: _itemList(orders: orders.merged_orders, from: 'all',),
            ),
          ]),
        ],
      ),
    );
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
                            "X" + (orders?[index].quantity.toString() ?? "") ??
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
    print("on accept pending");
    if(from == "pending"){
      order.status = "in_progress";
    }else if(from == "in_progress"){
      order.status = "completed";
    };
    List<Orders> orders = [];
    orders.add(order);
    Provider.of<OrdersProvider>(context, listen: false).UpdateOrder(orders, context, order.ordersId ?? "", order.tableNo ?? "");
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
