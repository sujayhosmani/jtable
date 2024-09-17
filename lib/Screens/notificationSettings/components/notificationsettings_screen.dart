import 'package:flutter/material.dart';
import 'package:jtable/Screens/Providers/staff_provider.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../Helpers/signalR_services.dart';
import '../../../Models/Table_master.dart';
import '../../Providers/global_provider.dart';
import '../../Providers/tables_provider.dart';
import '../../shared/loading_screen.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() => _NotificationSettingScreenState();
}



class _NotificationSettingScreenState extends State<NotificationSettingScreen>  with TickerProviderStateMixin, WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Provider.of<StaffProvider>(context, listen: false).GetStaff(context);
    super.initState();
  }

  Future<void> _handleRefresh({bool isSignal = false, required SignalRService signal}) async {
    Provider.of<TablesProvider>(context, listen: false).GetAllTables(context, true);
    signal.initializeConnection(context);
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<SignalRService>(builder: (context, signal, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: signal.connectionIsOpen ? Colors.orangeAccent : Colors.redAccent,
          title: Text("Notification settings"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.refresh, color: Colors.black,),
                        onPressed: () => {
                          _handleRefresh(signal: signal)
                        },
                      ),
                      !signal.connectionIsOpen ? ElevatedButton(onPressed: () => _handleRefresh(signal: signal, isSignal: true), child: Text("Retry now!")):SizedBox(height: 0, width: 0,) ,
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: ElevatedButton(onPressed: ()=> onSubmit(), child: Text("Save", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero
          ),
          backgroundColor: Colors.blueAccent,
          // padding: EdgeInsets.zero,
          // tapTargetSize: MaterialTapTargetSize.shrinkWrap
        )),
        body: Stack(
          children: [
            Consumer2<TablesProvider, StaffProvider>(builder: (context, tab, staff, child) {
              return buildTables2(signal, tab, staff);
            }),

            Consumer<GlobalProvider>(builder: (context, global, child) {
              print(global.error);
              return LoadingScreen(
                isBusy: global.isBusy,
                error: global.error ?? "",
                onPressed: () {},
              );
            })
          ],
        ),

      );
    });

  }

  buildTables2(SignalRService signal, TablesProvider tab, StaffProvider staff) {
    return loadAssignedContent(tab, staff);
  }

  loadAssignedContent(TablesProvider tab, StaffProvider staff) {
    return (staff.cats?.length ?? 0) > 0 ? ListView.builder(
        padding: const EdgeInsets.fromLTRB(8,0,8,12),
        itemCount: staff.cats.length,
        //physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index){
          var cat = staff.cats[index];
          List<TableKeyValue>? table1 = staff.tableValues?.where((element) => element.tableMaster?.tableCategory == cat.category).toList();
          return StickyHeader(
            header: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Checkbox(value: cat.isChecked, onChanged: (value) => _handleCatCheckbox(value ?? false, staff, cat)),
                  Text(cat.category ?? ""),

                ],
              ),
            ),
            content: loadGridContent(table1!, context, staff),
          );
        }) : Container();
  }

  loadGridContent(List<TableKeyValue> table1, BuildContext context, StaffProvider staff) {
    // return Text("fh");
    return ListView.builder(
        cacheExtent: 100,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: table1.length,
        itemBuilder: (BuildContext context, int index) {
          var table = table1[index];
          print(table.tableMaster?.tableNo);
          return Container(
            child: Row(
              children: [

                Checkbox(value: table.isChecked, onChanged: (value) => _handleTableCheckbox(value ?? false, staff, table)),
                Text(table.tableMaster?.tableNo ?? "", style: TextStyle(color: Colors.black),),
              ],
            ),
          );
        });
  }

  _handleCatCheckbox(bool value, StaffProvider staff, KeyValue cat)
  {
    staff.onCatClicked(cat, value);
  }

  onSubmit() {}

  _handleTableCheckbox(bool value, StaffProvider staff, TableKeyValue table1) {
    staff.onTableClicked(table1, value);
  }
}
