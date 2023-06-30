import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
import 'package:lunar/lunar.dart';
import 'package:provider/provider.dart';
import 'package:qimen/qimen.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart' show Share;

import 'drawerbuilder.dart';
import 'extensions/datetime_extensions.dart';
import '../generated/l10n.dart';
import 'shared/utils/color_of_element.dart';

class QiMenContent extends StatefulWidget {
  final DateTime? date;

  const QiMenContent({Key? key, this.date}) : super(key: key);

  @override
  State<QiMenContent> createState() => _QiMenContentState();
}

const String MIN_DATETIME = '0001-01-01 00:00:00';
const String MAX_DATETIME = '9998-12-31 23:59:59';
const String DATE_FORMAT = 'yyyy-MM-dd,H时:m分';

class _QiMenContentState extends State<QiMenContent>
    with SingleTickerProviderStateMixin {
  final TextEditingController _solarTextEditingController =
          TextEditingController(),
      _lunarTextEditingController = TextEditingController();
  final TextEditingController _timesetTextEditingController =
      TextEditingController();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  final ScreenshotController screenshotController = ScreenshotController();

  // DateTime _dateTime = DateTime.now();
  late Solar solar;
  late Lunar lunar;
  late QiMen qimen;

  @override
  void initState() {
    if (widget.date == null) {
      solar = Solar.fromDate(DateTime.now());
    } else {
      solar = Solar.fromDate(widget.date!);
    }
    lunar = solar.getLunar();
    qimen = QiMen(lunar);
    dateController.text = solar.toYmd();
    timeController.text = solar.toHM();
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
    final Locale locale = Localizations.localeOf(context);
    final String languageCode = Localizations.localeOf(context).languageCode;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).qimenTitle),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () async {
                final Uint8List? imageInUnit8List =
                    await screenshotController.capture();
                XFile file = XFile.fromData(imageInUnit8List!,
                    name: "image.jpg", mimeType: "image/jpeg");
                await Share.shareXFiles([file], text: "奇门排盘");
              },
            ),
          ],
        ),
        drawer: context.canPop() ? null : const NavigationDrawerBuilder(),
        body: MultiProvider(
          providers: [Provider.value(value: lunar)],
          child: SingleChildScrollView(
            child: Screenshot(
              controller: screenshotController,
              child: Container(
                color: Theme.of(context).colorScheme.background,
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
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: S.of(context).date,
                                isDense: true,
                              ),
                              readOnly: true, // when true user cannot edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    locale: locale,
                                    context: context,
                                    initialDate: DateTime.parse(
                                        solar.toYmd()), //get today's date
                                    firstDate: DateTime(
                                        1900), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2301));
                                if (pickedDate != null) {
                                  dateController.text =
                                      DateFormat.yMMMMd(languageCode)
                                          .format(pickedDate);
                                  setState(() {
                                    solar = solar.setDate(pickedDate);
                                    lunar = solar.getLunar();
                                    qimen = QiMen(lunar);
                                  });
                                }
                              }),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                              controller:
                                  timeController, //editing controller of this TextField
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: S.of(context).time,
                                  isDense: true),
                              readOnly: true, // when true user cannot edit text
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      DateTime.parse(solar.toYmdHms())),
                                );
                                if (pickedTime != null) {
                                  timeController.text =
                                      "${pickedTime.hour}:${pickedTime.minute}";
                                  setState(() {
                                    solar = solar.setTimeOfDay(pickedTime);
                                    lunar = solar.getLunar();
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
                    Card(
                      // padding: const EdgeInsets.all(8),
                      // decoration: BoxDecoration(
                      //     border: Border.all(width: sqrt1_2),
                      //     borderRadius: BorderRadius.circular(5)),
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Selector<Lunar, EightChar>(
                                selector: (context, lunar) {
                              final EightChar timeset =
                                  EightChar.fromLunar(lunar);
                              timeset.setSect(1);
                              return timeset;
                            }, builder: (context, timeset, child) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        timeset.getYearGan(),
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
                                          color: colorOfElement(
                                            context,
                                            timeset.getYearGan(),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        timeset.getMonthGan(),
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
                                          color: colorOfElement(
                                            context,
                                            timeset.getMonthGan(),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        timeset.getDayGan(),
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
                                          color: colorOfElement(
                                            context,
                                            timeset.getDayGan(),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        timeset.getTimeGan(),
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
                                          color: colorOfElement(
                                            context,
                                            timeset.getTimeGan(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        timeset.getYearZhi(),
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
                                          color: colorOfElement(
                                            context,
                                            timeset.getYearZhi(),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        timeset.getMonthZhi(),
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
                                          color: colorOfElement(
                                            context,
                                            timeset.getMonthZhi(),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        timeset.getDayZhi(),
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
                                          color: colorOfElement(
                                            context,
                                            timeset.getDayZhi(),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        timeset.getTimeZhi(),
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
                                          color: colorOfElement(
                                            context,
                                            timeset.getTimeZhi(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                            Column(
                              children: [
                                Text(
                                  "值使门",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.primary),
                                ),
                                Text(
                                  qimen.getWatchman(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "旬首",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.primary),
                                ),
                                Text(qimen.getFirstOfTenDays(format: false),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "局数",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.primary),
                                ),
                                Text(
                                    "${qimen.isYang() ? "阳" : "阴"}${qimen.sequence()}局",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "空亡",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.primary),
                                ),
                                Text(lunar.getTimeXunKong(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 24,
                      thickness: 1,
                    ),
                    GridView.count(
                        primary: false,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        children: [
                          magicSquareUnit(context, 3),
                          magicSquareUnit(context, 8),
                          magicSquareUnit(context, 1),
                          magicSquareUnit(context, 2),
                          magicSquareUnit(context, 4),
                          magicSquareUnit(context, 6),
                          magicSquareUnit(context, 7),
                          magicSquareUnit(context, 0),
                          magicSquareUnit(context, 5),
                        ]),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget magicSquareUnit(BuildContext context, int palace) {
    TextStyle? boxTextStyle = Theme.of(context).textTheme.bodyLarge;
    const palaceName = ["☵", "☷", "☳", "☴", "中宫", "☰", "☱", "☶", "☲"];

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "",
                  style: boxTextStyle,
                ),
                Text(
                  (qimen.jiuxing()[palace] == "天芮")
                      ? "${jiuXingString(qimen.jiuxing()[palace])}-\uE1C0"
                      : jiuXingString(qimen.jiuxing()[palace]),
                  style: boxTextStyle?.copyWith(
                      color: Colors.blueAccent, fontFamily: 'BabelStone'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (palace == 4)
                  Text(
                    "",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                else
                  (qimen.tianpan()[palace] == qimen.dipan()[1])
                      ? Row(
                          children: [
                            Text(
                              stemString(qimen.tianpan()[palace]),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: colorOfElement(
                                      context,
                                      qimen.tianpan()[palace],
                                    ),fontFamily: 'BabelStone'
                                  ),
                            ),
                            Text(
                              "-",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              stemString(qimen.dipan()[4]),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: colorOfElement(
                                      context,
                                      qimen.dipan()[4],
                                    ),fontFamily: 'BabelStone'
                                  ),
                            )
                          ],
                        )
                      : Text(
                          stemString(qimen.tianpan()[palace]),
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: colorOfElement(
                                      context,
                                      qimen.tianpan()[palace],
                                    ),fontFamily: 'BabelStone'
                                  ),
                        ),
                Text(
                  qimen.bashen()[palace],
                  style: boxTextStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "",
                  style: boxTextStyle,
                ),
                Text(
                  qimen.bamen()[palace],
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                qimen.dipan()[palace] == qimen.dipan()[1]
                    ? Row(
                        children: [
                          Text(
                            stemString(qimen.dipan()[palace]),
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: colorOfElement(
                                        context,
                                        qimen.dipan()[palace],
                                      ),fontFamily: 'BabelStone'
                                    ),
                          ),
                          Text(
                            "-",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            stemString(qimen.dipan()[4]),
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: colorOfElement(
                                        context,
                                        qimen.dipan()[4],
                                      ),fontFamily: 'BabelStone'
                                    ),
                          )
                        ],
                      )
                    : Text(
                        stemString(qimen.dipan()[palace]),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: colorOfElement(
                                context,
                                qimen.dipan()[palace],
                              ),fontFamily: 'BabelStone'
                            ),
                      ),
                Text(
                  palaceName[palace],
                  style: boxTextStyle?.copyWith(
                    color: colorOfElement(context, '土'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  jiuXingString(String jiuxing) {
    switch (jiuxing) {
      case "天蓬":
        return "\uE08F";
      case "天芮":
        return "\uE100";
      case "天冲":
        return "\uE1C9";
      case "天辅":
        return "\uE04B";
      case "天禽":
        return "\uE1C0";
      case "天心":
        return "\uE052";
      case "天柱":
        return "\uE01E";
      case "天任":
        return "\uE014";
      case "天英":
        return "\uE000";
    }
  }

  stemString(String stem) {
    switch (stem) {
      case "甲":
        return "\uE0FE";
      case "乙":
        return "\uE141";
      case "丙":
        return "";
      case "丁":
        return "\uE1AF";
      case "戊":
        return "\uE037";
      case "己":
        return "\uE0F7";
      case "庚":
        return "\uE16C";
      case "辛":
        return "\uE134";
      case "壬":
        return "\uE118";
      case "癸":
        return "\uE109";
    }
  }

  rootString(String root) {
    switch (root) {
      case "子":
        return "\uE0EA";
      case "丑":
        return "\uE0E9";
      case "寅":
        return "\uE0CF";
      case "卯":
        return "\uE032";
      case "辰":
        return "\uE0F3";
      case "巳":
        return "\uE11E";
      case "午":
        return "\uE02E";
      case "未":
        return "\uE02B";
      case "申":
        return "\uE0F1";
      case "酉":
        return "\uE0F8";
      case "戌":
        return "\uE028";
      case "亥":
        return "\uE0D1";
    }
  }
}

// class Timesets extends EightChar {
//   Timesets(Lunar lunar) : super(lunar) {
//     super.setSect(1);
//   }

//   Timesets.from
// }
