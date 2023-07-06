import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Constants.dart';

import 'headings_home.dart';


class LatestIssues extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12,0,12,0),
            child: HeadingTitle(label: "Latest Issues", onTap: (){print("");},),
          ),
          Container(
            height: 168,
            width: double.infinity,
            child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8,0,8,12),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                      width: 320,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _Issues(),
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
        color: Colors.green.shade100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: double.infinity,
              width: 7,
              color: Colors.green.shade600,
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CachedNetworkImage(imageUrl: profileUrl,height: 45,width: 45, fit:BoxFit.cover),
                          ),
                          SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Siddaraju", style: TextStyle(fontWeight: FontWeight.w600),),
                              Text("16 oct 2020", style: TextStyle(fontSize: 11),),
                              SizedBox(height: 6,)
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Resolved", style: TextStyle(fontSize: 12, color: Colors.white70),),
                        )),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,0,8,8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Parents of Class Nursery - 7", style: TextStyle(fontWeight: FontWeight.w600),),
                      SizedBox(height: 10,),
                      Text("hing impact in the lives of their studentsasf asf as fsa d sf sdf sd f sdf sd f sdf sd fs df sdf sd f sdf sdf sd f sdf sd fs df sdf s df sdf sdf  sdf  dffsdfsdfsdf sd f sd", maxLines: 3, overflow: TextOverflow.ellipsis,)
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

