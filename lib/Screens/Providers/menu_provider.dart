


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/auth_service.dart';
import 'package:jtable/Models/Auth.dart';
import 'package:jtable/Models/CategoriesMaster.dart';
import 'package:jtable/Models/Items.dart';
import 'package:jtable/Models/MenuItems.dart';
import 'package:jtable/Models/Orders.dart';
import 'package:jtable/Models/SubCategories.dart';
import 'package:jtable/Models/SubCategory.dart';
import 'package:jtable/Models/Table_master.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Models/Variations.dart';
import 'package:jtable/Network/ApiBaseHelper.dart';
import 'package:jtable/Network/ApiResponse.dart';
import 'package:jtable/Network/network_repo.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuProvider with ChangeNotifier{


  List<Orders>? _cartItems;
  List<Orders>? get cartItems => _cartItems;

  String _selectedCatId = "999";
  String get selectedCatId => _selectedCatId;

  String _selectedSubCatId = "All";
  String get selectedSubCatId => _selectedSubCatId;

  // List<CategoriesMaster>? _categories;
  // List<CategoriesMaster>? get categories => _categories;

  List<SubCategory> _subCategories = [];
  List<SubCategory> get subCategories => _subCategories;

  List<SubCategory>? _filterSubCategories;
  List<SubCategory>? get filterSubCategories => _filterSubCategories;

  List<SubCategories> _subListCategoriesz = [];
  List<SubCategories> get subListCategoriesz => _subListCategoriesz;

  List<SubCategories> _filterSubListCategoriesz = [];
  List<SubCategories> get filterSubListCategoriesz => _filterSubListCategoriesz;

  List<MenuItems> _menuItems = [];
  List<MenuItems> get menuItems => _menuItems;

  List<MenuItems> _filterMenuItems = [];
  List<MenuItems> get filterMenuItems => _filterMenuItems;

  final ApiBaseHelper _helper = ApiBaseHelper();

  // Future<List<CategoriesMaster>?> GetCategories(BuildContext context) async {
  //   try{
  //     final response = await _helper.get("Menu/category", context);
  //     print("network Model");
  //     if(response != null){
  //       _categories = List<CategoriesMaster>.from(response.map((model)=> CategoriesMaster.fromJson(model)));
  //       notifyListeners();
  //       return _categories;
  //     }
  //
  //   }catch(e){
  //     return null;
  //   }
  //
  // }

  Future<List<SubCategory>?> GetSubCategories(BuildContext context) async {
    try{
      final response = await _helper.get("subcategory/subcategory", context);
      print("network Model GetSubCategories" + response.toString());
      if(response != null){
        _subCategories = List<SubCategory>.from(response.map((model)=> SubCategory.fromJson(model)));
        List<SubCategories> subs = [];
        _selectedCatId = "999";
        _selectedSubCatId = "999";
        // SubCategories sub = SubCategories(subCategoryName: "All");
        // subs.add(sub);
        SubCategory subCat = SubCategory(categoryName: "All", id: "999", subCategories: subs);
        _subCategories.insert(0, subCat);
        await GetMenuItems(context);
      }

    }catch(e){
      return null;
    }

  }

  Future<List<SubCategory>?> GetMenuItems(BuildContext context) async {
    try{
      final response = await _helper.get("menu/menuitems", context);
      print("network Model GetMenuItems" + response.toString());
      if(response != null){
        _menuItems = List<MenuItems>.from(response.map((model)=> MenuItems.fromJson(model)));
        _filterMenuItems = List<MenuItems>.from(response.map((model)=> MenuItems.fromJson(model)));
        MergeAll();

      }

    }catch(e){
      return null;
    }

  }

  onSearch(String Val){
    _subCategories?.forEach((subCat) {
      // CategoriesMaster cat = CategoriesMaster(categoryName: subCat.categoryName, catImage: subCat.catImage, id: subCat.id);
      // _categories?.add(cat);
      subCat.subCategories?.forEach((subList) {
        List<MenuItems>? itemsOfSubCategory = _menuItems?.where((menuItem) => menuItem.subCategoryId == subList.subCategoryId && subCat.id == menuItem.categoryId).toList();
        itemsOfSubCategory?.forEach((element) {
          Items? item = element.items;
          if(item != null && item.itemName!.contains(Val)){
            subList.items?.add(item!);
          }
        });
      });
    });
    notifyListeners();
  }


  MergeAll(){
    // _subCategories?.forEach((subCat) {
    //   subCat.subCategories?.forEach((subList) {
    //       List<MenuItems>? itemsOfSubCategory = _menuItems?.where((menuItem) => menuItem.subCategoryId == subList.subCategoryId && subCat.id == menuItem.categoryId).toList();
    //       itemsOfSubCategory?.forEach((element) {
    //         Items? item = element.items;
    //         subList.items?.add(item!);
    //         subList.catId = subCat.id;
    //       });
    //   });
    // });
    // _filterSubCategories = subCategories.toList();
    // print("zzzzzzzzzzzzzzzzzz" + (subCatz.subCategoryName ?? "") + (subCatz?.catId ?? ""));
    // print("zzzzzzzzzzzzzzzzzz" + (subCatz.items?.length ?? 0).toString());
    // print("qqqqqqqqqqqqqqq" + (element.itemName ?? ""));

    _subListCategoriesz = [];
    _subCategories.forEach((mainSubCatz) {
          mainSubCatz.subCategories?.forEach((subCatz) {
               subCatz.items = [];
               var menuItemsz = _menuItems.where((element) => element.subCategoryId == subCatz.subCategoryId).toList();
               List<Items> finalItems = [];
               if(menuItemsz.length > 0){
                 menuItemsz.forEach((mz) {
                   Items? it = mz.items;
                   if(it != null){
                     finalItems.add(it);
                   }

                 });
                 subCatz.items = finalItems;
                 subCatz.catId = menuItemsz.first.categoryId;
                 _subListCategoriesz.add(subCatz);
                 print("zzzzzzzzzzzzzzzzzz" + (subCatz?.items?.length ?? 0).toString());
               }
          });
    });
    _filterSubCategories = subCategories.toList();
    _filterSubListCategoriesz = subListCategoriesz.toList();
    filterSubListCategoriesz.forEach((f1) {
      print("zzzzzzzzzzzzzzzzzzqqqqq" + (f1.catId ?? ""));
      f1.items?.forEach((element) {

      });
    });
    notifyListeners();
    return _subCategories;
  }

  onAddFirstCartItem(Items item){
      Orders cartItemAdd = Orders(
          description: item.description,
          discount: 0,
          preference: item.preference,
          isVeriation: false,
          itemId: item.id,
          itemName: item.itemName,
          quantity: 1,
          itemImage: item.itemImage,
          price: item.price
      );
      if((item.variations?.length ?? 0) > 0){
        Variations? variation = item.variations?.where((e) => e.isSelected == true).firstOrNull;
        if(variation?.isSelected ?? false){
          cartItemAdd.varName = variation?.name;
          cartItemAdd.price = variation?.price;
          cartItemAdd.isVeriation = true;
        }
      }
      _cartItems?.add(cartItemAdd);
      _filterMenuItems?.forEach((menuItem) {
        if(cartItemAdd.isVeriation ?? false){
          if(menuItem.itemId != null && menuItem.itemId == cartItemAdd.itemId){
            menuItem.items?.variations?.forEach((ver) {
                if(ver.name == cartItemAdd.varName){
                  ver.quantity = 1;
                }
            });

          }
        }else{
          if(menuItem.itemId != null && menuItem.itemId == cartItemAdd.itemId){
            menuItem.items?.quantity = cartItemAdd.quantity;
          }
        }
      });
      notifyListeners();
  }

  updateCatIdAndSubCatId(String? catId, String? subCatId) {
    _selectedCatId = catId ?? "999";
    _selectedSubCatId = subCatId ?? "999";
    updateMenuToSelectedCatId();
  }

  void updateMenuToSelectedCatId() {
    print(_selectedSubCatId);
    if(_selectedCatId == "999"){
      _filterSubListCategoriesz = subListCategoriesz.toList();
    }else{
      _filterSubListCategoriesz = subListCategoriesz.where((element) => element.catId == _selectedCatId).toList();
    }

    notifyListeners();
  }

}