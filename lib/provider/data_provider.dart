import 'package:flutter/cupertino.dart';
import 'package:hashkey/models/category.dart';

class DataProvider with ChangeNotifier{
  final List<Category> cards = [];
  // List get cards => _cards;

  setCards(List collectionList){
    // collectionList.forEach((element) { 
    //   Category category = Category.fromJson(element);
    //   _cards.add(category);
    // });
    // print(collectionList.length);
    // for(var i = 0; collectionList.length > i; i++){
    //   _cards.add(collectionList[i]);
    // }

    for(var el in collectionList){
      Category category = Category.fromJson(el);
      cards.add(category);
    }
    notifyListeners();
  }
}