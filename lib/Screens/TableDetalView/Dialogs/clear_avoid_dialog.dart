import 'package:flutter/material.dart';

class ClearAvoidDialog extends StatefulWidget {
  const ClearAvoidDialog({super.key});

  @override
  State<ClearAvoidDialog> createState() => _ClearAvoidDialogState();
}

class _ClearAvoidDialogState extends State<ClearAvoidDialog> {
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
              ],
            ),
            content: Container(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text("There are some orders going on, Please cancel all the orders or make it paid and try to clear the table"),
              ),
            ),

            contentPadding: EdgeInsets.zero,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Okay'),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
