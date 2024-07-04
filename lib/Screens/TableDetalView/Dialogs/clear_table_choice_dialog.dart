import 'package:flutter/material.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Screens/Providers/global_provider.dart';
import 'package:jtable/Screens/Providers/tables_provider.dart';
import 'package:jtable/Screens/shared/loading_screen.dart';
import 'package:provider/provider.dart';

class ClearChoiceDialog extends StatefulWidget {
  final TableMaster? tableMaster;
  const ClearChoiceDialog({super.key, required this.tableMaster});

  @override
  State<ClearChoiceDialog> createState() => _ClearChoiceDialogState();
}

class _ClearChoiceDialogState extends State<ClearChoiceDialog> {
  String? reason = "User no more intrested";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Clear Table", style: TextStyle(fontSize: 16),),
                Text("please choose the reason", style: TextStyle(color: Colors.grey, fontSize: 14),)
              ],
            ),
            content: Container(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(value: "User no more intrested", materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, groupValue: reason, onChanged: (value){
                          setState(() {
                            reason = value.toString();
                          });
                        }),
                        Text("User no more intrested")
                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: "user switched the table", materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, groupValue: reason, onChanged: (value){
                          setState(() {
                            reason = value.toString();
                          });
                        }),
                        Text("user switched the table")
                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: "no one at the table", materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,groupValue: reason, onChanged: (value){
                          setState(() {
                            reason = value.toString();
                          });
                        }),
                        Text("no one at the table")
                      ],
                    )
                  ],
                ),
              ),
            ),

            contentPadding: EdgeInsets.zero,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                onPressed: () {
                  onConfirmTableClear(widget.tableMaster, reason!);
                },
                child: Text('Ok'),
              ),
            ],
          ),
        ),
        Consumer<GlobalProvider>(builder: (context, global, child){
          print(global.error);
          return LoadingScreen(isBusy: global.isBusy,error: global?.error ?? "", onPressed: (){},);
        })

      ],
    );
  }

  onConfirmTableClear(TableMaster? table, String reason) async {
    table?.joinOTP = null;
    table?.assignedStaffId = null;
    table?.reason = reason;
    table?.from = "clear";


    print("111111111111111111111111111111111111111111111111111111111111111111111111111");
    print("111111111111111111111111111111111111111111111111111111111111111111111111111");
    await Provider.of<TablesProvider>(context, listen: false)
        .UpdateTable(table, context);

    Navigator.pop(context);
  }
}
