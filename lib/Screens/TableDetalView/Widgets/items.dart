import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jtable/Models/Orders.dart';
import 'package:jtable/Screens/Providers/orders_provider.dart';
import 'package:jtable/Screens/TableDetalView/Dialogs/cancel_item_dialog.dart';
import 'package:provider/provider.dart';

class ItemList extends StatelessWidget {
  final List<Orders>? orders;
  final String from;
  // final Function onCancel;

  const ItemList(
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
    Provider.of<OrdersProvider>(context, listen: false).UpdateOrderNormal(orders, context, order.ordersId ?? "", order.tableNo ?? "");
  }




}