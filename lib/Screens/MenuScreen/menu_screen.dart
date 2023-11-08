import 'package:flutter/material.dart';
import 'package:jtable/Helpers/UIHelper.dart';
import 'package:jtable/Models/Items.dart';
import 'package:jtable/Models/MenuItems.dart';
import 'package:jtable/Models/SubCategories.dart';
import 'package:jtable/Models/SubCategory.dart';
import 'package:jtable/Screens/MenuScreen/helping_widgets.dart';
import 'package:jtable/Screens/Providers/menu_provider.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool isFloating = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    GetSubCategories();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showGeneralDialog(
              barrierLabel: "Label",
              barrierDismissible: true,
              barrierColor: Colors.white.withOpacity(0.5),
              //transitionDuration: Duration(milliseconds: 300),
              context: context,
              pageBuilder: (context, anim1, anim2) {
                return Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 360,
                    width: 260,
                    child: buildSubCategory(),
                    margin: EdgeInsets.only(bottom: 40, left: 12, right: 12),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              // transitionBuilder: (context, anim1, anim2, child) {
              //   return SlideTransition(
              //     position: Tween(begin: Offset(1, 1), end: Offset(0, 0)).animate(anim1),
              //     child: child,
              //   );
              // },
            );
          },
          child: Icon(Icons.menu),
        ),
        appBar: AppBar(
          title: Text("Add Items"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ElevatedButton(onPressed: (){
                GetSubCategories();
              }, child: Text("Menu")),
            )
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for restaurants and food',
                          hintStyle:
                          Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Colors.grey,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    // UIHelper.horizontalSpaceMedium(),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    )
                  ],
                ),
                Expanded(
                  child: Consumer<MenuProvider>(builder: (context, menu, child) {
                        return _menuListView(menu);
                      }
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }

  void GetSubCategories() {
    List<MenuItems>? menus = Provider.of<MenuProvider>(context, listen: false).filterMenuItems;
    if((menus?.length ?? 0) > 0){
      Provider.of<MenuProvider>(context, listen: false).GetSubCategories(context);
    }else{
      Provider.of<MenuProvider>(context, listen: false).GetSubCategories(context);
    }

  }

  buildCategoryView() {
    return Container(
      width: 400,
      child: InkWell(
        onTap: () {
          setState(() {
            isFloating = false;
          });
        },
        child: Container(

          child: Text("sdg"),
        ),
      ),
    );
  }

  buildSubCategory() {
    List<SubCategory> subs = Provider.of<MenuProvider>(context, listen: false).subCategories;
    String? selectedCatId = Provider.of<MenuProvider>(context, listen: false).selectedCatId;
    String? selectedSubCatId = Provider.of<MenuProvider>(context, listen: false).selectedSubCatId;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.only(left: 12),
        child: ListView.builder(
            itemCount: subs.length,
            itemBuilder: (BuildContext context, int index){
              var sub = subs[index];
              return InkWell(
                onTap: () {
                  String id = "999";
                  if((sub.subCategories?.length ?? 0) > 0){
                    id = sub.subCategories?.first?.subCategoryId ?? "999";
                  }
                  Provider.of<MenuProvider>(context, listen: false).updateCatIdAndSubCatId(sub.id, id);
                  Navigator.pop(context);
                },
                splashColor: Colors.grey,
                highlightColor: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(sub.categoryName ?? "", style: TextStyle(color: Colors.white, fontWeight: selectedCatId == sub.id ? FontWeight.bold : FontWeight.w400, fontSize: selectedCatId == sub.id ? 18 : 16),),
                    ),
                    Divider(height: 0.5, thickness: 0.2),
                    selectedCatId == sub.id ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: sub.subCategories?.length,
                        itemBuilder: (BuildContext context, int index2){
                          var subListCat = sub.subCategories?[index2];
                          return (subListCat?.items?.length ?? 0) > 0 ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Provider.of<MenuProvider>(context, listen: false).updateCatIdAndSubCatId(sub.id, subListCat?.subCategoryId);
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                                  child: Text(subListCat?.subCategoryName ?? "", style: TextStyle(color: Colors.white, fontWeight: selectedSubCatId == subListCat?.subCategoryId ? FontWeight.bold : FontWeight.w400, fontSize: 14),),
                                ),

                              ),
                              Divider(height: 0.5, thickness: 0.2),

                            ],
                          ) : Container();
                        }
                    ) : Container(),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }

  buildSubCategoryWithProviderChanges() {
    return Scaffold(
      body: Consumer<MenuProvider>(builder: (context, menu, child) {
         return Container(
           decoration: BoxDecoration(
             color: Colors.black87,
             borderRadius: BorderRadius.circular(12),
           ),
           padding: const EdgeInsets.only(left: 12),
           child: ListView.builder(
               itemCount: menu.subCategories.length,
               itemBuilder: (BuildContext context, int index){
                 var sub = menu.subCategories[index];
                 return InkWell(
                   onTap: () => menu.updateCatIdAndSubCatId(sub.id, sub.subCategories?.first.subCategoryId),
                   splashColor: Colors.grey,
                   highlightColor: Colors.red,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(top: 10, bottom: 10),
                         child: Text(sub.categoryName ?? "", style: TextStyle(color: Colors.white, fontWeight: menu.selectedCatId == sub.id ? FontWeight.bold : FontWeight.w400, fontSize: menu.selectedCatId == sub.id ? 18 : 16),),
                       ),
                       Divider(height: 0.5, thickness: 0.2),
                       menu.selectedCatId == sub.id ? ListView.builder(
                           physics: const NeverScrollableScrollPhysics(),
                           shrinkWrap: true,
                           itemCount: sub.subCategories?.length,
                           itemBuilder: (BuildContext context, int index2){
                             var subListCat = sub.subCategories?[index2];
                             return Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 InkWell(
                                   child: Padding(
                                     padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                                     child: Text(subListCat?.subCategoryName ?? "", style: TextStyle(color: Colors.white, fontSize: 14),),
                                   ),
                                   onTap: () => print("sf"),
                                 ),
                                 Divider(height: 0.5, thickness: 0.2),

                               ],
                             );
                           }
                       ) : Container(),
                     ],
                   ),
                 );
               }
           ),
         );
      })
    );
  }
}

Widget _menuListView2(MenuProvider menu){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView.builder(
      itemCount: menu.filterMenuItems?.length,
      itemBuilder: (context, index){
        MenuItems? menuItem = menu.filterMenuItems?[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //menuItem != null ? FoodListView(foodsz: menuItem!) : Container(),
          ],
        );
      },
    ),
  );
}

Widget _menuListView(MenuProvider menu){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView.builder(
      itemCount: menu.filterSubListCategoriesz?.length,
      itemBuilder: (context, index){
        SubCategories? subCats = menu.filterSubListCategoriesz?[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subCats?.subCategoryName ?? ""),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: subCats?.items?.length,
              itemBuilder: (context, index){
                Items? item = subCats?.items?[index];
                return FoodListView(foodsz: item);
              },
            ),
          ],
        );
      },
    ),
  );
}









