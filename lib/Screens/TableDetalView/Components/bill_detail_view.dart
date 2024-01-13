import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillDetailViewScreen extends StatefulWidget {
  const BillDetailViewScreen({super.key});

  @override
  State<BillDetailViewScreen> createState() => _BillDetailViewScreenState();
}

class _BillDetailViewScreenState extends State<BillDetailViewScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                    Align(alignment: Alignment.centerLeft,child: Text("Bill Details", style: TextStyle(fontSize: 16),)),
                    SizedBox(height: 5,),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Phone No :",
                              style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                          ),
                          flex: 1, ),
                        Expanded(
                          child: Container(
                              child: Text("1234567890",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),),
                              alignment: Alignment.centerLeft),
                          flex: 4,),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Order Id :",
                              style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                          ),
                          flex: 1,),
                        Expanded(
                          child: Container(
                              child: Text("4244",
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
              Container(
                margin: EdgeInsets.only(top: 0,bottom: 10,left: 10,right: 10),
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
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                            ),
                            flex: 1),
                        Expanded(
                          child: Container(
                              child: Text("12321",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),),
                              alignment: Alignment.centerLeft),
                          flex: 1, ),

                        Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text("Date :",
                                style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                            ),
                            flex: 1),
                        Expanded(
                          child: Container(
                              child: Text("13/11/2024",
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
                              child: Text("Bill No :",
                                style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                            ),
                            flex: 1),
                        Expanded(
                          child: Container(
                              child: Text("534",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),),
                              alignment: Alignment.centerLeft),
                          flex: 1, ),

                        Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text("Time :",
                                style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                            ),
                            flex: 1),
                        Expanded(
                          child: Container(
                              child: Text("06:55",
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
                              child: Text("Guests :",
                                style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                            ),
                            flex: 1),
                        Expanded(
                          child: Container(
                              child: Text("6",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),),
                              alignment: Alignment.centerLeft),
                          flex: 1, ),

                        Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text("Amount :",
                                style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.red,),),
                            ),
                            flex: 1),
                        Expanded(
                          child: Container(
                              child: Text("15625",
                                style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.red,),),
                              alignment: Alignment.centerRight),
                          flex: 1, ),







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

                margin: EdgeInsets.only(top: 0,bottom: 5,left: 10,right: 10),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                            child: Text("ITEM " ,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.black54),),
                            alignment: Alignment.centerLeft),
                        flex: 2),
                    SizedBox(width: 2),

                    Expanded(
                        child: Container(
                            child: Text("QTY",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.black54),),
                            alignment: Alignment.center),
                        flex: 1),
                    SizedBox(width: 2),
                    Expanded(
                        child: Container(
                            child: Text("Amount",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.black54),),
                            alignment: Alignment.center),
                        flex: 1),



                  ],
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, int index) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 0,bottom: 10,left: 10,right: 10),

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
                                    child: Text("Mutton Pepper Fry " ,
                                      style: TextStyle(
                                          fontSize: 12, fontWeight: FontWeight.w400,color: Colors.black),),
                                    alignment: Alignment.centerLeft),
                                flex: 2),
                            SizedBox(width: 2),

                            Expanded(
                                child: Container(
                                    child: Text("X2",
                                      style: TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.w400,color: Colors.black),),
                                    alignment: Alignment.center),
                                flex: 1),
                            SizedBox(width: 2),
                            Expanded(
                                child: Container(
                                    child: Text("123",
                                      style: TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.w400,color: Colors.black),),
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
                margin: EdgeInsets.only(top: 10,bottom: 15,left: 10,right: 10),


                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Sub Total",
                            style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                        ),
                        Container(
                            child: Text("12345",
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
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                        ),
                        Container(
                            child: Text("12345",
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
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                        ),
                        Container(
                            child: Text("12345",
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
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                        ),
                        Container(
                            child: Text("12345",
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
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                        ),
                        Container(
                            child: Text("12345",
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
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.red,),),
                        ),
                        Container(
                            child: Text("12345",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.red),),
                            alignment: Alignment.centerLeft),
                      ],
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),

    );
  }
}
