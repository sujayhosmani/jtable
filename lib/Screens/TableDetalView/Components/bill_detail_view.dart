import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtable/Models/Orders.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Screens/Providers/orders_provider.dart';
import 'package:provider/provider.dart';

class BillDetailViewScreen extends StatefulWidget {
  final TableMaster tableMaster;
  final List<Orders>? orderDetails;
  const BillDetailViewScreen({super.key, required this.tableMaster, this.orderDetails});

  @override
  State<BillDetailViewScreen> createState() => _BillDetailViewScreenState();
}

class _BillDetailViewScreenState extends State<BillDetailViewScreen>
{

  late TableMaster selectedTable;
  late List<Orders>? orderDetails;


  @override
  void initState() {
    super.initState();
    selectedTable = widget.tableMaster;
    orderDetails = widget.orderDetails;


  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Container(
        color: Colors.white,
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
                child: Container(
                  constraints: BoxConstraints.expand(),
                  child: SingleChildScrollView(
                      child: Consumer<OrdersProvider>(builder: (context, orders, child){
                        selectedTable = orders.currentTable!;
                        orderDetails = (orders.orders?.length ?? 0) > 0 ? orders.orders : null;
                        Orders? order = (orders.orders?.length ?? 0) > 0 ? orders.orders?.first : null;
                        Orders? orderLast = (orders.orders?.length ?? 0) > 0 ? orders.orders?.last : null;
                        print(orderLast?.createdDateTime);
                        DateTime billDateTime = DateTime.parse(( orderLast?.createdDateTime) ?? "");
                        String billDate ="${billDateTime.day.toString().padLeft(2,'0')}/${billDateTime.month.toString().padLeft(2,'0')}/${billDateTime.year.toString()}";
                        String billTime ="${billDateTime.hour.toString().padLeft(2,'0')}:${billDateTime.minute.toString().padLeft(2,'0')}";
                        return Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Column(
                            children: [

                              Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Align(alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Bill Details", style: TextStyle(fontSize: 16),)),
                                    SizedBox(height: 5,),

                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Phone No :",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,),),
                                        ),
                                        Container(
                                            child: Text(selectedTable?.occupiedPh ?? "",
                                              style: TextStyle(
                                                  fontSize: 13, fontWeight: FontWeight.bold),),
                                            alignment: Alignment.centerLeft),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Order Id :",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,),),
                                          ),
                                          flex: 1,),
                                        Expanded(
                                          child: Container(
                                              child: Text((order?.orderIdInt ?? 0).toString() ?? "",
                                                style: TextStyle(
                                                    fontSize: 13, fontWeight: FontWeight.bold),),
                                              alignment: Alignment.centerLeft),
                                          flex: 4,),
                                      ],
                                    ),

                                    SizedBox(height: 5,),
                                    Divider(
                                      color: Colors.grey,
                                      height: 3,
                                    ),
                                    SizedBox(height: 5,),
                                  ],
                                ),

                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
                                child:
                                Column(
                                  children: [


                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Table No :",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,),),
                                            ),
                                            flex: 1),
                                        Expanded(
                                          child: Container(
                                              child: Text(selectedTable.tableNo ?? "",
                                                style: TextStyle(
                                                    fontSize: 13, fontWeight: FontWeight.bold),),
                                              alignment: Alignment.centerLeft),
                                          flex: 1,),

                                        Expanded(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Text("Date :",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,),),
                                            ),
                                            flex: 1),
                                        Expanded(
                                          child: Container(
                                              child: Text(billDate ?? "",
                                                style: TextStyle(
                                                    fontSize: 13, fontWeight: FontWeight.bold),),
                                              alignment: Alignment.centerRight),
                                          flex: 1,),


                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Bill No :",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,),),
                                            ),
                                            flex: 1),
                                        Expanded(
                                          child: Container(
                                              child: Text(order?.code.toString() ?? "",
                                                style: TextStyle(
                                                    fontSize: 13, fontWeight: FontWeight.bold),),
                                              alignment: Alignment.centerLeft),
                                          flex: 1,),

                                        Expanded(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Text("Time :",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,),),
                                            ),
                                            flex: 1),
                                        Expanded(
                                          child: Container(
                                              child: Text(billTime,
                                                style: TextStyle(
                                                    fontSize: 13, fontWeight: FontWeight.bold),),
                                              alignment: Alignment.centerRight),
                                          flex: 1,),


                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Guests :",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,),),
                                            ),
                                            flex: 1),
                                        Expanded(
                                          child: Container(
                                              child: Text((selectedTable.noOfPeople ?? 0).toString() ,
                                                style: TextStyle(
                                                    fontSize: 13, fontWeight: FontWeight.bold),),
                                              alignment: Alignment.centerLeft),
                                          flex: 1,),

                                        Expanded(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Text("Amount :",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,),),
                                            ),
                                            flex: 1),
                                        Expanded(
                                          child: Container(
                                              child: Text((selectedTable.totalBill ?? 0).toString(),
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,),),
                                              alignment: Alignment.centerRight),
                                          flex: 1,),


                                      ],
                                    ),


                                  ],
                                ),


                              ),
                              Divider(
                                color: Colors.grey,
                                height: 3,
                              ),
                              SizedBox(height: 5,),

                              Container(

                                margin: EdgeInsets.only(top: 0, bottom: 5, left: 5, right: 0),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Container(
                                            child: Text("ITEM ",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),),
                                            alignment: Alignment.centerLeft),
                                        flex: 4),

                                    Expanded(
                                        child: Container(
                                            child: Text("QTY",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),),
                                            alignment: Alignment.center),
                                        flex: 1),
                                    Expanded(
                                        child: Container(
                                            child: Text("Amount",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),),
                                            alignment: Alignment.center),
                                        flex: 1),


                                  ],
                                ),
                              ),
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: orders.merged_ordersExceptCancel?.length ?? 0,
                                itemBuilder: (context, int index) {
                                  Orders? itemOrder = orders.merged_ordersExceptCancel?[index];
                                  return Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        top: 0, bottom: 10, left: 5, right: 0),

                                    //margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                    decoration: BoxDecoration(
                                    ),

                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Container(
                                                    child: Text(itemOrder?.itemName ?? "",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.black),),
                                                    alignment: Alignment.centerLeft),
                                                flex: 4),

                                            Expanded(
                                                child: Container(
                                                    child: Text("X" + (itemOrder?.quantity ?? 0).toString(),
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.black),),
                                                    alignment: Alignment.center),
                                                flex: 1),
                                            Expanded(
                                                child: Container(
                                                    child: Text((itemOrder?.price ?? 0).toString(),
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.black),),
                                                    alignment: Alignment.center),
                                                flex: 1),


                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },

                              ),
                              Divider(
                                color: Colors.grey,
                                height: 3,
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 15, left: 10, right: 10),


                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Sub Total",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,),),
                                        ),
                                        Container(
                                            child: Text((selectedTable.subTotal ?? 0).toString(),
                                              style: TextStyle(
                                                  fontSize: 13, fontWeight: FontWeight.bold),),
                                            alignment: Alignment.centerLeft),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Service Charge",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,),),
                                        ),
                                        Container(
                                            child: Text((selectedTable.serviceCharge ?? 0).toString(),
                                              style: TextStyle(
                                                  fontSize: 13, fontWeight: FontWeight.bold),),
                                            alignment: Alignment.centerLeft),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Discount",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,),),
                                        ),
                                        Container(
                                            child: Text((selectedTable.discount ?? 0).toString(),
                                              style: TextStyle(
                                                  fontSize: 13, fontWeight: FontWeight.bold),),
                                            alignment: Alignment.centerLeft),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text("CGST",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,),),
                                        ),
                                        Container(
                                            child: Text((selectedTable.cgst ?? 0).toString(),
                                              style: TextStyle(
                                                  fontSize: 13, fontWeight: FontWeight.bold),),
                                            alignment: Alignment.centerLeft),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text("SGST",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,),),
                                        ),
                                        Container(
                                            child: Text((selectedTable.sgst ?? 0).toString(),
                                              style: TextStyle(
                                                  fontSize: 13, fontWeight: FontWeight.bold),),
                                            alignment: Alignment.centerLeft),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Divider(
                                      color: Colors.grey,
                                      height: 3,
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Total Bill",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,),),
                                        ),
                                        Container(
                                            child: Text((selectedTable.totalBill ?? 0).toString(),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),),
                                            alignment: Alignment.centerLeft),
                                      ],
                                    ),
                                  ],
                                ),
                              ),


                            ],
                          ),
                        );
                      })
                  ),
                )
            ),
            Container(
              height: 35,
              color: Colors.grey.shade100,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Total Bill",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,),),
                ),
                Container(
                    child: Text((selectedTable.totalBill ?? 0).toString(),
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),),
                    alignment: Alignment.centerLeft),
              ],
            ))
          ],
        ),
      )

    );
  }
}
