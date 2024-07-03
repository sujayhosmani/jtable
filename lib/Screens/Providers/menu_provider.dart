


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


  List<SubCategories> _subListCategoriesz = [];
  List<SubCategories> get subListCategoriesz => _subListCategoriesz;

  List<SubCategories> _filterSubListCategoriesz = [];
  List<SubCategories> get filterSubListCategoriesz => _filterSubListCategoriesz;

  List<MenuItems> _menuItems = [];
  List<MenuItems> get menuItems => _menuItems;


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

  Future<List<SubCategory>?> GetMenuItems(BuildContext context) async {
    try{
      final response = await _helper.get("menu/menuitems", context);
      print("network Model GetMenuItems" + response.toString());
      if(response != null){
        _menuItems = List<MenuItems>.from(response.map((model)=> MenuItems.fromJson(model)));
        MergeAll();

      }

    }catch(e){
      return null;
    }

  }


  MergeAll(){
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
    _filterSubListCategoriesz = getSubcategory();
    onFiltersValuesChanged(values, false);
    return _subCategories;
  }

  onInitFirst(String tableNo){
    _filterSubListCategoriesz = getSubcategory();
    if(selectedTableNo == ""){
      selectedTableNo = tableNo;
    }else if(selectedTableNo != tableNo){
      selectedTableNo = tableNo;
      resetItems();
    }else{
      selectedTableNo = tableNo;
      _filterSubListCategoriesz = getSubcategory();
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
          _filterSubListCategoriesz = getSubcategory();
        }else{
          _filterSubListCategoriesz = getSubcategory().where((element) => element.catId == _selectedCatId).toList();
        }
        notifyListeners();
        return;
      }

      if((values["veg"] ?? false) && (values["egg"] ?? false) && (values["non veg"] ?? false)){
        if(_selectedCatId == "999"){
          _filterSubListCategoriesz = getSubcategory();
        }else{
          _filterSubListCategoriesz = getSubcategory().where((element) => element.catId == _selectedCatId).toList();
        }
        notifyListeners();
        return;
      }
    }


    List<SubCategories> filteredMenuItem = [];
    if(isFromSearch){
      filteredMenuItem = List<SubCategories>.from(jsonDecode(jsonEncode(filterSubListCategoriesz.toList())).map((model)=> SubCategories.fromJson(model)));
    }else{
      filteredMenuItem = List<SubCategories>.from(jsonDecode(jsonEncode(filterSubListCategoriesz.toList())).map((model)=> SubCategories.fromJson(model)));
    }

    filteredMenuItem.forEach((subCats) {
      List<Items>? allItems = subCats.items?.toList();
      subCats.items = [];
      List<Items>? allVegItems = allItems?.where((e) => ((e.preference?.toLowerCase() != 'non veg') && (e.preference?.toLowerCase() != 'egg') && (e.preference?.toLowerCase() != 'drink'))).toList();
      List<Items>? allEggItems = allItems?.where((e) => ((e.preference?.toLowerCase() != 'veg') && (e.preference?.toLowerCase() != 'non veg') && (e.preference?.toLowerCase() != 'drink'))).toList();
      List<Items>? allNonVegItems = allItems?.where((e) => (e.preference?.toLowerCase() != 'veg') && (e.preference?.toLowerCase() != 'drink')).toList();
      print("veg: $allVegItems");
      print("egg: $allEggItems");
      print("non veg: $allNonVegItems");
      print((values["veg"] ?? false));
      if ((values["veg"] ?? false)) {
        subCats.items = [...?allVegItems];
      }
      if ((values["egg"] ?? false)) {
        subCats.items = [...?subCats.items, ...?allEggItems];
      }
      if ((values["non veg"] ?? false)) {
        subCats.items = [...?subCats.items, ...?allNonVegItems];
      }
      subCats.items = [...Set.from(subCats.items ?? [])];
      subCats.itemCount = subCats.items?.length ?? 0;
    });
    _filterSubListCategoriesz = filteredMenuItem.toList();


    notifyListeners();
  }



  onSearch(String Val, bool isFromFilter){
    if(Val.isEmpty){
      _filterSubListCategoriesz = getSubcategory();
      notifyListeners();
      return;
    }
    List<SubCategories> subCats = getSubcategory();


    List<SubCategories> searchedFinalItems = [];
    subCats.forEach((mainSub) {
      SubCategories sub = SubCategories();
      sub.subCategoryName = mainSub.subCategoryName;
      sub.subCategoryId = mainSub.subCategoryId;
      sub.catId = mainSub.catId;
      sub.status = mainSub.status;
      sub.discount = mainSub.discount;
      sub.itemCount = mainSub.itemCount;
      sub.maxQuantity = mainSub.maxQuantity;
      sub.items = [];
      mainSub.items?.forEach((mainItem) {
        if(mainItem.itemName?.toLowerCase().contains(Val.toLowerCase()) ?? false){
          sub.items?.add(mainItem);
        }
      });
      if((sub.items?.length ?? 0) > 0){
        searchedFinalItems.add(sub);
      }

    });
    _filterSubListCategoriesz = searchedFinalItems.toList();

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
      _filterSubListCategoriesz = getSubcategory();
    }else{
      List<SubCategories> mainList = getSubcategory();
      _filterSubListCategoriesz = mainList.where((element) => element.catId == _selectedCatId).toList();
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
      _filterSubListCategoriesz?.forEach((menuSubList) {
        menuSubList.items?.forEach((menuItem) {
          if(cartItemAdd.isVeriation ?? false){
            if(menuItem.id != null && menuItem.id == cartItemAdd.itemId){
              menuItem?.variations?.forEach((ver) {
                if(ver.name == cartItemAdd.varName){
                  ver.quantity = 1;
                }
              });

            }
          }else{
            if(menuItem.id != null && menuItem.id == cartItemAdd.itemId){
              menuItem?.quantity = cartItemAdd.quantity;
            }
          }
        });

      });

      _subListCategoriesz?.forEach((menuSubList) {
        menuSubList.items?.forEach((menuItem) {
          if(cartItemAdd.isVeriation ?? false){
            if(menuItem.id != null && menuItem.id == cartItemAdd.itemId){
              menuItem?.variations?.forEach((ver) {
                if(ver.name == cartItemAdd.varName){
                  ver.quantity = 1;
                }
              });

            }
          }else{
            if(menuItem.id != null && menuItem.id == cartItemAdd.itemId){
              menuItem?.quantity = cartItemAdd.quantity;
            }
          }
        });

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

    _filterSubListCategoriesz?.forEach((menuSubList) {
      menuSubList.items?.forEach((menuItem) {

        if(cartItemAdd.isVeriation ?? false){
          if(menuItem.id != null && menuItem.id == cartItemAdd.itemId){
            int varCount = 0;
            menuItem?.variations?.forEach((ver) {
              if(ver.name == cartItemAdd.varName){
                ver.quantity = 1;
              }
              varCount = varCount + (ver.quantity ?? 0);
            });
            menuItem.quantity = varCount;
          }
        }
      });
    });

    _subListCategoriesz?.forEach((menuSubList) {
      menuSubList.items?.forEach((menuItem) {

        if(cartItemAdd.isVeriation ?? false){
          if(menuItem.id != null && menuItem.id == cartItemAdd.itemId){
            int varCount = 0;
            menuItem?.variations?.forEach((ver) {
              if(ver.name == cartItemAdd.varName){
                ver.quantity = 1;
              }
              varCount = varCount + (ver.quantity ?? 0);
            });
            menuItem.quantity = varCount;
          }
        }
      });
    });


    notifyListeners();
  }


  void onPlus(Items item) {
    int foundCart = _cartItems.indexWhere((cart) => cart.itemId == item.id);
    if (foundCart != -1) {
      _cartItems[foundCart].quantity = (_cartItems[foundCart]?.quantity ?? 0) + 1;
      _filterSubListCategoriesz.forEach((element) {
        element.items?.forEach((mItem) {
          if(mItem.id == item.id){
            mItem.quantity = _cartItems[foundCart].quantity;
          }
        });
      });

      _subListCategoriesz.forEach((element) {
        element.items?.forEach((mItem) {
          if(mItem.id == item.id){
            mItem.quantity = _cartItems[foundCart].quantity;
          }
        });
      });

      notifyListeners();
    }
  }

  void onVarPlus(Items item, String varName) {
    int foundCart = _cartItems.indexWhere((e) => e.itemId == item.id && e.varName == varName);
    if (foundCart != -1) {
      _cartItems[foundCart].quantity = (_cartItems[foundCart]?.quantity ?? 0) + 1;

      _filterSubListCategoriesz.forEach((element) {
        element.items?.forEach((mItem) {
          if(mItem.id == item.id){
            int varCount = 0;
            mItem.variations?.forEach((variation) {
                if(variation.name == varName){
                   variation.quantity = (variation.quantity ?? 0) + 1;
                }
                varCount = varCount + (variation.quantity ?? 0);
            });
            mItem.quantity = varCount;
          }
        });
      });

      _subListCategoriesz.forEach((element) {
        element.items?.forEach((mItem) {
          if(mItem.id == item.id){
            int varCount = 0;
            mItem.variations?.forEach((variation) {
              if(variation.name == varName){
                variation.quantity = (variation.quantity ?? 0) + 1;
              }
              varCount = varCount + (variation.quantity ?? 0);
            });
            mItem.quantity = varCount;
          }
        });
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
        _filterSubListCategoriesz.forEach((element) {
          element.items?.forEach((mItem) {
            if(mItem.id == item.id){
              mItem.quantity = quantity;
            }
          });
        });

        _subListCategoriesz.forEach((element) {
          element.items?.forEach((mItem) {
            if(mItem.id == item.id){
              mItem.quantity = quantity;
            }
          });
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
        _filterSubListCategoriesz.forEach((element) {
          element.items?.forEach((mItem) {
            if(mItem.id == item.id){
              int varCount = 0;
              mItem.variations?.forEach((variation) {
                if(variation.name == varName){
                  variation.quantity = quantity;
                }
                varCount = varCount + (variation.quantity ?? 0);
              });
              mItem.quantity = varCount;
            }
          });
        });
        _subListCategoriesz.forEach((element) {
          element.items?.forEach((mItem) {
            if(mItem.id == item.id){
              int varCount = 0;
              mItem.variations?.forEach((variation) {
                if(variation.name == varName){
                  variation.quantity = quantity;
                }
                varCount = varCount + (variation.quantity ?? 0);
              });
              mItem.quantity = varCount;
            }
          });
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
        _subListCategoriesz.forEach((mList) {
          mList.items?.forEach((mItem) {
            if(mItem.id == cartItem.itemId){
              int varCount = 0;
              mItem.variations?.forEach((mVar) {
                if(mVar.name == cartItem.varName){
                    mVar.quantity = finalQuantity;
                }
                varCount = varCount + (mVar.quantity ?? 0);
              });
              mItem.quantity = varCount;
            }
          });
        });
        _filterSubListCategoriesz.forEach((mList) {
          mList.items?.forEach((mItem) {
            if(mItem.id == cartItem.itemId){
              int varCount = 0;
              mItem.variations?.forEach((mVar) {
                if(mVar.name == cartItem.varName){
                  mVar.quantity = finalQuantity;
                }
                varCount = varCount + (mVar.quantity ?? 0);
              });
              mItem.quantity = varCount;
            }
          });
        });
      } else {
        _subListCategoriesz.forEach((mList) {
          mList.items?.forEach((mItem) {
            if(mItem.id == cartItem.itemId){
              mItem.quantity = finalQuantity;
            }
          });
        });
        _filterSubListCategoriesz.forEach((mList) {
          mList.items?.forEach((mItem) {
            if(mItem.id == cartItem.itemId){
              mItem.quantity = finalQuantity;
            }
          });
        });
      }

      notifyListeners();
    }
  }


  void resetItems() {
    _cartItems = [];
    _subListCategoriesz.forEach((element) {
      element.items?.forEach((eItems) {
        eItems.variations?.forEach((eVar) {
          eVar.quantity = 0;
        });
          eItems.quantity = 0;
      });
    });
    _filterSubListCategoriesz.forEach((element) {
      element.items?.forEach((eItems) {
        eItems.variations?.forEach((eVar) {
          eVar.quantity = 0;
        });
        eItems.quantity = 0;
      });
    });
    notifyListeners();
  }

  List<SubCategories> getSubcategory() {
    return List<SubCategories>.from(jsonDecode(jsonEncode(subListCategoriesz.toList())).map((model)=> SubCategories.fromJson(model)));
  }





}