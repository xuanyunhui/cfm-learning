import 'package:cfm_learning/src/extensions/datetime_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lunar/lunar.dart';
import 'package:provider/provider.dart';

import 'data/icon_data.dart';
import '../generated/l10n.dart';
import 'drawerbuilder.dart';
import 'models/exam.dart';

class TimesetCalendar extends StatefulWidget {
  const TimesetCalendar({super.key});

  @override
  State<TimesetCalendar> createState() => _TimesetCalendarState();
}

class _TimesetCalendarState extends State<TimesetCalendar> {
  @override
  Widget build(BuildContext context) {
    // final List<DropdownMenuItem<String>> rootEntries =
    //     <DropdownMenuItem<String>>[];
    // for (final RootLabel root in RootLabel.values) {
    //   rootEntries.add(
    //       DropdownMenuItem<RootLabel>(value: root, child: Text(root.label)));
    // }

    final List<DropdownMenuItem<String>> stemEntries =
        <DropdownMenuItem<String>>[];
    final List<DropdownMenuItem<String>> rootEntries =
        <DropdownMenuItem<String>>[];

    for (final String stem in [
      '甲',
      '乙',
      '丙',
      '丁',
      '戊',
      '己',
      '庚',
      '辛',
      '壬',
      '癸'
    ]) {
      stemEntries.add(DropdownMenuItem<String>(value: stem, child: Text(stem)));
    }
    for (final String root in [
      '子',
      '丑',
      '寅',
      '卯',
      '辰',
      '巳',
      '午',
      '未',
      '申',
      '酉',
      '戌',
      '亥'
    ]) {
      rootEntries.add(DropdownMenuItem<String>(value: root, child: Text(root)));
    }

    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).timesetTitle),
        centerTitle: true,
      ),
      drawer: context.canPop() ? null : const NavigationDrawerBuilder(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ChangeNotifierProvider(
          create: (context) => TimesetModel(),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Consumer<TimesetModel>(
                        builder: (context, timeset, child) {
                      return DropdownButtonFormField<String>(
                        value: timeset.yearStem,
                        items: stemEntries,
                        onChanged: (String? stem) {
                          timeset.yearStem = stem!;
                        },
                        decoration: InputDecoration(
                            labelText: S.of(context).yearStemText,
                            border: const OutlineInputBorder(),
                            isDense: true),
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Consumer<TimesetModel>(
                        builder: (context, timeset, child) {
                      return TextField(
                        controller:
                            TextEditingController(text: timeset.monthStem),
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: S.of(context).monthStemText,
                            border: const OutlineInputBorder(),
                            isDense: true),
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Consumer<TimesetModel>(
                        builder: (context, timeset, child) {
                      return DropdownButtonFormField<String>(
                        value: timeset.dayStem,
                        items: stemEntries,
                        onChanged: (String? stem) {
                          timeset.dayStem = stem!;
                        },
                        decoration: InputDecoration(
                            labelText: S.of(context).dayStemText,
                            border: const OutlineInputBorder(),
                            isDense: true),
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Consumer<TimesetModel>(
                        builder: (context, timeset, child) {
                      return TextField(
                        controller:
                            TextEditingController(text: timeset.hourStem),
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: S.of(context).hourStemText,
                            border: const OutlineInputBorder(),
                            isDense: true),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              //Make a row of 4 dropdowns for root
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Consumer<TimesetModel>(
                        builder: (context, timeset, child) {
                      return DropdownButtonFormField<String>(
                        value: dropdownMenuItemBuilder(
                                rootsBuilder(timeset.yearStem))
                            .first
                            .value,
                        items: dropdownMenuItemBuilder(
                            rootsBuilder(timeset.yearStem)),
                        onChanged: (String? root) {
                          timeset.yearRoot = root!;
                        },
                        decoration: InputDecoration(
                            labelText: S.of(context).yearRootText,
                            border: const OutlineInputBorder(),
                            isDense: true),
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Consumer<TimesetModel>(
                        builder: (context, timeset, child) {
                      return DropdownButtonFormField<String>(
                        value: timeset.monthRoot,
                        items: rootEntries,
                        onChanged: (String? root) {
                          timeset.monthRoot = root!;
                        },
                        decoration: InputDecoration(
                            labelText: S.of(context).monthRootText,
                            border: const OutlineInputBorder(),
                            isDense: true),
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Consumer<TimesetModel>(
                        builder: (context, timeset, child) {
                      return DropdownButtonFormField<String>(
                        value: dropdownMenuItemBuilder(
                                rootsBuilder(timeset.dayStem))
                            .first
                            .value,
                        items: dropdownMenuItemBuilder(
                            rootsBuilder(timeset.dayStem)),
                        onChanged: (String? root) {
                          timeset.dayRoot = root!;
                        },
                        decoration: InputDecoration(
                            labelText: S.of(context).dayRootText,
                            border: const OutlineInputBorder(),
                            isDense: true),
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Consumer<TimesetModel>(
                        builder: (context, timeset, child) {
                      return DropdownButtonFormField<String>(
                        value: timeset.hourRoot,
                        items: rootEntries,
                        onChanged: (String? root) {
                          timeset.hourRoot = root!;
                        },
                        decoration: InputDecoration(
                            labelText: S.of(context).hourRootText,
                            border: const OutlineInputBorder(),
                            isDense: true),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Consumer<TimesetModel?>(
                  builder: (context, timeset, child) {
                    List<Solar> solars = Solar.fromBaZi(
                        timeset!.yearStem + timeset.yearRoot,
                        timeset.monthStem + timeset.monthRoot,
                        timeset.dayStem + timeset.dayRoot,
                        timeset.hourStem + timeset.hourRoot,
                        sect: 1);
                    // if (solar != null) {
                    //   lunar = Solar.fromDate(value.localSolarTime).getLunar();
                    // }
                    return Column(
                      children: [
                        for (final solar in solars)
                          ListTile(
                            leading: Text('${S.of(context).gongliText}:'),
                            title: Text(solar.toYmdHms()),
                            trailing: IconButton(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                randomEighthNoteIcon(),
                                size: 30,
                              ),
                              onPressed: () {
                                context.push(
                                  "/qimen/${solar.toYmdHms()}",
                                );
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) {
                                //   return QiMenContent(
                                //     date: solar.getDateTime(),
                                //   );
                                // }));
                              },
                              style: IconButton.styleFrom(
                                foregroundColor: colors.onSecondaryContainer,
                                backgroundColor: colors.secondaryContainer,
                                disabledBackgroundColor:
                                    colors.onSurface.withOpacity(0.12),
                                hoverColor: colors.onSecondaryContainer
                                    .withOpacity(0.08),
                                focusColor: colors.onSecondaryContainer
                                    .withOpacity(0.12),
                                highlightColor: colors.onSecondaryContainer
                                    .withOpacity(0.12),
                              ),
                            ),
                            onLongPress: () {
                              Clipboard.setData(ClipboardData(text: solar.getDateTime().toIso8601String()));
                            },
                          ),
                      ],
                    );
                  },
                ),
              ),
              // FilledButton(
              //   onPressed: () {
              //     setState(() {
              //     });
              //   },
              //    child: const Text('刷新题目')
              // ),
              // training(result),
            ],
          ),
        ),
      )),
    );
  }

  List<DropdownMenuItem<String>> dropdownMenuItemBuilder(List<String> items) {
    List<DropdownMenuItem<String>> entries = <DropdownMenuItem<String>>[];
    for (final String item in items) {
      entries.add(DropdownMenuItem<String>(value: item, child: Text(item)));
    }
    return entries;
  }

  List<String> rootsBuilder(String stem) {
    List<String> roots = [];
    switch (stem) {
      case '甲':
      case '丙':
      case '戊':
      case '庚':
      case '壬':
        roots = ['子', '寅', '辰', '午', '申', '戌'];
        break;
      case '乙':
      case '丁':
      case '己':
      case '辛':
      case '癸':
        roots = ['丑', '卯', '巳', '未', '酉', '亥'];
        break;
    }
    return roots;
  }
}

class ResultNotifier with ChangeNotifier {
  ValueNotifier<bool?> result = ValueNotifier<bool?>(null);
}

class SelectedNotifier with ChangeNotifier {
  ValueNotifier<StemLabel?> selectedStem =
      ValueNotifier<StemLabel?>(StemLabel.jia);
  ValueNotifier<RootLabel?> selectedRoot =
      ValueNotifier<RootLabel?>(RootLabel.zi);
}

enum MonthColumn {
  jia(3),
  yi(15),
  bing(27),
  ding(39),
  wu(51),
  ji(3),
  geng(15),
  xin(27),
  ren(39),
  gui(51);

  const MonthColumn(this.cycleIndex);
  final int cycleIndex;
}

enum DayColumn {
  jia(51),
  yi(3),
  bing(15),
  ding(27),
  wu(39),
  ji(51),
  geng(3),
  xin(15),
  ren(27),
  gui(39);

  const DayColumn(this.cycleIndex);
  final int cycleIndex;
}

class TimesetModel extends ChangeNotifier {
  String _yearStem = '甲';
  String _yearRoot = '子';
  String _monthStem = '丙';
  String _monthRoot = '寅';
  String _dayStem = '甲';
  String _dayRoot = '子';
  String _hourStem = '甲';
  String _hourRoot = '子';

  String get yearStem => _yearStem;
  String get yearRoot => _yearRoot;
  String get monthStem => _monthStem;
  String get monthRoot => _monthRoot;
  String get dayStem => _dayStem;
  String get dayRoot => _dayRoot;
  String get hourStem => _hourStem;
  String get hourRoot => _hourRoot;

  List<String> get monthStemList => monthStemsBuilder();
  List<String> get hourStemList => hourStemsBuilder();

  static List<String> get stemList =>
      ['甲', '乙', '丙', '丁', '戊', '己', '庚', '辛', '壬', '癸'];
  static List<String> get monthRootList =>
      ['寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥', '子', '丑'];
  static List<String> get hourRootList =>
      ['子', '丑', '寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥'];

  List<String> monthStemsBuilder() {
    List<String> stems = [];
    switch (_yearStem) {
      case '甲':
      case '己':
        stems = ['丙', '丁', '戊', '己', '庚', '辛', '壬', '癸', '甲', '乙', '丙', '丁'];
        break;
      case '乙':
      case '庚':
        stems = ['戊', '己', '庚', '辛', '壬', '癸', '甲', '乙', '丙', '丁', '戊', '己'];
        break;
      case '丙':
      case '辛':
        stems = ['庚', '辛', '壬', '癸', '甲', '乙', '丙', '丁', '戊', '己', '庚', '辛'];
        break;
      case '丁':
      case '壬':
        stems = ['壬', '癸', '甲', '乙', '丙', '丁', '戊', '己', '庚', '辛', '壬', '癸'];
        break;
      case '戊':
      case '癸':
        stems = ['甲', '乙', '丙', '丁', '戊', '己', '庚', '辛', '壬', '癸', '甲', '乙'];
        break;
    }
    return stems;
  }

  List<String> hourStemsBuilder() {
    List<String> stems = [];
    switch (_dayStem) {
      case '甲':
      case '己':
        stems = ['甲', '乙', '丙', '丁', '戊', '己', '庚', '辛', '壬', '癸', '甲', '乙'];
        break;
      case '乙':
      case '庚':
        stems = ['丙', '丁', '戊', '己', '庚', '辛', '壬', '癸', '甲', '乙', '丙', '丁'];
        break;
      case '丙':
      case '辛':
        stems = ['戊', '己', '庚', '辛', '壬', '癸', '甲', '乙', '丙', '丁', '戊', '己'];
        break;
      case '丁':
      case '壬':
        stems = ['庚', '辛', '壬', '癸', '甲', '乙', '丙', '丁', '戊', '己', '庚', '辛'];
        break;
      case '戊':
      case '癸':
        stems = ['壬', '癸', '甲', '乙', '丙', '丁', '戊', '己', '庚', '辛', '壬', '癸'];
        break;
    }
    return stems;
  }

  set yearStem(String yearStem) {
    _yearStem = yearStem;
    _monthStem = monthStemsBuilder()[monthRootList.indexOf(monthRoot)];
    notifyListeners();
  }

  set yearRoot(String yearRoot) {
    _yearRoot = yearRoot;
    notifyListeners();
  }

  set monthStem(String monthStem) {
    _monthStem = monthStem;
    notifyListeners();
  }

  set monthRoot(String monthRoot) {
    _monthRoot = monthRoot;
    _monthStem = monthStemsBuilder()[monthRootList.indexOf(monthRoot)];
    notifyListeners();
  }

  set dayStem(String dayStem) {
    _dayStem = dayStem;
    _hourStem = hourStemsBuilder()[hourRootList.indexOf(hourRoot)];
    notifyListeners();
  }

  set dayRoot(String dayRoot) {
    _dayRoot = dayRoot;
    notifyListeners();
  }

  set hourStem(String hourStem) {
    _hourStem = hourStem;
    notifyListeners();
  }

  set hourRoot(String hourRoot) {
    _hourRoot = hourRoot;
    _hourStem = hourStemsBuilder()[hourRootList.indexOf(hourRoot)];
    notifyListeners();
  }
}
