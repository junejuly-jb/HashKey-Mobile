import 'package:flutter/cupertino.dart';

class AppStateProvider with ChangeNotifier{
  String _appState = 'home';
  bool numberState = false;
  bool letterState = false;
  bool sysmbolState = false;

  String get appState => _appState;

  void setAppState(String val){
    _appState = val;
    notifyListeners();
  }
}