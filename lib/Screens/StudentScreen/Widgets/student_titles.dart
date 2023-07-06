import 'package:flutter/material.dart';
import 'package:jtable/Screens/HomeScreen/Widgets/main_cards.dart';
import 'package:jtable/Screens/HomeScreen/Widgets/main_cards.dart';


class StuTitles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainCard(label: "Marks",imgUrl: "marks.png",),
                SizedBox(width: 5,),
                MainCard(label: "Time Table",imgUrl: "timetable.png",),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainCard(label: "Exams",imgUrl: "examtt.png",),
                SizedBox(width: 5,),
                MainCard(label: "Attendance",imgUrl: "attendance.png",),
              ],
            )
          ],
        ),
      ),
    );
  }
}