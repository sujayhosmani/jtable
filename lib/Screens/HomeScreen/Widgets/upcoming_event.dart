import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/Utils.dart';

import 'headings_home.dart';

class UpcomingEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12,0,12,12),
        child: Column(
          children: [
            HeadingTitle(label: "Upcoming events", onTap: (){print("");},),
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(height: 200,width: double.infinity, fit: BoxFit.cover, imageUrl: profileUrl,)
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: Utils.storyGradient
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Parents Meeting", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),),
                        SizedBox(height: 3,),
                        Text("16 Aug 2020 | 10:17 am", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),),
                        SizedBox(height: 20,),
                        Text("Know More", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 16),),
                      ],
                    ),
                  ),
                )

              ],
            )

          ],
        ),
      ),
    );
  }
}
