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
            SizedBox(width: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Hi"),
                SizedBox(width: 5,),
                Consumer<NetworkProvider>(
                  builder: (context, user, child) {
                    return Text(user.users?.name ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),);
                  }
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
