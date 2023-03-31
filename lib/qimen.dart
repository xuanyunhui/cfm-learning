import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
import 'package:lunar/lunar.dart';
import 'package:qimen/qimen.dart';

import 'drawerbuilder.dart';

import 'datetime_extensions.dart';

class QiMenContent extends StatefulWidget {
  const QiMenContent({Key? key}) : super(key: key);

  // final Lunar lunar;

  @override
  State<QiMenContent> createState() => _QiMenContentState();
}

const String MIN_DATETIME = '0001-01-01 00:00:00';
const String MAX_DATETIME = '9998-12-31 23:59:59';
const String DATE_FORMAT = 'yyyy-MM-dd,H时:m分';

class _QiMenContentState extends State<QiMenContent>
    with SingleTickerProviderStateMixin {
  TextEditingController _solarTextEditingController = TextEditingController(),
      _lunarTextEditingController = TextEditingController();
  TextEditingController _timesetTextEditingController = TextEditingController();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  // DateTime _dateTime = DateTime.now();
  late Lunar lunar;
  late QiMen qimen;

  @override
  void initState() {
    lunar = Lunar.fromDate(DateTime.now());
    qimen = QiMen(lunar);
    super.initState();
  }

  @override
  void dispose() {
    _lunarTextEditingController.dispose();
    _solarTextEditingController.dispose();
    _timesetTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("奇门"),
          centerTitle: true,
        ),
        drawer: const NavigationDrawerBuilder(),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller:
                            dateController, //editing controller of this TextField
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "日期",
                          isDense: true,
                        ),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            dateController.text =
                                DateFormat.yMMMMd().format(pickedDate);
                            setState(() {
                              lunar = lunar.setDate(pickedDate);
                              qimen = QiMen(lunar);
                            });
                          }
                        }),
                  ),
                  Expanded(
                    child: TextField(
                        controller:
                            timeController, //editing controller of this TextField
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "时间",
                            isDense: true),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            timeController.text =
                                pickedTime.format(context).toString();
                            setState(() {
                              lunar = lunar.setTimeOfDay(pickedTime);
                              qimen = QiMen(lunar);
                            });
                          }
                        }),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(width: sqrt1_2),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                              EightChar.fromLunar(lunar).getYearGan() +
                                  EightChar.fromLunar(lunar).getMonthGan() +
                                  EightChar.fromLunar(lunar).getDayGan() +
                                  EightChar.fromLunar(lunar).getTimeGan(),
                              style: const TextStyle(
                                  color: Color.fromRGBO(85, 79, 86, 1))),
                          Text(
                              EightChar.fromLunar(lunar).getYearZhi() +
                                  EightChar.fromLunar(lunar).getMonthZhi() +
                                  EightChar.fromLunar(lunar).getDayZhi() +
                                  EightChar.fromLunar(lunar).getTimeZhi(),
                              style: const TextStyle(
                                  color: Color.fromRGBO(85, 79, 86, 1))),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 115, 10, 10),
                      thickness: 1,
                      height: 20,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("值使门",
                              style: TextStyle(
                                  color: Color.fromRGBO(85, 79, 86, 1))),
                          Text(
                            qimen.getWatchman(),
                            style: const TextStyle(
                                color: Color.fromRGBO(85, 79, 86, 1)),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("旬首",
                              style: TextStyle(
                                  color: Color.fromRGBO(85, 79, 86, 1))),
                          Text(qimen.getFirstOfTenDays(format: false),
                              style: const TextStyle(
                                  color: Color.fromRGBO(85, 79, 86, 1))),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("局数",
                              style: TextStyle(
                                  color: Color.fromRGBO(85, 79, 86, 1))),
                          Text(
                              "${qimen.isYang() ? "阳" : "阴"}${qimen.sequence()}局",
                              style: const TextStyle(
                                  color: Color.fromRGBO(85, 79, 86, 1))),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("空亡",
                              style: TextStyle(
                                  color: Color.fromRGBO(85, 79, 86, 1))),
                          Text(lunar.getTimeXunKong(),
                              style: const TextStyle(
                                  color: Color.fromRGBO(85, 79, 86, 1))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 24,
                thickness: 1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      magicSquareUnit(context, 3),
                      const SizedBox(width: sqrt2),
                      magicSquareUnit(context, 8),
                      const SizedBox(width: sqrt2),
                      magicSquareUnit(context, 1),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      magicSquareUnit(context, 2),
                      const SizedBox(width: sqrt2),
                      magicSquareUnit(context, 4),
                      const SizedBox(width: sqrt2),
                      magicSquareUnit(context, 6),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      magicSquareUnit(context, 7),
                      const SizedBox(width: sqrt2),
                      magicSquareUnit(context, 0),
                      const SizedBox(width: sqrt2),
                      magicSquareUnit(context, 5)
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget magicSquareUnit(BuildContext context, int palace) {
    const TextStyle boxTextStyle =
        TextStyle(color: Colors.white70, fontSize: 15);
    const double PALACESIZE = 120;
    const double RADIUSSIZE = 5;
    const Color boxColor = Color.fromRGBO(210, 92, 120, 1);
    const double OUTER = 4.0;
    const double INNER = 4.0;
    const palaceName = ["坎1", "坤2", "震3", "巽4", "中5", "乾6", "兑7", "艮8", "离9"];

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(RADIUSSIZE)),
        color: boxColor,
      ),
      // margin: const EdgeInsets.fromLTRB(OUTER, OUTER, OUTER, OUTER),
      width: PALACESIZE,
      height: PALACESIZE,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                const Expanded(
                  child: Center(
                      child: Text(
                    "",
                    style: boxTextStyle,
                  )),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      (qimen.jiuxing()[palace] == "天芮")
                          ? "${qimen.jiuxing()[palace]}-禽"
                          : qimen.jiuxing()[palace],
                      style: boxTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      (palace == 4)
                          ? ""
                          : (qimen.tianpan()[palace] == qimen.dipan()[1])
                              ? "${qimen.tianpan()[palace]}-${qimen.dipan()[4]}"
                              : qimen.tianpan()[palace],
                      style: boxTextStyle,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    qimen.bashen()[palace],
                    style: boxTextStyle,
                  )),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const Expanded(
                  child: Center(
                      child: Text(
                    "",
                    style: boxTextStyle,
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    qimen.bamen()[palace],
                    style: boxTextStyle,
                  )),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Center(
                      child: Text(
                    (qimen.dipan()[palace] == qimen.dipan()[1])
                        ? "${qimen.dipan()[palace]}-${qimen.dipan()[4]}"
                        : qimen.dipan()[palace],
                    style: boxTextStyle,
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    palaceName[palace],
                    style: boxTextStyle,
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class Timesets extends EightChar {
//   Timesets(Lunar lunar) : super(lunar) {
//     super.setSect(1);
//   }

//   Timesets.from
// }
