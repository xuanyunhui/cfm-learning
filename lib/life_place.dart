import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

class Palace extends StatefulWidget {
  const Palace({super.key});

  @override
  State<Palace> createState() => _PalaceState();
}

class _PalaceState extends State<Palace> {
  final TextEditingController stemController = TextEditingController();
  final TextEditingController rootController = TextEditingController();
  StemLabel? selectedStem;
  RootLabel? selectedRoot;

  ResultNotifier result = ResultNotifier();

  @override
  void dispose() {
    stemController.dispose();
    rootController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<StemLabel>> stemEntries =
        <DropdownMenuEntry<StemLabel>>[];
    for (final StemLabel stem in StemLabel.values) {
      stemEntries
          .add(DropdownMenuEntry<StemLabel>(value: stem, label: stem.label));
    }

    final List<DropdownMenuEntry<RootLabel>> rootEntries =
        <DropdownMenuEntry<RootLabel>>[];
    for (final RootLabel root in RootLabel.values) {
      rootEntries
          .add(DropdownMenuEntry<RootLabel>(value: root, label: root.label));
    }

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownMenu<StemLabel>(
                  initialSelection: StemLabel.jia,
                  controller: stemController,
                  label: const Text('天干'),
                  dropdownMenuEntries: stemEntries,
                  onSelected: (StemLabel? stem) {
                    setState(() {
                      selectedStem = stem;
                      // getPalace(stem!, selectedRoot!);
                    });
                  },
                ),
                const SizedBox(width: 20),
                DropdownMenu<RootLabel>(
                  initialSelection: RootLabel.zi,
                  controller: rootController,
                  // enableFilter: true,
                  // leadingIcon: const Icon(Icons.search),
                  label: const Text('地支'),
                  dropdownMenuEntries: rootEntries,
                  // inputDecorationTheme:
                  //     const InputDecorationTheme(filled: true),
                  onSelected: (RootLabel? root) {
                    setState(() {
                      selectedRoot = root;
                      // getPalace(selectedStem!, root!);
                    });
                  },
                ),
              ],
            ),
          ),
          if (selectedStem != null && selectedRoot != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    '${selectedStem?.label} ${selectedRoot?.label}: ${getPalace(selectedStem!, selectedRoot!)}'),
              ],
            )
          else
            const Text('Please select a color and an icon.'),
          // training(result),
        ],
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
    for (int i = 0; i < 1; ++i) {
      entries.add({
        'stem': StemLabel.values[rng.nextInt(10)],
        'root': RootLabel.values[rng.nextInt(10)]
      });
    }
    final List<DropdownMenuEntry<PalaceLabel>> palaceEntries =
        <DropdownMenuEntry<PalaceLabel>>[];
    for (final PalaceLabel palace in PalaceLabel.values) {
      palaceEntries.add(
          DropdownMenuEntry<PalaceLabel>(value: palace, label: palace.label));
    }

    

    return Column(children: [
      for (final entry in entries)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('${entry['stem'].label} ${entry['root'].label}'),
            DropdownMenu<PalaceLabel>(
              // controller: pala,
              // enableFilter: true,
              // leadingIcon: const Icon(Icons.search),
              label: const Text('长生宫'),
              dropdownMenuEntries: palaceEntries,
              // inputDecorationTheme:
              //     const InputDecorationTheme(filled: true),
              onSelected: (PalaceLabel? palace) {
                // setState(() {
                result.result = ValueNotifier(verify(entry, palace));
                // });
              },
            ),
            ValueListenableBuilder<bool?>(
                valueListenable: result.result,
                builder: (context, result, _) {
                  return result != null
                      ? result
                          ? const Icon(Icons.check, color: Colors.green)
                          : const Icon(Icons.close, color: Colors.red)
                      : const SizedBox();
                })
          ],
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
  ValueNotifier<bool?> result = ValueNotifier(null);
}
