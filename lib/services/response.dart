import 'package:flutter/material.dart';
import 'package:hashkey/provider/user_provider.dart';
import 'package:hashkey/shared/widgets/alert.dart';
import 'package:provider/provider.dart';

class ResponseHandler {
   
  Widget response(Map data, BuildContext context){
    if(data['status'] == 401){
      return CustomAlert(
        message: data['message'], 
        type: 'error', 
        statusType: 'errorWithRedirect',
        callback: () {
          Provider.of<UserProvider>(context, listen: false).removeUser();
          Navigator.pushReplacementNamed(context, '/login');
        }
      );
    }
    else{
      return CustomAlert(message: data['message'], type: 'error', statusType: 'error', callback: () => Navigator.pop(context),);
    }
  //   // switch (data['status']) {
  //   //   case 401:
  //   //     return CustomAlert(message: data['message'], type: 'error');
  //   //     break;
  //   //   case 200:
  //   //     widget = CustomAlert(message: data['message'], type: 'error');
  //   // }
  }
}