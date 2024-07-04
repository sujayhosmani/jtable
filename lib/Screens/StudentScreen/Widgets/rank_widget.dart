// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:jtable/Helpers/Constants.dart';
// import 'package:jtable/Helpers/Utils.dart';
// import 'package:jtable/Models/Table_master.dart';
// import 'package:jtable/Screens/HomeScreen/Widgets/headings_home.dart';
// import 'package:jtable/Screens/HomeScreen/Widgets/main_cards.dart';
//
//
// class RankWig extends StatelessWidget {
//   final List<TableMaster>? tableMaster;
//
//   const RankWig({Key? key, this.tableMaster}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(12,0,12,6),
//             child: HeadingTitle(label: "All Tables",color: Utils.fromHex("#F67B5A"), onTap: (){print("");},),
//           ),
//           Container(
//             height: 176,
//             width: double.infinity,
//             child:
//             GridView.builder(
//                 padding: const EdgeInsets.fromLTRB(8,0,8,12),
//                 itemCount: tableMaster?.length ?? 0,
//                 shrinkWrap: true,
//                 physics: const ClampingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (BuildContext context, int index){
//                   return Column(
//                     children: [
//                       Container(
//                           width: 90,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 0),
//                             child: _Stories(tableMaster: tableMaster?[index],),
//                           )
//                       ),
//                     ],
//                   );
//                 },
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 12
//
//               ),
//             ),
//           )
//
//         ],
//       ),
//     );
//   }
// }
//
// class _Stories extends StatelessWidget {
//   final TableMaster? tableMaster;
//
//   const _Stories({Key? key, this.tableMaster}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           height: 70,
//           child:  ClipRRect(
//               borderRadius: BorderRadius.circular(60),
//               child: Container(
//                 color: Colors.blueGrey,
//                 height: 70,
//                 width: 70,
//                 child: Text(tableMaster?.tableNo ?? "", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
//                 alignment: Alignment.center,
//               )
//           ),
//         ),
//
//       ],
//     );
//   }
// }