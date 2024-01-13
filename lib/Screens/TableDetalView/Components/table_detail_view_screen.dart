import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TableDetailViewScreen extends StatefulWidget
{
  const TableDetailViewScreen({super.key});

  @override
  State<TableDetailViewScreen> createState() => _TableDetailViewScreenState();
}

class _TableDetailViewScreenState extends State<TableDetailViewScreen>
{
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
                            child: Text("OTP : 123456",
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
                          child: Text("TRRR ",
                            style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.black54,),),
                        ),
                        Container(
                          child: Text("Vikas",
                            style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.black54, ),),
                        ),








                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text("1234567",
                            style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.black54,),),
                        ),
                        Container(
                          child: Text("8675345232",
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
                              child: Text("12321",
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
                              child: Text("534",
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
                              child: Text("Total Mins :",
                                style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                            ),
                            flex: 1),
                        Expanded(
                          child: Container(
                              child: Text("107 hr 13 min",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),),
                              alignment: Alignment.centerLeft),
                          flex: 2, ),

                        Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text("Is Running :",
                                style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                            ),
                            flex: 1),
                        Expanded(
                          child: Container(
                              child: Text("True",
                                style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold,color: Colors.grey,),),
                              alignment: Alignment.centerRight),
                          flex: 1, ),







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
                                    child: Text("1234567890",
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
                                    child: Text("4244",
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
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, int index) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),

                    //margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1
                        ),
                        color: Colors.greenAccent.shade100,
                        borderRadius: BorderRadius.circular(5)
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
                                    Text("TRR True",),
                                    Text("123456fsdf7"),
                                  ],
                                )



                              ],
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MaterialButton(
                                  onPressed: () {

                                  },
                                  color: Colors.purple,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  minWidth:30,
                                  child: Text("User" ,style: TextStyle(fontSize:16,fontWeight: FontWeight.bold,color: Colors.white),),
                                ),
                                SizedBox(width: 3,),
                                MaterialButton(
                                  minWidth:30,
                                  onPressed: () {

                                  },
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text("Joined" ,style: TextStyle(fontSize:16,fontWeight: FontWeight.bold,color: Colors.white),),
                                ),



                              ],
                            ),
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



            ],
          ),
        ),
      ),

    );
  }
}
