import 'dart:convert';

import 'package:hashkey/services/auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class App{
  final baseURL = 'http://10.0.2.2:5000/api';

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
}