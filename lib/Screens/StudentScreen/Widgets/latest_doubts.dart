import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/Utils.dart';
import 'package:jtable/Screens/HomeScreen/Widgets/headings_home.dart';



class LatestDoubts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12,0,12,6),
            child: HeadingTitle(label: "Assigned Tables",color: Utils.fromHex("#F67B5A"), onTap: (){print("");},),
          ),
          Container(
            height: 120,
            width: double.infinity,
            child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8,0,8,12),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                      width: 220,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Material(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade100, child: InkWell(customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: _Issues(), onTap: () => print("sdv"),)),
                      )
                  );
                }),
          )

        ],
      ),
    );
  }
}

class _Issues extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        // color: Colors.grey.shade100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: double.infinity,
              width: 5,
              color: Colors.orange.shade600,
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 6, 6, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Table G-15", style: TextStyle(fontWeight: FontWeight.w600),),

                            ],
                          ),
                        ],
                      ),
                    ),

                    // Container(
                    //     child: Padding(
                    //       padding: const EdgeInsets.fromLTRB(0,6,0,0),
                    //       child: Padding(
                    //         padding: const EdgeInsets.fromLTRB(8.0,0,8,8),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //           children: [
                    //             Container(
                    //               padding: EdgeInsets.symmetric(horizontal: 5),
                    //               decoration: BoxDecoration(
                    //                   color: Colors.green.shade200,
                    //                   borderRadius: BorderRadius.circular(2)),
                    //               child: Text("3"),
                    //             ),
                    //             SizedBox(width: 6,),
                    //             Container(
                    //               padding: EdgeInsets.symmetric(horizontal: 5),
                    //               decoration: BoxDecoration(
                    //                   color: Colors.orange.shade200,
                    //                   borderRadius: BorderRadius.circular(2)),
                    //               child: Text("3"),
                    //             ),
                    //             SizedBox(width: 6,),
                    //             Container(
                    //               padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    //               decoration: BoxDecoration(
                    //                   color: Colors.red.shade200,
                    //                   borderRadius: BorderRadius.circular(2)),
                    //               child: Text("3"),
                    //             )
                    //           ],
                    //         ),
                    //       )
                    //     )),

                  ],
                ),
                Divider(height: 5),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,0,8,8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6,),
                      Text("Sujay HS", style: TextStyle(fontWeight: FontWeight.w500),),
                      Text("8553555890", style: TextStyle(fontSize: 10)),
                      Text("5 Pax", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10),)
                    ],
                  ),
                ),


              ],
            ))
          ],
        ),
      ),
    );
  }
}

