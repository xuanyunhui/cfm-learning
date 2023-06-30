import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunar/calendar/EightChar.dart';
import 'package:lunar/calendar/Lunar.dart';
import 'package:lunar/calendar/Solar.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:share_plus/share_plus.dart';

import '../../../generated/l10n.dart';
import '../../models/person.dart';
import '../../provider/selected_index.dart';
import 'header_panel.dart';
import 'timeset_detail.dart';
import 'timeset_summary.dart';
// import '../models/tao_of_life.dart';

class ShowTimeset extends StatefulWidget {
  const ShowTimeset({Key? key, required this.person}) : super(key: key);

  final Person person;

  @override
  ShowTimesetState createState() => ShowTimesetState();
}

class ShowTimesetState extends State<ShowTimeset> {
  Solar _getSolar(DateTime date) {
    return Solar.fromDate(date);
  }

  EightChar _getTimeset(Lunar lunar) {
    return lunar.getEightChar();
  }

  Lunar _getLunar(Solar solar) {
    return solar.getLunar();
  }

  DetailType selectedType = DetailType.detail;

  final ScreenshotController screenshotController = ScreenshotController();
  final TextEditingController _notes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final person = widget.person;
    final solar = _getSolar(person.birthTime);
    final lunar = _getLunar(solar);
    final timeset = _getTimeset(lunar);
    timeset.setSect(1);
    _notes.text = person.notes ?? '';
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).timesetTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share),
            onPressed: () async {
              final Uint8List? imageInUnit8List =
                  await screenshotController.capture();
              XFile file = XFile.fromData(imageInUnit8List!,
                  name: "image.jpg", mimeType: "image/webp");
              await Share.shareXFiles([file], text: "时间局");
            },
          ),
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        // child: ShaderMask(
        //   shaderCallback: (rect) => LinearGradient(
        //     begin: Alignment.bottomCenter,
        //     end: Alignment.center,
        //     colors: [
        //       Theme.of(context).scaffoldBackgroundColor,
        //       Theme.of(context).scaffoldBackgroundColor,
        //     ],
        //   ).createShader(rect),
        //   blendMode: BlendMode.dst,
        //   child: Container(
        //     height: MediaQuery.of(context).size.height -
        //         MediaQuery.of(context).viewPadding.top -
        //         60 -
        //         MediaQuery.of(context).viewPadding.bottom,
        //     width: MediaQuery.of(context).size.width,
        //     decoration: BoxDecoration(
        //       // color: Colors.transparent,
        //       image: DecorationImage(
        //         image: AssetImage("lib/assets/stem_root_background.png"),
        //         fit: BoxFit.cover,
        //         colorFilter: ColorFilter.mode(
        //             Theme.of(context).scaffoldBackgroundColor, BlendMode.dst),
        //       ),
        //     ),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider<SelectedValue<bool>>(
                      create: (_) => SelectedValue<bool>(false),
                    ),
                  ],
                  child: Wrap(
                    runSpacing: 8,
                    children: [
                      HeaderPanal(person: person, lunar: lunar),
                      SizedBox(
                        width: double.infinity,
                        child: SegmentedButton<DetailType>(
                          segments: <ButtonSegment<DetailType>>[
                            ButtonSegment<DetailType>(
                                value: DetailType.summary,
                                label: Text(
                                  S.of(context).summaryText,
                                  style: TextStyle(
                                    fontSize:
                                        theme.textTheme.titleMedium!.fontSize,
                                  ),
                                ),
                                icon: const Icon(Icons.summarize_outlined)),
                            ButtonSegment<DetailType>(
                                value: DetailType.detail,
                                label: Text(
                                  S.of(context).detilText,
                                  style: TextStyle(
                                    fontSize:
                                        theme.textTheme.titleMedium!.fontSize,
                                  ),
                                ),
                                icon: const Icon(Icons.details_outlined)),
                          ],
                          selected: <DetailType>{selectedType},
                          onSelectionChanged: (Set<DetailType> newSelection) {
                            setState(() {
                              selectedType = newSelection.first;
                            });
                          },
                        ),
                      ),
                      [
                        TimesetSummary(lunar: lunar, timeset: timeset),
                        TimesetDetail(
                            lunar: lunar,
                            timeset: timeset,
                            gender: person.gender),
                      ][selectedType.index],
                    ],
                  ),
                ),
              ),
            ),
          ),
      //   ),
      // ),
    );
  }

  // @override
  // void dispose() {
  //   if (_subscription != null) _subscription?.cancel();
  //   super.dispose();
  // }
}

enum DetailType { summary, detail }
