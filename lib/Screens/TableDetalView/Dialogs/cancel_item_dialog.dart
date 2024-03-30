

import 'package:flutter/material.dart';
import 'package:jtable/Models/Orders.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Screens/Providers/global_provider.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:jtable/Screens/Providers/orders_provider.dart';
import 'package:jtable/Screens/shared/loading_screen.dart';
import 'package:provider/provider.dart';

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