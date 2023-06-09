import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunar/lunar.dart';

import '../../models/person.dart';

const bool _debug = !kReleaseMode && true;

class HeaderPanal extends StatefulWidget {
  HeaderPanal({Key? key, required this.person, required this.lunar})
      : super(key: key);

  final Person person;
  final Lunar lunar;

  @override
  _HeaderPanelState createState() => _HeaderPanelState();
}

class _HeaderPanelState extends State<HeaderPanal> {
  String _whichCreate = "乾造";

  @override
  void initState() {
    if (!widget.person.gender) {
      _whichCreate = "坤造";
    }
    if (_debug) {
      debugPrint(widget.person.gender.toString());
    }
    super.initState();
  }

  Future<int> _getStroke(name) {
    final Future<int> totalstroke = Future.value(1);
    // UnihanUtils.getTotalStroke(widget.person.name);
    return totalstroke;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
        margin: EdgeInsets.zero,
        child: ListTile(
          leading: Icon(
            widget.person.gender ? Icons.male_outlined : Icons.female_outlined,
            size: 48,
            color: widget.person.gender ? Colors.blue : Colors.pink,
          ),
          title: FutureBuilder(
              future: _getStroke(widget.person.name),
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasData && snapshot.data != 0) {
                  return Text(
                    '$_whichCreate ${widget.person.name} ${snapshot.data.toString()}划（${LunarUtil.JIA_ZI[snapshot.data! - 1]}）属${widget.lunar.getYearShengXiao()}',
                    style: TextStyle(
                      // fontFamily: GoogleFonts.notoSans, //TODO: 字体配置
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                } else {
                  return Text(
                    '$_whichCreate ${widget.person.name} 属${widget.lunar.getYearShengXiao()}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }
              }),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.person.location ?? "",
                style: TextStyle(
                  // fontFamily: "GlowSans",
                  fontSize: theme.textTheme.titleSmall!.fontSize,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary.withAlpha(200),
                ),
              ),
              Text(
                '农历: ${widget.lunar.toString()} ${widget.lunar.getTimeZhi()}时',
                style: TextStyle(
                  fontSize: theme.textTheme.titleSmall!.fontSize,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary.withAlpha(200),
                ),
              ),
            ],
          ),
        )
        //Row(children: [
        //   Container(
        //     height: 60,
        //     width: 60,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       // color: Colors.blue.shade100,
        //       border: Border.all(color: Colors.white),
        //     ),
        //     margin: EdgeInsets.all(10),
        //     padding: EdgeInsets.all(0),
        //     child: Icon(Icons.person),
        //   ),
        //   Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       FutureBuilder(
        //           future: _getStroke(widget.person.name),
        //           builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        //             if (snapshot.hasData && snapshot.data != 0) {
        //               return Text(
        //                 '$_whichCreate ${widget.person.name} ${snapshot.data.toString()}划（${LunarUtil.JIA_ZI[snapshot.data! - 1]}）属${widget.lunar.getYearShengXiao()}',
        //                 style: TextStyle(
        //                   fontFamily: "GlowSans",
        //                   fontSize: 14,
        //                   color: secondaryColor,
        //                 ),
        //               );
        //             } else {
        //               return Text(
        //                 '$_whichCreate ${widget.person.name} 属${widget.lunar.getYearShengXiao()}',
        //                 style: TextStyle(
        //                   fontFamily: "GlowSans",
        //                   fontSize: 14,
        //                   color: secondaryColor,
        //                 ),
        //               );
        //             }
        //           }),
        //       Text(
        //         widget.person.zone.target != null
        //           ? '${widget.person.zone.target!.provinceName}, ${widget.person.zone.target!.cityName}, ${widget.person.zone.target!.areaName}'
        //           : '',
        //         style: TextStyle(
        //           fontFamily: "GlowSans",
        //           fontSize: 12,
        //           color: secondaryColor,
        //         ),
        //       ),
        //       Text(
        //         '农历: ${widget.lunar.toString()} ${widget.lunar.getTimeZhi()}时',
        //         style: TextStyle(
        //           fontFamily: "GlowSans",
        //           fontSize: 12,
        //           color: secondaryColor,
        //         ),
        //       ),
        //     ],
        //   ),
        // ]),
        );
  }
}
