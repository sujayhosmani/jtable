import 'package:flutter/material.dart';
import 'package:jtable/Helpers/Utils.dart';
import 'package:jtable/Screens/Providers/slider_provider.dart';
import 'package:provider/provider.dart';

class TableDetailScreen extends StatefulWidget {

  const TableDetailScreen({super.key});

  @override
  State<TableDetailScreen> createState() => _TableDetailScreenState();
}

class _TableDetailScreenState extends State<TableDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table Details"),
        actions: [
          addItemAction()
        ],
      ),
      body: Consumer<SliderProvider>(builder: (context, slide, child) {
        return Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  buildPrimaryTopBar(slide.selectedVal),
                  buildSecondaryTopBar(slide.selectedVal, slide.selectedSecVal),

                ],
              )
            ),
            buildFooter(slide.selectedVal)


          ],
        );
      })

    );
  }

  buildPrimaryTopBar(selectedVal){
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300, width: 1),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildTopWidgets("Table", 1, selectedVal, context),
        buildTopWidgets("Cart", 2, selectedVal, context),
        buildTopWidgets("Orders", 3, selectedVal, context),
        buildTopWidgets("Bill", 4, selectedVal, context),
      ],
    ),
  );
  }

  buildTopWidgets(name, i, int selectedVal, context){
    return Flexible(
      flex: 1,
      child: InkWell(
        highlightColor: Colors.redAccent,
        onTap: () => Provider.of<SliderProvider>(context, listen: false).onValueChanged(i),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Text(name, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),),
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300, width: 0.4,),color: selectedVal == i ? Utils.fromHex("#ce3737") : Utils.fromHex("#495057")),
        ),
      ),
    );
  }

  buildFooter(selectedVal) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          getFooterBarBasedOnSelectedVal(selectedVal),
          //buildAddItemFooter()
        ],
      ),
    );
  }

  buildAddItemFooter(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: OutlinedButton(onPressed: ()=> print(""), child: Text("Go to Table view", style: TextStyle(color: Colors.black),), style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                backgroundColor: Colors.grey[200],
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),

      ],
    );
  }

  getFooterBarBasedOnSelectedVal(selectedVal) {
    switch(selectedVal){
      case 1: return buildTableFooter();
      case 2: return buildCartFooter();
      case 3: return buildOrderFooter();
      case 4: return buildBillFooter();
      default: return Container();
    }
  }

  buildTableFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: ()=> print(""), child: Text("Switch Table", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                backgroundColor: Colors.orange,
                // padding: EdgeInsets.zero,
                // tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: ()=> print(""), child: Text("Clear Table", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                backgroundColor: Colors.black87,
                // padding: EdgeInsets.zero,
                // tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),
      ],
    );
  }

  buildCartFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: ()=> print(""), child: Text("Confirm", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                backgroundColor: Colors.green,
                // padding: EdgeInsets.zero,
                // tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),

      ],
    );
  }

  buildOrderFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: OutlinedButton(onPressed: ()=> print(""), child: Text("Close", style: TextStyle(color: Colors.black),), style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                backgroundColor: Colors.grey[200],
                // padding: EdgeInsets.zero,
                // tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: ()=> print(""), child: Text("Add Item", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                backgroundColor: Colors.black87,
                // padding: EdgeInsets.zero,
                // tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),
      ],
    );
  }

  buildBillFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: OutlinedButton(onPressed: ()=> print(""), child: Text("Close", style: TextStyle(color: Colors.black),), style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                backgroundColor: Colors.grey[200],
                // padding: EdgeInsets.zero,
                // tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: ()=> print(""), child: Text("Add Item", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                backgroundColor: Colors.black87,
                // padding: EdgeInsets.zero,
                // tapTargetSize: MaterialTapTargetSize.shrinkWrap
            )),
          ),
        ),
      ],
    );
  }

  addItemAction() {
    return Padding(
        padding: const EdgeInsets.only(top: 5),
        // child: IconButton(onPressed: ()=>print("sdg"), icon: Icon(Icons.add_circle_rounded),),
        child: ElevatedButton(onPressed: ()=>print(""), child: Text("Add Items", style: TextStyle(color: Colors.white),),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              )
          ),
        )
    );
  }

  buildSecondaryTopBar(int selectedVal, int secVal) {
    switch(selectedVal){
      case 3: return buildSecondaryOrdersView(secVal);
    }
    return Container();
  }

  buildSecondaryOrdersView(selectedVal) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildOrdersSecWidgets("All", 1, selectedVal, context),
          buildOrdersSecWidgets("Pending", 2, selectedVal, context),
          buildOrdersSecWidgets("Done", 3, selectedVal, context),
          buildOrdersSecWidgets("Cancelled", 4, selectedVal, context),
        ],
      ),
    );
  }

  buildOrdersSecWidgets(name, i, int selectedVal, context){
    return Flexible(
      flex: 1,
      child: InkWell(
        highlightColor: Colors.redAccent,
        onTap: () => Provider.of<SliderProvider>(context, listen: false).onValueChangedForSec(i),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Text(name, textAlign: TextAlign.center, style: TextStyle(color: selectedVal == i ? Colors.white : Colors.black, fontWeight: selectedVal == i ? FontWeight.bold : FontWeight.w500, fontSize: 13),),
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300, width: 0.4,),color: selectedVal == i ? Utils.fromHex("#ce3737") : Utils.fromHex("#f5f5f5")),
        ),
      ),
    );
  }
}
