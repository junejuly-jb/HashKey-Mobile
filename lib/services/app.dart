import 'dart:convert';

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
}