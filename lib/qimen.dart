import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
import 'package:lunar/lunar.dart';
import 'package:qimen/qimen.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../extensions/datetime_extensions.dart';
import 'generated/l10n.dart';

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
  TextEditingController _solarTextEditingController = TextEditingController(),
      _lunarTextEditingController = TextEditingController();
  TextEditingController _timesetTextEditingController = TextEditingController();

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
    final String? countryCode = Localizations.localeOf(context).countryCode;
    final String languageCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).qimenTitle),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () async {
                final Uint8List? imageInUnit8List = await screenshotController.capture();
                XFile file = XFile.fromData(imageInUnit8List!,name: "image.jpg",mimeType: "image/jpeg");
                await Share.shareXFiles([file], text: "奇门排盘");
              },
            ),
            ],
        ),
        body: SingleChildScrollView(
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
                                  initialDate: DateTime.parse(solar.toYmd()), //get today's date
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
                                  DateTime.parse(solar.toYmdHms())
                                ),
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
                          Column(
                            children: [
                              Text(
                                  EightChar.fromLunar(lunar).getYearGan() +
                                      EightChar.fromLunar(lunar).getMonthGan() +
                                      EightChar.fromLunar(lunar).getDayGan() +
                                      EightChar.fromLunar(lunar).getTimeGan(),
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Text(
                                  EightChar.fromLunar(lunar).getYearZhi() +
                                      EightChar.fromLunar(lunar).getMonthZhi() +
                                      EightChar.fromLunar(lunar).getDayZhi() +
                                      EightChar.fromLunar(lunar).getTimeZhi(),
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                          // const Divider(
                          //   color: Color.fromARGB(255, 9, 9, 9),
                          //   thickness: 1,
                          //   height: 20,
                          //   indent: 0,
                          //   endIndent: 0,
                          // ),
                          Column(
                            children: [
                              Text("值使门",
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Text(
                                qimen.getWatchman(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text("旬首",
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Text(qimen.getFirstOfTenDays(format: false),
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                          Column(
                            children: [
                              Text("局数",
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Text(
                                  "${qimen.isYang() ? "阳" : "阴"}${qimen.sequence()}局",
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                          Column(
                            children: [
                              Text("空亡",
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Text(lunar.getTimeXunKong(),
                                  style: Theme.of(context).textTheme.bodyLarge),
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
        ));
  }

  Widget magicSquareUnit(BuildContext context, int palace) {
    TextStyle? boxTextStyle = Theme.of(context).textTheme.bodyLarge;
    const palaceName = ["坎1", "坤2", "震3", "巽4", "中5", "乾6", "兑7", "艮8", "离9"];

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
                      ? "${qimen.jiuxing()[palace]}-禽"
                      : qimen.jiuxing()[palace],
                  style: boxTextStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (palace == 4)
                      ? ""
                      : (qimen.tianpan()[palace] == qimen.dipan()[1])
                          ? "${qimen.tianpan()[palace]}-${qimen.dipan()[4]}"
                          : qimen.tianpan()[palace],
                  style: boxTextStyle,
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
                  style: boxTextStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (qimen.dipan()[palace] == qimen.dipan()[1])
                  ? "${qimen.dipan()[palace]}-${qimen.dipan()[4]}"
                  : qimen.dipan()[palace],
                  style: boxTextStyle,
                ),
                Text(
                  palaceName[palace],
                  style: boxTextStyle,
                ),
              ],
            ),
          ],
        ),
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
