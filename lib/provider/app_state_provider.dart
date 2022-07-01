// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hashkey/models/password.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider with ChangeNotifier{
  String _tabState = 'home';
  String randomString = '';
  String passLength = '10';
  bool upperCaseState = false;
  bool lowerCaseState = false;
  bool numberState = false;
  bool symbolState = false;

  String get appState => _tabState;

  void setAppState(String val){
    _tabState = val;
    notifyListeners();
  }

  void initGenerateSetting() async{
    final prefs = await SharedPreferences.getInstance();
    final String? sharedPrefSetting = prefs.getString('generate-setting');
    if(sharedPrefSetting == null){
      final Map a = {
        "length": passLength,
        "upperCaseState": upperCaseState,
        "lowerCaseState": lowerCaseState,
        "numberState": numberState,
        "symbolState": symbolState
      };
      String encoded = jsonEncode(a);
      prefs.setString('generate-setting', encoded);
    }
    else{
      final Map a = jsonDecode(sharedPrefSetting);
      passLength = a['length'];
      upperCaseState = a['upperCaseState'];
      lowerCaseState = a['lowerCaseState'];
      numberState = a['numberState'];
      symbolState = a['symbolState'];
    }
    notifyListeners();
  }

  void updateGenerateSetting(String type, String type2, String? val, bool? val2) async {
    final prefs = await SharedPreferences.getInstance();
    final String? sharedPrefSetting = prefs.getString('generate-setting');
    if(sharedPrefSetting != null){
      if(type2 == 'string'){
        updateStringState(type, val.toString());
      }
      else{
        updateBoolState(type, val2!);
        Map a = jsonDecode(sharedPrefSetting);
        switch (type) {
          case 'upperCaseState':
            a['upperCaseState'] = val2;
            break;
          case 'lowerCaseState':
            a['lowerCaseState'] = val2;
            break;
          case 'numberState':
            a['numberState'] = val2;
            break;
          case 'symbolState':
            a['symbolState'] = val2;
            break;
        }
        String b = jsonEncode(a);
        prefs.setString('generate-setting', b);
      }
    }
  }

  void updateStringState(String val, String val2){
    switch (val) {
      case 'passLength':
        passLength = val2;
        break;
      default:
        _tabState = val2;
    }
    notifyListeners();
  }

  void updateBoolState(String type, bool val){
    switch (type) {
      case 'upperCaseState':
        upperCaseState = val;
        break;
      case 'lowerCaseState':
        lowerCaseState = val;
        break;
      case 'numberState':
        numberState = val;
        break;
      case 'symbolState':
        symbolState = val;
    }
    notifyListeners();
  }

  void generateRandomString(){
    final password = RandomPasswordGenerator();
    String newPassword = password.randomPassword(
      letters: lowerCaseState,
      uppercase: upperCaseState, 
      numbers: numberState, 
      specialChar: symbolState, 
      passwordLength: double.parse(passLength)
    );
    randomString = newPassword;
    notifyListeners();
  }
}