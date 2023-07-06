import 'package:flutter/material.dart';
import 'package:jtable/Screens/HomeScreen/Widgets/headings_home.dart';


class MainTitles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            HeadingTitle(label: "All Tables", onTap: (){print("");},),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainCard(label: "View Tables",imgUrl: "story.png",),

              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}



class MainCard extends StatelessWidget {
  final String? imgUrl;
  final String? label;

  const MainCard({Key? key, this.imgUrl, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: (){},
        child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)), elevation: 2,
            child:
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(

                child: Row(
                  children: [
                    Image(image:  AssetImage("assets/images/" + imgUrl!), height: 30,),
                    SizedBox(width: 13,),
                    Text(label!, style: TextStyle(fontSize: 16),)
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios)

            ],
          ),
        )),
      ),
    );
  }
}
