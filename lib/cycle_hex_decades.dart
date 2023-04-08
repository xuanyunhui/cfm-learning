import 'package:flutter/material.dart';
import 'package:lunar/calendar/util/LunarUtil.dart';

import 'drawerbuilder.dart';
import 'generated/l10n.dart';

class CycleHexDecades extends StatefulWidget {
  const CycleHexDecades({super.key});

  @override
  State<CycleHexDecades> createState() => _CycleHexDecades();
}

class _CycleHexDecades extends State<CycleHexDecades> {
  final TextEditingController palaceController = TextEditingController();

  SelectedNotifier selected = SelectedNotifier();
  ResultNotifier result = ResultNotifier();

  @override
  void dispose() {
    palaceController.dispose();
    selected.dispose();
    result.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<StemLabel>> stemEntries =
        <DropdownMenuItem<StemLabel>>[];
    for (final StemLabel stem in StemLabel.values) {
      stemEntries.add(
          DropdownMenuItem<StemLabel>(value: stem, child: Text(stem.label)));
    }

    final List<DropdownMenuItem<RootLabel>> rootEntries =
        <DropdownMenuItem<RootLabel>>[];
    for (final RootLabel root in RootLabel.values) {
      rootEntries.add(
          DropdownMenuItem<RootLabel>(value: root, child: Text(root.label)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).cycleTitle),
        centerTitle: true,
      ),
      drawer: const NavigationDrawerBuilder(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButtonFormField<StemLabel>(
                  value: selected.selectedStem.value,
                  items: stemEntries,
                  onChanged: (StemLabel? stem) {
                    selected.selectedStem.value = stem;
                  },
                  decoration: InputDecoration(
                    labelText: S.of(context).stem,
                    border: const OutlineInputBorder(),
                    constraints: const BoxConstraints(maxWidth: 100),
                    isDense: true
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButtonFormField<RootLabel>(
                  value: selected.selectedRoot.value,
                  items: rootEntries,
                  onChanged: (RootLabel? root) {
                    selected.selectedRoot.value = root;
                  },
                  decoration: InputDecoration(
                    labelText: S.of(context).root,
                    border: const OutlineInputBorder(),
                    constraints: const BoxConstraints(maxWidth: 100),
                    isDense: true
                  ),
                ),
                const SizedBox(width: 8),
                ValueListenableBuilder(
                    valueListenable: selected.selectedStem,
                    builder: (builder, stem, child) {
                      return ValueListenableBuilder(
                          valueListenable: selected.selectedRoot,
                          builder: (context, root, child) {
                            return TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: getCycleIndex(stem!, root!),
                                border: const OutlineInputBorder(),
                                constraints:
                                    const BoxConstraints(maxWidth: 100),
                                    isDense: true
                              ),
                            );
                          });
                    }),
              ],
            ),
            const SizedBox(height: 12),
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
      )),
    );
  }

  String getCycleIndex(StemLabel stem, RootLabel root) {
    int index = LunarUtil.JIA_ZI.indexOf('${stem.label}${root.label}');
    return (index + 1).toString();
  }

}

enum StemLabel {
  jia('甲', 1, 1),
  yi('乙', 2, 6),
  bing('丙', 3, 10),
  ding('丁', 4, 9),
  wu('戊', 5, 10),
  ji('己', 6, 9),
  geng('庚', 7, 7),
  xin('辛', 8, 0),
  ren('壬', 9, 4),
  gui('癸', 10, 3);

  const StemLabel(this.label, this.stemIndex, this.offset);
  final String label;
  final int stemIndex;
  final int offset;
}

enum RootLabel {
  zi('子', 1),
  chou('丑', 2),
  yin('寅', 3),
  mao('卯', 4),
  chen('辰', 5),
  si('巳', 6),
  wu('午', 7),
  wei('未', 8),
  shen('申', 9),
  you('酉', 10),
  xu('戌', 11),
  hai('亥', 12);

  const RootLabel(this.label, this.rootIndex);
  final String label;
  final int rootIndex;
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
