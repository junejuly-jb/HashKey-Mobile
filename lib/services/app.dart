import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hashkey/services/auth.dart';
import 'package:http/http.dart' as http;

class App{
  final baseURL = 'https://hashkey-api.vercel.app/api/v2';

  Future<dynamic> getCollectionLength() async{
    try {
      var url = Uri.parse('$baseURL/collection-length');
      String token = await Auth().getToken();
      var response = await http.get(url, headers: {'Authorization': 'Bearer $token'});
      Map decode = jsonDecode(response.body);
      return decode;
    } catch (e) {
      print(e);
    }
  }

  Future addPin(String pin) async {
    Map decode;
    try {
      var url = Uri.parse('$baseURL/add-pin');
      String? token = await Auth().getToken();
      if(token != null){
        var response = await http.post(url, 
          body: { 'pin': pin },
          headers: {'Authorization': 'Bearer $token'}
        );
        decode = jsonDecode(response.body);
        return decode;
      }
      else{
        decode = {
          "success": false,
          "status": 401,
          "message": "Invalid token"
        };
        return decode;
      }
    }
    on SocketException catch (e) {
      decode = {
        "success": false,
        "message": e.message,
        "status": 000
      };
    }
    on TimeoutException catch (e){
      decode = {
        "success": false,
        "message": e.message,
        "status": 000
      };
    }
    // ignore: unused_catch_clause
    on Error catch (e){
      decode = {
        "success": false,
        "message": 'Server error please try again later',
        "status": 000
      };
    }
    return decode;
  }
}