
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier{

  // UserProvider(){
  //   getUserDetails();
  // }

  Map _user = {};

  Map get user => _user;

  Future getUserDetails() async{
    final prefs = await SharedPreferences.getInstance();
    final String? sharedPrefUser = prefs.getString('user');
    if(sharedPrefUser != null){
      final Map decoded = jsonDecode(sharedPrefUser.toString());
      _user = decoded;
    }
    else{
      _user = {};
    }
    notifyListeners();
  }

  void setUserDetails(Map data){
    _user = data;
    notifyListeners();
  }

  void updateBoolSetting(String type, bool val){
    _user['settings'][type] = val;
    notifyListeners();
  }
} 