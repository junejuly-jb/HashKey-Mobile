import 'package:flutter/cupertino.dart';

class AppStateProvider with ChangeNotifier{
  String _appState = 'home';
  String get appState => _appState;

  void setAppState(String val){
    _appState = val;
    notifyListeners();
  }
}