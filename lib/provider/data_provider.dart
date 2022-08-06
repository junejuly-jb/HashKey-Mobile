
import 'package:flutter/cupertino.dart';
import 'package:hashkey/models/category.dart';
import 'package:hashkey/models/contact.dart';
import 'package:hashkey/models/license.dart';
import 'package:hashkey/models/note.dart';
import 'package:hashkey/models/password.dart';
import 'package:hashkey/models/payment.dart';
import 'package:hashkey/models/recent.dart';
import 'package:hashkey/models/wifi.dart';

class DataProvider with ChangeNotifier{
  List<Category> cards = [];
  List<Recent> recents = [];
  
  List<Password> passwords = [];
  List<Wifi> wifis = [];
  List<Payment> payments = [];
  List<Contact> contacts = [];
  List<License> licenses = [];
  List<Note> notes = [];

  setCards(List collectionList){
    for(var el in collectionList){
      Category category = Category.fromJson(el);
      cards.add(category);
    }
    notifyListeners();
  }

  setEmpty(){
    cards = [];
    recents = [];
    passwords = [];
    wifis = [];
  }

  setRecents(List recentList){
    for(var el in recentList){
      Recent recent = Recent.fromJson(el);
      recents.add(recent);
    }
    notifyListeners();
  }

  setRecent(Map<String, dynamic> data){
    Recent recent = Recent.fromJson(data);
    recents.insert(0, recent);
    notifyListeners();
  }

  incrementCategoryCount(String type, String action){
    int indx = cards.indexWhere((element) => element.category == type);
    if(action == 'increment'){
      cards[indx].count = cards[indx].count + 1;
    }
    else{
      cards[indx].count = cards[indx].count - 1;
    }
    notifyListeners();
  }

  setPasswords(List data){
    for(var el in data){
      Password password = Password.fromJson(el);
      passwords.add(password);
    }
    notifyListeners();
  }

  setWifis(List data){
    for(var el in data){
      Wifi wifi = Wifi.fromJson(el);
      wifis.add(wifi);
    }
    notifyListeners();
  }

  setPayments(List data){
    for(var el in data){
      Payment payment = Payment.fromJson(el);
      payments.add(payment);
    }
    notifyListeners();
  }

  getCategoryType(String type){
    if(type == 'password'){
       return passwords;
    }
    else if(type == 'wifi'){
      return wifis;
    }
    else{
      return payments;
    }
  }

  setNewData(Map<String, dynamic> data, String type){
    switch (type) {
      case 'Password':
        Password password = Password.fromJson(data);
        passwords.insert(0, password);
        break;
      case 'Wifi':
        Wifi wifi = Wifi.fromJson(data);
        wifis.insert(0, wifi);
        break;
      case 'Payment':
        Payment payment = Payment.fromJson(data);
        payments.insert(0, payment);
        break;
      case 'Contact':
        Contact contact = Contact.fromJson(data);
        contacts.insert(0, contact);
        break;
      case 'License':
        License license = License.fromJson(data);
        licenses.insert(0, license);
        break;
      case 'Note':
        Note note = Note.fromJson(data);
        notes.insert(0, note);
        break;
    }
  }

}