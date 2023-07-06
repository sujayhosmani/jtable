import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Constants.dart';

import 'headings_home.dart';


class LatestAnnouncement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12,0,12,0),
            child: HeadingTitle(label: "Latest Announcements", onTap: (){print("");},),
          ),
          Container(
            height: 162,
            width: double.infinity,
            child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8,0,8,8),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                      width: 320,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _Announcement(),
                      )
                  );
                }),
          )

        ],
      ),
    );
  }
}

class _Announcement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.grey.shade100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: double.infinity,
              width: 7,
              color: Colors.orange.shade600,
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                              Text("Sulochana", style: TextStyle(fontWeight: FontWeight.w600),),
                              Text("Class Teacher of 4th B", style: TextStyle(fontSize: 11),),
                              SizedBox(height: 6,)
                            ],
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("16 oct 2020", style: TextStyle(fontSize: 11),),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,0,8,8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Parents of Class Nursery - 7", style: TextStyle(fontWeight: FontWeight.w600),),
                      SizedBox(height: 10,),
                      Text("hing impact in the lives of their students asf sdf sdf sdf sdf sd fs df sdf sdf sd f sdf sdf sd fsd fsdfsdf sdf sdf sd fsdf sdf sdf sdf sdf sdf ", maxLines: 3, overflow: TextOverflow.ellipsis,)
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

