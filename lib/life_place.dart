import 'dart:math';

import 'package:flutter/material.dart';

import 'drawerbuilder.dart';
import 'generated/l10n.dart';

class Palace extends StatefulWidget {
  const Palace({super.key});

  @override
  State<Palace> createState() => _PalaceState();
}

class _PalaceState extends State<Palace> {
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
        title: Text(S.of(context).lifePalaceTitle),
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
                                labelText: getPalace(stem!, root!),
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
            FilledButton(
              onPressed: () {
                setState(() {
                });
              },
               child: Text(S.of(context).refreshQuestion)
            ),
            training(result),
          ],
        ),
      )),
    );
  }

  String getPalace(StemLabel stem, RootLabel root) {
    int? offset = stem.offset;
    int index = offset + (stem.index % 2 == 0 ? root.index : -root.index);
    if (index >= 12) {
      index -= 12;
    }
    if (index < 0) {
      index += 12;
    }
    return PalaceLabel.values[index].label;
  }

  Widget training(result) {
    var rng = Random();
    final entries = []; // List<Map<String, dynamic>>();
    for (int i = 0; i < 5; ++i) {
      entries.add({
        'stem': StemLabel.values[rng.nextInt(10)],
        'root': RootLabel.values[rng.nextInt(10)],
        'result': ResultNotifier(),
      });
    }
    final List<DropdownMenuItem<PalaceLabel>> palaceEntries =
        <DropdownMenuItem<PalaceLabel>>[];
    for (final PalaceLabel palace in PalaceLabel.values) {
      palaceEntries.add(DropdownMenuItem<PalaceLabel>(
          value: palace, child: Text(palace.label)));
    }

    return Column(children: [
      for (final entry in entries)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('${entry['stem'].label} ${entry['root'].label}'),
              const SizedBox(width: 8),
              DropdownButtonFormField<PalaceLabel>(
                // controller: pala,
                // enableFilter: true,
                // leadingIcon: const Icon(Icons.search),
                value: null,
                items: palaceEntries,
                // inputDecorationTheme:
                //     const InputDecorationTheme(filled: true),
                onChanged: (PalaceLabel? palace) {
                  // setState(() {
                  entry['result'].result.value = verify(entry, palace);
                  // });
                },
                decoration: InputDecoration(
                  labelText: S.of(context).lifePalace,
                  border: const OutlineInputBorder(),
                  constraints: const BoxConstraints(maxWidth: 100),
                  isDense: true
                ),
              ),
              ValueListenableBuilder<bool?>(
                  valueListenable: entry['result'].result,
                  builder: (context, result, _) {
                    return result != null
                        ? result
                            ? const Icon(Icons.check, color: Colors.green)
                            : const Icon(Icons.close, color: Colors.red)
                        : const SizedBox(width: 24);
                  }),
            ],
          ),
        )
    ]);
  }

  bool verify(entry, PalaceLabel? palace) {
    String target = palace!.label.toString();
    String src = getPalace(entry['stem'], entry['root']);
    if (target == src) {
      return true;
    } else {
      return false;
    }
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

enum PalaceLabel {
  newborn('长生'),
  baptize('沐浴'),
  dressup('冠带'),
  takeoffice('临官'),
  tiptop('帝旺'),
  recess('衰'),
  sick('病'),
  dead('死'),
  tomb('墓'),
  extingnished('绝'),
  conceive('胎'),
  incubate('养');

  const PalaceLabel(this.label);
  final String label;
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
