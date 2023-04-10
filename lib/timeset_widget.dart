import 'package:flutter/material.dart';
import 'package:lunar/lunar.dart';

class TimesetWidget extends StatelessWidget {
  const TimesetWidget({super.key, required this.timeset});

  final EightChar timeset;

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
    final double? textFontSize = Theme.of(context).textTheme.titleLarge?.fontSize;
    return Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.transparent,
              ),
          // margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    timeset.getYearGan(),
                    style: TextStyle(
                      fontSize: textFontSize,
                      // fontWeight: mainFontWeight,
                      color: _fiveElementColor(
                          LunarUtil.WU_XING_GAN[timeset.getYearGan()]!),
                    ),
                  ),
                  Text(
                    timeset.getYearZhi(),
                    style: TextStyle(
                      fontSize: textFontSize,
                      // fontWeight: mainFontWeight,
                      color: _fiveElementColor(
                          LunarUtil.WU_XING_ZHI[timeset.getYearZhi()]!),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    timeset.getMonthGan(),
                    style: TextStyle(
                      fontSize: textFontSize,
                      // fontWeight: mainFontWeight,
                      color: _fiveElementColor(
                          LunarUtil.WU_XING_GAN[timeset.getMonthGan()]!),
                    ),
                  ),
                  Text(
                    timeset.getMonthZhi(),
                    style: TextStyle(
                      fontSize: textFontSize,
                      // fontWeight: mainFontWeight,
                      color: _fiveElementColor(
                          LunarUtil.WU_XING_ZHI[timeset.getMonthZhi()]!),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    timeset.getDayGan(),
                    style: TextStyle(
                      fontSize: textFontSize,
                      // fontWeight: mainFontWeight,
                      color: _fiveElementColor(
                          LunarUtil.WU_XING_GAN[timeset.getDayGan()]!),
                    ),
                  ),
                  Text(
                    timeset.getDayZhi(),
                    style: TextStyle(
                      fontSize: textFontSize,
                      // fontWeight: mainFontWeight,
                      color: _fiveElementColor(
                          LunarUtil.WU_XING_ZHI[timeset.getDayZhi()]!),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    timeset.getTimeGan(),
                    style: TextStyle(
                      fontSize: textFontSize,
                      // fontWeight: mainFontWeight,
                      color: _fiveElementColor(
                          LunarUtil.WU_XING_GAN[timeset.getTimeGan()]!),
                    ),
                  ),
                  Text(
                    timeset.getTimeZhi(),
                    style: TextStyle(
                      fontSize: textFontSize,
                      // fontWeight: mainFontWeight,
                      color: _fiveElementColor(
                          LunarUtil.WU_XING_ZHI[timeset.getTimeZhi()]!),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}