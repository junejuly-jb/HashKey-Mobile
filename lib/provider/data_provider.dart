import 'package:flutter/cupertino.dart';

class DataProvider with ChangeNotifier{
  final List _cards = [1,2,3,4];
  List get cards => _cards;
}