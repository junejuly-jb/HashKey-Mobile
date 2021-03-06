
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier{
  
  Map _user = {};

  Map get user => _user;
  String theme = 'dark';

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

  void removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');
    if(user != null){
      prefs.remove('user');
    }
  }

  void setPinState() async {
    final prefs = await SharedPreferences.getInstance();
    final String? a = prefs.getString('user');
    if(a != null){
      Map user = jsonDecode(a);
      user['pin'] = true;
      _user['pin'] = true;
      prefs.setString('user', jsonEncode(user));
    }
    notifyListeners();
  }

  void removeUserState() {
    _user = {};
  }

  Future updateRefreshToken(String newToken) async{
    final prefs = await SharedPreferences.getInstance();
    String? a = prefs.getString('user');
    if(a != null){
      Map user = jsonDecode(a);
      user['refreshToken'] = newToken;
      _user['settings']['refreshToken'] = newToken;
      String newUser = jsonEncode(user);
      prefs.setString('user', newUser);
    }
  }

  setTheme(){
    if(theme == 'dark'){
      theme = 'light';
    }
    else{
      theme = 'dark';
    }
    notifyListeners();
  }
} 