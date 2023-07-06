import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/Utils.dart';
import 'package:jtable/Screens/HomeScreen/Widgets/headings_home.dart';


class AssignmentWig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12,0,12,2),
            child: HeadingTitle(label: "Assignment",color: Utils.fromHex("#F67B5A"), onTap: (){print("");},),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {0: FractionColumnWidth(0.3)},
            border: TableBorder.all(width: 0.5),
            children: [
              for(int i = 0; i < 6; i++)
                TableRow(
                    children: [
                      Center(child: Text("Kannada")),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("dsgfdfg dfgf"),
                      ),


                    ]
                )
            ],
          )

        ],
      ),
    );
  }
}
