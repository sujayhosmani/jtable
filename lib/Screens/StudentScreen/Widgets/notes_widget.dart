import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/Utils.dart';
import 'package:jtable/Screens/HomeScreen/Widgets/headings_home.dart';


class NotesWig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12,0,12,2),
            child: HeadingTitle(label: "Notes",color: Utils.fromHex("#F67B5A"), onTap: (){print("");},),
          ),
          Container(
            height: 130,
            width: double.infinity,
            child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8,0,8,12),
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                      width: 205,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
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
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(height: double.infinity,width: double.infinity, fit: BoxFit.cover, imageUrl: profileUrl,)
        ),
        Container(
          height: double.infinity,
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
                Text("Kannada", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 16),),
              ],
            ),
          ),
        )

      ],
    );
  }
}