import 'package:e_commerce_app/phonecard.dart';
import 'package:flutter/material.dart';

class stateProvider with ChangeNotifier {
  List<phoneData> _phoneList = [];

  List<phoneData> get phonelist => _phoneList;

  void addItem(phoneData data) {
    _phoneList.add(data);
    print(_phoneList[0].phoneName);
    notifyListeners();
  }

  void removeItem(phoneData data) {
    _phoneList.remove(data);
    notifyListeners();
  }
}
