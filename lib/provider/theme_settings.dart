import 'package:cfm_learning/extensions/enum_type.dart';
import 'package:cfm_learning/themes/timesets-app/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../themes/timesets-app/custom_color.g.dart';

class ThemeSettings extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  ThemeSettings() {
    persistent();
  }

  set index(int index) {
    _index = index;
    notifyListeners();
  }

  void setTheme(int index) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _index =
        await sharedPreferences.setInt('theme', index).then((bool success) {
      return index;
    });
    notifyListeners();
  }

  getlightColorScheme() {
    switch (_index) {
      case 0:
        return generateColorScheme(ColorsOfYear.vivaMagenta.color(), false);
      case 1:
        return generateColorScheme(ColorsOfYear.veryPeri.color(), false);
      case 2:
        return generateColorScheme(ColorsOfYear.illuminating.color(), false);
      case 3:
        return generateColorScheme(ColorsOfYear.classicBlue.color(), false);
      case 4:
        return generateColorScheme(ColorsOfYear.livingCoral.color(), false);
      case 5:
        return generateColorScheme(ColorsOfYear.ultraViolet.color(), false);
      case 6:
        return timesetsLightColorScheme;
      default:
        return timesetsLightColorScheme;
    }
  }

  getdarkColorScheme() {
    switch (_index) {
      case 0:
        return generateColorScheme(ColorsOfYear.vivaMagenta.color(), true);
      case 1:
        return generateColorScheme(ColorsOfYear.veryPeri.color(), true);
      case 2:
        return generateColorScheme(ColorsOfYear.illuminating.color(), true);
      case 3:
        return generateColorScheme(ColorsOfYear.classicBlue.color(), true);
      case 4:
        return generateColorScheme(ColorsOfYear.livingCoral.color(), true);
      case 5:
        return generateColorScheme(ColorsOfYear.ultraViolet.color(), true);
      case 6:
        return timesetsDarkColorScheme;
      default:
        return timesetsDarkColorScheme;
    }
  }

  getLightCustomColors() {
    switch (_index) {
      case 0:
        return timesetsLightCustomColors;
      default:
        return timesetsLightCustomColors;
    }
  }

  getDarkCustomColors() {
    switch (_index) {
      case 0:
        return timesetsDarkCustomColors;
      default:
        return timesetsDarkCustomColors;
    }
  }

  generateColorScheme(Color color, bool isDark) {
    return isDark
        ? ColorScheme.fromSeed(seedColor: color, brightness: Brightness.dark)
        : ColorScheme.fromSeed(seedColor: color, brightness: Brightness.light);
  }

  persistent() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _index = sharedPreferences.getInt('theme') ?? 0;
    notifyListeners();
  }
}
