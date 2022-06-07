import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class ConnectionProvider with ChangeNotifier{
  final _connectivity = Connectivity();
  bool connectionState = false;

  void checkConnection() async{
    final res = await _connectivity.checkConnectivity();
    connectionState = _checkConnectionType(res);
    _connectivity.onConnectivityChanged.listen((event){
      connectionState = _checkConnectionType(res);
    });
     notifyListeners();
  }

  _checkConnectionType(ConnectivityResult res){
    if(res == ConnectivityResult.none){
      return false;
    }
    return true;
  }
}