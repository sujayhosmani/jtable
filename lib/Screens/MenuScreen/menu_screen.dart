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
        appBar: AppBar(
          title: Text("Menu "),
          actions: [],
        ),
        body: Column(
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
              child: Consumer<MenuProvider>(
                builder: (context, menu, child) {
                  return _menuListView(menu);
                }
              ),
            ),
          ],
        ));
  }

  void GetSubCategories() {
    List<MenuItems>? menus = Provider.of<MenuProvider>(context, listen: false).filterMenuItems;
    if((menus?.length ?? 0) > 0){

    }else{
      Provider.of<MenuProvider>(context, listen: false).GetSubCategories(context);
    }

  }
}

Widget _menuListView(MenuProvider menu){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView.builder(
      itemCount: menu.filterMenuItems?.length,
      itemBuilder: (context, index){
        MenuItems? menuItem = menu.filterMenuItems?[index];
        String? CatId;
        String? SubCatId;
        if(index != 0){
          if(menu.filterMenuItems?[index - 1].categoryId != menuItem?.categoryId){
            CatId = menuItem?.categoryName;
          };
        }else{
          CatId = menuItem?.categoryName;
        }
        if(index != 0){
          if(menu.filterMenuItems?[index - 1].subCategoryId != menuItem?.subCategoryId){
            SubCatId = menuItem?.subCategoryName;
          };
        }else{
          SubCatId = menuItem?.subCategoryName;
        }

        Items? item = menuItem?.items;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6,),
            InkWell(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubCatId != null ? Text(menuItem?.categoryName ?? "", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),) : Container(),
                      SubCatId != null ? Text(SubCatId, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange.shade700)) : Container(),
                    ],
                  ),
                ],
              ),
            ),
            menuItem != null ? FoodListView(foods: menuItem!) : Container(),
          ],
        );
      },
    ),
  );
}









