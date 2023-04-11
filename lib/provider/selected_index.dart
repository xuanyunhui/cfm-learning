import 'package:flutter/material.dart';

class SelectedIndex extends ChangeNotifier {
  int _index = 0;

  SelectedIndex(this._index);

  int get index => _index;
  
  set index(int index) {
    _index = index;
    notifyListeners();
  }
}