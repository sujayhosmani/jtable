import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:provider/provider.dart';


class ParentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Container(
                  color: Colors.blueGrey,
                  height: 75,
                  width: 75,
                  child: Center(child: Text("SU", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),)),
                )
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Siddaraju", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                Text("8553655890"),
                Text("Staff")
              ],
            )

          ],
        ),
      ),
    );
  }
}
