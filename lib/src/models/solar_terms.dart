import 'package:cfm_learning/src/extensions/datetime_extensions.dart';
import 'package:lunar/lunar.dart';

class SolarTerms {
  SolarTerms({required this.lunar});

  final Lunar lunar;
  Solar get solar => lunar.getSolar();

  Map<String, Solar> currentSolarTerms() {
    final _terms = lunar.getJieQiTable();
    final _keys = _terms.keys;
    var _name = "";
    Map<String, Solar> currentRelated = {};
    for (var key in _keys) {
      if (_terms[key]!.getYear() == solar.getYear() &&
          _terms[key]!.getMonth() == solar.getMonth()) {
        _name = Lunar.fromDate(_terms[key]!.getDateTime()).getJieQi();
        currentRelated.putIfAbsent(_name, () => _terms[key]!);
      }
    }
    return currentRelated;
  }
}
