


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

  List<CategoriesMaster>? _categories;
  List<CategoriesMaster>? get categories => _categories;

  List<SubCategory>? _subCategories;
  List<SubCategory>? get subCategories => _subCategories;

  List<SubCategory>? _filterSubCategories;
  List<SubCategory>? get filterSubCategories => _filterSubCategories;

  List<MenuItems>? _menuItems;
  List<MenuItems>? get menuItems => _menuItems;

  List<MenuItems>? _filterMenuItems;
  List<MenuItems>? get filterMenuItems => _filterMenuItems;

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
      final response = await _helper.get("Menu/subcategory", context);
      print("network Model");
      if(response != null){
        _subCategories = List<SubCategory>.from(response.map((model)=> SubCategory.fromJson(model)));
        await GetMenuItems(context);
      }

    }catch(e){
      return null;
    }

  }

  Future<List<SubCategory>?> GetMenuItems(BuildContext context) async {
    try{
      final response = await _helper.get("Menu/menuitems", context);
      print("network Model");
      if(response != null){
        _menuItems = List<MenuItems>.from(response.map((model)=> MenuItems.fromJson(model)));
        notifyListeners();
        return GetCatDetails();

      }

    }catch(e){
      return null;
    }

  }

  onSearch(String Val){
    _subCategories?.forEach((subCat) {
      CategoriesMaster cat = CategoriesMaster(categoryName: subCat.categoryName, catImage: subCat.catImage, id: subCat.categoryId);
      _categories?.add(cat);
      subCat.subCategories?.forEach((subList) {
        List<MenuItems>? itemsOfSubCategory = _menuItems?.where((menuItem) => menuItem.subCategoryId == subList.subCategoryId && subCat.categoryId == menuItem.categoryId).toList();
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

  GetCatDetails(){
    _menuItems?.forEach((menuItem) {
        SubCategory? firstSub = _subCategories?.where((subCat) => subCat.categoryId == menuItem.categoryId).firstOrNull;
        menuItem.categoryName = firstSub?.categoryName;
        SubCategories? subListCat = firstSub?.subCategories?.where((subList) => subList.subCategoryId == menuItem.subCategoryId).firstOrNull;
        menuItem.subCategoryName = subListCat?.subCategoryName;
        _filterMenuItems = _menuItems;
    });
  }

  MergeAll(){
    _subCategories?.forEach((subCat) {
      CategoriesMaster cat = CategoriesMaster(categoryName: subCat.categoryName, catImage: subCat.catImage, id: subCat.categoryId);
      _categories?.add(cat);
      subCat.subCategories?.forEach((subList) {
          List<MenuItems>? itemsOfSubCategory = _menuItems?.where((menuItem) => menuItem.subCategoryId == subList.subCategoryId && subCat.categoryId == menuItem.categoryId).toList();
          itemsOfSubCategory?.forEach((element) {
            Items? item = element.items;
            subList.items?.add(item!);
          });
      });
    });
    _filterSubCategories = subCategories;
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





}