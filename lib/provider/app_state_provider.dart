
import 'package:flutter/cupertino.dart';
import 'package:random_password_generator/random_password_generator.dart';

class AppStateProvider with ChangeNotifier{

  //card state loading
  bool isCardLoading = false;

  //bottom app bar STATE
  String _tabState = 'home';

  //generate tab
  String randomString = '';
  double passLength = 10;
  bool upperCaseState = false;
  bool lowerCaseState = false;
  bool numberState = false;
  bool symbolState = false;

  String get appState => _tabState;

  void setAppState(String val){
    _tabState = val;
    notifyListeners();
  }

  void updateStringState(String val, String val2){
    switch (val) {
      case '_tabState':
        _tabState = val2;
        break;
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
        break;
      case 'isCardLoading':
        isCardLoading = val;
        break;
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
      passwordLength: passLength.toDouble()
    );
    randomString = newPassword;
    notifyListeners();
  }


  void updatePassLength(double val) async {
    passLength = val;
    notifyListeners();
  }

  void setAppStateOnLogout(){
    _tabState = 'home';
  }
}