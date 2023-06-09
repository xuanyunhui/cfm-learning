import 'package:cfm_learning/src/extensions/datetime_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunar/lunar.dart';
import 'package:mongol/mongol.dart' show MongolText;

import '../../extensions/lunar_util_extensions.dart';

class TimesetDetail extends StatefulWidget {
  TimesetDetail(
      {Key? key,
      required this.lunar,
      required this.timeset,
      required this.gender})
      : super(key: key);

  final Lunar lunar;
  final EightChar timeset;
  final bool gender;

  @override
  _TimesetDetailState createState() => _TimesetDetailState();
}

class _TimesetDetailState extends State<TimesetDetail> {
  final List<DaYun> _episodes = <DaYun>[];
  int _runningyearindex = 0;
  int _episodeindex = 0;
  List<LiuNian> _runningyears = <LiuNian>[];
  List<LiuYue> _runningmonths = <LiuYue>[];

  final NumberFormat doubleDigits = NumberFormat("##", "en_US");

  @override
  void initState() {
    _episodes.addAll(_getEpisodes());

    setState(() {
      _episodeindex = _getCurrentEpidodeIndex();
      _runningyears = _getRunningYear(_episodes[_episodeindex]);
      _runningyearindex = _getCurrentRunningYearIndex();
      _runningmonths = _getRunningMonth(_runningyears[_runningyearindex]);
    });
    super.initState();
  }

  int _getCurrentEpidodeIndex() {
    int index = 1;
    final year = DateTime.now().year;
    for (var episode in this._getEpisodes()) {
      if (episode.getStartYear() <= year && year <= episode.getEndYear()) {
        index = episode.getIndex();
      }
    }
    return index;
  }

  int _getCurrentRunningYearIndex() {
    int index = 0;
    final year = DateTime.now().year;
    for (var runningyear in this._runningyears) {
      if (runningyear.getYear() == year) {
        index = runningyear.getIndex();
      }
    }
    return index;
  }

  List<DaYun> _getEpisodes() {
    Yun yun = widget.timeset.getYun(widget.gender ? 1 : 0);
    List<DaYun> episodes = yun.getDaYun();
    return episodes;
  }

  List<LiuNian> _getRunningYear(DaYun episode) {
    List<LiuNian> runningyears = <LiuNian>[];
    runningyears.addAll(episode.getLiuNian());
    return runningyears;
  }

  List<LiuYue> _getRunningMonth(LiuNian runningyear) {
    List<LiuYue> runningMonths = runningyear.getLiuYue();
    return runningMonths;
  }

  void _handleEposodeChange(int i) {
    setState(() {
      _episodeindex = i;
      _runningyearindex = 0;
      _runningyears = _getRunningYear(_episodes[_episodeindex]);
      _runningmonths = _getRunningMonth(_runningyears[_runningyearindex]);
    });
    debugPrint(_runningyearindex.toString());
  }

