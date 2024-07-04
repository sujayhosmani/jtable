


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
import 'package:jtable/Models/OrdersPost.dart';
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

  Map<String, bool> values = {
    'veg': false,
    'non veg': false,
    "egg": false
  };


  String selectedTableNo = "";

  List<OrdersPost> _cartItems = [];
  List<OrdersPost> get cartItems => _cartItems;

  String _selectedCatId = "999";
  String get selectedCatId => _selectedCatId;

  String _selectedSubCatId = "All";
  String get selectedSubCatId => _selectedSubCatId;

  // List<CategoriesMaster>? _categories;
  // List<CategoriesMaster>? get categories => _categories;

  List<SubCategory> _subCategories = [];
  List<SubCategory> get subCategories => _subCategories;


  // List<SubCategories> _subListCategoriesz = [];
  // List<SubCategories> get subListCategoriesz => _subListCategoriesz;


  List<MenuItems> _menuItems = [];
  List<MenuItems> get menuItems => _menuItems;

  List<MenuItems> _filterMenuList = [];
  List<MenuItems> get filterMenuList => _filterMenuList;


  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<SubCategory>?> GetSubCategories(BuildContext context, String tableNo) async {
    try{
      selectedTableNo = tableNo;
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

  storeMenuItems(List<MenuItems> menuItems) async{
    final prefs = await SharedPreferences.getInstance();
    String vl = jsonEncode(menuItems);
    prefs.setString("menuitems", vl);
  }

  getMenuItemsFromStorage()async{
    final prefs = await SharedPreferences.getInstance();
    String userValues = prefs?.getString("menuitems") ?? "";
    print("menus from $userValues");
    if(userValues == ""){
      return null;
    }

    return List<MenuItems>.from(jsonDecode(userValues).map((model)=> MenuItems.fromJson(model)));

  }

  Future<List<SubCategory>?> GetMenuItems(BuildContext context) async {
    try{
      List<MenuItems> fromStorage = await getMenuItemsFromStorage() ?? [];
      print("menus from storage $fromStorage");
      if(fromStorage.length > 0){

        _menuItems = fromStorage;
        MergeAll();
      }else{
        print("menus from network");
        final response = await _helper.get("menu/menuitems", context);
        print("network Model GetMenuItems" + response.toString());
        if(response != null){
          _menuItems = List<MenuItems>.from(response.map((model)=> MenuItems.fromJson(model)));
          storeMenuItems(_menuItems);
          MergeAll();

        }
      }


    }catch(e){
      return null;
    }

  }


  MergeAll(){
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
          print("zzzzzzzzzzzzzzzzzz" + (subCatz?.items?.length ?? 0).toString());
        }
      });
    });
    _filterMenuList = getMenuItems();
    _selectedCatId = "999";
    _selectedSubCatId = "999";
    values["veg"] = false;
    values["non veg"] = false;
    values["egg"] = false;
    onSearch("", false);
    print(values["non veg"]);
    onFiltersValuesChanged(values, false);
    return _subCategories;
  }

  onInitFirst(String tableNo){
    // _filterSubListCategoriesz = getSubcategory();
    _selectedCatId = "999";
    _selectedSubCatId = "999";
    values["veg"] = false;
    values["non veg"] = false;
    values["egg"] = false;
    onSearch("", false);
    print(values["non veg"]);
    onFiltersValuesChanged(values, false);

    _filterMenuList = getMenuItems();
    if(selectedTableNo == ""){
      selectedTableNo = tableNo;
    }else if(selectedTableNo != tableNo){
      selectedTableNo = tableNo;
      resetItems();
    }else{
      selectedTableNo = tableNo;
      _filterMenuList = getMenuItems();
      // _filterSubListCategoriesz = getSubcategory();
      notifyListeners();
    }

  }

  onFiltersValuesChanged(val, bool isFromSearch){
    values = val;
    if(isFromSearch){
      if(!(values["veg"] ?? false) && !(values["egg"] ?? false) && !(values["non veg"] ?? false)){
        notifyListeners();
        return;
      }

      if((values["veg"] ?? false) && (values["egg"] ?? false) && (values["non veg"] ?? false)){
        notifyListeners();
        return;
      }
    }else{
      if(!(values["veg"] ?? false) && !(values["egg"] ?? false) && !(values["non veg"] ?? false)){
        if(_selectedCatId == "999"){
          // _filterSubListCategoriesz = getSubcategory();
          _filterMenuList = getMenuItems();
        }else{
          // _filterSubListCategoriesz = getSubcategory().where((element) => element.catId == _selectedCatId).toList();
          _filterMenuList = getMenuItems().where((element) => element.categoryId == _selectedCatId).toList();
        }
        notifyListeners();
        return;
      }

      if((values["veg"] ?? false) && (values["egg"] ?? false) && (values["non veg"] ?? false)){
        if(_selectedCatId == "999"){
          _filterMenuList = getMenuItems();
          // _filterSubListCategoriesz = getSubcategory();
        }else{
          _filterMenuList = getMenuItems().where((element) => element.categoryId == _selectedCatId).toList();
          // _filterSubListCategoriesz = getSubcategory().where((element) => element.catId == _selectedCatId).toList();
        }
        notifyListeners();
        return;
      }
    }


    List<MenuItems> filteredMenuItem = [];
    List<MenuItems> filteredMenuItem2 = [];
    if(isFromSearch){
      filteredMenuItem = List<MenuItems>.from(jsonDecode(jsonEncode(_filterMenuList.toList())).map((model)=> MenuItems.fromJson(model)));
    }else{
      filteredMenuItem = List<MenuItems>.from(jsonDecode(jsonEncode(_filterMenuList.toList())).map((model)=> MenuItems.fromJson(model)));
    }

    List<MenuItems>? allItems = filteredMenuItem;
    List<MenuItems> allVegItems = allItems.where((e) => ((e.items?.preference?.toLowerCase() != 'non veg') && (e.items?.preference?.toLowerCase() != 'egg') && (e.items?.preference?.toLowerCase() != 'drink'))).toList();
    List<MenuItems>? allEggItems = allItems?.where((e) => ((e.items?.preference?.toLowerCase() != 'veg') && (e.items?.preference?.toLowerCase() != 'non veg') && (e.items?.preference?.toLowerCase() != 'drink'))).toList();
    List<MenuItems>? allNonVegItems = allItems?.where((e) => (e.items?.preference?.toLowerCase() != 'veg') && (e.items?.preference?.toLowerCase() != 'drink')).toList();



    print((values["veg"] ?? false));
    if ((values["veg"] ?? false)) {
      print("veg: $allVegItems");
      filteredMenuItem2 = [...allVegItems];
    }
    if ((values["egg"] ?? false)) {
      print("egg: $allEggItems");
      filteredMenuItem2 = [...filteredMenuItem2, ...?allEggItems];
    }
    if ((values["non veg"] ?? false)) {
      print("non veg: $allNonVegItems");
      filteredMenuItem2 = [...filteredMenuItem2, ...?allNonVegItems];
      print("non veg filtered: $filteredMenuItem");
    }
    filteredMenuItem2 = [...Set.from(filteredMenuItem2 ?? [])];
    _filterMenuList = filteredMenuItem2.toList();

    notifyListeners();
  }



  onSearch(String Val, bool isFromFilter){
    if(Val.isEmpty){
      // _filterSubListCategoriesz = getSubcategory();
      _filterMenuList = getMenuItems();
      onFiltersValuesChanged(values, true);
      notifyListeners();
      return;
    }
    List<MenuItems> subMenuItems = getMenuItems();
    List<MenuItems> searchedFinalItems = [];
    searchedFinalItems = subMenuItems.where((mainItem) => (mainItem.items?.itemName?.toLowerCase().contains(Val.toLowerCase()) ?? false)).toList() ?? [];
    _filterMenuList = searchedFinalItems.toList();

    _selectedCatId = "999";
    _selectedSubCatId = "999";
    if(!isFromFilter){
      onFiltersValuesChanged(values, true);
    }else{
      notifyListeners();
    }

  }

  updateCatIdAndSubCatId(String? catId, String? subCatId) {
    _selectedCatId = catId ?? "999";
    _selectedSubCatId = subCatId ?? "999";

    print(_selectedSubCatId);
    if(_selectedCatId == "999"){
      // _filterSubListCategoriesz = getSubcategory();
      _filterMenuList = getMenuItems();
    }else{
      // _filterSubListCategoriesz = mainList.where((element) => element.catId == _selectedCatId).toList();
      _filterMenuList = getMenuItems().where((element) => element.categoryId == _selectedCatId).toList();
    }

    onFiltersValuesChanged(values, false);
  }

  onAddFirstCartItem(Items item){
      OrdersPost cartItemAdd = OrdersPost(
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
      _cartItems?.add(cartItemAdd);
        _filterMenuList.forEach((menuItem) {
          if(cartItemAdd.isVeriation ?? false){
            if(menuItem.items?.id != null && menuItem.items?.id == cartItemAdd.itemId){
              menuItem.items?.variations?.forEach((ver) {
                if(ver.name == cartItemAdd.varName){
                  ver.quantity = 1;
                }
              });

            }
          }else{
            if(menuItem.items?.id != null && menuItem.items?.id == cartItemAdd.itemId){
              menuItem?.items?.quantity = cartItemAdd.quantity;
            }
          }
        });

        _menuItems?.forEach((menuItem) {
          if(cartItemAdd.isVeriation ?? false){
            if(menuItem.items?.id != null && menuItem.items?.id == cartItemAdd.itemId){
              menuItem.items?.variations?.forEach((ver) {
                if(ver.name == cartItemAdd.varName){
                  ver.quantity = 1;
                }
              });

            }
          }else{
            if(menuItem.items?.id != null && menuItem.items?.id == cartItemAdd.itemId){
              menuItem.items?.quantity = cartItemAdd.quantity;
            }
          }
        });


      notifyListeners();
  }


  onAddFirstVarCartItem(Items item, String varName){
    OrdersPost cartItemAdd = OrdersPost(
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

    if ((item.variations?.length ?? 0) > 0) {
      Variations? variation = item.variations?.firstWhere((e) => e.name == varName, orElse: () => Variations());
      if (variation != null) {
        cartItemAdd.varName = variation.name;
        cartItemAdd.price = (item.price ?? 0) + (variation.price ?? 0);
        cartItemAdd.isVeriation = true;
      }
    }

    _cartItems?.add(cartItemAdd);

      _filterMenuList?.forEach((menuItem) {

        if(cartItemAdd.isVeriation ?? false){
          if(menuItem.items?.id != null && menuItem.items?.id == cartItemAdd.itemId){
            int varCount = 0;
            menuItem?.items?.variations?.forEach((ver) {
              if(ver.name == cartItemAdd.varName){
                ver.quantity = 1;
              }
              varCount = varCount + (ver.quantity ?? 0);
            });
            menuItem.items?.quantity = varCount;
          }
        }
      });

      _menuItems?.forEach((menuItem) {

        if(cartItemAdd.isVeriation ?? false){
          if(menuItem.items?.id != null && menuItem.items?.id == cartItemAdd.itemId){
            int varCount = 0;
            menuItem.items?.variations?.forEach((ver) {
              if(ver.name == cartItemAdd.varName){
                ver.quantity = 1;
              }
              varCount = varCount + (ver.quantity ?? 0);
            });
            menuItem.items?.quantity = varCount;
          }
        }
    });


    notifyListeners();
  }


  void onPlus(Items item) {
    int foundCart = _cartItems.indexWhere((cart) => cart.itemId == item.id);
    if (foundCart != -1) {
      _cartItems[foundCart].quantity = (_cartItems[foundCart]?.quantity ?? 0) + 1;
        _filterMenuList?.forEach((mItem) {
          if(mItem.items?.id == item.id){
            mItem.items?.quantity = _cartItems[foundCart].quantity;
          }
        });

        _menuItems?.forEach((mItem) {
          if(mItem.items?.id == item.id){
            mItem.items?.quantity = _cartItems[foundCart].quantity;
          }
        });

      notifyListeners();
    }
  }

  void onVarPlus(Items item, String varName) {
    int foundCart = _cartItems.indexWhere((e) => e.itemId == item.id && e.varName == varName);
    if (foundCart != -1) {
      _cartItems[foundCart].quantity = (_cartItems[foundCart]?.quantity ?? 0) + 1;

        _filterMenuList?.forEach((mItem) {
          if(mItem.items?.id == item.id){
            int varCount = 0;
            mItem.items?.variations?.forEach((variation) {
                if(variation.name == varName){
                   variation.quantity = (variation.quantity ?? 0) + 1;
                }
                varCount = varCount + (variation.quantity ?? 0);
            });
            mItem.items?.quantity = varCount;
          }
        });

        _menuItems?.forEach((mItem) {
          if(mItem.items?.id == item.id){
            int varCount = 0;
            mItem.items?.variations?.forEach((variation) {
              if(variation.name == varName){
                variation.quantity = (variation.quantity ?? 0) + 1;
              }
              varCount = varCount + (variation.quantity ?? 0);
            });
            mItem.items?.quantity = varCount;
          }
        });

      notifyListeners();
    }
  }

  void onMinus(Items item) {
    int foundCart = _cartItems.indexWhere((cart) => cart.itemId == item.id);
    if (foundCart != -1) {
      int quantity = (_cartItems[foundCart]?.quantity ?? 0) - 1;
      if (quantity <= 0) {
        _cartItems.removeAt(foundCart);
      } else {
        _cartItems[foundCart].quantity = quantity;
      }

      if (foundCart != -1) {
          _filterMenuList?.forEach((mItem) {
            if(mItem.items?.id == item.id){
              mItem.items?.quantity = quantity;
            }
          });

          _menuItems.forEach((mItem) {
            if(mItem.items?.id == item.id){
              mItem.items?.quantity = quantity;
            }
          });

        notifyListeners();
      }
    }
  }

  void onVarMinus(Items item, String varName) {
    int foundCart = cartItems.indexWhere((e) => e.itemId == item.id && e.varName == varName);
    if (foundCart != -1) {
      int quantity = (cartItems[foundCart]?.quantity ?? 0) - 1;
      if (quantity <= 0) {
        cartItems.removeAt(foundCart);
      } else {
        cartItems[foundCart].quantity = quantity;
      }

      if (foundCart != -1) {
          _filterMenuList?.forEach((mItem) {
            if(mItem.items?.id == item.id){
              int varCount = 0;
              mItem.items?.variations?.forEach((variation) {
                if(variation.name == varName){
                  variation.quantity = quantity;
                }
                varCount = varCount + (variation.quantity ?? 0);
              });
              mItem.items?.quantity = varCount;
            }
          });
          _menuItems?.forEach((mItem) {
            if(mItem.items?.id == item.id){
              int varCount = 0;
              mItem.items?.variations?.forEach((variation) {
                if(variation.name == varName){
                  variation.quantity = quantity;
                }
                varCount = varCount + (variation.quantity ?? 0);
              });
              mItem.items?.quantity = varCount;
            }
          });

        notifyListeners();
      }
    }
  }

  void onCartItemScreen({required bool isFromVar, required OrdersPost cartItem, required bool isAdd, bool? isRemove}) {
    int? foundCart;
    if (isFromVar) {
      foundCart = _cartItems.indexWhere((e) => (e.itemId == cartItem.itemId) && (e.varName == cartItem.varName));
    } else {
      foundCart = _cartItems.indexWhere((e) => (e.itemId == cartItem.itemId));
    }
    if (foundCart != null) {
      int quantity = _cartItems[foundCart].quantity ?? 0;
      int finalQuantity = isAdd ? quantity + 1 : quantity - 1;
      if (isRemove == true) {
        finalQuantity = 0;
      }
      if (finalQuantity <= 0) {
        _cartItems.removeAt(foundCart);
      } else {
        _cartItems[foundCart].quantity = finalQuantity;
      }


      if (isFromVar) {
          _menuItems.forEach((mItem) {
            if(mItem.items?.id == cartItem.itemId){
              int varCount = 0;
              mItem.items?.variations?.forEach((mVar) {
                if(mVar.name == cartItem.varName){
                    mVar.quantity = finalQuantity;
                }
                varCount = varCount + (mVar.quantity ?? 0);
              });
              mItem.items?.quantity = varCount;
            }
          });
          _filterMenuList?.forEach((mItem) {
            if(mItem.items?.id == cartItem.itemId){
              int varCount = 0;
              mItem.items?.variations?.forEach((mVar) {
                if(mVar.name == cartItem.varName){
                  mVar.quantity = finalQuantity;
                }
                varCount = varCount + (mVar.quantity ?? 0);
              });
              mItem.items?.quantity = varCount;
            }
          });
      } else {
          _menuItems?.forEach((mItem) {
            if(mItem.items?.id == cartItem.itemId){
              mItem.items?.quantity = finalQuantity;
            }
          });
          _filterMenuList?.forEach((mItem) {
            if(mItem.items?.id == cartItem.itemId){
              mItem.items?.quantity = finalQuantity;
            }
          });
      }

      notifyListeners();
    }
  }


  void resetItems() {
    _cartItems = [];
    _selectedCatId = "999";
    _selectedSubCatId = "999";
      _menuItems?.forEach((eItems) {
        eItems.items?.variations?.forEach((eVar) {
          eVar.quantity = 0;
        });
          eItems.items?.quantity = 0;
      });
      _filterMenuList?.forEach((eItems) {
        eItems.items?.variations?.forEach((eVar) {
          eVar.quantity = 0;
        });
        eItems.items?.quantity = 0;
      });
    notifyListeners();
  }



  List<MenuItems> getMenuItems(){
    return List<MenuItems>.from(jsonDecode(jsonEncode(_menuItems.toList())).map((model)=> MenuItems.fromJson(model)));;
  }





}