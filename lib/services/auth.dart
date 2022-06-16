import 'dart:convert';

import 'package:http/http.dart' as http;

class Auth{
  final baseURL = 'http://10.0.2.2:5000/api';

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
    try {
      var url = Uri.parse('$baseURL/login');
      var response = await http.post(url,
          body: {'email': email, 'password': password});
      Map decode = jsonDecode(response.body);
      return decode;
    } catch (e) {
      print(e);
    }
  }
}