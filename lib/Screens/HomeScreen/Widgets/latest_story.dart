import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/Utils.dart';

import 'headings_home.dart';

class LatestStory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12,0,12,0),
            child: HeadingTitle(label: "Latest Stories", onTap: (){print("");},),
          ),
          Container(
            height: 190,
            width: double.infinity,
            child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8,0,8,12),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                      width: 130,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _Stories(),
                      )
                  );
                }),
          )

        ],
      ),
    );
  }
}

class _Stories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(imageUrl: demoUrl,height: double.infinity,
          width: double.infinity,fit:BoxFit.cover),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: Utils.storyGradient,
            borderRadius: BorderRadius.circular(12)
          ),
        ),
        Positioned(
          bottom: 8,
            left: 8,
            right: 8,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sujay hosmani ", maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
            SizedBox(height: 2,),
            Text("class 2nd", style: TextStyle(color: Colors.white70,),),
          ],
        ))
      ],
    );
  }
}

