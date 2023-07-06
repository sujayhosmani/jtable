import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/Utils.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Screens/HomeScreen/Widgets/headings_home.dart';
import 'package:jtable/Screens/HomeScreen/Widgets/main_cards.dart';
import 'package:jtable/Screens/ViewTableScreen/table_view_screen.dart';


class AssignedTables extends StatelessWidget {
  final List<TableMaster>? tableMaster;
  final Function onPressed;

  const AssignedTables({Key? key, this.tableMaster, required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12,0,12,6),
            child: HeadingTitle(label: "Assigned Tables",color: Utils.fromHex("#F67B5A"), onTap: (){print("");},),
          ),
          Container(
            height: 156,
            width: double.infinity,
            child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8,0,8,12),
                itemCount: tableMaster?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                      width: 110,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: InkWell(
                          onTap: () => onPressed(tableMaster![index]),
                            child: _Stories(tableMaster:tableMaster?[index])
                        ),
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
  final TableMaster? tableMaster;

  const _Stories({Key? key, this.tableMaster}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 90,
                width: 90,
                alignment: Alignment.center,
                color: Utils.scaffold,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(tableMaster?.tableNo ?? "", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Text(tableMaster?.joinOTP ?? ""),
                  ],
                ),
              )
          ),
        ),
        SizedBox(height: 8,),
        Center(child: Text(tableMaster?.occupiedName ?? "", textAlign: TextAlign.center,  maxLines: 2, overflow: TextOverflow.fade, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),)),
        SizedBox(height: 1,),
        Text(tableMaster?.occupiedPh ?? "",maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11),)
      ],
    );
  }
}