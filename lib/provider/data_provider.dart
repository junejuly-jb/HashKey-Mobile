
import 'package:flutter/cupertino.dart';
import 'package:hashkey/models/category.dart';
import 'package:hashkey/models/password.dart';
import 'package:hashkey/models/recent.dart';
import 'package:hashkey/models/wifi.dart';

class DataProvider with ChangeNotifier{
  List<Category> cards = [];
  List<Recent> recents = [];
  
  List<Password> passwords = [];
  List<Wifi> wifis = [];

  setCards(List collectionList){
    for(var el in collectionList){
      Category category = Category.fromJson(el);
      cards.add(category);
    }
    notifyListeners();
  }

  setEmpty(){
    cards = [];
    recents = [];
    passwords = [];
    wifis = [];
  }

  setRecents(List recentList){
    for(var el in recentList){
      Recent recent = Recent.fromJson(el);
      recents.add(recent);
    }
    notifyListeners();
  }

  setRecent(Map<String, dynamic> data){
    Recent recent = Recent.fromJson(data);
    recents.insert(0, recent);
    notifyListeners();
  }

  incrementCategoryCount(String type, String action){
    int indx = cards.indexWhere((element) => element.category == type);
    if(action == 'increment'){
      cards[indx].count = cards[indx].count + 1;
    }
    else{
      cards[indx].count = cards[indx].count - 1;
    }
    notifyListeners();
  }

  getPasswords(List data){
    for(var el in data){
      Password password = Password.fromJson(el);
      passwords.add(password);
    }
    notifyListeners();
  }

  getWifis(List data){
    for(var el in data){
      Wifi wifi = Wifi.fromJson(el);
      wifis.add(wifi);
    }
    notifyListeners();
  }

  getCategoryType(String type){
    if(type == 'password'){
       return passwords;
    }
    else{
      return wifis;
    }
  }

}