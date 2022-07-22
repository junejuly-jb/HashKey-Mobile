import 'package:flutter/cupertino.dart';
import 'package:hashkey/models/category.dart';
import 'package:hashkey/models/password.dart';
import 'package:hashkey/models/recent.dart';

class DataProvider with ChangeNotifier{
  List<Category> cards = [];
  List<Recent> recents = [];
  final List<Password> passwords = [];

  setCards(List collectionList){
    for(var el in collectionList){
      Category category = Category.fromJson(el);
      cards.add(category);
    }
    notifyListeners();
  }

  setEmpty(){
    cards = [];
  }

  setRecents(List recentList){
    for(var el in recentList){
      Recent recent = Recent.fromJson(el);
      recents.add(recent);
    }
    notifyListeners();
  }

}