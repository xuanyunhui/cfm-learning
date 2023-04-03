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
    return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          timeset.getYearGan(),
                          style: TextStyle(
                            // fontSize: mainFontSize,
                            // fontWeight: mainFontWeight,
                            color: _fiveElementColor(
                                LunarUtil.WU_XING_GAN[timeset.getYearGan()]!),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          timeset.getYearZhi(),
                          style: TextStyle(
                            // fontSize: mainFontSize,
                            // fontWeight: mainFontWeight,
                            color: _fiveElementColor(
                                LunarUtil.WU_XING_ZHI[timeset.getYearZhi()]!),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          timeset.getMonthGan(),
                          style: TextStyle(
                            // fontSize: mainFontSize,
                            // fontWeight: mainFontWeight,
                            color: _fiveElementColor(
                                LunarUtil.WU_XING_GAN[timeset.getMonthGan()]!),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          timeset.getMonthZhi(),
                          style: TextStyle(
                            // fontSize: mainFontSize,
                            // fontWeight: mainFontWeight,
                            color: _fiveElementColor(
                                LunarUtil.WU_XING_ZHI[timeset.getMonthZhi()]!),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          timeset.getDayGan(),
                          style: TextStyle(
                            // fontSize: mainFontSize,
                            // fontWeight: mainFontWeight,
                            color: _fiveElementColor(
                                LunarUtil.WU_XING_GAN[timeset.getDayGan()]!),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          timeset.getDayZhi(),
                          style: TextStyle(
                            // fontSize: mainFontSize,
                            // fontWeight: mainFontWeight,
                            color: _fiveElementColor(
                                LunarUtil.WU_XING_ZHI[timeset.getDayZhi()]!),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          timeset.getTimeGan(),
                          style: TextStyle(
                            // fontSize: mainFontSize,
                            // fontWeight: mainFontWeight,
                            color: _fiveElementColor(
                                LunarUtil.WU_XING_GAN[timeset.getTimeGan()]!),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          timeset.getTimeZhi(),
                          style: TextStyle(
                            // fontSize: mainFontSize,
                            // fontWeight: mainFontWeight,
                            color: _fiveElementColor(
                                LunarUtil.WU_XING_ZHI[timeset.getTimeZhi()]!),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  }
}