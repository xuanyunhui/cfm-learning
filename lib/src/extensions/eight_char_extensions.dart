

import 'package:lunar/lunar.dart';

import 'lunar_util_extensions.dart';

extension EightCharExtensions on EightChar {

  List<String> getYearHiddenStems() => LunarUtilExt.hiddenStems[getYearZhi()]!;

  List<String> getMonthHiddenStems() => LunarUtilExt.hiddenStems[getMonthZhi()]!;

  List<String> getDayHiddenStems() => LunarUtilExt.hiddenStems[getDayZhi()]!;

  List<String> getHourHiddenStems() => LunarUtilExt.hiddenStems[getTimeZhi()]!;

  // The Relations
  List<String> getTheRelationsOfRoot(String root) {
    List<String> hiddenStems = LunarUtilExt.hiddenStems[root]!;
    List<String> l = <String>[];
    for (String gan in hiddenStems) {
      l.add(LunarUtil.SHI_SHEN_ZHI['${getDayGan()}$root$gan']!);
    }
    return l;
  }

  List<String> getYearTheRelationsOfRoot() => getTheRelationsOfRoot(getYearZhi());

  List<String> getMonthTheRelationsOfRoot() => getTheRelationsOfRoot(getMonthZhi());

  List<String> getDayTheRelationsOfRoot() => getTheRelationsOfRoot(getDayZhi());

  List<String> getHourTheRelationsOfRoot() => getTheRelationsOfRoot(getTimeZhi());
}