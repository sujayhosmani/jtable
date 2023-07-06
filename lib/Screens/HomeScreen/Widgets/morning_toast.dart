import 'package:flutter/material.dart';

class MorningToast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.orangeAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image(image: AssetImage("assets/images/sun_img.png"), height: 25,),
                SizedBox(width: 10,),
                Center(child: Text("Important News", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),))
              ],
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0,8,8,0),
              child: Text("Education is the key to success in life, and teachers make a lasting impact in the lives of their students."),
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
