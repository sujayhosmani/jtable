import 'package:flutter/material.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Screens/Providers/global_provider.dart';
import 'package:jtable/Screens/Providers/tables_provider.dart';
import 'package:jtable/Screens/shared/loading_screen.dart';
import 'package:provider/provider.dart';

class SwitchTableDialog extends StatefulWidget {
  final TableMaster? currentTable;
  final List<TableMaster> destinations;
  const SwitchTableDialog({super.key, required this.currentTable, required this.destinations});

  @override
  State<SwitchTableDialog> createState() => _SwitchTableDialogState();
}

class _SwitchTableDialogState extends State<SwitchTableDialog> {
  TableMaster? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Switch Table", style: TextStyle(fontSize: 16),),
              ],
            ),
            content: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("From Table"),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: widget.currentTable?.tableNo ?? "",
                        enabled: false,
                        contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      ),
                    ),
                    Text("To Table"),
                    Container(
                      width: double.infinity,
                      child: DropdownButton(
                        isExpanded: true,
                        value: dropdownValue,
                        onChanged: (TableMaster? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: widget.destinations.map<DropdownMenuItem<TableMaster>>((TableMaster value) {
                          return DropdownMenuItem<TableMaster>(
                            value: value,
                            enabled: !(value.isOccupied ?? false),
                            child: (value.isOccupied ?? false) ? Container(
                              color: Colors.grey,
                              child: Row(
                                children: [
                                  Text(value.tableNo ?? ""),
                                  Text("- occupied", style: TextStyle(color: Colors.red),)
                                ],
                              ),
                            ):
                            Text(value.tableNo ?? ""),
                          );
                        }).toList(),
                      ),
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
                  onSwitchTable();
                },
                child: Text('Switch the table'),
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

  onSwitchTable() async {
    if(dropdownValue != null){
      var val = {
        'FromTableDetails': widget.currentTable,
        'ToTableDetails': dropdownValue
      };

      await Provider.of<TablesProvider>(context, listen: false).SwitchTable(widget.currentTable, dropdownValue, context);
      Navigator.pop(context);
    }
  }
}

