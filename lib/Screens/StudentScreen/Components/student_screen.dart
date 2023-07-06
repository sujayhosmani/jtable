import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Utils.dart';
import 'package:jtable/Screens/HomeScreen/Widgets/main_cards.dart';
import 'package:jtable/Screens/HomeScreen/Widgets/morning_toast.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/assignment_wig.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/final_time_table.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/latest_doubts.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/notes_widget.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/rank_widget.dart';
import 'package:jtable/Screens/StudentScreen/Widgets/student_titles.dart';

class StudentProfile extends StatefulWidget {
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Utils.peach,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("Sujay HS"),
                  Text("Class 4th BSec"),
                ],
              ),
            ),
            MorningToast(),
            SizedBox(height: 8,),
            //RankWig(),
            SizedBox(height: 8,),
            AssignmentWig(),
            SizedBox(height: 8,),
            NotesWig(),
            SizedBox(height: 8,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              width: double.infinity,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // gradient: Utils.btnGradient,
                color: Utils.fromHex("#DA1345")
              ),
              child: TextButton(

                child: new Text('List of holidays', style: TextStyle(color: Colors.white),),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 8,),
            LatestDoubts(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 45,
              width: double.infinity,
              decoration: new BoxDecoration(
                  gradient: Utils.btnGradient,
              ),
              child: TextButton(
                child: new Text('Have a doubt? Ask', style: TextStyle(color: Colors.white),),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 8,),
            StuTitles(),
            SizedBox(height: 8,),
            FinalTimeTable(),
            SizedBox(height: 32,),

          ],
        ),
      ),
    );
  }
}
