
import 'package:flutter/foundation.dart';

class SelectedValue<T> extends ChangeNotifier {
  SelectedValue(this._value);

  T _value;

  T get value => _value;

  set value(T value) {
    _value = value;
    notifyListeners();
  }
}