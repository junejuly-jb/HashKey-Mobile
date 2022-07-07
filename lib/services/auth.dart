import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth{
  final baseURL = 'https://hashkey-api.vercel.app/api/v2';

  Future<dynamic> register(String name, String email, String password) async{
    try {
      var url = Uri.parse('$baseURL/register');
      var response = await http.post(url,
          body: {'name': name, 'email': email, 'password': password});
      Map decode = jsonDecode(response.body);
      return decode;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> login(String email, String password) async{
    Map decode;
    try {
      var url = Uri.parse('$baseURL/login');
      var response = await http.post(url,
          body: {'email': email, 'password': password});
      print(response);
      decode = jsonDecode(response.body);
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
    on Error catch (e) {
      decode = {
        "success": false,
        "message": 'Server error please try again later',
        "status": 000
      };
    }

    return decode;
  }

  Future getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? a = prefs.getString('user');
    if(a != null){
      Map user = jsonDecode(a);
      return user['token'];
    }
    return null;
  }
}