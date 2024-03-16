import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtable/Models/Logged_in_users.dart';
import 'package:jtable/Models/Orders.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Screens/Providers/logged_inProvider.dart';
import 'package:jtable/Screens/Providers/menu_provider.dart';
import 'package:provider/provider.dart';

class TableDetailViewScreen extends StatefulWidget
{
  final TableMaster tableMaster;
  final Orders? orderDetails;
  const TableDetailViewScreen({super.key, required this.tableMaster, this.orderDetails});

  @override
  State<TableDetailViewScreen> createState() => _TableDetailViewScreenState();
}

class _TableDetailViewScreenState extends State<TableDetailViewScreen>
{
  late TableMaster finalTable;
  late Orders? orderDetails;

  @override
  void initState() {
    super.initState();
    finalTable = widget.tableMaster;
    orderDetails = widget.orderDetails;

    if((Provider.of<LoggedInProvider>(context, listen: false).loggedInUserForTable?.length ?? 0) == 0){
      getLoggedInUsers(); // fff
    }


  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          //margin: EdgeInsets.all(5),
          //padding: EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(5)
          ),
          child: Column(
            children: [

              Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Table Details :",
                            style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black54,),),
                        ),
                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    width: 1
                                )
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text("OTP : " + (finalTable.joinOTP ?? ""),
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),)),
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
                margin: EdgeInsets.all(5),
                child:
                Column(
                  children: [


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text("Occupied user ",
                            style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.black54,),),
                        ),
                        Container(
                          child: Text("Assigned Staff",
                            style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.black54, ),),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(finalTable.occupiedName ?? "",
                            style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.black54,),),
                        ),
                        Container(
                          child: Text(finalTable.assignedStaffName ?? "",
                            style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.black54, ),),
                        ),








                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(finalTable.occupiedPh ?? "",
                            style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.black54,),),
                        ),
                        Container(
                          child: Text(finalTable.assignedStaffPh ?? "",
                            style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.black54, ),),
                        ),

                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 3,
                    ),

                  ],
                ),


              ),
              Container(
                margin: EdgeInsets.all(5),
                child:
                Column(
                  children: [


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Total Pax :",
                                style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                            ),
                            flex: 1),
                        Expanded(
                          child: Container(
                              child: Text("" + (finalTable.noOfPeople ?? 0).toString(),
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),),
                              alignment: Alignment.centerLeft),
                          flex: 1, ),

                        Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text("Is Paid :",
                                style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                            ),
                            flex: 2),
                        Expanded(
                          child: Container(
                              child: Text("No",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),),
                              alignment: Alignment.centerRight),
                          flex: 1, ),







                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Total Bill :",
                                style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                            ),
                            flex: 1),
                        Expanded(
                          child: Container(
                              child: Text("" + (finalTable.totalBill ?? 0).toString(),
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),),
                              alignment: Alignment.centerLeft),
                          flex: 1, ),

                        Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text("Is Printed :",
                                style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                            ),
                            flex: 2),
                        Expanded(
                          child: Container(
                              child: Text((finalTable.isPrinted ?? 0) > 0 ? "Yes" : "No",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),),
                              alignment: Alignment.centerRight),
                          flex: 1, ),







                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Total Mins :",
                                style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                            ),
                            flex: 1),
                        Expanded(
                          child: Container(
                              child: Text(finalTable.duration ?? "",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),),
                              alignment: Alignment.centerLeft),
                          flex: 2, ),









                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 3,
                    ),
                    SizedBox(height: 5,),
                    Container(
                      child: Column(
                        children: [

                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Order Id :",
                                    style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                                ),
                                flex: 1, ),
                              Expanded(
                                child: Container(
                                    child: Text(orderDetails?.ordersId ?? "",
                                      style: TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.bold),),
                                    alignment: Alignment.centerLeft),
                                flex: 2,),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Order Id 2:",
                                    style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                                ),
                                flex: 1,),
                              Expanded(
                                child: Container(
                                    child: Text(orderDetails?.orderIdInt ?? "",
                                      style: TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.bold),),
                                    alignment: Alignment.centerLeft),
                                flex: 2, ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Current Order :",
                                    style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                                ),
                                flex: 2,),
                              Expanded(
                                child: Container(
                                    child: Text((orderDetails?.orderNo ?? 0).toString() ?? "",
                                      style: TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.bold),),
                                    alignment: Alignment.centerLeft),
                                flex: 4, ),
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



                  ],
                ),


              ),


              Container(

                margin: EdgeInsets.all(5),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                            child: Text("Logged In users " ,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),),
                            alignment: Alignment.centerLeft),
                        flex: 2),
                    SizedBox(width: 2),




                  ],
                ),
              ),
        Consumer<LoggedInProvider>(builder: (context, loginProvider, child){
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: loginProvider.loggedInUserForTable?.length ?? 0,
            itemBuilder: (context, int index) {
              LoggedInUsers? user = loginProvider.loggedInUserForTable?[index];
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(5),

                //margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.1
                  ),
                  color: (user?.isFirst ?? false) ? Colors.greenAccent.shade100 : Colors.transparent,
                ),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text("1.",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(width: 12,),
                            Column(
                              children: [
                                Text(user?.name ?? "",),
                              ],
                            )



                          ],
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Text(user?.phone ?? "")


                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              );
            },

          );
        }),



            ],
          ),
        ),
      ),

    );
  }

  void getLoggedInUsers() {
    Provider.of<LoggedInProvider>(context, listen: false).GetLoggedInUserTableId(finalTable.id ?? "", context);
  }
}
