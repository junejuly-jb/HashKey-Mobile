import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{

  String theme = '';

  ThemeProvider(String val) {
    theme = val;
  }


  setTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userTheme = prefs.getString('theme');
    if(userTheme == 'light'){
      theme = 'dark';
      prefs.setString('theme', 'dark');
    }
    else{
      theme = 'light';
      prefs.setString('theme', 'light');
    }
    notifyListeners();
  }


}