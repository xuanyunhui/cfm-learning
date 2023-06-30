import 'package:cfm_learning/src/extensions/eight_char_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lunar/lunar.dart';

import '../../../generated/l10n.dart';
import '../../models/solar_terms.dart';

class TimesetSummary extends StatelessWidget {
  TimesetSummary({Key? key, required this.lunar, required this.timeset})
      : super(key: key);

  final Lunar lunar;
  final EightChar timeset;

  // const smallSize =
  // final TextStyle mainTextStyle = TextStyle(
  //   fontSize: 28,
  //   fontWeight: FontWeight.w500,
  // );

  final double mainFontSize = 28;
  final FontWeight mainFontWeight = FontWeight.w500;

  Color _fiveElementColor(String char) {
    switch (char) {
      case "木":
        {
          return const Color.fromRGBO(107, 172, 68, 1);
        }
      case "火":
        {
          return const Color.fromRGBO(217, 2, 28, 1);
        }
      case "土":
        {
          return const Color.fromRGBO(138, 88, 27, 1);
        }
      case "金":
        {
          return const Color.fromRGBO(219, 131, 59, 1);
        }
      case "水":
        {
          return const Color.fromRGBO(0, 0, 176, 1);
        }
      default:
        {
          return Colors.black;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      children: [
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "日期",
                    ),
                    Text(
                      "年柱",
                    ),
                    Text(
                      "月柱",
                    ),
                    Text(
                      "日柱",
                    ),
                    Text(
                      "时柱",
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "主星",
                      style: TextStyle(
                          // color: textColor,
                          ),
                    ),
                    Text(
                      timeset.getYearShiShenGan(),
                      style: const TextStyle(
                          // color: secondaryColor,
                          ),
                    ),
                    Text(
                      timeset.getMonthShiShenGan(),
                      style: const TextStyle(
                          // color: secondaryColor,
                          ),
                    ),
                    Text(
                      timeset.getDayShiShenGan(),
                      style: const TextStyle(
                          // color: secondaryColor,
                          ),
                    ),
                    Text(
                      timeset.getTimeShiShenGan(),
                      style: const TextStyle(
                          // color: secondaryColor,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "天干",
                      style: TextStyle(
                          // color: textColor,
                          ),
                    ),
                    Text(
                      timeset.getYearGan(),
                      style: TextStyle(
                        fontSize: mainFontSize,
                        fontWeight: mainFontWeight,
                        color: _fiveElementColor(
                            LunarUtil.WU_XING_GAN[timeset.getYearGan()]!),
                      ),
                    ),
                    Text(
                      timeset.getMonthGan(),
                      style: TextStyle(
                        fontSize: mainFontSize,
                        fontWeight: mainFontWeight,
                        color: _fiveElementColor(
                            LunarUtil.WU_XING_GAN[timeset.getMonthGan()]!),
                      ),
                    ),
                    Text(
                      timeset.getDayGan(),
                      style: TextStyle(
                        fontSize: mainFontSize,
                        fontWeight: mainFontWeight,
                        color: _fiveElementColor(
                            LunarUtil.WU_XING_GAN[timeset.getDayGan()]!),
                      ),
                    ),
                    Text(
                      timeset.getTimeGan(),
                      style: TextStyle(
                        fontSize: mainFontSize,
                        fontWeight: mainFontWeight,
                        color: _fiveElementColor(
                            LunarUtil.WU_XING_GAN[timeset.getTimeGan()]!),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "地支",
                      style: TextStyle(
                          // color: textColor,
                          ),
                    ),
                    Text(
                      timeset.getYearZhi(),
                      style: TextStyle(
                        fontSize: mainFontSize,
                        fontWeight: mainFontWeight,
                        color: _fiveElementColor(
                            LunarUtil.WU_XING_ZHI[timeset.getYearZhi()]!),
                      ),
                    ),
                    Text(
                      timeset.getMonthZhi(),
                      style: TextStyle(
                        fontSize: mainFontSize,
                        fontWeight: mainFontWeight,
                        color: _fiveElementColor(
                            LunarUtil.WU_XING_ZHI[timeset.getMonthZhi()]!),
                      ),
                    ),
                    Text(
                      timeset.getDayZhi(),
                      style: TextStyle(
                        fontSize: mainFontSize,
                        fontWeight: mainFontWeight,
                        color: _fiveElementColor(
                            LunarUtil.WU_XING_ZHI[timeset.getDayZhi()]!),
                      ),
                    ),
                    Text(
                      timeset.getTimeZhi(),
                      style: TextStyle(
                        fontSize: mainFontSize,
                        fontWeight: mainFontWeight,
                        color: _fiveElementColor(
                            LunarUtil.WU_XING_ZHI[timeset.getTimeZhi()]!),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "藏干",
                  // style: TextStyle(
                  //   color: textColor,
                  // ),
                ),
                Column(
                  children: timeset
                      .getYearHiddenStems()
                      .map((stem) => Text(
                            '$stem${LunarUtil.WU_XING_GAN[stem]}',
                            style: const TextStyle(
                                // color: secondaryColor,
                                ),
                          ))
                      .toList(),
                ),
                Column(
                  children: timeset
                      .getMonthHiddenStems()
                      .map((stem) => Text(
                            '$stem${LunarUtil.WU_XING_GAN[stem]}',
                            style: const TextStyle(
                              // color: secondaryColor,
                            ),
                          ))
                      .toList(),
                ),
                Column(
                  children: timeset
                      .getDayHiddenStems()
                      .map((stem) => Text(
                            '$stem${LunarUtil.WU_XING_GAN[stem]}',
                            style: const TextStyle(
                              // color: secondaryColor,
                            ),
                          ))
                      .toList(),
                ),
                Column(
                  children: timeset
                      .getHourHiddenStems()
                      .map((stem) => Text(
                            '$stem${LunarUtil.WU_XING_GAN[stem]}',
                            style: const TextStyle(
                              // color: secondaryColor,
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "副星",
                  // style: TextStyle(color: textColor,),
                ),
                Column(
                  children: timeset
                      .getYearTheRelationsOfRoot()
                      .map((root) => Text(
                            root,
                            // style: TextStyle(color: secondaryColor),
                          ))
                      .toList(),
                ),
                Column(
                  children: timeset
                      .getMonthTheRelationsOfRoot()
                      .map((root) => Text(
                            root,
                            // style: TextStyle(color: secondaryColor),
                          ))
                      .toList(),
                ),
                Column(
                  children: timeset
                      .getDayTheRelationsOfRoot()
                      .map((root) => Text(
                            root,
                            // style: TextStyle(color: secondaryColor),
                          ))
                      .toList(),
                ),
                Column(
                  children: timeset
                      .getHourTheRelationsOfRoot()
                      .map((root) => Text(
                            root,
                            // style: TextStyle(color: secondaryColor),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "节气",
                  // style: TextStyle(color: textColor),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: SolarTerms(lunar: lunar)
                      .currentSolarTerms()
                      .keys
                      .map((name) => Text(
                            '$name ${SolarTerms(lunar: lunar).currentSolarTerms()[name]!.toYmdHms()}',
                            // style: TextStyle(color: secondaryColor),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
