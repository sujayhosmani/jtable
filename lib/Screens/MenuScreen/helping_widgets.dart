import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jtable/Models/Items.dart';
import 'package:jtable/Models/MenuItems.dart';
import 'package:jtable/Models/SubCategories.dart';
import 'package:jtable/Models/SubCategory.dart';
import 'package:jtable/Models/Variations.dart';
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
    Items? foods = foodsz; //.items;
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
                      .bodyLarge!
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
          (foods?.quantity ?? 0) > 0 ? CartBtnView(quantity: foods?.quantity,
            onItemPlus: (){
            if((foodsz?.variations?.length ?? 0) > 0){
              callBottomSheet(context, foodsz);
            }else{
              Provider.of<MenuProvider>(context, listen: false).onPlus(foodsz!);
            }
          },
            onItemMinus: (){
              if((foodsz?.variations?.length ?? 0) > 0){
                callBottomSheet(context, foodsz);
              }else{
                Provider.of<MenuProvider>(context, listen: false).onMinus(foodsz!);
              }
            },
          ) : AddBtnView(onItemAdded: () {
            print("dwdsfsff");
            if((foods?.variations?.length ?? 0) > 0){
              callBottomSheet(context, foods);
            }else{
              Provider.of<MenuProvider>(context, listen: false).onAddFirstCartItem(foods!);
            }

          },),
        ],
      ),
    );
  }


  buildBottomBar(Items? foods, context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1))
      ),
      child: Column(
        children: [
          Row(
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
                      maxLines: 12,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
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
                child: Text((foods?.price.toString() ?? "") + " Rs", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          Expanded(
              child: Consumer<MenuProvider>(builder: (context, menu, child) {
                  var finalItem = menu.filterMenuList?.where((itemz) => itemz.items?.id == foods?.id).toList();
                  if(finalItem != null && (finalItem?.length ?? 0) > 0){
                    foods = finalItem?.first.items;
                  }

                return ListView.builder(
                    itemCount: foods?.variations?.length,
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (BuildContext context, int index){
                      Variations? v = foods?.variations?[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(v?.name ?? ""),

                                (v?.quantity ?? 0) > 0 ? CartBtnView(quantity: v?.quantity,onItemPlus: (){
                                  Provider.of<MenuProvider>(context, listen: false).onVarPlus(foods!, (v?.name ?? ""));
                                }, onItemMinus: (){
                                  Provider.of<MenuProvider>(context, listen: false).onVarMinus(foods!, (v?.name ?? ""));
                                }) : AddBtnView(onItemAdded: (){
                                  Provider.of<MenuProvider>(context, listen: false).onAddFirstVarCartItem(foods!, (v?.name ?? ""));
                                },)
                              ],
                            ),
                          ),
                          Divider(height: 0.1,)
                        ],
                      );
                    });
              })
          )
        ],
      ),
    );
  }

  void callBottomSheet(context, foods) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 350,
          // color: Colors.amber,
          padding: const EdgeInsets.all(12),
          child: buildBottomBar(foods, context),
        );
      },
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
              .titleSmall!
              .copyWith(color: Colors.green),
        ),
      ),
    );
  }
}

class CartBtnView extends StatelessWidget {
  final int? quantity;
  final Function onItemPlus;
  final Function onItemMinus;
  const CartBtnView({
    Key? key, required this.quantity, required this.onItemPlus, required this.onItemMinus
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
                onItemMinus();

              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                  child: Icon(Icons.remove, size: 15)
              ),
            ),
            Text(
                (quantity ?? 0).toString(),
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)
            ),
            InkWell(
              onTap: (){
                print("wrwr22");
               onItemPlus();
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

  getVariationCount() {

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


