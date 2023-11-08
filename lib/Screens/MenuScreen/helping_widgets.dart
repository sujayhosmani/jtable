import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jtable/Models/Items.dart';
import 'package:jtable/Models/MenuItems.dart';
import 'package:jtable/Models/SubCategories.dart';
import 'package:jtable/Models/SubCategory.dart';
import 'package:jtable/Screens/Providers/menu_provider.dart';
import 'package:provider/provider.dart';





class FoodListView extends StatelessWidget {
  const FoodListView({
    Key? key,
    required this.foodsz,
  }) : super(key: key);

  final Items? foodsz;

  @override
  Widget build(BuildContext context) {
    var foods = foodsz; //.items;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,0),
            child: foods?.preference?.toLowerCase() == "veg" ?  const VegBadgeView() : foods?.preference?.toLowerCase() == "non veg" ? const NonVegBadgeView()  : Container(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text( foods?.itemName ?? "", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue.shade900),),
                ),

                Text(
                  foods?.description ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(
                    fontSize: 12.0,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,10,0),
            child: Text(foods?.price.toString() ?? "", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
          ),
          (foods?.quantity ?? 0) > 0 ? CartBtnView() : AddBtnView(onItemAdded: () {
            print("dwdsfsff");
            Provider.of<MenuProvider>(context, listen: false).onAddFirstCartItem(foods!);
          },),
        ],
      ),
    );
  }
}

class AddBtnView extends StatelessWidget {
  final Function onItemAdded;
  const AddBtnView({
    Key? key, required this.onItemAdded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print("on Add");
        onItemAdded();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 23.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Text(
          'ADD',
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.green),
        ),
      ),
    );
  }
}

class CartBtnView extends StatelessWidget {
  const CartBtnView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                HapticFeedback.heavyImpact();
                print("wrwr");
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                  child: Icon(Icons.remove, size: 15)
              ),
            ),
            Text(
              '1',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)
            ),
            InkWell(
              onTap: (){
                print("wrwr");
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                  child: Icon(Icons.add, size: 15)
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class VegBadgeView extends StatelessWidget {
  const VegBadgeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      height: 12.0,
      width: 12.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green[800]!),
      ),
      child: ClipOval(
        child: Container(
          height: 4.0,
          width: 4.0,
          color: Colors.green[800],
        ),
      ),
    );
  }
}

class NonVegBadgeView extends StatelessWidget {
  const NonVegBadgeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      height: 12.0,
      width: 12.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red[800]!),
      ),
      child: ClipOval(
        child: Container(
          height: 4.0,
          width: 4.0,
          color: Colors.red[800],
        ),
      ),
    );
  }
}


Widget catAndSubCat(MenuProvider menu){
  return (menu.filterSubCategories?.length ?? 0) > 0 ? ListView.builder(
      itemCount: menu.filterSubCategories?.length,
      itemBuilder: (context, index) {
        SubCategory? subMain = menu.filterSubCategories?[index];
        return Column(
          children: [
            Text(subMain?.categoryName ?? ""),
            ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: subMain?.subCategories?.length,
                itemBuilder: (context, index2) {
                  SubCategories? subCat = subMain?.subCategories?[index2];
                  return Text(subCat?.subCategoryName ?? "");
                })
          ],
        );
      }) : Container();
}

