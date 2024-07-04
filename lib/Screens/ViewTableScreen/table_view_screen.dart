// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:jtable/Models/Orders.dart';
// import 'package:jtable/Models/Table_master.dart';
// import 'package:jtable/Models/Users.dart';
// import 'package:jtable/Screens/MenuScreen/menu_screen.dart';
// import 'package:jtable/Screens/Providers/global_provider.dart';
// import 'package:jtable/Screens/Providers/network_provider.dart';
// import 'package:jtable/Screens/Providers/orders_provider.dart';
// import 'package:jtable/Screens/Providers/tables_provider.dart';
// import 'package:jtable/Screens/shared/loading_screen.dart';
// import 'package:provider/provider.dart';
//
// class TableViewScreen extends StatefulWidget {
//   final TableMaster tableMaster;
//   const TableViewScreen({super.key, required this.tableMaster});
//
//   @override
//   State<TableViewScreen> createState() => _TableViewScreenState();
// }
//
// class _TableViewScreenState extends State<TableViewScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<OrdersProvider>(context, listen: false).GetOrdersByOrderId(
//         context,
//         widget?.tableMaster?.occupiedById ?? "",
//         widget?.tableMaster?.tableNo ?? "");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.tableMaster.tableNo ?? "",
//           style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
//         ),
//         actions: [
//           TextButton(onPressed: () {}, child: Text("otp: " + (widget.tableMaster.joinOTP ?? "") ?? "", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),))
//         ],
//       ),
//       body: Stack(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       child: ListView(
//                         padding: EdgeInsets.fromLTRB(0,2,0,2),
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           ElevatedButton(onPressed: () {
//                             Navigator.push(context, MaterialPageRoute(
//                                 builder: (BuildContext context) {
//                                   return MenuScreen(tableNo: "",);
//                                 }));
//                           }, child: Text("Order")),
//                           SizedBox(width: 6,),
//                           ElevatedButton(onPressed: () {}, child: Text("View Bill")),
//                           SizedBox(width: 6,),
//                           ElevatedButton(onPressed: () {}, child: Text("Switch Table")),
//                           SizedBox(width: 6,),
//                           ElevatedButton(onPressed: () {}, child: Text("LoggedIn Users")),
//                         ],
//                       ),
//                       height: 40,
//                     ),
//                     Card(
//                       child: Padding(
//                         padding:
//                         const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "User: ",
//                                       style: TextStyle(fontWeight: FontWeight.bold),
//                                     ),
//                                     Text(widget.tableMaster?.occupiedName ?? ""),
//                                   ],
//                                 ),
//
//                                 Text(widget.tableMaster?.occupiedPh ?? ""),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Staff: ",
//                                       style: TextStyle(fontWeight: FontWeight.bold),
//                                     ),
//                                     Text(widget.tableMaster?.assignedStaffName ?? ""),
//                                   ],
//                                 ),
//
//                                 Text(widget.tableMaster?.assignedStaffPh ?? ""),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 children: [
//                   Consumer<OrdersProvider>(builder: (context, orders, child) {
//                       return tabselection(orders: orders);
//                     }
//                   )
//                 ],
//               )
//             ],
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Container(
//               margin: EdgeInsets.fromLTRB(2, 10, 2, 5),
//               height: 40,
//               width: double.infinity,
//               decoration: new BoxDecoration(
//                   borderRadius: BorderRadius.circular(0),
//                   color: Colors.black87
//               ),
//               child: TextButton(
//
//                 child: new Text('Clean the Table', style: TextStyle(color: Colors.white),),
//                 onPressed: () {
//                   CleanTheTable(context);
//                 },
//               ),
//             ),
//           ),
//           Consumer<GlobalProvider>(builder: (context, global, child){
//             print(global.error);
//             return LoadingScreen(isBusy: global.isBusy,error: global?.error ?? "", onPressed: (){},);
//           })
//         ],
//       )
//     );
//   }
//
//
//   Future<void> CleanTheTable(BuildContext context) async {
//     widget.tableMaster.joinOTP = null;
//     widget.tableMaster.assignedStaffId = null;
//     widget.tableMaster.occupiedPh = null;
//     widget.tableMaster.occupiedName = null;
//     widget.tableMaster.occupiedBy = null;
//
//     widget.tableMaster.assignedStaffPh = null;
//     widget.tableMaster.assignedStaffName = null;
//     widget.tableMaster.isOccupied = false;
//     widget.tableMaster.isReserved = false;
//     widget.tableMaster.from = "clean";
//
// // not using
//     await Provider.of<TablesProvider>(context, listen: false)
//         .UpdateTable(widget.tableMaster, context);
//
//     Navigator.pop(context);
//   }
// }
//
// class tabselection extends StatelessWidget{
//   final OrdersProvider orders;
//   // final Function onAccept;
//   // final Function onCancel;
//
//   const tabselection({super.key, required this.orders});
//
//   @override
//   Widget build(BuildContext context){
//     return DefaultTabController(
//       length: 4,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Container(
//             width: double.infinity,
//             height: 40,
//             child:
//             TabBar(isScrollable: true,
//                 padding: EdgeInsets.zero,
//                 // labelPadding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
//                 indicatorColor: Colors.black87,
//                 tabs: [
//                   Tab(
//                     child: Badge(
//                       child: Text("Pending"),
//                       offset: Offset(12, -9),
//                       alignment: Alignment.topRight,
//                       label: Text((orders.pending_orders?.length.toString()) ?? ""),
//                     ),
//                   ),
//
//                   Tab(
//                     child: Badge(
//                       child: Text("In Progress"),
//                       offset: Offset(12, -9),
//                       backgroundColor: Colors.green,
//                       alignment: Alignment.topRight,
//                       label: Text((orders.inprogress_orders?.length.toString()) ?? ""),
//                     ),
//                   ),
//                   Tab(text: "Completed"),
//                   Tab(text: "All"),
//                 ]),
//           ),
//           Container(
//             //Add this to give height
//             height: MediaQuery.of(context).size.height - 240,
//             child: TabBarView(children: [
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                 child: _itemList(orders: orders.pending_orders, from: 'pending',),
//               ),
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                 child: _itemList(orders: orders.inprogress_orders, from: 'in_progress',),
//               ),
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                 child: _itemList(orders: orders.completedOrders, from: 'completed',),
//               ),
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                 child: _itemList(orders: orders.merged_orders, from: 'all',),
//               ),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class _itemList extends StatelessWidget {
//   final List<Orders>? orders;
//   final String from;
//   // final Function onCancel;
//
//   const _itemList(
//       {super.key, required this.orders, required this.from});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         ListView.builder(
//             scrollDirection: Axis.vertical,
//             shrinkWrap: true,
//             padding: EdgeInsets.fromLTRB(0, 0, 0, 45),
//             itemCount: orders?.length ?? 0,
//             itemBuilder: (context, index) {
//               return Column(
//                 children: [
//                   Table(
//                     defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                     border: TableBorder(bottom: BorderSide(width: 1,
//                         color: Colors.grey.shade300,
//                         style: BorderStyle.solid)),
//                     columnWidths: from == "pending" || from == "in_progress" ? const {
//                       0: FlexColumnWidth(6),
//                       1: FlexColumnWidth(1),
//                       2: FlexColumnWidth(2),
//                       3: FlexColumnWidth(3)
//                     }:
//                     from == "completed" ?
//                     const {
//                       0: FlexColumnWidth(6),
//                       1: FlexColumnWidth(1),
//                       2: FlexColumnWidth(2),
//                       3: FlexColumnWidth(2)
//                     }:
//                     const {
//                       0: FlexColumnWidth(6),
//                       1: FlexColumnWidth(1),
//                       2: FlexColumnWidth(2),
//                     },
//                     children: [
//                       TableRow(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     orders?[index].itemName ?? "", style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.grey.shade800),),
//                                   orders?[index].varName != null
//                                       ? Text(orders?[index].varName ?? "",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w100, fontSize: 11),)
//                                       : Container()
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
//                               child: Text(
//                                 "X" + (orders?[index].quantity.toString() ?? "") ??
//                                     "", style: TextStyle(fontSize: 13.0),),
//                             ),
//
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
//                               child: Text(orders?[index].price.toString() ?? "",
//                                   style: TextStyle(fontSize: 12.0),
//                                   textAlign: TextAlign.end),
//                             ),
//                             from != "all" ? Padding(
//                               padding: const EdgeInsets.fromLTRB(8, 5, 0, 8),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   InkWell(
//                                       child: Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 4, horizontal: 1),
//                                         child: Icon(Icons.delete_outline,
//                                           color: Colors.red.shade400,),
//                                       ),
//                                       onTap: () => {
//                                         showDialog(
//                                           context: context,
//                                           builder: (context) => CancelItemDialog(order: orders![index]),
//                                         )
//                                       }
//                                   ),
//                                   from == "pending" || from == "in_progress" ? SizedBox(width: 10,): Container(),
//                                   from == "pending" || from == "in_progress" ?  InkWell(
//                                       child: Container(
//
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 6, horizontal: 4),
//                                             child: Icon(Icons.done,
//                                               color: Colors.green.shade500,),
//                                           )
//                                       ),
//                                       onTap: () =>
//                                       {
//                                         onAcceptPending(orders![index], context, from)
//                                       }
//                                   ) : Container(),
//                                   SizedBox(width: 6,),
//
//                                 ],
//                               ),
//                             ): Container(),
//                           ],
//                       decoration: BoxDecoration(
//                         color: orders?[index]?.status == "cancelled" ? Colors.red.shade200 : Colors.transparent
//                       )),
//                     ],
//                   ),
//                 ],
//               );
//             }),
//         (from == "pending" || from =="in_progress") && (orders?.length ?? 0) > 0 ? Align(
//           alignment: Alignment.bottomRight,
//           child: ElevatedButton(
//             onPressed: () {
//               onAcceptAll(orders, context, from);
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green.shade500
//             ),
//             child: Text("Accept All", style: TextStyle(color: Colors.white),)
//           ),
//         ): Container()
//       ],
//     );
//   }
//
//   onAcceptPending(Orders order, BuildContext context, String from) {
//     print("on accept pending");
//     if(from == "pending"){
//       order.status = "in_progress";
//     }else if(from == "in_progress"){
//       order.status = "completed";
//     };
//     List<Orders> orders = [];
//     orders.add(order);
//    // Provider.of<OrdersProvider>(context, listen: false).UpdateOrder(orders, context, order.ordersId ?? "", order.tableNo ?? "");
//   }
//
//   onAcceptAll(List<Orders>? orders, BuildContext context, String from) {
//     orders?.forEach((element) {
//       if(from == "pending"){
//         element.status = "in_progress";
//       }else if(from == "in_progress"){
//         element.status = "completed";
//       };
//     });
//     //Provider.of<OrdersProvider>(context, listen: false).UpdateOrder(orders, context, orders?[0].ordersId ?? "", orders?[0].tableNo ?? "", orders);
//   }
//
//
// }
//
//
// class CancelItemDialog extends StatefulWidget {
//   final Orders order;
//   const CancelItemDialog({super.key, required this.order});
//
//   @override
//   State<CancelItemDialog> createState() => _CancelItemDialogState();
// }
//
// class _CancelItemDialogState extends State<CancelItemDialog> {
//   String? reason = "User ordered by mistake";
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           child: AlertDialog(
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Do you want to cancel", style: TextStyle(fontSize: 16),),
//                 Text(widget.order.itemName ?? "", style: TextStyle(color: Colors.grey, fontSize: 14),)
//               ],
//             ),
//             content: Container(
//               height: 130,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Radio(value: "User ordered by mistake", materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, groupValue: reason, onChanged: (value){
//                           setState(() {
//                             reason = value.toString();
//                           });
//                         }),
//                         Text("User selected by mistake")
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Radio(value: "Not available", materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, groupValue: reason, onChanged: (value){
//                           setState(() {
//                             reason = value.toString();
//                           });
//                         }),
//                         Text("Not available")
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Radio(value: "Wrongly listed in menu", materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,groupValue: reason, onChanged: (value){
//                           setState(() {
//                             reason = value.toString();
//                           });
//                         }),
//                         Text("Wrongly listed in menu")
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//
//             contentPadding: EdgeInsets.zero,
//             actions: [
//               TextButton(
//                 style: TextButton.styleFrom(
//                     tapTargetSize: MaterialTapTargetSize.shrinkWrap
//                 ),
//                 onPressed: () {
//                     Navigator.pop(context);
//                 },
//                 child: Text('Cancel'),
//               ),
//               TextButton(
//                 style: TextButton.styleFrom(
//                     tapTargetSize: MaterialTapTargetSize.shrinkWrap
//                 ),
//                 onPressed: () {
//                     OnCancelledItem(widget.order, reason!);
//                 },
//                 child: Text('Ok'),
//               ),
//             ],
//           ),
//         ),
//         Consumer<GlobalProvider>(builder: (context, global, child){
//           print(global.error);
//           return LoadingScreen(isBusy: global.isBusy,error: global?.error ?? "", onPressed: (){},);
//         })
//
//       ],
//     );
//   }
//
//   Future<void> OnCancelledItem(Orders order, String remark) async {
//
//     Users? user = Provider.of<NetworkProvider>(context, listen: false).users;
//     order.status = "cancelled";
//     order.cancelledById = user?.id;
//     order.cancelledByName = user?.name;
//     order.remarks = remark;
//     List<Orders> orders = [];
//     orders.add(order);
//     //await Provider.of<OrdersProvider>(context, listen: false).UpdateOrder(orders, context, order.ordersId ?? "", order.tableNo ?? "");
//     Navigator.pop(context);
//   }
// }
//
//
//