  bool _isStem(String char) {
    if (LunarUtil.GAN.indexOf(char) < 0) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Solar solar = widget.lunar.getSolar();
    final ThemeData theme = Theme.of(context);

    return Wrap(
      runSpacing: 8,
      children: [
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("日期", style: theme.textTheme.bodyMedium),
                      Text("岁", style: theme.textTheme.bodyMedium),
                      Text("年", style: theme.textTheme.bodyMedium),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("流年", style: theme.textTheme.bodyMedium),
                      Text(
                        "${_runningyears[_runningyearindex].getAge().toString()}岁",
                        // style: TextStyle(color: secondaryColor),
                      ),
                      Text(
                        "${_runningyears[_runningyearindex].getYear().toString()}",
                        // style: TextStyle(color: secondaryColor),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((_episodeindex == 0) ? "小运" : "大运",
                          style: theme.textTheme.bodyMedium),
                      Text(
                        "${_episodes[_episodeindex].getStartAge().toString()}岁",
                        // style: TextStyle(color: secondaryColor),
                      ),
                      Text(
                        _episodes[_episodeindex].getStartYear().toString(),
                        // style: TextStyle(color: secondaryColor),
                      )
                    ],
                  ),
                  VerticalDivider(
                    width: 0,
                    thickness: 1,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("年柱", style: theme.textTheme.bodyMedium),
                      Text(
                        solar.getYear().toString(),
                        style: TextStyle(
                            // color: secondaryColor,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("月柱", style: theme.textTheme.bodyMedium),
                      Text(
                        solar.getMonth().toString(),
                        style: TextStyle(
                            // color: secondaryColor,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("日柱", style: theme.textTheme.bodyMedium),
                      Text(
                        solar.getDay().toString(),
                        style: TextStyle(
                            // color: secondaryColor,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("时柱", style: theme.textTheme.bodyMedium),
                      Text(
                        solar.toHM(),
                        style: TextStyle(
                            // color: secondaryColor,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "天干",
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text(
                        "地支",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _runningyears[_runningyearindex]
                        .getGanZhi()
                        .split('')
                        .map(
                          (char) => ChatWithRelatives(
                            char: char,
                            timeset: widget.timeset,
                            isStem: _isStem(char),
                            isYun: true,
                          ),
                        )
                        .toList(),
                  ),
                  (_episodeindex != 0)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: _episodes[_episodeindex]
                              .getGanZhi()
                              .split('')
                              .map(
                                (char) => ChatWithRelatives(
                                  char: char,
                                  timeset: widget.timeset,
                                  isStem: _isStem(char),
                                  isYun: true,
                                ),
                              )
                              .toList(),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: _episodes[_episodeindex]
                              .getXiaoYun()[_runningyearindex]
                              .getGanZhi()
                              .split('')
                              .map(
                                (char) => ChatWithRelatives(
                                  char: char,
                                  timeset: widget.timeset,
                                  isStem: _isStem(char),
                                  isYun: true,
                                ),
                              )
                              .toList(),
                        ),
                  VerticalDivider(
                    width: 0,
                    thickness: 1,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ChatWithRelatives(
                        char: widget.timeset.getYearGan(),
                        timeset: widget.timeset,
                        isStem: _isStem(
                          widget.timeset.getYearGan(),
                        ),
                        isYun: false,
                      ),
                      ChatWithRelatives(
                        char: widget.timeset.getYearZhi(),
                        timeset: widget.timeset,
                        isStem: _isStem(
                          widget.timeset.getYearZhi(),
                        ),
                        isYun: false,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ChatWithRelatives(
                        char: widget.timeset.getMonthGan(),
                        timeset: widget.timeset,
                        isStem: _isStem(
                          widget.timeset.getMonthGan(),
                        ),
                        isYun: false,
                      ),
                      ChatWithRelatives(
                        char: widget.timeset.getMonthZhi(),
                        timeset: widget.timeset,
                        isStem: _isStem(
                          widget.timeset.getMonthZhi(),
                        ),
                        isYun: false,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ChatWithRelatives(
                        char: widget.timeset.getDayGan(),
                        timeset: widget.timeset,
                        isStem: _isStem(
                          widget.timeset.getDayGan(),
                        ),
                        isYun: false,
                      ),
                      ChatWithRelatives(
                        char: widget.timeset.getDayZhi(),
                        timeset: widget.timeset,
                        isStem: _isStem(
                          widget.timeset.getDayZhi(),
                        ),
                        isYun: false,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ChatWithRelatives(
                        char: widget.timeset.getTimeGan(),
                        timeset: widget.timeset,
                        isStem: _isStem(
                          widget.timeset.getTimeGan(),
                        ),
                        isYun: false,
                      ),
                      ChatWithRelatives(
                        char: widget.timeset.getTimeZhi(),
                        timeset: widget.timeset,
                        isStem: _isStem(
                          widget.timeset.getTimeZhi(),
                        ),
                        isYun: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    Text(
                      "流月干",
                      // style: TextStyle(color: textColor),
                    ),
                    Text(
                      "流月支",
                      // style: TextStyle(color: textColor),
                    ),
                  ],
                ),
              ].toList()
                ..addAll(
                  _runningmonths
                      .map(
                        (month) => Column(
                          children: month
                              .getGanZhi()
                              .split('')
                              .map(
                                (char) => RunningYearText(
                                  char: char,
                                  isStem: _isStem(char),
                                ),
                              )
                              .toList(),
                        ),
                      )
                      .toList(),
                ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    Text(
                      "长生宫",
                      // style: TextStyle(color: textColor),
                    ),
                    Text(
                      "空亡",
                      // style: TextStyle(color: textColor),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      widget.timeset.getDiShi(LunarUtil.ZHI.indexOf(
                              _runningyears[_runningyearindex]
                                  .getGanZhi()
                                  .split('')[1]) -
                          1),
                      // style: TextStyle(color: textColor),
                    ),
                    InkWell(
                        onTap: () {
                          debugPrint(
                              _runningyears[_runningyearindex].getXunKong());
                        },
                        child: Text(
                            _runningyears[_runningyearindex].getXunKong())),
                  ],
                ),
                (_episodeindex != 0)
                    ? Column(
                        children: [
                          Text(
                            widget.timeset.getDiShi(LunarUtil.ZHI.indexOf(
                                    _episodes[_episodeindex]
                                        .getGanZhi()
                                        .split('')[1]) -
                                1),
                            // style: TextStyle(color: textColor),
                          ),
                          Text(_episodes[_episodeindex].getXunKong())
                        ],
                      )
                    : Column(
                        children: [
                          Text(
                            widget.timeset.getDiShi(LunarUtil.ZHI.indexOf(
                                    _episodes[_episodeindex]
                                        .getXiaoYun()[_runningyearindex]
                                        .getGanZhi()
                                        .split('')[1]) -
                                1),
                            // style: TextStyle(color: textColor),
                          ),
                          Text(_episodes[_episodeindex]
                              .getXiaoYun()[_runningyearindex]
                              .getXunKong()),
                        ],
                      ),
                Column(
                  children: [
                    Text(widget.timeset.getYearDiShi()),
                    Text(widget.timeset.getYearXunKong()),
                  ],
                ),
                Column(
                  children: [
                    Text(widget.timeset.getMonthDiShi()),
                    Text(widget.timeset.getMonthXunKong()),
                  ],
                ),
                Column(
                  children: [
                    Text(widget.timeset.getDayDiShi()),
                    Text(widget.timeset.getDayXunKong()),
                  ],
                ),
                Column(
                  children: [
                    Text(widget.timeset.getTimeDiShi()),
                    Text(widget.timeset.getTimeXunKong()),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Text(
                "大运",
                // style: TextStyle(color: textColor),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _episodes
                    .map(
                      (spisode) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${(spisode.getIndex() == 0) ? spisode.getStartAge().toString() + "-" + spisode.getEndAge().toString() : spisode.getStartAge().toString() + "岁"}',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            '${(spisode.getIndex() == 0) ? "" : spisode.getStartYear().toString()}',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: (spisode.getIndex() == _episodeindex)
                                    ? Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.38)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(3),
                            child: InkWell(
                              onTap: () =>
                                  _handleEposodeChange(spisode.getIndex()),
                              child: MongolText(
                                '${(spisode.getIndex() == 0) ? "小运" : spisode.getGanZhi()}',
                                style: TextStyle(
                                    color: (spisode.getIndex() == _episodeindex)
                                        ? Colors.white
                                        : Colors.black),
                                // textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              // ],
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Text(
                "流年",
                // style: TextStyle(color: textColor),
              ),
              // SizedBox(width: 16,),
              subtitle: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: runningYearListBody(_runningyears),
                ),
              ),
              // ],
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            leading: Text(
              '起运时间:',
            ),
            title: Text(
              '${widget.timeset.getYun(widget.gender ? 1 : 0, 1).getStartSolar().toYmdHms()}',
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> runningYearListBody(List<LiuNian> runningyears) {
    var listWidget = _runningyears
        .map(
          (runningyear) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${runningyear.getYear()}',
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: (runningyear.getIndex() == _runningyearindex)
                      ? Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.38)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(3),
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _runningyearindex = runningyear.getIndex();
                      _runningmonths =
                          _getRunningMonth(_runningyears[_runningyearindex]);
                    });
                  },
                  child: MongolText(
                    '${runningyear.getGanZhi()}',
                    style: TextStyle(
                        color: (runningyear.getIndex() == _runningyearindex)
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
            ],
          ),
        )
        .toList();
    for (int i = listWidget.length; i < 10; i++) {
      listWidget.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '',
              style: TextStyle(
                fontSize: 10,
                // color: buttonColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(2),
              alignment: Alignment.center,
              child: MongolText(''),
            ),
          ],
        ),
      );
    }

    return listWidget;
  }
}

class RunningYearText extends StatelessWidget {
  const RunningYearText({Key? key, required this.char, this.isStem = true})
      : super(key: key);

  final String char;
  final bool isStem;

  Color _fiveElementColor(String char) {
    switch (char) {
      case "木":
        {
          return Color.fromRGBO(107, 172, 68, 1);
        }
      case "火":
        {
          return Color.fromRGBO(217, 2, 28, 1);
        }
      case "土":
        {
          return Color.fromRGBO(138, 88, 27, 1);
        }
      case "金":
        {
          return Color.fromRGBO(219, 131, 59, 1);
        }
      case "水":
        {
          return Color.fromRGBO(0, 0, 176, 1);
        }
      default:
        {
          return Colors.black;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(char,
        style: TextStyle(
          color: _fiveElementColor(isStem
              ? LunarUtil.WU_XING_GAN[char]!
              : LunarUtil.WU_XING_ZHI[char]!),
        ));
  }
}

class ChatWithRelatives extends StatelessWidget {
  ChatWithRelatives({
    Key? key,
    required this.char,
    required this.timeset,
    required this.isStem,
    required this.isYun,
  }) : super(key: key);

  final String char;
  final EightChar timeset;
  final bool isStem;
  final bool isYun;

  Color _fiveElementColor(String char) {
    switch (char) {
      case "木":
        {
          return Color.fromRGBO(107, 172, 68, 1);
        }
      case "火":
        {
          return Color.fromRGBO(217, 2, 28, 1);
        }
      case "土":
        {
          return Color.fromRGBO(138, 88, 27, 1);
        }
      case "金":
        {
          return Color.fromRGBO(219, 131, 59, 1);
        }
      case "水":
        {
          return Color.fromRGBO(0, 0, 176, 1);
        }
      default:
        {
          return Colors.black;
        }
    }
  }

  List<String> getShiShenZhiShort(String zhi) {
    List<String> hideGan = LunarUtilExt.hiddenStems[zhi]!;
    List<String> l = <String>[];
    for (String gan in hideGan) {
      l.add(LunarUtilExt.SHI_SHEN_ZHI_SHORT['${timeset.getDayGan()}$zhi$gan']!);
    }
    // 这是一个奇怪的处理方式，为了保证页面上有三个渲染数据来保持高度一致
    for (int i = l.length; i < 3; i++) {
      l.insert(1, "");
    }
    return l;
  }

  bool isKong(String char) {
    bool isKong = false;
    if (isYun) {
      isKong = false;
    } else {
      isKong = LunarUtilExt.KONG[timeset.getDayXunKong()]!.contains(char);
    }
    return isKong;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return IntrinsicHeight(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            isKong(char)
                ? Text("(",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _fiveElementColor(isStem
                          ? LunarUtil.WU_XING_GAN[char]!
                          : LunarUtil.WU_XING_ZHI[char]!),
                    ))
                : Text(" "),
            Text(
              char,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _fiveElementColor(isStem
                    ? LunarUtil.WU_XING_GAN[char]!
                    : LunarUtil.WU_XING_ZHI[char]!),
              ),
            ),
            isKong(char)
                ? Text(")",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _fiveElementColor(isStem
                          ? LunarUtil.WU_XING_GAN[char]!
                          : LunarUtil.WU_XING_ZHI[char]!),
                    ))
                : Text(" "),
            (isStem)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        LunarUtilExt
                            .SHI_SHEN_GAN_SHORT['${timeset.getDayGan()}$char']!,
                        style: TextStyle(
                          fontSize: 10,
                          // color: buttonColor,
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: getShiShenZhiShort(char)
                        .map(
                          (e) => Text(
                            e,
                            style: TextStyle(
                              fontSize: 10,
                              // color: buttonColor,
                            ),
                          ),
                        )
                        .toList(),
                  )
          ]),
    );
  }
}
